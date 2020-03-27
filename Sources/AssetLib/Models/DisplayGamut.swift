import Foundation

/** The color gamut of the device display. */
public enum DisplayGamut: String, Codable, CaseIterable {
  /**
   The image uses the standard sRGB color space.
   */
  case sRGB
  /**
   The image uses a wide gamut color space.
   */
  case displayP3 = "display-P3"
}
