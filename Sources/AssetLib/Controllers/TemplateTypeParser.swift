public struct TemplateTypeParser: TemplateTypeParserProtocol {
  public init() {}

  public func templateType(fromPath path: String) -> TemplateType? {
    let type: TemplateType?
    if let ext = path.components(separatedBy: ".").last {
      if ext == "imageset" {
        type = .imageset
      } else if ext == "appiconset" {
        type = .appicon
      } else {
        type = nil
      }
    } else {
      type = nil
    }
    return type
  }
}
