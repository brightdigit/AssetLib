@testable import AssetLib

struct AssetTemplateBuilder {
  func document(fromTemplate _: AssetTemplate) -> AssetSpecificationDocumentProtocol {
    _ = ImageSetTemplateConfiguration(
      renderAs: nil,
      compression: .automatic,
      preserveVectorData: false,
      devices: [.mac],
      appearances: [ValueAppearance(value: Luminosity.dark).eraseToAny()],
      highContrast: false,
      scaling: .single,
      specifyGamut: false,
      direction: [.leftToRight],
      specifiedWidthClass: .regular,
      specifiedHeightClass: .compact,
      memorySet: [.requires1GB, .requires4GB],
      graphicFSSet: [.metal4v1],
      specifyAWWidth: true,
      autoScaling: true,
      locale: nil,
      resourceTags: ["tag", "otherTag"]
    )
    fatalError()
  }
}
