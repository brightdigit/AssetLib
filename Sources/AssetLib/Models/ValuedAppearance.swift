/**
 Appearance object  used for high contrast or dark mode images.
 */
public struct ValuedAppearance<ValueType: AppearanceValue>: Appearance {
  /**
   The value of the appearance object.
   */
  public var value: String {
    appearanceValue.appearanceValue
  }

  /**
   The type of appearance object.
   */
  public var appearance: String {
    return ValueType.appearanceKey
  }

  /**
   The strong-typed value of the appearance object.
   */
  let appearanceValue: ValueType

  /**
   Appearance object  based on the value.
   */
  public init(value: ValueType) {
    appearanceValue = value
  }
}
