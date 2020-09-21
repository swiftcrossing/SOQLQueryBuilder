
import Foundation

public enum Value {
  case string(String)
  case bool(Bool)
  case int(Int)
  case double(Double)
  case date(Date)
  case dateTime(Date)
  case dateLiteral(DateLiteral)

  var asQueryString: String {
    switch self {
    case .string(let stringValue):
      return "'\(stringValue)'"
    case .bool(let boolValue):
      return "\(boolValue)"
    case .int(let intValue):
      return "\(intValue)"
    case .double(let doubleValue):
      return "\(doubleValue)"
    case .date(let dateValue):
      return "\(dateValue)"
    case .dateTime(let dateValue):
      #warning("Convert to Salesforce DateTime format (yyyy-mm-ddThh-mm-ss.sssZ)")
      return "\(dateValue)"
    case .dateLiteral(let dateLiteralValue):
      #warning("Convert to Salesforce Date format (yyyy-mm-dd)")
      return dateLiteralValue.asValue
    }
  }
}

/// A *fieldExpression* can use a date literal to compare a range of values to the value in a *date* or *dateTime* field. Each literalis a range of time beginning with midnight (00:00:00).
///
/// To find a value within the range, use =. To find values on either side of the range,use > or <.
/// The following table shows the available list of date literals, the ranges they represent, and examples.
///
/// # Note:
/// - If the UNIT in LAST_N_UNIT:n is any unit except DAYS, the date literal does not include the current day. So, for example, LAST_N_WEEKS:1 does not include today.
/// - The two date literals LAST_N_DAYS:n and LAST_90_DAYS do include the current day. So, for example, LAST_N_DAYS:1 includes yesterday and today. And LAST_90_DAYS includes 91 days, not just 90.
///
/// # Minimum and Maximum Dates
/// Only dates within a certain range are valid. The earliest valid date is 1700-01-01T00:00:00Z GMT, or just after midnight on January 1, 1700. The latest valid date is 4000-12-31T00:00:00Z GMT, or just after midnight on December 31, 4000. These values are offset by your time zone. For example, in the Pacific time zone, the earliest valid date is 1699-12-31T16:00:00, or 4:00 PM on December 31, 1699.
public enum DateLiteral {
  /// Starts 00:00:00 the day before and continues for 24 hours.
  case yesterday
  /// Starts 00:00:00 of the current day and continues for 24 hours.
  case today
  /// Starts 00:00:00 after the current day and continues for 24 hours.
  case tomorrow
  /// Starts 00:00:00 on the first day of the week before the most recent first day of the week and continues for seven full days.
  /// Your locale determines the first day of the week.
  case lastWeek
  /// Starts 00:00:00 on the most recent first day of the week on or before the current day and continues for seven full days.
  /// Your locale determines the first day of the week.
  case thisWeek
  /// Starts 00:00:00 on the most recent first day of the week after the current day and continues for seven full days.
  /// Your locale determines the first day of the week.
  case nextWeek
  /// Starts 00:00:00 on the first day of the month before the current day and continues for all the days of that month.
  case lastMonth
  /// Starts 00:00:00 on the first day of the month that the current day is in and continues for all the days of that month.
  case thisMonth
  /// Starts 00:00:00 on the first day of the month after the month that the current day is in and continues for all the days of that month.
  case nextMonth
  /// Starts with the current day and continues for the past 90 days.
  /// This includes the current day, not just previous days. So it includes 91 days in total.
  case last90Days
  /// Starts 00:00:00 of the next day and continues for the next 90 days.
  case next90Days
  /// For the number *n* provided, starts with the current day and continues for the past *n* days.
  /// This includes the current day, not just previous days. For example, LAST_N_DAYS:1 includes yesterday and today.
  case lastNDays(Int)
  /// For the number *n* provided, starts 00:00:00 of the next day and continues for the next *n* days.
  /// This does not include the current day. For example, NEXT_N_DAYS:1 is equivalent to TOMORROW.
  case nextNDays(Int)
  /// For the number *n* provided, starts 00:00:00 of the first day of the next week and continues for the next *n* weeks.
  case nextNWeeks(Int)
  /// For the number *n* provided, starts 00:00:00 of the last day of the previous week and continues for the past *n* weeks.
  case lastNWeeks(Int)
  ///For the number *n* provided, starts 00:00:00 of the first day of the next month and continues for the next *n* months.
  case nextNMonths(Int)
  /// For the number *n* provided, starts 00:00:00 of the last day of the previous month and continues for the past *n* months.
  case lastNMonths(Int)
  /// Starts 00:00:00 of the current quarter and continues to the end of the current quarter.
  case thisQuarter
  /// Starts 00:00:00 of the previous quarter and continues to the end of that quarter.
  case lastQuarter
  /// Starts 00:00:00 of the next quarter and continues to the end of that quarter.
  case nextQuarter
  /// Starts 00:00:00 of the next quarter and continues to the end of the *n*th quarter.
  case nextNQuarters(Int)
  /// Starts 00:00:00 of the previous quarter and continues to the end of the previous *n*th quarter.
  case lastNQuarters(Int)
  /// Starts 00:00:00 on January 1 of the current year and continues through the end of December 31 of the current year.
  case thisYear
  /// Starts 00:00:00 on January 1 of the previous year and continues through the end of December 31 of that year.
  case lastYear
  /// Starts 00:00:00 on January 1 of the following year and continues through the end of December 31 of that year.
  case nextYear
  /// Starts 00:00:00 on January 1 of the following year and continues through the end of December 31 of the *n*th year.
  case nextNYears(Int)
  /// Starts 00:00:00 on January 1 of the previous year and continues through the end of December 31 of the previous *n*th year.
  case lastNYears(Int)
  /// Starts 00:00:00 on the first day of the current fiscal quarter and continues through the end of the last day of the fiscal quarter.
  case thisFiscalQuarter
  /// Starts 00:00:00 on the first day of the last fiscal quarter and continues through the end of the last day of that fiscal quarter.
  case lastFiscalQuarter
  /// Starts 00:00:00 on the first day of the next fiscal quarter and continues through the end of the last day of that fiscal quarter.
  case nextFiscalQuarter
  /// Starts 00:00:00 on the first day of the next fiscal quarter and continues through the end of the last day of the *n*th fiscal quarter.
  case nextNFiscalQuarters(Int)
  /// Starts 00:00:00 on the first day of the last fiscal quarter and continues through the end of the last day of the previous *n*th fiscal quarter.
  case lastNFiscalQuarters(Int)
  /// Starts 00:00:00 on the first day of the current fiscal year and continues through the end of the last day of the fiscal year.
  case thisFiscalYear
  /// Starts 00:00:00 on the first day of the last fiscal year and continues through the end of the last day of that fiscal year.
  case lastFiscalYear
  /// Starts 00:00:00 on the first day of the next fiscal year and continues through the end of the last day of that fiscal year.
  case nextFiscalYear
  /// Starts 00:00:00 on the first day of the next fiscal year and continues through the end of the last day of the *n*th fiscal year.
  case nextNFiscalYears(Int)
  /// Starts 00:00:00 on the first day of the last fiscal year and continues through the end of the last day of the previous *n*th fiscal year.
  case lastNFiscalYears(Int)

