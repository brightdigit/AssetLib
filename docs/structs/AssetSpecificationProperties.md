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
public let compressionType: CompressionType?
```

### `preservesVectorRepresentation`

```swift
public let preservesVectorRepresentation: Bool?
```

### `localizable`

```swift
public let localizable: Bool?
```

## Methods
### `init(templateRenderingIntent:autoScaling:compressionType:preservesVectorRepresentation:localizable:)`

```swift
public init(
  templateRenderingIntent: RenderingIntent?,
  autoScaling: AppleWatchAutoScaingMethod?,
  compressionType: CompressionType?,
  preservesVectorRepresentation: Bool?,
  localizable: Bool?
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