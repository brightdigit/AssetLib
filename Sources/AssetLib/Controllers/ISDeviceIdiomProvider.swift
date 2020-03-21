public struct ISDeviceIdiomProvider: ISDeviceIdiomProviderProtocol {
  let dictionary: [ImageSetDevice: (ImageIdiom, DeviceSubType?)]

  static let defaultDictionray: [ImageSetDevice: (ImageIdiom, DeviceSubType?)] = [
    .universal: (.universal, nil),
    .iphone: (.iphone, nil),
    .ipad: (.ipad, nil),
    .mac: (.mac, nil),
    .tv: (.tv, nil),
    .watch: (.watch, nil),
    .car: (.car, nil),
    .macCatalyst: (.ipad, .macCatalyst)
  ]

  public init() {
    dictionary = Self.defaultDictionray
  }

  public init?(dictionary: [ImageSetDevice: (ImageIdiom, DeviceSubType?)]) {
    guard Set(dictionary.keys) == Set(ImageSetDevice.allCases) else {
      return nil
    }
    self.dictionary = dictionary
  }

  public func idioms(forDevice device: ImageSetDevice) -> (ImageIdiom, DeviceSubType?)? {
    return dictionary[device]
  }
}
