import Foundation

// MARK:- Table

public protocol Table {
  static var name: String { get }
}

// MARK:- Field

public protocol FieldConvertible: PartialQuery {
  var asString: String { get }
}

public extension FieldConvertible where Self: RawRepresentable, RawValue == String {
  var asString: String {
    rawValue
  }
}

public extension FieldConvertible where Self: CaseIterable {
  static var allFields: FieldGroup {
    FieldGroup(allCases.map(\.asString))
  }
}

public extension FieldConvertible {
  func build() -> String {
    asString
  }
}

extension String: FieldConvertible {
  public var asString: String { self }
}

// MARK:- PartialQuery

public protocol PartialQuery {
  var asQueryGroup: QueryGroup { get }
  func build() -> String
}

public extension PartialQuery {
  var asQueryGroup: QueryGroup {
    if let queryGroup = self as? QueryGroup {
      return queryGroup
    } else {
      return QueryGroup([self])
    }
  }
}

// MARK:- SelectType

protocol SelectType { }

// MARK:- RelationType

protocol RelationType {
  func buildChildren() -> [String]
}

// MARK:- ValueQuery

public protocol ValueQuery {
  init(field: FieldConvertible, value: Value)
}

public extension ValueQuery {
  init(_ field: FieldConvertible, _ stringValue: String) {
    self.init(field: field, value: .string(stringValue))
  }

  init(_ field: FieldConvertible, _ boolValue: Bool) {
    self.init(field: field, value: .bool(boolValue))
  }

  init(_ field: FieldConvertible, _ intValue: Int) {
    self.init(field: field, value: .int(intValue))
  }

  init(_ field: FieldConvertible, _ doubleValue: Double) {
    self.init(field: field, value: .double(doubleValue))
  }

  init(_ field: FieldConvertible, date dateValue: Date) {
    self.init(field: field, value: .date(dateValue))
  }

  init(_ field: FieldConvertible, dateTime dateTimeValue: Date) {
    self.init(field: field, value: .dateTime(dateTimeValue))
  }

  init(_ field: FieldConvertible, _ dateLiteralValue: DateLiteral) {
    self.init(field: field, value: .dateLiteral(dateLiteralValue))
  }
}

// MARK:- ValuesQuery

public protocol ValuesQuery {
  init(field: FieldConvertible, values: [Value])
}

extension ValuesQuery {
  public init(_ field: FieldConvertible, _ stringValues: [String]) {
    self.init(field: field, values: stringValues.map(Value.string))
  }

  public init(_ field: FieldConvertible, _ boolValues: [Bool]) {
    self.init(field: field, values: boolValues.map(Value.bool))
  }

  public init(_ field: FieldConvertible, _ intValues: [Int]) {
    self.init(field: field, values: intValues.map(Value.int))
  }

  public init(_ field: FieldConvertible, _ doubleValues: [Double]) {
    self.init(field: field, values: doubleValues.map(Value.double))
  }

  public init(_ field: FieldConvertible, date dateValues: [Date]) {
    self.init(field: field, values: dateValues.map(Value.date))
  }

  public init(_ field: FieldConvertible, dateTime dateTimeValues: [Date]) {
    self.init(field: field, values: dateTimeValues.map(Value.dateTime))
  }

  public init(_ field: FieldConvertible, _ dateLiteralValues: [DateLiteral]) {
    self.init(field: field, values: dateLiteralValues.map(Value.dateLiteral))
  }
}
