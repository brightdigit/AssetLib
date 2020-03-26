**STRUCT**

# `TemplateResultParser`

```swift
public struct TemplateResultParser: TemplateResultParserProtocol
```

> Based on the url, tries to decipher the resulting template.

## Properties
### `parser`

```swift
public let parser: TemplateParser
```

### `reader`

```swift
public let reader: (URL) throws -> Data
```

## Methods
### `init(parser:reader:)`

```swift
public init(parser: TemplateParser? = nil, reader: ((URL) throws -> Data)? = nil)
```

### `template(fromURL:withType:)`

```swift
public func template(fromURL url: URL, withType type: TemplateType?) -> TemplateResult
```

> Based on the url, tries to decipher the resulting template or error.
> - Parameter url: Source file for the template.
> - Parameter type: Optional template type, otherwise both types will be attempted.

#### Parameters

| Name | Description |
| ---- | ----------- |
| url | Source file for the template. |
| type | Optional template type, otherwise both types will be attempted. |