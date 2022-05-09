
protocol RuleDecodable: RuleProtocol {
  static func canDecodeType(_ type: String) -> Bool
  init(from decoder: Decoder) throws
  
}


protocol TypedRuleDecodable {
  associatedtype OperatorType : RawRepresentable where OperatorType.RawValue == String
}

extension TypedRuleDecodable {
  static func canDecodeType(_ type: String) -> Bool {
    OperatorType(rawValue: type) != nil
  }
}
 
extension RuleDecodable {
  static func anyRule(from decocder: Decoder) throws -> AnyRule {
    let rule = try Self.init(from: decocder)
    return AnyRule(wrapped: rule)
  }
}
protocol RuleProtocol {
  
}

extension RuleProtocol {
  func equals (rhs: RuleProtocol) -> Bool {
    return false
  }
}

extension RuleProtocol where Self : Equatable {
  func equals (rhs: Self) -> Bool {
    self == rhs
  }
  
  func equals<RHSType: RuleProtocol>(rhs: RHSType) -> Bool {
    guard let rhs = rhs as? Self else {
      return false
    }
    return self == rhs
  }
}
protocol Rule: Codable, Equatable, RuleProtocol {}

struct AnyRule {
  
  let wrapped: RuleProtocol
}

extension AnyRule : Equatable {
  static func == (lhs: AnyRule, rhs: AnyRule) -> Bool {
    lhs.wrapped.equals(rhs: rhs.wrapped)
  }
  
  
}

enum Rules {
  static let types : [RuleDecodable.Type] = [FieldRule.self, CollectionRule.self]
}

public struct FieldRule: Rule, Codable, Equatable, TypedRuleDecodable {

  
  let type : OperatorType
  let field : Field
  let value : String

  public enum Field: String, Codable {
    case locale
    case idiom
    case heightClass
    case widthClass
  }
  
  enum OperatorType: String, Codable  {
    case equals
  }
}

public struct CollectionRule: Rule, Codable, Equatable,TypedRuleDecodable {
  enum CodingKeys : String, CodingKey {
    case type
    case rules
//    case field
//    case value
//    case rules
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)
    //self.type = type
    
    var rules = [AnyRule].init()
    var rulescontainer  = try container.nestedUnkeyedContainer(forKey: .rules)
    while !rulescontainer.isAtEnd {
      let container = try rulescontainer.nestedContainer(keyedBy: SourceRule.CodingKeys.self)
      let ruleType = try container.decode(String.self, forKey: .type)
      let decodableType = Rules.types.first { type in
        type.canDecodeType(ruleType)
      }
      guard let decodableType = decodableType else {
        fatalError()
      }

      rules.append(try decodableType.anyRule(from: decoder))
    }
  }
  let type : OperatorType
  let rules : [AnyRule]
  
  enum OperatorType: String, Codable {
    case and
    case or
  }
}

public struct SourceRule: Codable, Equatable {
//  public enum RuleType: String, Codable {
//    case equals
//    case and
//    case or
//  }
//
//  let type: String
  let rule: AnyRule

  
  enum CodingKeys : String, CodingKey {
    case type
//    case field
//    case value
//    case rules
  }
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let ruleType = try container.decode(String.self, forKey: .type)
    let decodableType = Rules.types.first { type in
      type.canDecodeType(ruleType)
    }
    guard let decodableType = decodableType else {
      fatalError()
    }

    let rule = try decodableType.anyRule(from: decoder)
    self.rule = rule
  }
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
