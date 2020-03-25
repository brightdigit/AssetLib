**PROTOCOL**

# `AssetSpecificationProtocol`

```swift
public protocol AssetSpecificationProtocol
```

> A size or variant of an image or icon.

## Properties
### `idiom`

```swift
var idiom: ImageIdiom
```

> The device type for the image.

### `scale`

```swift
var scale: Float?
```

> The targeted display scale for the image or icon.

### `size`

```swift
var size: Size?
```

> The size of the app icon.

### `filename`

```swift
var filename: String?
```

> The HEIF, .png, .jpg, or .pdf file for the image.

### `role`

```swift
var role: AppleWatchRole?
```

> The role for an Apple Watch icon

### `subtype`

```swift
var subtype: DeviceSubType?
```

> The type of Apple Watch when there is more than one icon size for a role.

### `appearances`

```swift
var appearances: [AnyAppearance]
```

### `displayGamut`

```swift
var displayGamut: DisplayGamut?
```

> The color gamut of the device display for the image.

### `languageDirection`

```swift
var languageDirection: LanguageDirection?
```

### `screenWidth`

```swift
var screenWidth: AppleWatchScreenWidth?
```

> A different version of an image for each Apple Watch screen size.

### `heightClass`

```swift
var heightClass: SizeClass?
```

### `widthClass`

```swift
var widthClass: SizeClass?
```

### `memory`

```swift
var memory: Memory?
```

### `graphicsFeatureSet`

```swift
var graphicsFeatureSet: GraphicsFeatureSet?
```

> The graphics feature set required for the item.

### `locale`

```swift
var locale: Locale?
```
