import Foundation

public struct TemplateWriter: TemplateWriterProtocol {
  public static let shared: TemplateWriterProtocol = TemplateWriter()

  public func saveTemplateResult(_ result: TemplateResult, to url: URL) throws {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = [.prettyPrinted]

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

    let data = try jsonEncoder.encode(AssetSpecificationDocument(info: document.info, images: document.images, properties: document.properties))
    try data.write(to: url)
  }
}
