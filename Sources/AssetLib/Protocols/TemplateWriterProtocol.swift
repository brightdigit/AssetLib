import Foundation
/**
 Writes the resulting template to the url.
 */
public protocol TemplateWriterProtocol {
  /**
   Writes the resulting template to the url.
    - Parameter result: Template Result
    - Parameter url: Destination url.
   */
  func saveTemplateResult(_ result: TemplateResult, to url: URL) throws
}
