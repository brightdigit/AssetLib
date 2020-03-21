/**
 Converts `ImageSetDevice` into an `ImageSetIdiomDetail`.
 */
public protocol ISDeviceIdiomProviderProtocol {
  /**
   Provides the `ImageSetIdiomDetail` based on the `ImageSetDevice`,

   - Parameter device: `ImageSetDevice` to lookup.
   - Returns: `ImageSetIdiomDetail` for device.
   */
  func idiom(forDevice device: ImageSetDevice) -> ImageSetIdiomDetail?
}
