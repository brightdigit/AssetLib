/**
 Type erased appearance object  used for high contrast or dark mode images.
 */
public struct AnyAppearance: Appearance, Codable {
  /**
   The type of appearance object.
   */
  public let appearance: String
  /**
   The value of the appearance object.
   */
  public let value: String
}
