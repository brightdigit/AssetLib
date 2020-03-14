import Foundation

public extension Data {
  func jsonSerialized() -> Data? {
    guard let json = try? JSONSerialization.jsonObject(with: self) else {
      return nil
    }
    let object: Any = {
      if let array = json as? [Any] {
        return array.strippingNulls()
      } else if let dictionary = json as? [String: Any] {
        return dictionary.strippingNulls()
      } else {
        return json
      }
    }()
    if #available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *) {
      if let data = try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys, .prettyPrinted]) {
        return data
      }
    } else if let dictionary = object as? [String: Any] {
      let orderedJson = SortedDictionary(dictionary)

      if let data = try? JSONSerialization.data(withJSONObject: orderedJson, options: [.prettyPrinted]) {
        return data
      }
    }
    return nil
  }

  static func jsonMismatch(lhs: Data, rhs: Data, alreadySerialized: Bool = false) -> Int? {
    switch alreadySerialized {
    case true:
      return _jsonMismatch(lhs: lhs, rhs: rhs)
    case false:
      guard let lhs = lhs.jsonSerialized(), let rhs = rhs.jsonSerialized() else {
        return nil
      }
      return _jsonMismatch(lhs: lhs, rhs: rhs)
    }
  }

  private static func _jsonMismatch(lhs: Data, rhs: Data) -> Int? {
    guard let string1 = String(data: lhs, encoding: .utf8), let string2 = String(data: rhs, encoding: .utf8) else {
      return nil
    }
    let components1 = string1.components(separatedBy: "\n")
    let components2 = string2.components(separatedBy: "\n")
    let count = components1.count < components2.count ? components1.count : components2.count
    for index in 0 ..< count where components1[index] != components2[index] {
      return index
    }
    return nil
  }
}
