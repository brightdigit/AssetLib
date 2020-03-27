import Foundation

/**
 Writes the resulting template to the url.
 */
public struct TemplateWriter: TemplateWriterProtocol {
  public static let shared: TemplateWriterProtocol = TemplateWriter()

  public static let defaultEncoder: TemplateEncoder = {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = [.prettyPrinted]
    return jsonEncoder
  }()

  public let encoder: TemplateEncoder

  public init(encoder: TemplateEncoder? = nil) {
    self.encoder = encoder ?? Self.defaultEncoder
  }

  /**
   Writes the resulting template to the url.
    - Parameter result: Template Result
    - Parameter url: Destination url.
   */
  public func saveTemplateResult(_ result: TemplateResult, to url: URL) throws {
    let document: AssetSpecificationDocumentProtocol
    switch result {
    case let .appicon(template):
      let builder = AppIconTemplateBuilder()
      document = builder.document(fromTemplate: template)
    case let .imageset(template):
      let builder = ImageSetTemplateBuilder()
      document = builder.document(fromTemplate: template)

    case let .failure(error):
      throw error
    }

    let data = try encoder.encode(AssetSpecificationDocument(info: document.info, images: document.images, properties: document.properties))
    try data.write(to: url)
  }
}
