import Foundation

extension Dictionary where Key == String, Value == Any {
  func strippingNulls() -> Dictionary {
    var dictionary = self
    dictionary.stripNulls()
    return dictionary
  }

  mutating func stripNulls() {
    for (key, value) in self {
      if value is NSNull {
        removeValue(forKey: key)
      } else if let array = value as? [Any] {
        self[key] = array.strippingNulls()
      } else if let dictionary = value as? [String: Any] {
        self[key] = dictionary.strippingNulls()
      }
    }
  }
}
