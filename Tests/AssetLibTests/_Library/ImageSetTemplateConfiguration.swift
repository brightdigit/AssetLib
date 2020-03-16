@testable import AssetLib
import Foundation

struct ImageSetTemplateConfiguration {
  let renderAs: RenderingIntent?
  let compression: CompressionType
  let preserveVectorData: Bool
  let devices: Set<ImageSetDevice>
  let appearances: Set<AnyAppearance>
  let scaling: TemplateScaling?
  let specifyGamut: Bool
  let direction: Set<LanguageDirection>
  let specifiedWidthClass: SizeClass?
  let specifiedHeightClass: SizeClass?
  let memorySet: Set<Memory>
  let graphicFSSet: Set<GraphicsFeatureSet>
  let specifyAWWidth: Bool
  let autoScaling: Bool
  let locales: [Locale]
  let resourceTags: Set<String>
}
