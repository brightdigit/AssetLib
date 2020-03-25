public struct AppIconTemplate: Codable {
  /// The devices supported for the app icon.
  let devices: Set<AppIconDevice>

  /**
   Whether to support specific display gamuts.
   */
  let specifyGamut: Bool

  /***
   Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.
   */
  let prerendered: Bool

  enum CodingKeys: String, CodingKey {
    case devices
    case specifyGamut = "specify-gamut"
    case prerendered = "pre-rendered"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    devices = try container.decodeIfPresent(Set<AppIconDevice>.self, forKey: .devices) ?? Set(AppIconDevice.allCases)
    specifyGamut = try container.decodeIfPresent(Bool.self, forKey: .specifyGamut) ?? false
    prerendered = try container.decodeIfPresent(Bool.self, forKey: .prerendered) ?? false
  }

  public init(
    devices: Set<AppIconDevice>? = nil,
    specifyGamut: Bool = false,
    prerendered: Bool = false
  ) {
    self.devices = devices ?? Set(AppIconDevice.allCases)
    self.specifyGamut = specifyGamut
    self.prerendered = prerendered
  }
}
