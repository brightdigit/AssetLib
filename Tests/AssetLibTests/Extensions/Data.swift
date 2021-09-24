import Foundation

public typealias JsonMismatch = (offset: Int, element: (String, String))
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
      debugPrint("***Fallback SORTED***")
      let orderedJson = SortedDictionary(dictionary)

      if let data = try? JSONSerialization.data(withJSONObject: orderedJson, options: [.prettyPrinted]) {
        return data
      }
    }
    return nil
  }

  static func jsonMismatch(lhs: Data, rhs: Data, alreadySerialized: Bool = false) -> [JsonMismatch] {
    switch alreadySerialized {
    case true:
      return _jsonMismatch(lhs: lhs, rhs: rhs)

    case false:
      guard let lhs = lhs.jsonSerialized(), let rhs = rhs.jsonSerialized() else {
        return [JsonMismatch]()
      }
      return _jsonMismatch(lhs: lhs, rhs: rhs)
    }
  }

  private static func _jsonMismatch(lhs: Data, rhs: Data) -> [JsonMismatch] {
    guard let string1 = String(data: lhs, encoding: .utf8), let string2 = String(data: rhs, encoding: .utf8) else {
      return [JsonMismatch]()
    }
    let components1 = string1.components(separatedBy: "\n")
    let components2 = string2.components(separatedBy: "\n")
    return zip(components1, components2).enumerated().filter {
      $1.0 != $1.1
    }
  }
}
