**STRUCT**

# `ValuedAppearance`

```swift
public struct ValuedAppearance<ValueType: AppearanceValue>: Appearance
```

Appearance object  used for high contrast or dark mode images.

## Properties
### `value`

```swift
public var value: String
```

The value of the appearance object.

### `appearance`

```swift
public var appearance: String
```

The type of appearance object.

## Methods
### `init(value:)`

```swift
public init(value: ValueType)
```

Appearance object  based on the value.
