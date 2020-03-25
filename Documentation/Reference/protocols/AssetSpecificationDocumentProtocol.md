**PROTOCOL**

# `AssetSpecificationDocumentProtocol`

```swift
public protocol AssetSpecificationDocumentProtocol: Codable
```

> An asset specification document for an app icon or image set.

## Properties
### `info`

```swift
var info: AssetSpecificationMetadataProtocol
```

> Metadata for the author and format version of the asset catalog.

### `properties`

```swift
var properties: AssetSpecificationPropertiesProtocol?
```

>
> Properties associated with the app icon or image set.

### `images`

```swift
var images: [AssetSpecificationProtocol]?
```

> An array of sizes or variants of an image or icon.
