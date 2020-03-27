import Foundation

/**
 Prebuilt scales for App Icons and Image Sets.
 */
public enum Scales: Float {
  /**
   Targeted for unscaled displays.
   */
  case unscaled1x = 1.0
  /**
   Targeted for Retina displays.
   */
  case retina2x = 2.0
  /**
   Targeted for Retina displays with higher density such as those on the iPhone 6 Plus.
   */
  case highdensityretina3x = 3.0
}
