extension Array {
  /**
   Convert the array into a dictionary grouped by keyPath.
   */
  func group<PropertyType>(by keyPath: KeyPath<Element, PropertyType>) -> [PropertyType: [Element]] {
    Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }
}

extension Set {
  /**
   Convert the set into a dictionary grouped by keyPath.
   */
  func group<PropertyType>(by keyPath: KeyPath<Element, PropertyType>) -> [PropertyType: [Element]] {
    Array(self).group(by: keyPath)
  }
}

extension Array where Element == AssetSpecificationProtocol {
  /**
   Creates a Cartesian product with modified values for building templates.
   - Parameters:
   - factor: Property values to create a product with.
   - keyPath: The keyPath of the AssetSpecificationProtocol to update.
   - filter: The filter operation to test whether the AssetSpecificationProtocol should be considered. If `nil` use all values.
   - operation:  Whether to return just the result, append the results, or replace the filtered with modified values.
   */
  func multiply<PropertyType>(
    by factor: [PropertyType],
    with keyPath: WritableKeyPath<AssetSpecificationBuilder, PropertyType>,
    where filter: ((Element) -> Bool)? = nil,
    operation: ProductOperation = .new
  ) -> [Element] {
    let multiplier: Self

    if let filter = filter, operation != .modify {
      multiplier = self.filter(filter)
    } else {
      multiplier = self
    }

    let result: [AssetSpecificationProtocol] = multiplier.flatMap { spec -> [AssetSpecificationProtocol] in
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
