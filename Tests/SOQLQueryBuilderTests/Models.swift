
import Foundation
import SOQLQueryBuilder

struct Test1Table: Table {
  static let name = "Test1__c"
  static let test2 = Test2Table.self

  enum Field: String, CaseIterable, FieldConvertible {
    case id = "Id"
    case name = "Name"
    case field1 = "Field1__c"
    case field2 = "Field2__c"
  }
}

struct Test2Table: Table {
  static let name = "Test2"
  static let test3 = Test3Table.self

  enum Field: String, CaseIterable, FieldConvertible {
    case id = "Id"
    case name = "Name"
    case field3 = "Field3__c"
    case field4 = "Field4__c"
    case field5 = "Field5__c"
  }
}

struct Test3Table: Table {
  static let name = "Test3__c"

  enum Field: String, CaseIterable, FieldConvertible {
    case id = "Id"
    case name = "Name"
    case field6 = "Field6__c"
    case field7 = "Field7__c"
    case field8 = "Field8__c"
  }
}

struct Test4Table: Table {
  static let name = "Test4__c"

  enum Field: String, CaseIterable, FieldConvertible {
    case id = "Id"
    case name = "Name"
    case field9 = "Field9__c"
  }
}


public extension FieldConvertible where Self: RawRepresentable, RawValue == String {
  var asString: String {
    rawValue
  }
}

public extension FieldConvertible {
  func build() -> String {
    asString
  }
}
