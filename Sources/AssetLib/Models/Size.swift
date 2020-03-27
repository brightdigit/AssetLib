import Foundation

/**
 The dimensions for the image or icon variant.
 */
public struct Size: Equatable {
  /**
   Size width.
   */
  public let width: Float
  /**
   Size height.
   */
  public let height: Float

  public init(width: Float, height: Float) {
    self.width = width
    self.height = height
  }

  public init(squareWithLength length: Float) {
    width = length
    height = length
  }

  public init(_ size: Sizes) {
    width = size.rawValue
    height = size.rawValue
  }
}
