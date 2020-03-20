extension Array {
  func group<PropertyType>(by keyPath: KeyPath<Element, PropertyType>) -> [PropertyType: [Element]] {
    return Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }
}
