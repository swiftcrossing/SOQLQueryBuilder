
/// Returns the average value of a numeric field.
///
/// # Example:
/// ```
/// SELECT CampaignId, AVG(Amount)
/// FROM Opportunity
/// GROUP BY CampaignId
/// ```
///
/// *Available in API version 18.0 and later.*
public struct Avg: FieldConvertible {
  let field: FieldConvertible
  let alias: String?

  public init(_ field: FieldConvertible, alias: String? = nil) {
    self.field = field
    self.alias = alias
  }

  public var asString: String {
    ["AVG(\(field.asString))", alias]
      .compactMap({ $0 })
      .joined(separator: "+")
  }
}

/// Returns the number of rows matching the query criteria.
///
/// # Example using COUNT():
/// ```
/// SELECT COUNT()
/// FROM Account
/// WHERE Name LIKE'a%'
/// ```
///
/// # Example using COUNT(*fieldName*):
/// ```
/// SELECT COUNT(Id)
/// FROM Account
/// WHERE Name LIKE'a%'
/// ```
///
/// # Note:
/// COUNT(Id) in SOQL is equivalent to COUNT(*) in SQL.
///
/// The COUNT(fieldName) syntax is available in API version 18.0 and later.
/// If you are using a GROUP BY clause, use COUNT(fieldName) instead of COUNT().
/// For more information, see COUNT() and COUNT(fieldName)
public struct Count: FieldConvertible {
  let field: FieldConvertible?
  let alias: String?

  public init(_ field: FieldConvertible, alias: String? = nil) {
    self.field = field
    self.alias = alias
  }

  public var asString: String {
    ["COUNT(\(field?.asString ?? ""))", alias]
      .compactMap({ $0 })
      .joined(separator: "+")
  }
}

/// Returns the number of distinct non-null field values matching the query criteria.
///
/// # Example:
/// ```
/// SELECT COUNT_DISTINCT(Company)
/// FROM Lead
/// ```
///
/// # Note:
/// COUNT_DISTINCT(fieldName) in SOQL is equivalent to COUNT(DISTINCT fieldName) in SQL. To query for all the distinct values, including null, for an object, see GROUP BY.
///
/// *Available in API version 18.0 and later.*
public struct CountDistinct: FieldConvertible {
  let field: FieldConvertible?
  let alias: String?

  public init(_ field: FieldConvertible, alias: String? = nil) {
    self.field = field
    self.alias = alias
  }

  public var asString: String {
    ["COUNT_DISTINCT(\(field?.asString ?? ""))", alias]
      .compactMap({ $0 })
      .joined(separator: "+")
  }
}

/// Returns the minimum value of a field
///
/// # Example:
/// ```
/// SELECT MIN(CreatedDate), FirstName, LastName
/// FROM Contact
/// GROUP BY FirstName, LastName
/// ```
///
/// # Note:
/// If you use the MIN() or MAX() functions on a picklist field, the function uses the sort order of the picklist values instead of alphabetical order.
///
/// *Available in API version 18.0 and later.*
public struct MIN: FieldConvertible {
  let field: FieldConvertible?
  let alias: String?

  public init(_ field: FieldConvertible, alias: String? = nil) {
    self.field = field
    self.alias = alias
  }

  public var asString: String {
    ["MIN(\(field?.asString ?? ""))", alias]
      .compactMap({ $0 })
      .joined(separator: "+")
  }
}

/// Returns the maximum value of a field
///
/// # Example:
/// ```
/// SELECT Name, MAX(BudgetedCost)
/// FROM Campaign
/// GROUP BY FirstName, LastName
/// ```
///
/// *Available in API version 18.0 and later.*
public struct MAX: FieldConvertible {
  let field: FieldConvertible?
  let alias: String?

  public init(_ field: FieldConvertible, alias: String? = nil) {
    self.field = field
    self.alias = alias
  }

  public var asString: String {
    ["MAX(\(field?.asString ?? ""))", alias]
      .compactMap({ $0 })
      .joined(separator: "+")
  }
}

/// Returns the total sum of a numeric field.
///
/// # Example:
/// ```
/// SELECT SUM(Amount)
/// FROM Opportunity
/// WHERE IsClosed = false AND Probability > 60
/// ```
///
/// *Available in API version 18.0 and later.*
public struct SUM: FieldConvertible {
  let field: FieldConvertible?
  let alias: String?

  public init(_ field: FieldConvertible, alias: String? = nil) {
    self.field = field
    self.alias = alias
  }

  public var asString: String {
    ["SUM(\(field?.asString ?? ""))", alias]
      .compactMap({ $0 })
      .joined(separator: "+")
  }
}
