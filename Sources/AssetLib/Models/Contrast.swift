public enum Contrast: String, AppearanceValue {
  case high

  public static var appearanceKey: String {
    return "contrast"
  }

  public var appearanceValue: String {
    return rawValue
  }
}
