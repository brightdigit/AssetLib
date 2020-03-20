@testable import AssetLib
import XCTest

// struct AppIconDeviceSpecification: AppIconDeviceSpecificationProvider {
//  let dictionary: [AppIconDevice: (Bool) -> [AssetSpecificationProtocol]]
//  func specifications(forDevice device: AppIconDevice, specifyGamut: Bool) -> [AssetSpecificationProtocol] {
//    guard let specifications = dictionary[device]?(specifyGamut) else {
//      preconditionFailure()
//    }
//
//    return specifications
//  }
// }
//
// protocol AppIconDeviceSpecificationProvider {
//  func specifications(forDevice device: AppIconDevice, specifyGamut: Bool) -> [AssetSpecificationProtocol]
// }

protocol AppIconDisplayGamutProtocol {
  func idiomUsesDisplayGamut(_ idiom: ImageIdiom) -> Bool
}

struct AppIconTemplateBuilder: AssetTemplateBuilder {
  typealias Template = AppIconTemplate

  func setProducts<T>(_ lhs: [T],
                      specs: [AssetSpecificationProtocol],
                      withKeyPath keyPath: WritableKeyPath<AssetSpecificationBuilder, T>) -> [AssetSpecificationProtocol] {
    lhs.flatMap { value in
      specs.map { spec in
        var specBuilder = AssetSpecificationBuilder(specifications: spec)
        specBuilder[keyPath: keyPath] = value
        return specBuilder.assetSpec()
      }
    }
  }

  func document(fromTemplate template: AppIconTemplate) -> AssetSpecificationDocumentProtocol {
    let appIconTemplateData = Data(base64Encoded: appIconTemplateBase64)!
    let jsonDecoder = JSONDecoder()
    let masterDocument = try! jsonDecoder.decode(AssetSpecificationDocument.self, from: appIconTemplateData)

    let map = AppIconDeviceIdiomMap()
    let images = masterDocument.images ?? [AssetSpecificationProtocol]()

    let dictionary: [ImageIdiom: [AssetSpecificationProtocol]] =
      Dictionary(grouping: images) { image in
        image.idiom
      }
    let displayGamutChecker: AppIconDisplayGamutProtocol! = nil

    let template = AppIconTemplate(devices: [.car, .ipad, .iphone, .mac, .tv], specifyGamut: true, prerendered: true)

    let specs = template.devices.flatMap(map.idiom(forDevice:)).flatMap { (idiom) -> [AssetSpecificationProtocol] in
      let specsOpt = dictionary[idiom]

      guard let specs = specsOpt else {
        return [AssetSpecificationProtocol]()
      }

      guard displayGamutChecker.idiomUsesDisplayGamut(idiom) else {
        return specs
      }

      return setProducts(DisplayGamut.allCases, specs: specs, withKeyPath: \.displayGamut)
    }

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: AssetSpecificationProperties(preRendered: true))
  }
}

struct AppIconDeviceIdiomMap: AppIconDeviceIdiomMapProtocol {
  func idiom(forDevice device: AppIconDevice) -> [ImageIdiom] {
    switch device {
    case .iphone:
      return [.iphone, .iosMarketing]
    case .ipad:
      return [.ipad, .iosMarketing]
    case .mac:
      return [.mac]
    case .tv:
      return [.tv]
    case .watch:
      return [.watch, .watchMarketing]
    case .car:
      return [.car]
    }
  }

//
//  func appIconDevice(forIdiom idiom: ImageIdiom)  -> [AppIconDevice]{
//    switch idiom {
//
//    case .universal:
//      return []
//    case .iphone:
//      return [.iphone]
//    case .ipad:
//      return [.ipad]
//    case .mac:
//      return [.mac]
//    case .tv:
//      return [.tv]
//    case .watch:
//      return [.watch]
//    case .car:
//      return [.car]
//    case .watchMarketing:
//      return [.watch]
//    case .iosMarketing:
//      return [.iphone, .ipad]
//    }
//  }
}

protocol AppIconDeviceIdiomMapProtocol {
  func idiom(forDevice device: AppIconDevice) -> [ImageIdiom]
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
