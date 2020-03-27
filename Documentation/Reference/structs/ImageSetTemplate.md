**STRUCT**

# `ImageSetTemplate`

```swift
public struct ImageSetTemplate: Codable, Equatable
```

## Properties
### `templateRenderingIntent`

```swift
public let templateRenderingIntent: RenderingIntent?
```

> Specifies if the image is a template for use with visual effects such as replacing colors.
>  For `nil` values, if the name of the image ends in "Template", use the image as a template, otherwise render it as the original image.

### `compressionType`

```swift
public let compressionType: CompressionType
```

> The type of compression

### `preservesVectorRepresentation`

```swift
public let preservesVectorRepresentation: Bool
```

>
> Whether to preserve the vector information for a PDF file.

### `devices`

```swift
public let devices: Set<ImageSetDevice>
```

> The devices supported for the image set.

### `appearances`

```swift
public let appearances: Set<AnyAppearance>
```

> Specific appearances supported by the image set.

### `scaling`

```swift
public let scaling: TemplateScaling?
```

> Specific scaling supported by the ImageSet. `nil` value means both are supported.

### `displayGamuts`

```swift
public let displayGamuts: Bool
```

> Whether to support specific display gamuts.

### `languageDirections`

```swift
public let languageDirections: Set<LanguageDirection>
```

> Specific horizontal display directions for the image set.
>  If only one `LanguageDirection` is specified then the image is mirrored for the other `LanguageDirection`.
>  If no `LanguageDirection` is specified then the image has a fixed horizontal orientation and will display in the same direction.

### `widthClass`

```swift
public let widthClass: SizeClass?
```

> The size class for the image width.

### `heightClass`

```swift
public let heightClass: SizeClass?
```

> The size class for the image height.

### `memorySet`

```swift
public let memorySet: Set<Memory>
```

> Specific memory configurations required by the data item.

### `graphicsFeatureSets`

```swift
public let graphicsFeatureSets: Set<GraphicsFeatureSet>
```

> Graphics feature sets specifically required by the Image Set.

### `appleWatchScreens`

```swift
public let appleWatchScreens: Bool
```

> Whether to allow specific images based on Apple Watch size.

### `autoScaling`

```swift
public let autoScaling: Bool
```

> Whether to allow for auto-scaling of PDFs for the Apple Watch.

### `locales`

```swift
public let locales: Set<Locale>
```

> Locales supported by the asset.

### `onDemandResourceTags`

```swift
public let onDemandResourceTags: Set<String>
```

>
> The on-demand resource tags for the image set.
> *

## Methods
### `init(templateRenderingIntent:compressionType:preservesVectorRepresentation:devices:appearances:scaling:displayGamuts:languageDirections:widthClass:heightClass:memorySet:graphicsFeatureSets:appleWatchScreens:autoScaling:locales:onDemandResourceTags:)`

```swift
public init(
  templateRenderingIntent: RenderingIntent? = nil,
  compressionType: CompressionType = .automatic,
  preservesVectorRepresentation: Bool = false,
  devices: Set<ImageSetDevice> = [.universal],
  appearances: Set<AnyAppearance> = Set(),
  scaling: TemplateScaling? = nil,
  displayGamuts: Bool = false,
  languageDirections: Set<LanguageDirection> = Set(),
  widthClass: SizeClass? = nil,
  heightClass: SizeClass? = nil,
  memorySet: Set<Memory> = Set(),
  graphicsFeatureSets: Set<GraphicsFeatureSet> = Set(),
  appleWatchScreens: Bool = false,
  autoScaling: Bool = false,
  locales: Set<Locale> = Set(),
  onDemandResourceTags: Set<String> = Set()
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