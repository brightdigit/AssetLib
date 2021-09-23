**STRUCT**

# `TemplateWriter`

```swift
public struct TemplateWriter: TemplateWriterProtocol
```

Writes the resulting template to the url.

## Properties
### `encoder`

```swift
public let encoder: TemplateEncoder
```

## Methods
### `init(encoder:)`

```swift
public init(encoder: TemplateEncoder? = nil)
```

### `saveTemplateResult(_:to:)`

```swift
public func saveTemplateResult(_ result: TemplateResult, to url: URL) throws
```

Writes the resulting template to the url.
 - Parameter result: Template Result
 - Parameter url: Destination url.

#### Parameters

| Name | Description |
| ---- | ----------- |
| result | Template Result |
| url | Destination url. |