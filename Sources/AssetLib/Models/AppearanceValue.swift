/**
 An value which can be used as an appearace.
 */
public protocol AppearanceValue: Hashable, Codable {
  /**
   Key for the Appearance
   */
  static var appearanceKey: String { get }
  /**
   String value of the appearance.
   */
  var appearanceValue: String { get }
}
