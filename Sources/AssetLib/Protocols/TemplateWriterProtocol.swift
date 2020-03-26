import Foundation
public protocol TemplateWriterProtocol {
  func saveTemplateResult(_ result: TemplateResult, to url: URL) throws
}
