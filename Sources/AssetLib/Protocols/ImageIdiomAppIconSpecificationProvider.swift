public protocol ImageIdiomAppIconSpecificationProvider {
  func appIcon(specificationFor idiom: ImageIdiom) -> [AssetSpecificationProtocol]
}
