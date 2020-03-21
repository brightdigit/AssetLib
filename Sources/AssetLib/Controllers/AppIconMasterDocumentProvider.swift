import Foundation

/**
 Provides a master `AssetSpecificationDocumentProtocol` for app icons.
 */
public struct AppIconMasterDocumentProvider: AppIconMasterDocumentProviderProtocol {
  /**
   `JSONDecoder` for decoding the `AssetSpecificationDocument`.
   */
  public let jsonDecoder = JSONDecoder()

  /**
   Decodes the `AssetSpecificationDocument` based on the stored Base64 data.
   */
  public func document() throws -> AssetSpecificationDocumentProtocol {
    let appIconTemplateData = Data(base64Encoded: _appIconTemplateBase64)!

    return try jsonDecoder.decode(AssetSpecificationDocument.self, from: appIconTemplateData)
  }

  /**
   Default `AppIconMasterDocumentProviderProtocol`.
   */
  public static let `default`: AppIconMasterDocumentProviderProtocol = AppIconMasterDocumentProvider()
}
