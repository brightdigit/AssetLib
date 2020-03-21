func product<Multiplier, Factor>(
  _ sequence: [Factor],
  _ other: [Multiplier]
) -> [(Factor, Multiplier)] {
  return other.flatMap { value in
    sequence.map { element in
      (element, value)
    }
  }
}

func product<Multiplier, Factor, Product>(
  _ sequence: [Factor],
  _ other: [Multiplier],
  using closure: (Factor, Multiplier) -> Product
) -> [Product] {
  product(sequence, other).map(closure)
}

@available(*, deprecated)
func setProducts<T>(_ lhs: [T],
                    specs: [AssetSpecificationProtocol],
                    withKeyPath keyPath: WritableKeyPath<AssetSpecificationBuilder, T>) -> [AssetSpecificationProtocol] {
  lhs.flatMap { value in
    specs.map { spec in
      var specBuilder = AssetSpecificationBuilder(specifications: spec)
      specBuilder[keyPath: keyPath] = value
      return specBuilder.assetSpec()
    }
  }
}
