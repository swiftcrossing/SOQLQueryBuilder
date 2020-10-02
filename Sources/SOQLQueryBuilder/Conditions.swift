
import Foundation

public struct Null: PartialQuery {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public func build() -> String {
    return "\(field.asString)+=+null"
  }
}

public struct NotNull: PartialQuery {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public func build() -> String {
    return "\(field.asString)+!=+null"
  }
}

/// Expression is true if the value in the specified *fieldName* equals the specified *value* in the expression.
/// String comparisons using the equals operator are case-sensitive for unique case-sensitive fields and case-insensitive for all other fields.
public struct Equal: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+=+\(value.asQueryString)"
  }
}

/// Expression is true if the value in the specified fieldName does not equal the specified *value*.
public struct NotEqual: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+!=+\(value.asQueryString)"
  }
}

/// Expression is true if the value in the specified *fieldName* is less than the specified *value*.
public struct LessThan: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+<+\(value.asQueryString)"
  }
}

/// Expression is true if the value in the specified *fieldName* is less than, or equals, the specified *value*.
public struct LessThanOrEqualTo: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+<=+\(value.asQueryString)"
  }
}

/// Expression is true if the value in the specified *fieldName* is greater than the specified *value*.
public struct GreaterThan: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+>+\(value.asQueryString)"
  }
}

/// Expression is true if the value in the specified *fieldName* is greater than or equal to the specified *value*.
public struct GreaterThanOrEqualTo: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+>=+\(value.asQueryString)"
  }
}

/// Expression is true if the value in the specified *fieldName* matches the characters ofthe text string in the specified *value*.
///
/// The LIKE operator in SOQL and SOSL is similar to the LIKE operator in SQL; it provides a mechanism for matching partial text stringsand includes support for wildcards.
/// - The % and _ wildcards are supported for the LIKE operator.
/// - The % wildcard matches zero or more characters.
/// - The _ wildcard matches exactly one character.
/// - The text string in the specified value must be enclosed in single quotes.
/// - The LIKE operator is supported for string fields only.
/// - The LIKE operator performs a case-insensitive match, unlike the case-sensitive matching in SQL.
/// - The LIKE operator in SOQL and SOSL supports escaping of special characters % or _.
/// - Don’t use the backslash character in a search except to escape a special character.
///
/// For example, the following query matches Appleton, Apple, and Appl, but not Bappl:
/// ```
/// SELECT AccountId, FirstName, lastname
/// FROM Contact
/// WHERE lastname LIKE 'appl%'
/// ```
public struct Like: PartialQuery, ValueQuery {
  let field: FieldConvertible
  let value: Value

  public init(field: FieldConvertible, value: Value) {
    self.field = field
    self.value = value
  }

  public func build() -> String {
    "\(field.asString)+LIKE+\(value.asQueryString)"
  }
}

/// If the value equals any one of the specified values in a WHERE clause.
///
/// For example:
/// ```
/// SELECT Name FROM Account
/// WHERE BillingState IN ('California', 'New York')
/// ```
/// The values for IN must be in parentheses. String values must be surrounded by single quotes.
///
/// IN and NOT IN can also be used for semi-joins and anti-joins when querying on ID (primary key) or reference (foreign key) fields.
public struct In: PartialQuery, ValuesQuery {
  let field: FieldConvertible
  let values: [Value]?
  let queryGroup: QueryGroup?

  public init(field: FieldConvertible, values: [Value]) {
    self.field = field
    self.values = values
    self.queryGroup = nil
  }

  public init(_ field: FieldConvertible, @SOQLFunctionBuilder builder: () -> PartialQuery) {
    self.field = field
    self.values = nil
    self.queryGroup = builder().asQueryGroup
  }

  public func build() -> String {
    if let values = values {
      return "\(field.asString)+IN+(\(values.map(\.asQueryString).joined(separator: ",")))"
    } else if let queryGroup = queryGroup {
      return "\(field.asString)+IN+(\(queryGroup.queries.map({ $0.build() }).joined()))"
    } else {
      return ""
    }
  }
}

/// If the value does not equal any of the specified values in a WHERE clause.
///
/// For example:
/// ```
/// SELECT Name FROM Account
/// WHERE BillingState NOT IN ('California', 'New York')
/// ```
/// The values for NOT IN must be in parentheses, and string values must be surrounded by single quotes.
///
/// There is also a logical operator NOT, which is unrelated to this comparison operator.
public struct NotIn: PartialQuery, ValuesQuery {
  let field: FieldConvertible
  let values: [Value]?
  let queryGroup: QueryGroup?

  public init(field: FieldConvertible, values: [Value]) {
    self.field = field
    self.values = values
    self.queryGroup = nil
  }

  public init(_ field: FieldConvertible, @SOQLFunctionBuilder builder: () -> PartialQuery) {
    self.field = field
    self.values = nil
    self.queryGroup = builder().asQueryGroup
  }

  public func build() -> String {
    if let values = values {
      return "\(field.asString)+NOT+IN+(\(values.map(\.asQueryString).joined(separator: ",")))"
    } else if let queryGroup = queryGroup {
      return "\(field.asString)+NOT IN+(\(queryGroup.queries.map({ $0.build() }).joined()))"
    } else {
      return ""
    }
  }
}
