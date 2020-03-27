import AssetLib

struct MockValueType: AppearanceValue {
  static var appearanceKey: String {
    return "mock"
  }

  let appearanceValue: String
}
