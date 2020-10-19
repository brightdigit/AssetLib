**PROTOCOL**

# `AssetSpecificationPropertiesProtocol`

```swift
public protocol AssetSpecificationPropertiesProtocol: Codable
```

Properties associated with the app icon or image set.

## Properties
### `templateRenderingIntent`

```swift
var templateRenderingIntent: RenderingIntent?
```

Specifies if the image is a template for use with visual effects such as replacing colors.
 For `nil` values, if the name of the image ends in "Template", use the image as a template, otherwise render it as the original image.

### `autoScaling`

```swift
var autoScaling: AppleWatchAutoScaingMethod?
```

### `compressionType`

```swift
var compressionType: CompressionType
```

The type of compression

### `preservesVectorRepresentation`

```swift
var preservesVectorRepresentation: Bool
```

Set to true to preserve the vector information for a PDF file.

### `localizable`

```swift
var localizable: Bool
```

Whether localization is supported.

### `onDemandResourceTags`

```swift
var onDemandResourceTags: [String]
```

The on-demand resource tags for the image set.
*

### `preRendered`

```swift
var preRendered: Bool
```

Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.
