**STRUCT**

# `AssetSpecificationProperties`

```swift
public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol
```

## Properties
### `templateRenderingIntent`

```swift
public let templateRenderingIntent: RenderingIntent?
```

### `autoScaling`

```swift
public let autoScaling: AppleWatchAutoScaingMethod?
```

### `compressionType`

```swift
public let compressionType: CompressionType
```

> The type of compression

### `preservesVectorRepresentation`

```swift
public let preservesVectorRepresentation: Bool
```

### `localizable`

```swift
public let localizable: Bool
```

### `preRendered`

```swift
public let preRendered: Bool
```

### `onDemandResourceTags`

```swift
public let onDemandResourceTags: [String]
```

## Methods
### `init(templateRenderingIntent:autoScaling:compressionType:preservesVectorRepresentation:localizable:preRendered:onDemandResourceTags:)`

```swift
public init(
  templateRenderingIntent: RenderingIntent? = nil,
  autoScaling: AppleWatchAutoScaingMethod? = nil,
  compressionType: CompressionType = .automatic,
  preservesVectorRepresentation: Bool = false,
  localizable: Bool = false,
  preRendered: Bool = false,
  onDemandResourceTags: [String] = [String]()
)
```

### `init(properties:)`

```swift
public init(properties: AssetSpecificationPropertiesProtocol)
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