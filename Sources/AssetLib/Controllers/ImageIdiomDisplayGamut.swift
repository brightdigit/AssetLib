/**
 Returns whether a speciifc `ImageIdiom` supports display gamuts for App Icons.
 */
public struct ImageIdiomDisplayGamut: ImageIdiomDisplayGamutProtocol {
  /**
   Set of `ImageIdiom` which support display gamut.
   */
  public let supportedImageIdioms: Set<ImageIdiom>

  /**
   Returns whether a speciifc `ImageIdiom` supports display gamuts for App Icons.
    - Parameter idiom: The `ImageIdiom` to check.
    - Returns: true, if the `ImageIdiom` supports display gamuts for App Icons; false, otherwise.
   */
  public func supportsDisplayGamut(_ idiom: ImageIdiom) -> Bool {
    supportedImageIdioms.contains(idiom)
  }
}
