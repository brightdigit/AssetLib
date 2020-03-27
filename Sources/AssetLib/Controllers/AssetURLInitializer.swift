import Foundation

public struct AssetURLInitializer: AssetURLIntializerProtocol {
  public let createDirectory: ((URL) throws -> Void)?

  public static let defaultCreateDirectory = {
    try FileManager.default.createDirectory(at: $0, withIntermediateDirectories: false, attributes: nil)
  }

  public init(createDirectory: ((URL) throws -> Void)? = defaultCreateDirectory) {
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
