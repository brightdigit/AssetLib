/**
 Returns the ImageIdioms based on AppIconDevice.
 */
public struct AppIconDeviceIdiomMap: AppIconDeviceIdiomMapProtocol {
  /**
   Returns the ImageIdioms based on AppIconDevice.

    - Parameter device: The AppIconDevice.
    - Returns: An Array of ImageIdioms based on the AppIconDevice.
   */
  public func idiom(forDevice device: AppIconDevice) -> [ImageIdiom] {
    switch device {
    case .iphone:
      return [.iphone, .iosMarketing]
    case .ipad:
      return [.ipad, .iosMarketing]
    case .mac:
      return [.mac]
    case .tv:
      return [.tv]
    case .watch:
      return [.watch, .watchMarketing]
    case .car:
      return [.car]
    }
  }
}
