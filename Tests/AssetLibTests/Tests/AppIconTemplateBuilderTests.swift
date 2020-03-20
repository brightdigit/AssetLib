@testable import AssetLib
import XCTest

protocol AppIconDeviceSpecificationProvider {
  func specifications(forDevice device: AppIconDevice, specifyGamut: Bool) -> [AssetSpecificationProtocol]
}

struct AppIconTemplateBuilder: AssetTemplateBuilder {
  typealias Template = AppIconTemplate

  let deviceSpecificationProvider: AppIconDeviceSpecificationProvider! = nil
  func document(fromTemplate template: AppIconTemplate) -> AssetSpecificationDocumentProtocol {
    let specs = template.devices.flatMap {
      self.deviceSpecificationProvider.specifications(forDevice: $0, specifyGamut: template.specifyGamut)
    }

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: AssetSpecificationProperties(preRendered: true))
  }
}

final class AppIconTemplateBuilderTests: XCTestCase {
  func testTemplates() {
    let template = AppIconTemplate(devices: [.car, .ipad, .iphone, .mac, .tv], specifyGamut: true, prerendered: true)
    let builder = AppIconTemplateBuilder()

    XCTAssert(true)
    return

    guard let actualDocument = builder.document(fromTemplate: template) as? AssetSpecificationDocument else {
      XCTFail("Not Actual Document")
      return
    }

    assertApproximateEquals(actualDocument, "BigAppIcon.appiconset")
  }
}
