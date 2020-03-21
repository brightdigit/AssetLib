public protocol ISDeviceIdiomProviderProtocol {
  func idioms(forDevice device: ImageSetDevice) -> (ImageIdiom, DeviceSubType?)?
}
