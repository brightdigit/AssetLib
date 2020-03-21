extension Array {
  func group<PropertyType>(by keyPath: KeyPath<Element, PropertyType>) -> [PropertyType: [Element]] {
    return Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }
}

extension WritableKeyPath where Root == AssetSpecificationBuilder {
  func modify(spec: AssetSpecificationProtocol, value: Value) -> AssetSpecificationProtocol {
    var builder = AssetSpecificationBuilder(specifications: spec)
    builder[keyPath: self] = value
    return builder.assetSpec()
  }
}

extension Array where Element == AssetSpecificationProtocol {
  func multiply<PropertyType>(by _: [PropertyType], with _: WritableKeyPath<AssetSpecificationBuilder, PropertyType>, where _: ((Element) -> Bool)? = nil, append _: Bool = false) -> [Element] {
    return self
  }
}
