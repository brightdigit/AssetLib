/**
 Returns the ImageIdioms based on AppIconDevice.
 */
public protocol AppIconDeviceIdiomMapProtocol {
  /**
   Returns the ImageIdioms based on AppIconDevice.

    - Parameter device: The AppIconDevice.
    - Returns: An Array of ImageIdioms based on the AppIconDevice.
   */
  func idiom(forDevice device: AppIconDevice) -> [ImageIdiom]
}
