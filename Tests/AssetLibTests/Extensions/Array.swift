import Foundation

extension Array where Element == Any {
  func strippingNulls() -> Array {
    var array = self
    array.stripNulls()
    return array
  }

  mutating func stripNulls() {
    guard !self.isEmpty else {
      return
    }
    let count = self.count
    for index in 0 ..< count {
      let translatedIndex = count - 1 - index
      if self[translatedIndex] is NSNull {
        remove(at: translatedIndex)
      } else if let array = self[translatedIndex] as? [Any] {
        self[translatedIndex] = array.strippingNulls()
      } else if let dictionary = self[translatedIndex] as? [String: Any] {
        self[translatedIndex] = dictionary.strippingNulls()
      }
    }
  }
}
