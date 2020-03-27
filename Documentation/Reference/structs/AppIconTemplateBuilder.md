**STRUCT**

# `AppIconTemplateBuilder`

```swift
public struct AppIconTemplateBuilder: AssetTemplateBuilder
```

> Builds a `AssetSpecificationDocument` based on the `AppIconTemplate`

## Properties
### `supportsDisplayGamut`

```swift
public let supportsDisplayGamut: ImageIdiomDisplayGamutProtocol
```

> Tells whether the `ImageIdiom` supports display gamuts.

### `appIconSpecifications`

```swift
public let appIconSpecifications: IdiomAppIconSpecProvider
```

> Returns a list of `AssetSpecificationProtocol` based on the `ImageIdiom`.

### `idiomDeviceMap`

```swift
public let idiomDeviceMap: AppIconDeviceIdiomMapProtocol
```

> Returns a list of `ImageIdiom` based on the  `AppIconDevice`.

## Methods
### `init(supportsDisplayGamut:appIconSpecifications:map:)`

```swift
public init(
  supportsDisplayGamut: ImageIdiomDisplayGamutProtocol? = nil,
  appIconSpecifications: IdiomAppIconSpecProvider? = nil,
  map: AppIconDeviceIdiomMapProtocol? = nil
)
```

> Creates the `AppIconTemplateBuilder`.
> - Parameters:
>   - supportsDisplayGamut: Tells whether the `ImageIdiom` supports display gamuts.
>   - appIconSpecifications: Returns a list of `AssetSpecificationProtocol` based on the `ImageIdiom`.
>   - idiomDeviceMap: Returns a list of `ImageIdiom` based on the  `AppIconDevice`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| supportsDisplayGamut | Tells whether the `ImageIdiom` supports display gamuts. |
| appIconSpecifications | Returns a list of `AssetSpecificationProtocol` based on the `ImageIdiom`. |
| idiomDeviceMap | Returns a list of `ImageIdiom` based on the  `AppIconDevice`. |

### `document(fromTemplate:)`

```swift
public func document(fromTemplate template: AppIconTemplate) -> AssetSpecificationDocumentProtocol
```

> Creates `AssetSpecificationDocumentProtocol` based on the `AppIconTemplate`.
>
>  - Parameter template: The `AppIconTemplate`.
>  - Returns: The `AssetSpecificationDocumentProtocol`

#### Parameters

| Name | Description |
| ---- | ----------- |
| template | The `AppIconTemplate`. |