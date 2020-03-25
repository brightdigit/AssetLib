**STRUCT**

# `ImageSetTemplate`

```swift
public struct ImageSetTemplate: Codable
```

## Properties
### `renderAs`

```swift
public let renderAs: RenderingIntent?
```

### `compression`

```swift
public let compression: CompressionType
```

> The type of compression

### `preserveVectorData`

```swift
public let preserveVectorData: Bool
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

### `specifyGamut`

```swift
public let specifyGamut: Bool
```

> Whether to support specific display gamuts.

### `direction`

```swift
public let direction: Set<LanguageDirection>
```

> Specific horizontal display directions for the image set.
>  If only one `LanguageDirection` is specified then the image is mirrored for the other `LanguageDirection`.
>  If no `LanguageDirection` is specified then the image has a fixed horizontal orientation and will display in the same direction.

### `specifiedWidthClass`

```swift
public let specifiedWidthClass: SizeClass?
```

### `specifiedHeightClass`

```swift
public let specifiedHeightClass: SizeClass?
```

### `memorySet`

```swift
public let memorySet: Set<Memory>
```

### `graphicFSSet`

```swift
public let graphicFSSet: Set<GraphicsFeatureSet>
```

> Graphics feature sets specifically required by the Image Set.

### `specifyAWWidth`

```swift
public let specifyAWWidth: Bool
```

> Whether to allow specific images based on Apple Watch size.

### `autoScaling`

```swift
public let autoScaling: Bool
```

> Whether to allow for auto-scaling of PDFs for the Apple Watch.

### `locales`

```swift
public let locales: [Locale]
```

### `resourceTags`

```swift
public let resourceTags: Set<String>
```

>
> The on-demand resource tags for the image set.
> *
