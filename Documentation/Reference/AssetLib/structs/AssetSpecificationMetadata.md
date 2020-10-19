**STRUCT**

# `AssetSpecificationMetadata`

```swift
public struct AssetSpecificationMetadata: AssetSpecificationMetadataProtocol
```

Metadata for the author and format version of the asset catalog.

## Properties
### `author`

```swift
public let author: String
```

The application that authored the asset catalog. Use your bundle ID.

### `version`

```swift
public let version: Int
```

The format version of the asset catalog. Use 1.

## Methods
### `init(author:version:)`

```swift
public init(author: String = xcodeAuthor, version: Int = defaultVersion)
```
