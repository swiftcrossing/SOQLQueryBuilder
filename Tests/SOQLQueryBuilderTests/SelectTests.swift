import XCTest
@testable import SOQLQueryBuilder

final class SelectTests: XCTestCase {
  override class func setUp() {
    super.setUp()
    SOQLFunctionBuilder.whitespaceCharacter = .space
  }

  @SOQLFunctionBuilder
  func makeQuery() -> PartialQuery {
    Select(from: Test1Table.self) { test1 in
      test1.Field.allFields
    }
  }

  func test1() {
    let queryString = makeQuery().build()
    let expectedString = #"SELECT Id,Name,Field1__c,Field2__c FROM Test1__c"#
    XCTAssertEqual(queryString, expectedString)
  }

  static var allTests = [
    ("test1", test1),
  ]
}
