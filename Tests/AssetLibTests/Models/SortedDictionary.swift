import Foundation

@objc class SortedDictionary: NSDictionary {
  let values: NSMutableArray = []
  let keys: NSMutableOrderedSet = []

  override var count: Int {
    return keys.count
  }

  override func keyEnumerator() -> NSEnumerator {
    return keys.objectEnumerator()
  }

  override func object(forKey aKey: Any) -> Any? {
    let index = keys.index(of: aKey)
    if index != NSNotFound {
      return values[index]
    }
    return nil
  }

  private func setObject(_ anObject: Any, forKey aKey: String) {
    let index = keys.index(of: aKey)
    if index != NSNotFound {
      values[index] = convertObject(anObject)
    } else {
      keys.add(aKey)
      values.add(convertObject(anObject))
    }
  }

  private func convertObject(_ object: Any) -> Any {
    if let dict = object as? [String: Any] {
      return SortedDictionary(dict)
    } else if let array = object as? [Any] {
      return array.map {
        convertObject($0)
      }
    } else {
      return object
    }
  }

  @objc convenience init(_ dictionary: [String: Any]) {
    self.init()
    dictionary.sorted {
      $0.0.compare($1.0, options: [.caseInsensitive, .forcedOrdering]) == .orderedAscending
    }
    .forEach {
      self.setObject($0.value, forKey: $0.key)
    }
  }
}
