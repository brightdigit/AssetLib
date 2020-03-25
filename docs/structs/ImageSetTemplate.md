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

### `devices`

```swift
public let devices: Set<ImageSetDevice>
```

### `appearances`

```swift
public let appearances: Set<AnyAppearance>
```

### `scaling`

```swift
public let scaling: TemplateScaling?
```

### `specifyGamut`

```swift
public let specifyGamut: Bool
```

### `direction`

```swift
public let direction: Set<LanguageDirection>
```

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
