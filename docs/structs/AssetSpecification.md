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

### `init(specifications:)`

```swift
public init(specifications: AssetSpecificationProtocol)
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