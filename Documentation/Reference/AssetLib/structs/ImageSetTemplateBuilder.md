**STRUCT**

# `ImageSetTemplateBuilder`

```swift
public struct ImageSetTemplateBuilder: AssetTemplateBuilder
```

Builds a `AssetSpecificationDocument` based on the `ImageSetTemplate`

## Properties
### `scaleProvider`

```swift
public let scaleProvider: IdiomScaleProviderProtocol
```

### `dependencyProvider`

```swift
public let dependencyProvider: ISDeviceIdiomProviderProtocol
```

## Methods
### `init()`

```swift
public init()
```

### `document(fromTemplate:)`

```swift
public func document(fromTemplate configuration: ImageSetTemplate) -> AssetSpecificationDocumentProtocol
```

Creates `AssetSpecificationDocumentProtocol` based on the `ImageSetTemplate`.

 - Parameter template: The `ImageSetTemplate`.
 - Returns: The `AssetSpecificationDocumentProtocol`

#### Parameters

| Name | Description |
| ---- | ----------- |
| template | The `ImageSetTemplate`. |