@testable import AssetLib
import Foundation

struct ImageSetTemplateConfiguration {
  let renderAs: RenderingIntent?
  let compression: CompressionType
  let preserveVectorData: Bool
  let devices: Set<ImageIdiom>
  let appearance: Set<Appearance<Luminosity>>
  let highContrast: Bool
  let scale: TemplateScaling
  let specifyGamut: Bool
  let direction: Set<LanguageDirection>
  let widthClass: SizeClass?
  let heightClass: SizeClass?
  let memory: Set<Memory>
  let graphicFS: Set<GraphicFeatureSet>
  let specifyAppleWatchScreenWidth: Set<AppleWatchScreenWidth>
  let autoScaling: Bool
  let locale: Locale
  let resourceTags: [String]
}
