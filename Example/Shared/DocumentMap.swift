import AssetLib
import Foundation

struct DocumentMap {
  private init() {}

  public static func decodeContents() -> OrderedDictionary<URL, AssetSpecificationDocumentProtocol>? {
    let decoder = JSONDecoder()

    guard let resourceURL = Bundle.main.resourceURL else {
      return nil
    }

    guard let enumerator = FileManager.default.enumerator(at: resourceURL, includingPropertiesForKeys: nil) else {
      return nil
    }

    let urls = enumerator.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    var documents = [URL: AssetSpecificationDocumentProtocol]()
    for url in urls {
      guard let data = try? Data(contentsOf: url) else {
        continue
      }

      guard let document = try? decoder.decode(AssetSpecificationDocument.self, from: data) else {
        continue
      }

      documents[url] = document
    }

    return OrderedDictionary(dictionary: documents)
  }
}
