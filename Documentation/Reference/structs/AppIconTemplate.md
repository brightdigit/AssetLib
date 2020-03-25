**STRUCT**

# `AppIconTemplate`

```swift
public struct AppIconTemplate: Codable
```

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
