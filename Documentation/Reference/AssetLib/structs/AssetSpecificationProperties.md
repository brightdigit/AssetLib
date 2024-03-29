**STRUCT**

# `AssetSpecificationProperties`

```swift
public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol
```

Properties associated with the app icon or image set.

## Properties
### `templateRenderingIntent`

```swift
public let templateRenderingIntent: RenderingIntent?
```

Specifies if the image is a template for use with visual effects such as replacing colors.
 For `nil` values, if the name of the image ends in "Template", use the image as a template, otherwise render it as the original image.

### `autoScaling`

```swift
public let autoScaling: AppleWatchAutoScaingMethod?
```

### `compressionType`

```swift
public let compressionType: CompressionType
```

The type of compression

### `preservesVectorRepresentation`

```swift
public let preservesVectorRepresentation: Bool
```

Set to true to preserve the vector information for a PDF file.

### `localizable`

```swift
public let localizable: Bool
```

Whether localization is supported.

### `preRendered`

```swift
public let preRendered: Bool
```

Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.

### `onDemandResourceTags`

```swift
public let onDemandResourceTags: [String]
```

The on-demand resource tags for the image set.
*

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