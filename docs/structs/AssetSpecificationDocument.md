**STRUCT**

# `AssetSpecificationDocument`

```swift
public struct AssetSpecificationDocument: AssetSpecificationDocumentProtocol, Codable
```

## Properties
### `info`

```swift
public let info: AssetSpecificationMetadataProtocol
```

### `images`

```swift
public let images: [AssetSpecificationProtocol]?
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

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | The encoder to write data to. |