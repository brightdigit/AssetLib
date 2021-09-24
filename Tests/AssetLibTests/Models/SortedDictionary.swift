import Foundation

class SortedDictionary: NSDictionary, Comparable {
  static func < (lhs: SortedDictionary, rhs: SortedDictionary) -> Bool {
    if lhs.count == rhs.count {
      let lhe = lhs.keyEnumerator()
      let rhe = rhs.keyEnumerator()
      let enumerations = zip(lhe, rhe)
      for args in enumerations {
        guard let lhk = args.0 as? String else {
          return true
        }
        guard let rhk = args.1 as? String else {
          return false
        }

        let result = lhk.compare(rhk)

        if result == .orderedSame {
          guard let lhv = lhs[lhk] as? String else {
            return true
          }
          guard let rhv = rhs[rhk] as? String else {
            return false
          }
          if lhv == rhv {
            continue
          } else {
            return lhv.compare(rhv) == .orderedAscending
          }
        } else {
          return result == .orderedAscending
        }
      }
      return true
    } else {
      return lhs.count < rhs.count
    }
  }

  let values: NSMutableArray = []
  let keys: NSMutableOrderedSet = []

  override var count: Int {
    keys.count
  }

  override func keyEnumerator() -> NSEnumerator {
    keys.objectEnumerator()
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
      }.sorted { lhs, rhs -> Bool in
        guard let lhd = lhs as? SortedDictionary else {
          return false
        }
        guard let rhd = rhs as? SortedDictionary else {
          return true
        }
        return lhd < rhd
      }
    } else {
      return object
    }
  }

  convenience init(_ dictionary: [String: Any]) {
    self.init()
    dictionary.sorted {
      $0.0.compare($1.0, options: [.caseInsensitive, .forcedOrdering]) == .orderedAscending
    }
    .forEach {
      self.setObject($0.value, forKey: $0.key)
    }
  }
}
