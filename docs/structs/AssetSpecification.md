**STRUCT**

# `AssetSpecification`

```swift
public struct AssetSpecification: AssetSpecificationProtocol, Codable
```

## Properties
### `idiom`

```swift
public let idiom: ImageIdiom
```

### `scale`

```swift
public let scale: CGFloat?
```

### `size`

```swift
public let size: CGSize?
```

### `filename`

```swift
public let filename: String?
```

### `role`

```swift
public let role: AppleWatchRole?
```

### `subtype`

```swift
public let subtype: AppleWatchType?
```

## Methods
### `init(idiom:scale:size:role:subtype:filename:)`

```swift
public init(idiom: ImageIdiom,
            scale: CGFloat? = nil,
            size: CGSize? = nil,
            role: AppleWatchRole? = nil,
            subtype: AppleWatchType? = nil,
            filename: String? = nil)
```

### `init(specifications:)`

```swift
public init(specifications: AssetSpecificationProtocol)
```

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | The encoder to write data to. |