import AssetLib

struct MockValueType: AppearanceValue {
  static var appearanceKey: String {
    "mock"
  }

  let appearanceValue: String
}
