**PROTOCOL**

# `IdiomScaleProviderProtocol`

```swift
public protocol IdiomScaleProviderProtocol
```

Returns the required scales based on the `ImageIdiom`.

## Methods
### `scales(forIdiom:)`

```swift
func scales(forIdiom idiom: ImageIdiom) -> [Float]
```

Returns the required scales based on the `ImageIdiom`.
- Parameter idiom: The `ImageIdiom` to lookup scales for.
- Returns: The Set of `Float` scales

#### Parameters

| Name | Description |
| ---- | ----------- |
| idiom | The `ImageIdiom` to lookup scales for. |