import XCTest
@testable import SOQLQueryBuilder

final class SOQLQueryBuilderTests: XCTestCase {
  @SOQLFunctionBuilder
  func makeQuery(condition1: Bool, condition2: Bool, condition3: Bool) -> PartialQuery {
    Select(from: Test1Table.self) { test1 in
      test1.Field.allFields
      Relation(from: test1.test2, relationshipName: "OrderItemNo") { test2 in
        test2.Field.id
        test2.Field.name
        Relation(from: test2.test3) { test3 in
          test3.Field.allFields
        }
      }
      if condition1 {
        Select(from: Test2Table.self) { test2 in
          test2.Field.allFields
        }
      } else {
        Select(from: Test2Table.self) { test2 in
          test2.Field.id
        }
      }
    }
    if condition2 {
      Where {
        Or {
          And {
            NotEqual(Test1Table.Field.id, "StringValue")
            Equal(Test1Table.Field.name, 1)
            NotNull(Test1Table.Field.field1)
          }
          if condition3 {
            In(Test1Table.Field.field2, ["AAA", "BBB"])
            And {
              Equal(Test1Table.Field.field1, 1.0)
              NotEqual(Test1Table.Field.field1, true)
              Null(Test1Table.Field.field1)
            }
          }
        }
      }
    }
  }

  func test1() {
    let queryString = makeQuery(condition1: false, condition2: false, condition3: false).build()
    let expectedString = #"SELECT+Id,Name,Field1__c,Field2__c,OrderItemNo__r.Id,OrderItemNo__r.Name,OrderItemNo__r.Test3__r.Id,OrderItemNo__r.Test3__r.Name,OrderItemNo__r.Test3__r.Field6__c,OrderItemNo__r.Test3__r.Field7__c,OrderItemNo__r.Test3__r.Field8__c,(SELECT+Id+FROM+Test2)+FROM+Test1__c"#
    XCTAssertEqual(queryString, expectedString)
  }

  func test2() {
    let queryString = makeQuery(condition1: true, condition2: true, condition3: true).build()
    let expectedString = #"SELECT+Id,Name,Field1__c,Field2__c,OrderItemNo__r.Id,OrderItemNo__r.Name,OrderItemNo__r.Test3__r.Id,OrderItemNo__r.Test3__r.Name,OrderItemNo__r.Test3__r.Field6__c,OrderItemNo__r.Test3__r.Field7__c,OrderItemNo__r.Test3__r.Field8__c,(SELECT+Id,Name,Field3__c,Field4__c,Field5__c+FROM+Test2)+FROM+Test1__c+WHERE+(Id+!=+'StringValue'+AND+Name+=+1+AND+Field1__c+!=+null)+OR+Field2__c+IN+('AAA','BBB')+OR+(Field1__c+=+1.0+AND+Field1__c+!=+true+AND+Field1__c+=+null)"#
    XCTAssertEqual(queryString, expectedString)
  }

  static var allTests = [
    ("test1", test1),
    ("test2", test2),
  ]
}
