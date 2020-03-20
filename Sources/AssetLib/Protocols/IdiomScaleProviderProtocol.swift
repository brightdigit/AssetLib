import Foundation

public protocol IdiomScaleProviderProtocol {
  func scales(forIdiom idiom: ImageIdiom) -> [Float]
}
