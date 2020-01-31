import AssetLib
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let decoder = JSONDecoder()

    guard let resourceURL = Bundle.main.resourceURL else {
      return false
    }

    guard let enumerator = FileManager.default.enumerator(at: resourceURL, includingPropertiesForKeys: nil) else {
      return false
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

    let documentsViewController = DocumentsTableViewController(style: .plain)
    documentsViewController.documentMap = OrderedDictionary(dictionary: documents)

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = documentsViewController
    window.makeKeyAndVisible()
    self.window = window

    // Override point for customization after application launch.
    return true
  }
}
