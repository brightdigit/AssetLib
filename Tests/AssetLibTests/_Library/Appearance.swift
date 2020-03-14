public protocol AppearanceValue: Hashable, Codable {
  static var appearanceKey: String { get }
}

public enum Luminosity: String, AppearanceValue {
  case light
  case dark

  public static var appearanceKey: String {
    return "luminosity"
  }
}

public struct Appearance<ValueType: AppearanceValue>: Codable, Hashable {
  var appearance: String {
    return ValueType.appearanceKey
  }

  let value: ValueType

  public init(value: ValueType) {
    self.value = value
  }
}
