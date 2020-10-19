**STRUCT**

# `AssetURLInitializer`

```swift
public struct AssetURLInitializer: AssetURLIntializerProtocol
```

## Properties
### `createDirectory`

```swift
public let createDirectory: ((URL) throws -> Void)?
```

## Methods
### `init(createDirectory:)`

```swift
public init(createDirectory: ((URL) throws -> Void)? = defaultCreateDirectory)
```

### `url(fromPath:withType:)`

```swift
public func url(fromPath path: String, withType type: TemplateType?) throws -> URL
```
