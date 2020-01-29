import Foundation

extension DecodingError {
  var keyString: String? {
    switch self {
    case let .dataCorrupted(context):
      return context.codingPath.last?.stringValue
    default:
      return nil
    }
  }
}
