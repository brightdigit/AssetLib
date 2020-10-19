**PROTOCOL**

# `ISDeviceIdiomProviderProtocol`

```swift
public protocol ISDeviceIdiomProviderProtocol
```

Converts `ImageSetDevice` into an `ImageSetIdiomDetail`.

## Methods
### `idiom(forDevice:)`

```swift
func idiom(forDevice device: ImageSetDevice) -> ImageSetIdiomDetail?
```

Provides the `ImageSetIdiomDetail` based on the `ImageSetDevice`,

- Parameter device: `ImageSetDevice` to lookup.
- Returns: `ImageSetIdiomDetail` for device.

#### Parameters

| Name | Description |
| ---- | ----------- |
| device | `ImageSetDevice` to lookup. |