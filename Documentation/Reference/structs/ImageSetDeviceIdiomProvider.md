**STRUCT**

# `ImageSetDeviceIdiomProvider`

```swift
public struct ImageSetDeviceIdiomProvider: ImageIdiomDependencyProvider
```

## Methods
### `init()`

```swift
public init()
```

### `init(dictionary:)`

```swift
public init?(dictionary: [ImageSetDevice: (ImageIdiom, DeviceSubType?)])
```

### `idioms(forDevice:)`

```swift
public func idioms(forDevice device: ImageSetDevice) -> (ImageIdiom, DeviceSubType?)
```
