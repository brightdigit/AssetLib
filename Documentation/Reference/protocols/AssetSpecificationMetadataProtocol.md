**PROTOCOL**

# `AssetSpecificationMetadataProtocol`

```swift
public protocol AssetSpecificationMetadataProtocol: Codable
```

> Metadata for the author and format version of the asset catalog.

## Properties
### `author`

```swift
var author: String
```

> The application that authored the asset catalog. Use your bundle ID.

### `version`

```swift
var version: Int
```

> The format version of the asset catalog. Use 1.
