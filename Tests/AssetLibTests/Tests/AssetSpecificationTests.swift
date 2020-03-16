@testable import AssetLib
import XCTest

final class AssetSpecificationTests: XCTestCase {
  func testSuccessful() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/Data")
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)

    let contentsJSONUrls = enumerator!.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let documents = contentsJSONUrls.compactMap { url -> (URL, AssetSpecificationDocument, Data)? in
      do {
        let data = try Data(contentsOf: url)
        return try (url, decoder.decode(AssetSpecificationDocument.self, from: data), data)
      } catch {
        XCTFail("\(url): \(error.localizedDescription)")
        return nil
      }
    }

    XCTAssertGreaterThan(contentsJSONUrls.count, 0)
    XCTAssertEqual(contentsJSONUrls.count, documents.count)
    let contentsEncodeds = documents.compactMap { arg -> (URL, Data)? in
      do {
        let data = try encoder.encode(arg.1)
        return (arg.0, data)
      } catch {
        XCTFail("\(arg.0): \(error.localizedDescription)")
        return nil
      }
    }
    XCTAssertEqual(documents.count, contentsEncodeds.count)

    let expected = Dictionary(grouping: documents) { $0.0 }.compactMapValues { $0.first?.2 }
    let actual = Dictionary(grouping: contentsEncodeds) { $0.0 }.compactMapValues { $0.first?.1 }

    XCTAssertEqual(expected.count, actual.count)

    for (url, data) in actual {
      guard let expectedData = expected[url] else {
        XCTFail("No expected data for \(url)")
        continue
      }
      XCTAssertNil(Data.jsonMismatch(lhs: data, rhs: expectedData), "Mismatch at \(url)")
    }
  }

  fileprivate func testInvalidJSON(_ dataDirectoryUrl: URL, _ errorKey: String) {
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)

    let contentsJSONUrls = enumerator!.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    let decoder = JSONDecoder()
    XCTAssertGreaterThan(contentsJSONUrls.count, 0)
    for url in contentsJSONUrls {
      var errorOpt: Error?
      do {
        let data = try Data(contentsOf: url)
        XCTAssertThrowsError(try decoder.decode(AssetSpecificationDocument.self, from: data)) {
          errorOpt = $0
        }
      } catch {
        XCTFail("\(url): \(error.localizedDescription)")
        continue
      }
      guard let error = errorOpt else {
        XCTFail("\(url): did not catch error")
        continue
      }
      guard let decodingError = error as? DecodingError else {
        XCTFail("\(url): \(error.localizedDescription)")
        continue
      }
      XCTAssertEqual(decodingError.keyString, errorKey)
    }
  }

  func testInvalidScale() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/InvalidScale")
    testInvalidJSON(dataDirectoryUrl, "scale")
  }

  func testInvalidSize() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/InvalidSize")
    testInvalidJSON(dataDirectoryUrl, "size")
  }

  func testMetadata() {
    let author = "test"
    let version = 2

    XCTAssertEqual(AssetSpecificationMetadata(author: author, version: version).author, author)
    XCTAssertEqual(AssetSpecificationMetadata(author: author, version: version).version, version)

    XCTAssertEqual(AssetSpecificationMetadata(author: author).author, author)
    XCTAssertEqual(AssetSpecificationMetadata(author: author).version, AssetSpecificationMetadata.defaultVersion)

    XCTAssertEqual(AssetSpecificationMetadata().author, AssetSpecificationMetadata.xcodeAuthor)
    XCTAssertEqual(AssetSpecificationMetadata().version, AssetSpecificationMetadata.defaultVersion)
  }

  func testSpecifications() {
    let idiom = ImageIdiom.car
    let scale = CGFloat.random(in: 1 ... 3)
    let sizeDimension = CGFloat.random(in: 20 ... 200)
    let size = CGSize(width: sizeDimension, height: sizeDimension)
    let role = AppleWatchRole.companionSettings
    let subtype = DeviceSubType.size40
    let filename = "test.png"

    let specifications = AssetSpecification(idiom: idiom, scale: scale, size: size, role: role, subtype: subtype, filename: filename)

    XCTAssertEqual(specifications.idiom, idiom)
    XCTAssertEqual(specifications.scale, scale)
    XCTAssertEqual(specifications.size, size)
    XCTAssertEqual(specifications.role, role)
    XCTAssertEqual(specifications.subtype, subtype)
    XCTAssertEqual(specifications.filename, filename)

    XCTAssertEqual(AssetSpecification(idiom: idiom).scale, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).size, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).role, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).subtype, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).filename, nil)
  }

  func testDecodingError() {
    let error = DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [CodingKey](), debugDescription: ""))
    XCTAssertNil(error.keyString)
  }
}
