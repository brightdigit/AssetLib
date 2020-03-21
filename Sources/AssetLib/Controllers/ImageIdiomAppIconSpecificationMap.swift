public struct ImageIdiomAppIconSpecificationMap: ImageIdiomAppIconSpecificationProvider {
  let dictionary: [ImageIdiom: [AssetSpecificationProtocol]]

  // swiftlint:disable force_try
  static let defaultDictionary: [ImageIdiom: [AssetSpecificationProtocol]] =
    try! (AppIconMasterDocumentProvider.default.document().images?.group(by: \.idiom))!
  // swiftlint:enable force_try

  init(dictionary: [ImageIdiom: [AssetSpecificationProtocol]]? = nil) {
    self.dictionary = dictionary ?? ImageIdiomAppIconSpecificationMap.defaultDictionary
  }

  public func appIcon(specificationFor idiom: ImageIdiom) -> [AssetSpecificationProtocol] {
    return dictionary[idiom] ?? [AssetSpecificationProtocol]()
  }
}
