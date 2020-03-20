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
