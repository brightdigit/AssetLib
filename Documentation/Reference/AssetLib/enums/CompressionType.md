**ENUM**

# `CompressionType`

```swift
public enum CompressionType: String, Codable
```

The type of compression

## Cases
### `automatic`

```swift
case automatic
```

The image uses an automatic lossy compression.

### `gpuOptimizedBest`

```swift
case gpuOptimizedBest = "gpu-optimized-best"
```

The image uses a lossy GPU compression format optimized for quality.

### `gpuOptimizedSmallest`

```swift
case gpuOptimizedSmallest = "gpu-optimized-smallest"
```

The image uses a lossy GPU compression format optimized for memory size.

### `lossless`

```swift
case lossless
```

The image uses lossless compression.
This is the default if the compresson-type tag is not included.

### `lossy`

```swift
case lossy
```

The image uses basic lossy compression.
