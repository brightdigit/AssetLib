import Foundation

public protocol TemplateParserProtocol {
  func template(fromURL url: URL, withType type: TemplateType?) -> TemplateResult
}
