import Foundation

/**
 Based on the url, tries to decipher the resulting template.
 */
public protocol TemplateResultParserProtocol {
  /**
   Based on the url, tries to decipher the resulting template or error.
   - Parameter url: Source file for the template.
   - Parameter type: Optional template type, otherwise both types will be attempted.
   */
  func template(fromURL url: URL, withType type: TemplateType?) -> TemplateResult
}
