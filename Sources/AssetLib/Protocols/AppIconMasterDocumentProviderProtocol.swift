/**
 Provides a master `AssetSpecificationDocumentProtocol` for app icons.
 */
public protocol AppIconMasterDocumentProviderProtocol {
  /**
   Provides a master `AssetSpecificationDocumentProtocol` for app icons.
   */
  func document() throws -> AssetSpecificationDocumentProtocol
}
