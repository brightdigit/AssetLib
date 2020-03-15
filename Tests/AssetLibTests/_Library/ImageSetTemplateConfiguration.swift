@testable import AssetLib
import Foundation

struct ImageSetTemplateConfiguration {
  let renderAs: RenderingIntent?
  let compression: CompressionType
  let preserveVectorData: Bool
  let devices: Set<ImageIdiom>
  let appearances: Set<AnyAppearance>
  let highContrast: Bool
  let scaling: TemplateScaling?
  let specifyGamut: Bool
  let direction: Set<LanguageDirection>
  let specifiedWidthClass: SizeClass?
  let specifiedHeightClass: SizeClass?
  let memorySet: Set<Memory>
  let graphicFSSet: Set<GraphicFeatureSet>
  let specifyAWWidth: Bool
  let autoScaling: Bool
  let locale: Locale?
  let resourceTags: Set<String>
}
