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
var scale: CGFloat?
```

> The targeted display scale for the image or icon.

### `size`

```swift
var size: CGSize?
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
