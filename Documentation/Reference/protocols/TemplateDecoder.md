**PROTOCOL**

# `TemplateDecoder`

```swift
public protocol TemplateDecoder
```

## Methods
### `decode(_:from:)`

```swift
func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
```
