import AssetLib

extension TemplateResult: Equatable {
  public static func == (lhs: TemplateResult, rhs: TemplateResult) -> Bool {
    switch (lhs, rhs) {
    case let (.appicon(lht), .appicon(rht)):
      return lht == rht

    case let (.imageset(lht), .imageset(rht)):
      return lht == rht

    case let (.failure(lhe), .failure(rhe)):
      return lhe.localizedDescription == rhe.localizedDescription

    default:
      return false
    }
  }

  public init?(_ template: Any?) {
    if let appicon = template as? AppIconTemplate {
      self = .appicon(appicon)
    } else if let imageset = template as? ImageSetTemplate {
      self = .imageset(imageset)
    } else {
      return nil
    }
  }
}
