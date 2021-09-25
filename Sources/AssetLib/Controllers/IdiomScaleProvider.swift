import Foundation

/**
 Returns the required scales based on the `ImageIdiom`.
 */
public struct IdiomScaleProvider: IdiomScaleProviderProtocol {
  /**
   Dictionary to base scales from.
   */
  public let dictionary: [ImageIdiom: [Float]]

  /**
   Default dictionary to base scales from.
   */
  public static let defaultDictionary: [ImageIdiom: [Float]] = [
    .universal: [1.0, 2.0, 3.0],
    .iphone: [1.0, 2.0, 3.0],
    .ipad: [1.0, 2.0],
    .mac: [1.0, 2.0],
    .tv: [1.0, 2.0],
    .watch: [2.0],
    .car: [2.0, 3.0]
  ]

  /**
   Creates a `IdiomScaleProvider` based on
   the optional`[ImageIdiom: [Float]]` dictionary passed.

   - Parameter dictionary: The optional`[ImageIdiom: [Float]]` dictionary
   otherwise use `IdiomScaleProvider.defaultDictionary`
   */
  public init(dictionary: [ImageIdiom: [Float]]? = nil) {
    self.dictionary = dictionary ?? Self.defaultDictionary
  }

  /**
   Returns the required scales based on the `ImageIdiom`.
   - Parameter idiom: The `ImageIdiom` to lookup scales for.
   - Returns: The Set of `Float` scales
   */
  public func scales(forIdiom idiom: ImageIdiom) -> [Float] {
    dictionary[idiom] ?? [Float]()
  }
}
