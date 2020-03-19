public protocol Appearance: Hashable {
  var appearance: String { get }
  var value: String { get }
}

extension Appearance {
  func eraseToAny() -> AnyAppearance {
    return AnyAppearance(appearance: appearance, value: value)
  }
}
