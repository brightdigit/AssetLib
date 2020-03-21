import Foundation

/**
 Returns the required scales based on the `ImageIdiom`.
 */
public protocol IdiomScaleProviderProtocol {
  /**
   Returns the required scales based on the `ImageIdiom`.
   - Parameter idiom: The `ImageIdiom` to lookup scales for.
   - Returns: The Set of `Float` scales
   */
  func scales(forIdiom idiom: ImageIdiom) -> [Float]
}
