public protocol AppearanceValue: Hashable, Codable {
  static var appearanceKey: String { get }
  var appearanceValue: String { get }
}

public protocol Appearance: Hashable {
  var appearance: String { get }
  var value: String { get }
}

public enum Luminosity: String, AppearanceValue {
  public var appearanceValue: String {
    return rawValue
  }

  case light
  case dark

  public static var appearanceKey: String {
    return "luminosity"
  }
}

struct AnyAppearance: Appearance, Codable {
  public let appearance: String
  public let value: String
}

public struct ValueAppearance<ValueType: AppearanceValue>: Appearance {
  public var value: String {
    appearanceValue.appearanceValue
  }

  public var appearance: String {
    return ValueType.appearanceKey
  }

  let appearanceValue: ValueType

  public init(value: ValueType) {
    appearanceValue = value
  }
}
