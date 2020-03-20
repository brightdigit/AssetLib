extension Array {
  func group<PropertyType>(by keyPath: KeyPath<Element, PropertyType>) -> [PropertyType: [Element]] {
    return Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }
}

func modifySpec<T>(_ keyPath: WritableKeyPath<AssetSpecificationBuilder, T>) -> (AssetSpecificationProtocol, T) -> AssetSpecificationProtocol {
  return {
    spec, value in
    var builder = AssetSpecificationBuilder(specifications: spec)
    builder[keyPath: keyPath] = value
    return builder.assetSpec()
  }
}
