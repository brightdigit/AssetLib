protocol Rule: Codable, Equatable {}

struct AnyRule: Codable, Equatable {}

public struct FieldRule: Rule, Codable, Equatable {}

public struct CollectionRule: Rule, Codable, Equatable {}

public struct SourceRule: Codable, Equatable {
  public enum RuleType: String, Codable {
    case equals
    case and
    case or
  }

  public enum Field: String {
    case locale
    case idiom
    case heightClass
    case widthClass
  }

  let type: RuleType
  let rule: AnyRule
}

public struct SourceProvider: Codable, Equatable {
  let `default`: String?
  let rules: [SourceRule]
  func findSource(forSpec _: AssetSpecificationProtocol) -> String? {
    nil
  }
}

public struct AppIconTemplate: Codable, Equatable {
  /// The devices supported for the app icon.
  public let devices: Set<AppIconDevice>

  /**
   Whether to support specific display gamuts.
   */
  public let specifyGamut: Bool

  /***
   Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.
   */
  public let prerendered: Bool

  public let sources: SourceProvider! = nil
  enum CodingKeys: String, CodingKey {
    case devices
    case specifyGamut = "specify-gamut"
    case prerendered = "pre-rendered"
    case sources
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
