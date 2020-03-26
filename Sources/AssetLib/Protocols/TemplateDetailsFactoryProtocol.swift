/**
 Deciphers the details for the template based on the path.
 */
@available(*, deprecated)
public protocol TemplateDetailsFactoryProtocol {
  /**
   Deciphers the details for the template based on the path.
   - Parameter path: Output file path to template.
   */
  func details(fromFilePath path: String) -> TemplateDetails
}
