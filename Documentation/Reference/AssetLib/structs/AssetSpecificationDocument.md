**STRUCT**

# `AssetSpecificationDocument`

```swift
public struct AssetSpecificationDocument: AssetSpecificationDocumentProtocol, Codable
```

An asset specification document for an app icon or image set.

## Properties
### `info`

```swift
public let info: AssetSpecificationMetadataProtocol
```

Metadata for the author and format version of the asset catalog.

### `properties`

```swift
public let properties: AssetSpecificationPropertiesProtocol?
```

Properties associated with the app icon or image set.

### `images`

```swift
public let images: [AssetSpecificationProtocol]
```

An array of sizes or variants of an image or icon.

## Methods
### `init(info:images:properties:)`

```swift
public init(
  info: AssetSpecificationMetadataProtocol,
  images: [AssetSpecificationProtocol],
  properties: AssetSpecificationPropertiesProtocol? = nil
)
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