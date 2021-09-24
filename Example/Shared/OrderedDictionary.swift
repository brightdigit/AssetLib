import Foundation

struct OrderedDictionary<Key: Hashable, Value> {
  let dictionary: [Key: Value]
  let keys: [Key]

  init(dictionary: [Key: Value]) {
    self.dictionary = dictionary
    keys = [Key](dictionary.keys)
  }

  var count: Int {
    keys.count
  }
}
