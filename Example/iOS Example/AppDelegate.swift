import AssetLib
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    guard let documentMap = DocumentMap.decodeContents() else {
      return false
    }
    let documentsViewController = DocumentsTableViewController(style: .plain)
    documentsViewController.documentMap = documentMap

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = documentsViewController
    window.makeKeyAndVisible()
    self.window = window

    // Override point for customization after application launch.
    return true
  }
}
