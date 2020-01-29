import Foundation

@available(*, deprecated: 0.0, message: "Just use scale regex.")
public struct RegularExpressionSet: RegularExpressionSetProtocol {
  public func regularExpression(for key: RegularExpressionKey) -> NSRegularExpression! {
    dictionary[key]
  }

  public let dictionary: [RegularExpressionKey: NSRegularExpression]

  public static let shared: RegularExpressionSetProtocol = {
    regularExpressionBuilder in
    // swiftlint:disable:next force_try
    try! regularExpressionBuilder.buildRegularExpressions(fromDictionary: [
      // .geometry: ("x?(\\d+)", options: [.caseInsensitive]),
      // .integer: ("\\d+", options: []),
      .scale: ("(\\d+)x", options: [])
      // .size: ("(\\d+\\.?\\d*)x(\\d+\\.?\\d*)", options: []),
      // .number: ("\\d", options: [])
    ])
  }(RegularExpressionSetBuilder())
}
