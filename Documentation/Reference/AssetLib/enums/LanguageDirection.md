**ENUM**

# `LanguageDirection`

```swift
public enum LanguageDirection: String, Codable
```

The horizontal display direction for the image.

## Cases
### `leftToRight`

```swift
case leftToRight = "left-to-right"
```

The image is used for display in left-to-right languages.
The image is mirrored in right-to-left languages unless a right-to-left version of the image is provided.

### `rightToLeft`

```swift
case rightToLeft = "right-to-left"
```

The image is used for display in right-to-left languages.
The image is mirrored in left-to-right languages unless a left-to-right version of the image is provided.
