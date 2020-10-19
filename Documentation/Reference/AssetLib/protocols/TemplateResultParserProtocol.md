**PROTOCOL**

# `TemplateResultParserProtocol`

```swift
public protocol TemplateResultParserProtocol
```

Based on the url, tries to decipher the resulting template.

## Methods
### `template(fromURL:withType:)`

```swift
func template(fromURL url: URL, withType type: TemplateType?) -> TemplateResult
```

Based on the url, tries to decipher the resulting template or error.
- Parameter url: Source file for the template.
- Parameter type: Optional template type, otherwise both types will be attempted.

#### Parameters

| Name | Description |
| ---- | ----------- |
| url | Source file for the template. |
| type | Optional template type, otherwise both types will be attempted. |