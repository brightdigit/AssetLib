**STRUCT**

# `AssetSpecification`

```swift
public struct AssetSpecification: AssetSpecificationProtocol, Codable
```

> A size or variant of an image or icon.

## Properties
### `idiom`

```swift
public let idiom: ImageIdiom
```

> The device type for the image.

### `scale`

```swift
public let scale: CGFloat?
```

> The targeted display scale for the image or icon.

### `size`

```swift
public let size: CGSize?
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
public let subtype: AppleWatchType?
```

> The type of Apple Watch when there is more than one icon size for a role.

## Methods
### `init(idiom:scale:size:role:subtype:filename:)`

```swift
public init(idiom: ImageIdiom,
            scale: CGFloat? = nil,
            size: CGSize? = nil,
            role: AppleWatchRole? = nil,
            subtype: AppleWatchType? = nil,
            filename: String? = nil)
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
public static func formatSize(_ size: CGSize) -> String
```

> Formats an CGSize for an Asset's size.
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