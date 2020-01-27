import Foundation

public protocol RegularExpressionSetProtocol {
  func regularExpression(for key: RegularExpressionKey) -> NSRegularExpression!
}
