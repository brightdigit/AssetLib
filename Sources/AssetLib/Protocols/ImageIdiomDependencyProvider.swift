public protocol ImageIdiomDependencyProvider {
  func idioms(forDevice device: ImageSetDevice) -> (ImageIdiom, DeviceSubType?)
}
