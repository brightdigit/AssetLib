/**
 Converts `ImageSetDevice` into an `ImageSetIdiomDetail`.
 */
public struct ISDeviceIdiomProvider: ISDeviceIdiomProviderProtocol {
  /**
   Dictionary to look up `ImageSetIdiomDetail` based on `ImageSetDevice`.
   */
  public let dictionary: [ImageSetDevice: ImageSetIdiomDetail]

  /**
   Default dictionary to look up `ImageSetIdiomDetail` based on `ImageSetDevice`.
   */
  public static let defaultDictionray: [ImageSetDevice: ImageSetIdiomDetail] = [
    .universal: (.universal, nil),
    .iphone: (.iphone, nil),
    .ipad: (.ipad, nil),
    .mac: (.mac, nil),
    .tv: (.tv, nil),
    .watch: (.watch, nil),
    .car: (.car, nil),
    .macCatalyst: (.ipad, .macCatalyst)
  ]

  /**
   Create `ISDeviceIdiomProvider` based on default dictionary.
   */
  public init() {
    dictionary = Self.defaultDictionray
  }

  /**
   Create `ISDeviceIdiomProvider` based on dictionary passed as long as all `ImageSetDevice` cases are keys.

   - Parameter dictionary: Dictionary to look up `ImageSetIdiomDetail` based on `ImageSetDevice`.
   */
  public init?(dictionary: [ImageSetDevice: ImageSetIdiomDetail]) {
    guard Set(dictionary.keys) == Set(ImageSetDevice.allCases) else {
      return nil
    }
    self.dictionary = dictionary
  }

  /**
   Provides the `ImageSetIdiomDetail` based on the `ImageSetDevice`,

   - Parameter device: `ImageSetDevice` to lookup.
   - Returns: `ImageSetIdiomDetail` for device.
   */
  public func idiom(forDevice device: ImageSetDevice) -> ImageSetIdiomDetail? {
    return dictionary[device]
  }
}
