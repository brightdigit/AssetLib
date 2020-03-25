**PROTOCOL**

# `AssetSpecificationPropertiesProtocol`

```swift
public protocol AssetSpecificationPropertiesProtocol: Codable
```

>
> Properties associated with the app icon or image set.

## Properties
### `templateRenderingIntent`

```swift
var templateRenderingIntent: RenderingIntent?
```

### `autoScaling`

```swift
var autoScaling: AppleWatchAutoScaingMethod?
```

### `compressionType`

```swift
var compressionType: CompressionType
```

> The type of compression

### `preservesVectorRepresentation`

```swift
var preservesVectorRepresentation: Bool
```

>
> Set to true to preserve the vector information for a PDF file.

### `localizable`

```swift
var localizable: Bool
```

> Whether localization is supported.

### `onDemandResourceTags`

```swift
var onDemandResourceTags: [String]
```

>
> The on-demand resource tags for the image set.
> *

### `preRendered`

```swift
var preRendered: Bool
```

>
> Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.
