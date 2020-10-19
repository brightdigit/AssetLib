**STRUCT**

# `IdiomScaleProvider`

```swift
public struct IdiomScaleProvider: IdiomScaleProviderProtocol
```

Returns the required scales based on the `ImageIdiom`.

## Properties
### `dictionary`

```swift
public let dictionary: [ImageIdiom: [Float]]
```

Dictionary to base scales from.

## Methods
### `init(dictionary:)`

```swift
public init(dictionary: [ImageIdiom: [Float]]? = nil)
```

Creates a `IdiomScaleProvider` based on the optional`[ImageIdiom: [Float]]` dictionary passed.

- Parameter dictionary: The optional`[ImageIdiom: [Float]]` dictionary otherwise use `IdiomScaleProvider.defaultDictionary`

#### Parameters

| Name | Description |
| ---- | ----------- |
| dictionary | The optional`[ImageIdiom: [Float]]` dictionary otherwise use `IdiomScaleProvider.defaultDictionary` |

### `scales(forIdiom:)`

```swift
public func scales(forIdiom idiom: ImageIdiom) -> [Float]
```

Returns the required scales based on the `ImageIdiom`.
- Parameter idiom: The `ImageIdiom` to lookup scales for.
- Returns: The Set of `Float` scales

#### Parameters

| Name | Description |
| ---- | ----------- |
| idiom | The `ImageIdiom` to lookup scales for. |