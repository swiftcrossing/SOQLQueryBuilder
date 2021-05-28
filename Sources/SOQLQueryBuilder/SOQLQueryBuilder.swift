import Foundation

// MARK: - Function builder

@resultBuilder
public struct SOQLFunctionBuilder {
  public static var whitespaceCharacter: WhitespaceCharacter = .space

  public static func buildBlock(_ queries: PartialQuery...) -> PartialQuery {
    QueryGroup(queries)
  }

  public static func buildIf(_ query: PartialQuery?) -> PartialQuery {
    query ?? EmptyQuery()
  }

  public static func buildEither(first: PartialQuery) -> PartialQuery {
    first
  }

  public static func buildEither(second: PartialQuery) -> PartialQuery {
    second
  }
}
