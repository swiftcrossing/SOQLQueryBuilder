
public struct Select<T: Table>: PartialQuery, SelectType {
  let table: T.Type
  let relationshipName: String?
  let queryGroup: QueryGroup

  public init(from table: T.Type, relationshipName: String? = nil, @SOQLFunctionBuilder builder: (T.Type) -> PartialQuery) {
    self.table = table
    self.relationshipName = relationshipName
    queryGroup = builder(table).asQueryGroup
  }

  public func build() -> String {
    let (fields, innerQueries) = queryGroup.queries
      .reduce(([], []), { (acc, next) -> ([PartialQuery], [PartialQuery]) in
        var (fields, innerQueries) = acc
        if next is FieldConvertible {
          fields.append(next)
        } else {
          innerQueries.append(next)
        }
        return (fields, innerQueries)
      })
    let innerQueryFields = !innerQueries.isEmpty
      ? [InnerQuery(innerQueries)]
      : []
    let allFields = fields + innerQueryFields
    let tableName = relationshipName ?? table.name
    let fieldsString = allFields.map({ $0.build() }).joined(separator: ",")
    return ["SELECT", fieldsString, "FROM", tableName].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

public struct Where: PartialQuery {
  let queryGroup: QueryGroup

  public init(@SOQLFunctionBuilder builder: () -> PartialQuery) {
    queryGroup = builder().asQueryGroup
  }

  public func build() -> String {
    ["", "WHERE", queryGroup.queries.map({ $0.build() }).joined()].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

/// Use the optional ORDER BY in a SELECT statement of a SOQL query to control the order of the query results, such as alphabetically beginning with z.
/// If records are null, you can use ORDER BY to display the empty records first or last.
///
/// You can use ORDER BY in a SELECT statement to control the order of the query results.
/// There is no guarantee of the order of resultsunless you use an ORDER BY clause in a query.
///
/// The syntax is:
/// ```
/// [ORDER BY *fieldOrderByList* {ASC|DESC} [NULLS {FIRST|LAST}]]
/// ```
public struct OrderBy: PartialQuery {
  public enum OrderDescriptor: String {
    case asc
    case desc
  }

  public enum NullOrder: String {
    case first
    case last

    var displayValue: String {
      switch self {
      case .first:
        return ["NULLS", "FIRST"].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
      case .last:
        return ["NULLS", "LAST"].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
      }
    }
  }

  public struct Conditions {
    let field: FieldConvertible
    let orderDescriptor: OrderDescriptor?
    let nullOrder: NullOrder?

    public init(_ field: FieldConvertible, orderDescriptor: OrderDescriptor? = nil, nullOrder: NullOrder? = nil) {
      self.field = field
      self.orderDescriptor = orderDescriptor
      self.nullOrder = nullOrder
    }

    var asString: String {
      ["", "ORDER", "BY", field.asString, orderDescriptor?.rawValue.uppercased(), nullOrder?.displayValue]
        .compactMap({ $0 })
        .joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
    }
  }

  let conditionsList: [Conditions]

  /// Initialize with a required field to order by and optionally provide the *OrderDescriptor* and *NullOrder*.
  /// - Parameters:
  ///   - field: Field to order by.
  ///   - orderDescriptor: Specifies whether the results are ordered in ascending (ASC) or descending (DESC) order. Default order is ascending.
  ///   - nullOrder: Orders null records at the beginning (NULLS FIRST) or end (NULLS LAST) of the results. By default, null values are sorted first.
  public init(_ field: FieldConvertible, orderDescriptor: OrderDescriptor? = nil, nullOrder: NullOrder? = nil) {
    conditionsList = [Conditions(field, orderDescriptor: orderDescriptor, nullOrder: nullOrder)]
  }

  /// Initialize with a list of conditions
  /// - Parameter conditionsList: List of Order By conditions
  public init(list conditionsList: [Conditions]) {
    self.conditionsList = conditionsList
  }

  public func build() -> String {
    conditionsList.map(\.asString).joined(separator: ",")
  }
}

public struct Limit: PartialQuery {
  let limit: Int

  public init(_ limit: Int) {
    self.limit = limit
  }

  public func build() -> String {
    ["", "LIMIT", String(limit)].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

public struct Offset: PartialQuery {
  let offset: Int

  public init(_ offset: Int) {
    self.offset = offset
  }

  public func build() -> String {
    ["", "OFFSET", String(offset)].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

public struct GroupBy: PartialQuery {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public func build() -> String {
    ["", "GROUP", "BY", field.asString].joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

public struct GroupByRollup: PartialQuery {
  let fields: [FieldConvertible]

  public init(_ fields: [FieldConvertible]) {
    self.fields = fields
  }

  public func build() -> String {
    ["", "GROUP", "BY", "ROLLUP(\(fields.map(\.asString).joined(separator: ",")))"]
      .joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

public struct GroupByCube: PartialQuery {
  let fields: [FieldConvertible]

  public init(_ fields: [FieldConvertible]) {
    self.fields = fields
  }

  public func build() -> String {
    ["", "GROUP", "BY", "CUBE(\(fields.map(\.asString).joined(separator: ",")))"]
      .joined(separator: SOQLFunctionBuilder.whitespaceCharacter)
  }
}

public struct Relation<T: Table>: PartialQuery, RelationType, FieldConvertible {
  let relationshipName: String?
  let queryGroup: QueryGroup
  private var resolvedRelationshipName: String {
    (relationshipName ?? T.name).replacingOrAddingSuffix("__c", with: "__r")
  }

  public var asString: String {
    build()
  }

  public init(from relationship: T.Type, relationshipName: String? = nil, @SOQLFunctionBuilder builder: (T.Type) -> PartialQuery) {
    self.relationshipName = relationshipName
    queryGroup = builder(relationship).asQueryGroup
  }

  public func build() -> String {
    buildChildren()
      .joined(separator: ",")
  }

  func buildChildren() -> [String] {
    return queryGroup.queries
      .flatMap({ query -> [String] in
        if let relation = query as? RelationType {
          return relation.buildChildren().map({ resolvedRelationshipName + "." + $0 })
        } else if let fieldGroup = query as? FieldGroup {
          return fieldGroup.fields.map({ resolvedRelationshipName + "." + $0.asString })
        } else {
          return [resolvedRelationshipName + "." + query.build()]
        }
      })
  }
}

public struct And: PartialQuery {
  let queryGroup: QueryGroup

  public init(@SOQLFunctionBuilder builder: () -> PartialQuery) {
    queryGroup = builder().asQueryGroup
  }

  public func build() -> String {
    queryGroup.queries
      .map({ wrap($0.build(), if: $0 is Or && queryGroup.queries.count > 1) })
      .joined(separator: ["", "AND", ""].joined(separator: SOQLFunctionBuilder.whitespaceCharacter))

  }
}

public struct Or: PartialQuery {
  let queryGroup: QueryGroup

  public init(@SOQLFunctionBuilder builder: () -> PartialQuery) {
    queryGroup = builder().asQueryGroup
  }

  public func build() -> String {
    queryGroup.queries
      .map({ wrap($0.build(), if: $0 is And && queryGroup.queries.count > 1) })
      .joined(separator: ["", "OR", ""].joined(separator: SOQLFunctionBuilder.whitespaceCharacter))
  }
}
