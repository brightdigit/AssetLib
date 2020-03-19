public protocol AppearanceValue: Hashable, Codable {
  static var appearanceKey: String { get }
  var appearanceValue: String { get }
}
