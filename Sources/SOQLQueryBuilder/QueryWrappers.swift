
public struct EmptyQuery: PartialQuery {
  public func build() -> String { "" }
}

public struct QueryGroup: PartialQuery {
  var queries: [PartialQuery] {
    allQueries
      .filter({ !($0 is EmptyQuery) })
      .flatMap(flattenQuery)
  }
  private let allQueries: [PartialQuery]

  public init(_ allQueries: [PartialQuery]) {
    self.allQueries = allQueries
  }

  public func build() -> String {
    queries.map({ $0.build() }).joined()
  }
}

public struct FieldGroup: PartialQuery, FieldConvertible {
  let fields: [FieldConvertible]

  public var asString: String {
    build()
  }

  public init(_ fields: [FieldConvertible]) {
    self.fields = fields
  }

  public func build() -> String {
    fields.map(\.asString).joined(separator: ",")
  }
}

extension FieldGroup {
  public func adding(_ fields: FieldConvertible...) -> FieldGroup {
    adding(fields)
  }

  public func adding(_ fields: [FieldConvertible]) -> FieldGroup {
    let addingFields = fields.filter({ updateField in
      !self.fields.contains(where: { $0.asString == updateField.asString })
    })
    let updatedFields = self.fields + addingFields
    return FieldGroup(updatedFields)
  }

  public func removing(_ fields: FieldConvertible...) -> FieldGroup {
    removing(fields)
  }

  public func removing(_ fields: [FieldConvertible]) -> FieldGroup {
    var updatedFields = self.fields
    updatedFields.removeAll(where: { updatedField in
      fields.contains(where: { $0.asString == updatedField.asString })
    })
    return FieldGroup(updatedFields)
  }
}

public struct InnerQuery: PartialQuery {
  var queries: [PartialQuery] {
    allQueries
      .filter({ !($0 is EmptyQuery) })
      .flatMap(flattenQuery)
  }
  private let allQueries: [PartialQuery]

  public init(_ allQueries: [PartialQuery]) {
    self.allQueries = allQueries
  }

  public func build() -> String {
    wrap(queries.map({ $0.build() }).joined())
  }
}
