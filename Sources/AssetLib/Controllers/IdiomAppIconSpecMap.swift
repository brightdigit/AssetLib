/**
 Returns the list of `AssetSpecificationProtocol` based on the `ImageIdiom` using a `Dictionary`
 */
public struct IdiomAppIconSpecMap: IdiomAppIconSpecProvider {
  /**
   The `[ImageIdiom: [AssetSpecificationProtocol]]` Dictionary to base `AssetSpecificationProtocol` on.
   */
  public let dictionary: [ImageIdiom: [AssetSpecificationProtocol]]

  // swiftlint:disable force_try
  /**
   The default `[ImageIdiom: [AssetSpecificationProtocol]]` Dictionary based on the default `AppIconMasterDocumentProvider`.
   */
  public static let defaultDictionary: [ImageIdiom: [AssetSpecificationProtocol]] =
    try! (AppIconMasterDocumentProvider.default.document().images?.group(by: \.idiom))!
  // swiftlint:enable force_try

  /**
   Creates a `IdiomAppIconSpecMap` based on the `[ImageIdiom: [AssetSpecificationProtocol]]` Dictionary passed.

   - Parameter dictionary: The optional `[ImageIdiom: [AssetSpecificationProtocol]]` to use otherwise base it on what `AppIconMasterDocumentProvider` provides.
   */
  public init(dictionary: [ImageIdiom: [AssetSpecificationProtocol]]? = nil) {
    self.dictionary = dictionary ?? IdiomAppIconSpecMap.defaultDictionary
  }

  /**
   Returns the list of `AssetSpecificationProtocol` based on the `ImageIdiom` using a `Dictionary`. Otherwise returns an empty array.

    - Parameter idiom: The `ImageIdiom`.
    - Returns: An `Array<AssetSpecificationProtocol>` based on the dictionary, otherwise an empty array.
   */
  public func appIcon(specificationFor idiom: ImageIdiom) -> [AssetSpecificationProtocol] {
    return dictionary[idiom] ?? [AssetSpecificationProtocol]()
  }
}
