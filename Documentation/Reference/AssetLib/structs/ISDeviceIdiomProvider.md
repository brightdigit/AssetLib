**STRUCT**

# `ISDeviceIdiomProvider`

```swift
public struct ISDeviceIdiomProvider: ISDeviceIdiomProviderProtocol
```

Converts `ImageSetDevice` into an `ImageSetIdiomDetail`.

## Properties
### `dictionary`

```swift
public let dictionary: [ImageSetDevice: ImageSetIdiomDetail]
```

Dictionary to look up `ImageSetIdiomDetail` based on `ImageSetDevice`.

## Methods
### `init()`

```swift
public init()
```

Create `ISDeviceIdiomProvider` based on default dictionary.

### `init(dictionary:)`

```swift
public init?(dictionary: [ImageSetDevice: ImageSetIdiomDetail])
```

Create `ISDeviceIdiomProvider` based on dictionary passed as long as all `ImageSetDevice` cases are keys.

- Parameter dictionary: Dictionary to look up `ImageSetIdiomDetail` based on `ImageSetDevice`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| dictionary | Dictionary to look up `ImageSetIdiomDetail` based on `ImageSetDevice`. |

### `idiom(forDevice:)`

```swift
public func idiom(forDevice device: ImageSetDevice) -> ImageSetIdiomDetail?
```

Provides the `ImageSetIdiomDetail` based on the `ImageSetDevice`,

- Parameter device: `ImageSetDevice` to lookup.
- Returns: `ImageSetIdiomDetail` for device.

#### Parameters

| Name | Description |
| ---- | ----------- |
| device | `ImageSetDevice` to lookup. |