

public struct ValueAppearance<ValueType: AppearanceValue>: Appearance {
  public var value: String {
    appearanceValue.appearanceValue
  }

  public var appearance: String {
    return ValueType.appearanceKey
  }

  let appearanceValue: ValueType

  public init(value: ValueType) {
    appearanceValue = value
  }
}
