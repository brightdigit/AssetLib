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