  var asValue: String {
    let stringValue: String
    switch self {
    case .yesterday: stringValue = "YESTERDAY"
    case .today: stringValue = "TODAY"
    case .tomorrow: stringValue = "TOMORROW"
    case .lastWeek: stringValue = "LAST_WEEK"
    case .thisWeek: stringValue = "THIS_WEEK"
    case .nextWeek: stringValue = "NEXT_WEEK"
    case .lastMonth: stringValue = "LAST_MONTH"
    case .thisMonth: stringValue = "THIS_MONTH"
    case .nextMonth: stringValue = "NEXT_MONTH"
    case .last90Days: stringValue = "LAST_90_DAYS"
    case .next90Days: stringValue = "NEXT_90_DAYS"
    case .lastNDays(let n): stringValue = "LAST_N_DAYS:\(n)"
    case .nextNDays(let n): stringValue = "NEXT_N_DAYS:\(n)"
    case .nextNWeeks(let n): stringValue = "NEXT_N_WEEKS:\(n)"
    case .lastNWeeks(let n): stringValue = "LAST_N_WEEKS:\(n)"
    case .nextNMonths(let n): stringValue = "NEXT_N_MONTHS:\(n)"
    case .lastNMonths(let n): stringValue = "LAST_N_MONTHS:\(n)"
    case .thisQuarter: stringValue = "THIS_QUARTER"
    case .lastQuarter: stringValue = "LAST_QUARTER"
    case .nextQuarter: stringValue = "NEXT_QUARTER"
    case .nextNQuarters(let n): stringValue = "NEXT_N_QUARTERS:\(n)"
    case .lastNQuarters(let n): stringValue = "LAST_N_QUARTERS:\(n)"
    case .thisYear: stringValue = "THIS_YEAR"
    case .lastYear: stringValue = "LAST_YEAR"
    case .nextYear: stringValue = "NEXT_YEAR"
    case .nextNYears(let n): stringValue = "NEXT_N_YEARS:\(n)"
    case .lastNYears(let n): stringValue = "LAST_N_YEARS:\(n)"
    case .thisFiscalQuarter: stringValue = "THIS_FISCAL_QUARTER"
    case .lastFiscalQuarter: stringValue = "LAST_FISCAL_QUARTER"
    case .nextFiscalQuarter: stringValue = "NEXT_FISCAL_QUARTER"
    case .nextNFiscalQuarters(let n): stringValue = "NEXT_N_FISCAL_QUARTERS:\(n)"
    case .lastNFiscalQuarters(let n): stringValue = "LAST_N_FISCAL_QUARTERS:\(n)"
    case .thisFiscalYear: stringValue = "THIS_FISCAL_YEAR"
    case .lastFiscalYear: stringValue = "LAST_FISCAL_YEAR"
    case .nextFiscalYear: stringValue = "NEXT_FISCAL_YEAR"
    case .nextNFiscalYears(let n): stringValue = "NEXT_N_FISCAL_YEARS:\(n)"
    case .lastNFiscalYears(let n): stringValue = "LAST_N_FISCAL_YEARS:\(n)"
    }
    return stringValue
  }
}

