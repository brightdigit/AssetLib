import Foundation

public struct AssetSpecification: AssetSpecificationProtocol, Codable {
  public let idiom: ImageIdiom
  public let scale: CGFloat?
  public let size: CGSize?
  public let filename: String?
  public let role: AppleWatchRole?
  public let subtype: AppleWatchType?

  enum CodingKeys: String, CodingKey {
    case idiom
    case scale
    case size
    case filename
    case role
    case subtype
  }

  public init(idiom: ImageIdiom,
              scale: CGFloat? = nil,
              size: CGSize? = nil,
              role: AppleWatchRole? = nil,
              subtype: AppleWatchType? = nil,
              filename: String? = nil) {
    self.idiom = idiom
    self.scale = scale
    self.size = size
    self.filename = filename
    self.role = role
    self.subtype = subtype
  }

  public init(specifications: AssetSpecificationProtocol) {
    idiom = specifications.idiom
    scale = specifications.scale
    size = specifications.size
    filename = specifications.filename
    subtype = specifications.subtype
    role = specifications.role
  }

  // swiftlint:disable:next force_try
  static let scaleRegex = try! NSRegularExpression(pattern: "(\\d+)x", options: NSRegularExpression.Options())
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    idiom = try container.decode(ImageIdiom.self, forKey: .idiom)
    filename = try container.decodeIfPresent(String.self, forKey: .filename)
    if let scaleString = try container.decodeIfPresent(String.self, forKey: .scale) {
      guard let scaleValueString = scaleString.firstMatchGroups(regex: Self.scaleRegex)?[1], let scale = Double(scaleValueString) else {
        throw DecodingError.dataCorruptedError(forKey: .scale, in: container, debugDescription: scaleString)
      }
      self.scale = CGFloat(scale)
    } else {
      scale = nil
    }

    if let sizeString = try container.decodeIfPresent(String.self, forKey: .size) {
      let sizeArray = sizeString.split(separator: Character("x")).map(String.init).compactMap(Double.init)
      guard let width = sizeArray.first, let height = sizeArray.last, sizeArray.count == 2 else {
        throw DecodingError.dataCorruptedError(forKey: .size, in: container, debugDescription: sizeString)
      }
      size = CGSize(width: width, height: height)
    } else {
      size = nil
    }

    role = try container.decodeIfPresent(AppleWatchRole.self, forKey: .role)
    subtype = try container.decodeIfPresent(AppleWatchType.self, forKey: .subtype)
  }

  static func formatSize(_ size: CGSize) -> String {
    "\(size.width.clean)x\(size.height.clean)"
  }

  static func formatScale(_ scale: CGFloat) -> String {
    let scale = Int(scale.rounded())
    return "\(scale)x"
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if let size = size {
      try container.encode(AssetSpecification.formatSize(size), forKey: .size)
    }

    if let scale = scale {
      try container.encode(AssetSpecification.formatScale(scale), forKey: .scale)
    }

    if let filename = filename {
      try container.encode(filename, forKey: .filename)
    }

    if let subtype = subtype {
      try container.encode(subtype, forKey: .subtype)
    }

    if let role = role {
      try container.encode(role, forKey: .role)
    }

    try container.encode(idiom, forKey: .idiom)
  }
}
