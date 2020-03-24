public struct AppIconTemplate: Codable {
  let devices: Set<AppIconDevice>
  let specifyGamut: Bool
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
