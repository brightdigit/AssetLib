/**
 Returns whether a speciifc `ImageIdiom` supports display gamuts for App Icons.
 */
public protocol ImageIdiomDisplayGamutProtocol {
  /**
   Returns whether a speciifc `ImageIdiom` supports display gamuts for App Icons.
    - Parameter idiom: The `ImageIdiom` to check.
    - Returns: true, if the `ImageIdiom` supports display gamuts for App Icons; false, otherwise.
   */
  func supportsDisplayGamut(_ idiom: ImageIdiom) -> Bool
}
