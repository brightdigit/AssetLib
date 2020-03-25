**STRUCT**

# `AssetSpecification`

```swift
public struct AssetSpecification: AssetSpecificationProtocol, Codable
```

> A size or variant of an image or icon.

## Properties
### `screenWidth`

```swift
public let screenWidth: AppleWatchScreenWidth?
```

> A different version of an image for each Apple Watch screen size.

### `heightClass`

```swift
public let heightClass: SizeClass?
```

### `widthClass`

```swift
public let widthClass: SizeClass?
```

### `memory`

```swift
public let memory: Memory?
```

### `graphicsFeatureSet`

```swift
public let graphicsFeatureSet: GraphicsFeatureSet?
```

> The graphics feature set required for the item.

### `locale`

```swift
public let locale: Locale?
```

### `idiom`

```swift
public let idiom: ImageIdiom
```

> The device type for the image.

### `scale`

```swift
public let scale: Float?
```

> The targeted display scale for the image or icon.

### `size`

```swift
public let size: Size?
```

> The size of the app icon.

### `filename`

```swift
public let filename: String?
```

> The HEIF, .png, .jpg, or .pdf file for the image.

### `role`

```swift
public let role: AppleWatchRole?
```

> The role for an Apple Watch icon

### `subtype`

```swift
public let subtype: DeviceSubType?
```

> The type of Apple Watch when there is more than one icon size for a role.

### `appearances`

```swift
public let appearances: [AnyAppearance]
```

### `displayGamut`

```swift
public let displayGamut: DisplayGamut?
```

> The color gamut of the device display for the image.

### `languageDirection`

```swift
public let languageDirection: LanguageDirection?
```

## Methods
### `init(idiom:scale:size:role:subtype:filename:appearances:displayGamut:languageDirection:screenWidth:heightClass:widthClass:memory:graphicsFeatureSet:locale:)`

```swift
public init(idiom: ImageIdiom,
            scale: Float? = nil,
            size: Size? = nil,
            role: AppleWatchRole? = nil,
            subtype: DeviceSubType? = nil,
            filename: String? = nil,
            appearances: [AnyAppearance] = [AnyAppearance](),
            displayGamut: DisplayGamut? = nil,
            languageDirection: LanguageDirection? = nil,
            screenWidth: AppleWatchScreenWidth? = nil,
            heightClass: SizeClass? = nil,
            widthClass: SizeClass? = nil,
            memory: Memory? = nil,
            graphicsFeatureSet: GraphicsFeatureSet? = nil,
            locale: Locale? = nil)
```

> Builds an AssetSpecification
> - Parameters:
>   - idiom: The device type for the image.
>   - scale: The size of the app icon.
>   - size: The size of the app icon.
>   - role: The role for an Apple Watch icon.
>   - subtype: The type of Apple Watch when there is more than one icon size for a role.
>   - filename: The HEIF, .png, .jpg, or .pdf file for the image.

#### Parameters

| Name | Description |
| ---- | ----------- |
| idiom | The device type for the image. |
| scale | The size of the app icon. |
| size | The size of the app icon. |
| role | The role for an Apple Watch icon. |
| subtype | The type of Apple Watch when there is more than one icon size for a role. |
| filename | The HEIF, .png, .jpg, or .pdf file for the image. |

### `init(specifications:)`

```swift
public init(specifications: AssetSpecificationProtocol)
```

> Builds an AssetSpecification from an AssetSpecificationProtocol.
> - Parameter specifications: The AssetSpecificationProtocol to copy.

#### Parameters

| Name | Description |
| ---- | ----------- |
| specifications | The AssetSpecificationProtocol to copy. |

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |

### `formatSize(_:)`

```swift
public static func formatSize(_ size: Size) -> String
```

> Formats an Size for an Asset's size.
> - Parameter size: The dimensions for the image or icon variant.

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | The dimensions for the image or icon variant. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | The encoder to write data to. |