//
//  File.swift
//  
//
//  Created by Nolan Warner on 2021/05/28.
//

import Foundation

public enum WhitespaceCharacter {
  case space
  case plus

  var asCharacter: Character {
    switch self {
    case .space: return " "
    case .plus: return "+"
    }
  }

  var asString: String {
    String(asCharacter)
  }
}

extension Array where Element == String {
  func joined(separator: WhitespaceCharacter) -> String {
    joined(separator: separator.asString)
  }
}
