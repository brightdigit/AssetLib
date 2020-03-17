import Foundation

public protocol ImageIdiomScaleProvider {
  func scales(forIdiom idiom: ImageIdiom) -> [Float]
}
