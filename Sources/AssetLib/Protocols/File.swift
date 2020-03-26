import Foundation

public protocol AssetURLIntializerProtocol {
  func url(fromPath path: String, withType type: TemplateType?) throws -> URL
}

public struct AssetURLInitializer : AssetURLIntializerProtocol {

  public let createDirectory : ((URL) throws -> Void)?
  
  public static let defaultCreateDirectory = {
    try FileManager.default.createDirectory(at: $0, withIntermediateDirectories: false, attributes: nil)
  }
  
  public init (createDirectory : ((URL) throws -> Void)? = defaultCreateDirectory) {
    self.createDirectory = createDirectory
  }
  
  public func url(fromPath path: String, withType type: TemplateType?) throws -> URL {
    let outputURL: URL
    if type != nil {
      let outputDirURL = URL(fileURLWithPath: path, isDirectory: true)
      try createDirectory?(outputDirURL)
      outputURL = outputDirURL.appendingPathComponent("Contents.json")
    } else {
      outputURL = URL(fileURLWithPath: path)
    }
    return outputURL
  }
}

public protocol TemplateTypeParserProtocol {
  func templateType(fromPath path: String) -> TemplateType?
}


public struct TemplateTypeParser : TemplateTypeParserProtocol {
  public func templateType(fromPath path: String) -> TemplateType? {
    let type: TemplateType?
    if let ext = path.components(separatedBy: ".").last {
      if ext == "imageset" {
        type = .imageset
      } else if ext == "appiconset" {
        type = .appicon
      } else {
        type = nil
      }
    } else {
      type = nil
    }
    return type
  }
}
