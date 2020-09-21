
/// Returns a number representing the calendar month of a date field.
///
/// **Examples:**
/// - 1 for January
/// - 12 for December
public struct CalerdarMonth: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "CALENDAR_MONTH(\(field.asString))"
  }
}

/// Returns a number representing the calendar quarter of a date field.
///
/// **Examples:**
/// - 1 for January 1 through March 31
/// - 2 for April 1 through June 30
/// - 3 for July 1 through September 30
/// - 4 for October 1 through December 31
public struct CalendarQuarter: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "CALENDAR_QUARTER(\(field.asString))"
  }
}

/// Returns a number representing the calendar year of a date field.
///
/// **Examples:**
/// - 2009
public struct CalendarYear: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "CALENDAR_YEAR(\(field.asString))"
  }
}

/// Returns a number representing the day in the month of a date field.
///
/// **Examples:**
/// - 20 for February 20
public struct DayInMonth: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "DAY_IN_MONTH(\(field.asString))"
  }
}

/// Returns a number representing the day of the week for a date field.
///
/// **Examples:**
/// - 1 for Sunday
/// - 7 for Saturday
public struct DayInWeek: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "DAY_IN_WEEK(\(field.asString))"
  }
}

/// Returns a number representing the day in the year for a date field.
///
/// **Examples:**
/// - 32 for February 1
public struct DayInYear: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "DAY_IN_YEAR(\(field.asString))"
  }
}

/// Returns a date representing the day portion of a dateTime field.
///
/// **Examples:**
/// - 2009-09-22 for September 22, 2009
/// *You can only use DAY_ONLY() with dateTime fields.*
public struct DayOnly: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "DAY_ONLY(\(field.asString))"
  }
}

/// Returns a number representing the fiscal month of a date field. This differs from CALENDAR_MONTH() if your organization uses a fiscal year that does not match the Gregorian calendar.
///
/// **Note:**
///
/// This function is not supported if your organization has custom fiscal years enabled. See"Define Your Fiscal Year" in the Salesforce Help.
///
/// **Examples:**
///
/// If your fiscal year starts in March:
///  - 1 for March
///  - 12 for February
public struct FiscalMonth: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "FISCAL_MONTH(\(field.asString))"
  }
}

/// Returns a number representing the fiscal quarter of a date field. This differs from CALENDAR_QUARTER() if your organization uses a fiscal year that does not match the Gregorian calendar.
///
/// **Note:**
///
/// This function is not supported if your organization has custom fiscal years enabled. See"Define Your Fiscal Year" in the Salesforce Help.
///
/// **Examples:**
///
/// If your fiscal year starts in July:
/// - 1 for July 15
/// - 4 for June 6
public struct FiscalQuarter: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "FISCAL_QUARTER(\(field.asString))"
  }
}
/// Returns a number representing the fiscal year of a date field. This differs from CALENDAR_YEAR() if your organization uses a fiscal year that does not match the Gregorian calendar.
///
/// **Note:**
///
/// This function is not supported if your organization has custom fiscal years enabled. See"Define Your Fiscal Year" in the Salesforce Help.
///
/// **Examples:**
/// - 2009
public struct FiscalYear: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "FISCAL_YEAR(\(field.asString))"
  }
}

/// Returns a number representing the hour in the day for a dateTime field.
///
/// **Examples:**
/// - 18 for a time of 18:23:10
///
/// *You can only use HOUR_IN_DAY() with dateTime fields.*
public struct HourInDay: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "HOUR_IN_DAY(\(field.asString))"
  }
}

/// Returns a number representing the week in the month for a date field.
///
/// **Examples:**
/// - 2 for April 10
///
/// *The first week is from the first through the seventh day of the month.*
public struct WeekInMonth: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "WEEK_IN_MONTH(\(field.asString))"
  }
}

/// Returns a number representing the week in the year for a date field.
///
/// **Examples:**
/// - 1 for January 3
///
/// *The first week is from January 1 through January 7.*
public struct WeekInYear: FieldConvertible {
  let field: FieldConvertible

  public init(_ field: FieldConvertible) {
    self.field = field
  }

  public var asString: String {
    "WEEK_IN_YEAR(\(field.asString))"
  }
}
