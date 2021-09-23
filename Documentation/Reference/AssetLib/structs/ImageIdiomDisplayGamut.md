**STRUCT**

# `ImageIdiomDisplayGamut`

```swift
public struct ImageIdiomDisplayGamut: ImageIdiomDisplayGamutProtocol
```

Returns whether a speciifc `ImageIdiom` supports display gamuts for App Icons.

## Properties
### `supportedImageIdioms`

```swift
public let supportedImageIdioms: Set<ImageIdiom>
```

Set of `ImageIdiom` which support display gamut.

## Methods
### `supportsDisplayGamut(_:)`

```swift
public func supportsDisplayGamut(_ idiom: ImageIdiom) -> Bool
```

Returns whether a speciifc `ImageIdiom` supports display gamuts for App Icons.
 - Parameter idiom: The `ImageIdiom` to check.
 - Returns: true, if the `ImageIdiom` supports display gamuts for App Icons; false, otherwise.

#### Parameters

| Name | Description |
| ---- | ----------- |
| idiom | The `ImageIdiom` to check. |