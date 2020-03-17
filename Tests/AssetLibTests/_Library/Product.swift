import Foundation

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

func multiply<Multiplier, Factor>(
  sequence: [Factor],
  by other: [Multiplier],
  andAppend shouldAppend: Bool = false,
  onlyIf test: Bool = true,
  using closure: (Factor, Multiplier) -> Factor
) -> [Factor] {
  guard test else {
    return sequence
  }

  guard !other.isEmpty else {
    return sequence
  }

  var newSequence = product(sequence, other, using: closure)

  if shouldAppend {
    newSequence.append(contentsOf: sequence)
  }

  return newSequence
}
