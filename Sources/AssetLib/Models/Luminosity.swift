/**
 Luminosity appearance values for dark-mode and light-mode.
 */
public enum Luminosity: String, AppearanceValue {
  public var appearanceValue: String {
    rawValue
  }

  /**
   Light mode appearance value.
   */
  case light

  /**
   Dakr mode appearance value.
   */
  case dark

  public static var appearanceKey: String {
    "luminosity"
  }
}
