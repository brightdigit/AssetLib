import Foundation

public enum AppleWatchScreenWidth: String, Codable, CaseIterable {
  case size38 = "<=145"
  case size40 = ">161"
  case size42 = ">145"
  case size44 = ">183"
}
