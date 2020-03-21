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
  func multiply<PropertyType>(by factor: [PropertyType], with keyPath: WritableKeyPath<AssetSpecificationBuilder, PropertyType>, where filter: ((Element) -> Bool)? = nil, append: Bool = false) -> [Element] {
    let multiplier: Self

    if let filter = filter {
      multiplier = self.filter(filter)
    } else {
      multiplier = self
    }

    let result = factor.flatMap { value in
      multiplier.map { spec -> AssetSpecificationProtocol in
        var specBuilder = AssetSpecificationBuilder(specifications: spec)
        specBuilder[keyPath: keyPath] = value
        return specBuilder.assetSpec()
      }
    }

    if append {
      return self + result
    } else {
      return result
    }
  }
}
