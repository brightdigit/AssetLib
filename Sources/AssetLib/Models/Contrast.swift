/**
 Apperance Value for providing images with greater visual separation between adjoining colors.
 https://developer.apple.com/documentation/uikit/uiimage/providing_images_for_different_appearances
 */
public enum Contrast: String, AppearanceValue {
  /**
   Apperance Value for providing images with greater visual separation between adjoining colors.
   https://developer.apple.com/documentation/uikit/uiimage/providing_images_for_different_appearances
   */
  case high

  public static var appearanceKey: String {
    "contrast"
  }

  public var appearanceValue: String {
    rawValue
  }
}
