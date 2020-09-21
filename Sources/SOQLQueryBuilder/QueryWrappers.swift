
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

  init(_ allQueries: [PartialQuery]) {
    self.allQueries = allQueries
  }

  public func build() -> String {
    queries.map({ $0.build() }).joined()
  }
}

public struct FieldGroup: PartialQuery {
  let fields: [FieldConvertible]

  init(_ fields: [FieldConvertible]) {
    self.fields = fields
  }

  public func build() -> String {
    fields.map(\.asString).joined(separator: ",")
  }
}
