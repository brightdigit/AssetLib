**PROTOCOL**

# `IdiomAppIconSpecProvider`

```swift
public protocol IdiomAppIconSpecProvider
```

Returns the list of basic `AssetSpecificationProtocol` for App Icons  based on an `ImageIdiom`.

## Methods
### `appIcon(specificationFor:)`

```swift
func appIcon(specificationFor idiom: ImageIdiom) -> [AssetSpecificationProtocol]
```

Returns the list of `AssetSpecificationProtocol` based on the `ImageIdiom`.

 - Parameter idiom: The `ImageIdiom`.
 - Returns: An `Array<AssetSpecificationProtocol>` based on the `ImageIdiom`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| idiom | The `ImageIdiom`. |