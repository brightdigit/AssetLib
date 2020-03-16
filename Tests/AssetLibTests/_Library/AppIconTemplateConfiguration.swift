@testable import AssetLib

struct AppIconTemplateConfiguration: AssetTemplateConfiguration {
  let devices: Set<ImageIdiom>
  let specifyGamut: Bool
  let prerendered: Bool
}
