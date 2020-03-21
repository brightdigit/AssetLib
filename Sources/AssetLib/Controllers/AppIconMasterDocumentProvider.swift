import Foundation

struct AppIconMasterDocumentProvider: AppIconMasterDocumentProviderProtocol {
  func document() throws -> AssetSpecificationDocumentProtocol {
    let appIconTemplateData = Data(base64Encoded: _appIconTemplateBase64)!
    let jsonDecoder = JSONDecoder()
    return try jsonDecoder.decode(AssetSpecificationDocument.self, from: appIconTemplateData)
  }

  static let `default`: AppIconMasterDocumentProviderProtocol = AppIconMasterDocumentProvider()
}
