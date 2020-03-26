import Foundation

public protocol AssetURLIntializerProtocol {
  func url(fromPath path: String, withType type: TemplateType?) throws -> URL
}
