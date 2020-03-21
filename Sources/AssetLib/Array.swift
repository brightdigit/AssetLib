extension Array {
  func group<PropertyType>(by keyPath: KeyPath<Element, PropertyType>) -> [PropertyType: [Element]] {
    return Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }
}

enum ProductOperation {
  case replace
  case append
  case modify
}

extension Array where Element == AssetSpecificationProtocol {
  func multiply<PropertyType>(
    by factor: [PropertyType],
    with keyPath: WritableKeyPath<AssetSpecificationBuilder, PropertyType>,
    where filter: ((Element) -> Bool)? = nil,
    operation: ProductOperation = .replace
  ) -> [Element] {
    let multiplier: Self

    if let filter = filter, operation != .modify {
      multiplier = self.filter(filter)
    } else {
      multiplier = self
    }

    let result: [AssetSpecificationProtocol] = multiplier.flatMap { (spec) -> [AssetSpecificationProtocol] in
      guard operation != .modify || filter?(spec) == true else {
        return [spec]
      }
      return factor.map { value in
        var specBuilder = AssetSpecificationBuilder(specifications: spec)
        specBuilder[keyPath: keyPath] = value
        return specBuilder.assetSpec()
      }
    }

    if operation == .append {
      return self + result
    } else {
      return result
    }
  }
}
