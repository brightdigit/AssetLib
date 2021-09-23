**STRUCT**

# `AppIconTemplate`

```swift
public struct AppIconTemplate: Codable, Equatable
```

## Properties
### `devices`

```swift
public let devices: Set<AppIconDevice>
```

The devices supported for the app icon.

### `specifyGamut`

```swift
public let specifyGamut: Bool
```

Whether to support specific display gamuts.

### `prerendered`

```swift
public let prerendered: Bool
```

Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.

## Methods
### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |

### `init(devices:specifyGamut:prerendered:)`

```swift
public init(
  devices: Set<AppIconDevice>? = nil,
  specifyGamut: Bool = false,
  prerendered: Bool = false
)
```
