**STRUCT**

# `IdiomAppIconSpecMap`

```swift
public struct IdiomAppIconSpecMap: IdiomAppIconSpecProvider
```

> Returns the list of `AssetSpecificationProtocol` based on the `ImageIdiom` using a `Dictionary`

## Properties
### `dictionary`

```swift
public let dictionary: [ImageIdiom: [AssetSpecificationProtocol]]
```

> The `[ImageIdiom: [AssetSpecificationProtocol]]` Dictionary to base `AssetSpecificationProtocol` on.

## Methods
### `init(dictionary:)`

```swift
public init(dictionary: [ImageIdiom: [AssetSpecificationProtocol]]? = nil)
```

> Creates a `IdiomAppIconSpecMap` based on the `[ImageIdiom: [AssetSpecificationProtocol]]` Dictionary passed.
>
> - Parameter dictionary: The optional `[ImageIdiom: [AssetSpecificationProtocol]]` to use otherwise base it on what `AppIconMasterDocumentProvider` provides.

#### Parameters

| Name | Description |
| ---- | ----------- |
| dictionary | The optional `[ImageIdiom: [AssetSpecificationProtocol]]` to use otherwise base it on what `AppIconMasterDocumentProvider` provides. |

### `appIcon(specificationFor:)`

```swift
public func appIcon(specificationFor idiom: ImageIdiom) -> [AssetSpecificationProtocol]
```

> Returns the list of `AssetSpecificationProtocol` based on the `ImageIdiom` using a `Dictionary`. Otherwise returns an empty array.
>
>  - Parameter idiom: The `ImageIdiom`.
>  - Returns: An `Array<AssetSpecificationProtocol>` based on the dictionary, otherwise an empty array.

#### Parameters

| Name | Description |
| ---- | ----------- |
| idiom | The `ImageIdiom`. |