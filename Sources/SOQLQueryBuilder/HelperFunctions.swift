
func flattenQuery(_ query: PartialQuery) -> [PartialQuery] {
  if let queryGroup = query as? QueryGroup {
    return queryGroup.queries
  } else {
    return [query]
  }
}

func wrap(_ string: String, if condition: @autoclosure () -> Bool = true) -> String {
  condition() ? "(" + string + ")" : string
}

extension String {
  var capitalizedFirst: String {
    self.prefix(1).uppercased() + self.dropFirst()
  }

  func replacingOrAddingSuffix(_ suffix: String, with newSuffix: String) -> String {
    if self.hasSuffix(suffix) {
      return self.dropLast(3) + newSuffix
    } else {
      return self + newSuffix
    }
  }
}
