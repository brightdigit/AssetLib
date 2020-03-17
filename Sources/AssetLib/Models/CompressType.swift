/**
 The type of compression
 */
public enum CompressionType: String, Codable {
  /**
   The image uses an automatic lossy compression.
   */
  case automatic
  /**
   The image uses a lossy GPU compression format optimized for quality.
   */
  case gpuOptimizedBest
  /**

   The image uses a lossy GPU compression format optimized for memory size.
   */
  case gpuOptimizedSmallest
  /**

   The image uses lossless compression.
   This is the default if the compresson-type tag is not included.
   */
  case lossless
  /**
   The image uses basic lossy compression.
   */
  case lossy
}
