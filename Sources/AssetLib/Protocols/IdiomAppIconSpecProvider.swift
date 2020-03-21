/**
 Returns the list of basic `AssetSpecificationProtocol` for App Icons  based on an `ImageIdiom`.
 */
public protocol IdiomAppIconSpecProvider {
  /**
   Returns the list of `AssetSpecificationProtocol` based on the `ImageIdiom`.

    - Parameter idiom: The `ImageIdiom`.
    - Returns: An `Array<AssetSpecificationProtocol>` based on the `ImageIdiom`.
   */
  func appIcon(specificationFor idiom: ImageIdiom) -> [AssetSpecificationProtocol]
}
