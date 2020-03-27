**STRUCT**

# `AppIconMasterDocumentProvider`

```swift
public struct AppIconMasterDocumentProvider: AppIconMasterDocumentProviderProtocol
```

> Provides a master `AssetSpecificationDocumentProtocol` for app icons.

## Properties
### `jsonDecoder`

```swift
public let jsonDecoder = JSONDecoder()
```

> `JSONDecoder` for decoding the `AssetSpecificationDocument`.

## Methods
### `document()`

```swift
public func document() throws -> AssetSpecificationDocumentProtocol
```

> Decodes the `AssetSpecificationDocument` based on the stored Base64 data.
