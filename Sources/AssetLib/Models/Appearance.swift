/**
 Appearance object  used for high contrast or dark mode images.
 */
public protocol Appearance: Hashable {
  /**
   The type of appearance object.
   */
  var appearance: String { get }
  /**
   The value of the appearance object.
   */
  var value: String { get }
}

extension Appearance {
  /**
   Type erases the Appearance object.
   */
  func eraseToAny() -> AnyAppearance {
    return AnyAppearance(appearance: appearance, value: value)
  }
}
