import Foundation

/// A size or variant of an image or icon.
public struct AssetSpecification: AssetSpecificationProtocol, Codable {
  public let screenWidth: AppleWatchScreenWidth?
  public let heightClass: SizeClass?
  public let widthClass: SizeClass?
  public let memory: Memory?
  public let graphicsFeatureSet: GraphicsFeatureSet?
  public let locale: Locale?

  /// The device type for the image.
  public let idiom: ImageIdiom
  /// The targeted display scale for the image or icon.
  public let scale: Float?
  /// The size of the app icon.
  public let size: Size?
  /// The HEIF, .png, .jpg, or .pdf file for the image.
  public let filename: String?
  /// The role for an Apple Watch icon
  public let role: AppleWatchRole?
  /// The type of Apple Watch when there is more than one icon size for a role.
  public let subtype: DeviceSubType?

  public let appearances: [AnyAppearance]
  public let displayGamut: DisplayGamut?
  public let languageDirection: LanguageDirection?

  enum CodingKeys: String, CodingKey {
    case idiom
    case scale
    case size
    case filename
    case role
    case subtype
    case appearances
    case displayGamut
    case languageDirection
    case screenWidth
    case heightClass
    case widthClass
    case memory
    case graphicsFeatureSet
    case locale
  }

  /// Builds an AssetSpecification
  /// - Parameters:
  ///   - idiom: The device type for the image.
  ///   - scale: The size of the app icon.
  ///   - size: The size of the app icon.
  ///   - role: The role for an Apple Watch icon.
  ///   - subtype: The type of Apple Watch when there is more than one icon size for a role.
  ///   - filename: The HEIF, .png, .jpg, or .pdf file for the image.
  public init(idiom: ImageIdiom,
              scale: Float? = nil,
              size: Size? = nil,
              role: AppleWatchRole? = nil,
              subtype: DeviceSubType? = nil,
              filename: String? = nil,
              appearances: [AnyAppearance] = [AnyAppearance](),
              displayGamut: DisplayGamut? = nil,
              languageDirection: LanguageDirection? = nil,
              screenWidth: AppleWatchScreenWidth? = nil,
              heightClass: SizeClass? = nil,
              widthClass: SizeClass? = nil,
              memory: Memory? = nil,
              graphicsFeatureSet: GraphicsFeatureSet? = nil,
              locale: Locale? = nil) {
    self.idiom = idiom
    self.scale = scale
    self.size = size
    self.filename = filename
    self.role = role
    self.subtype = subtype
    self.appearances = appearances
    self.displayGamut = displayGamut
    self.languageDirection = languageDirection
    self.screenWidth = screenWidth
    self.heightClass = heightClass
    self.widthClass = widthClass
    self.memory = memory
    self.graphicsFeatureSet = graphicsFeatureSet
    self.locale = locale
  }

  /// Builds an AssetSpecification from an AssetSpecificationProtocol.
  /// - Parameter specifications: The AssetSpecificationProtocol to copy.
  public init(specifications: AssetSpecificationProtocol) {
    idiom = specifications.idiom
    scale = specifications.scale
    size = specifications.size
    filename = specifications.filename
    subtype = specifications.subtype
    role = specifications.role
    appearances = specifications.appearances
    displayGamut = specifications.displayGamut
    languageDirection = specifications.languageDirection
    screenWidth = specifications.screenWidth
    heightClass = specifications.heightClass
    widthClass = specifications.widthClass
    memory = specifications.memory
    graphicsFeatureSet = specifications.graphicsFeatureSet
    locale = specifications.locale
  }

  // swiftlint:disable force_try
  /// Regular Expression for a valid scale value.
  public static let scaleRegularExpression = try! NSRegularExpression(pattern: "(\\d+)x", options: NSRegularExpression.Options())
  // swiftlint:enable force_try

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    idiom = try container.decode(ImageIdiom.self, forKey: .idiom)
    filename = try container.decodeIfPresent(String.self, forKey: .filename)
    if let scaleString = try container.decodeIfPresent(String.self, forKey: .scale) {
      guard let scaleValueString = scaleString.firstMatchGroups(regex: Self.scaleRegularExpression)?[1], let scale = Double(scaleValueString) else {
        throw DecodingError.dataCorruptedError(forKey: .scale, in: container, debugDescription: scaleString)
      }
      self.scale = Float(scale)
    } else {
      scale = nil
    }

    if let sizeString = try container.decodeIfPresent(String.self, forKey: .size) {
      let sizeArray = sizeString.split(separator: Character("x")).map(String.init).compactMap(Float.init)
      guard let width = sizeArray.first, let height = sizeArray.last, sizeArray.count == 2 else {
        throw DecodingError.dataCorruptedError(forKey: .size, in: container, debugDescription: sizeString)
      }
      size = Size(width: width, height: height)
    } else {
      size = nil
    }

    role = try container.decodeIfPresent(AppleWatchRole.self, forKey: .role)
    subtype = try container.decodeIfPresent(DeviceSubType.self, forKey: .subtype)
    appearances = try container.decodeIfPresent([AnyAppearance].self, forKey: .appearances) ?? [AnyAppearance]()
    displayGamut = try container.decodeIfPresent(DisplayGamut.self, forKey: .displayGamut)
    languageDirection = try container.decodeIfPresent(LanguageDirection.self, forKey: .languageDirection)
    screenWidth = try container.decodeIfPresent(AppleWatchScreenWidth.self, forKey: .screenWidth)
    heightClass = try container.decodeIfPresent(SizeClass.self, forKey: .heightClass)
    widthClass = try container.decodeIfPresent(SizeClass.self, forKey: .widthClass)
    memory = try container.decodeIfPresent(Memory.self, forKey: .memory)
    graphicsFeatureSet = try container.decodeIfPresent(GraphicsFeatureSet.self, forKey: .graphicsFeatureSet)

    let localeString = try container.decodeIfPresent(String.self, forKey: .locale)

    locale = localeString.map(Locale.init(identifier:))
  }

  /// Formats an Size for an Asset's size.
  /// - Parameter size: The dimensions for the image or icon variant.
  public static func formatSize(_ size: Size) -> String {
    "\(size.width.clean)x\(size.height.clean)"
  }

  /// Formats a Float for an Asset's scale.
  /// - Parameter size: The scale for the image or icon variant.
  static func formatScale(_ scale: Float) -> String {
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
