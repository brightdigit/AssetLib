protocol AssetTemplateBuilder {
  associatedtype Template
  func document(fromTemplate template: Template) -> AssetSpecificationDocumentProtocol
}
