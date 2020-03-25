import Foundation
/**
 A different version of an image for each Apple Watch screen size.
 */
public enum AppleWatchScreenWidth: String, Codable, CaseIterable {
  /**
   38mm Apple Watch.
   */
  case size38 = "<=145"

  /**
   40mm Apple Watch.
   */
  case size40 = ">161"

  /**
   42mm Apple Watch.
   */
  case size42 = ">145"

  /**
   44mm Apple Watch.
   */
  case size44 = ">183"
}
