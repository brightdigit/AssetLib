import Foundation

public struct ScaleListProvider: ImageIdiomScaleProvider {
  let dictionary: [ImageIdiom: [Float]]

  static let defaultDictionary: [ImageIdiom: [Float]] = [
    .universal: [1.0, 2.0, 3.0],
    .iphone: [1.0, 2.0, 3.0],
    .ipad: [1.0, 2.0],
    .mac: [1.0, 2.0],
    .tv: [1.0, 2.0],
    .watch: [2.0],
    .car: [2.0, 3.0]
  ]

  init(dictionary: [ImageIdiom: [Float]]? = nil) {
    self.dictionary = dictionary ?? Self.defaultDictionary
  }

  public func scales(forIdiom idiom: ImageIdiom) -> [Float] {
    return dictionary[idiom] ?? [Float]()
  }
}
