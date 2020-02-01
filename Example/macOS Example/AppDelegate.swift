import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var window: NSWindow?

  func applicationDidFinishLaunching(_: Notification) {
    // Insert code here to initialize your application

    if #available(OSX 10.11, *) {
      let viewController = DocumentsTableViewController()
      let window = NSWindow(contentViewController: viewController)
      window.setFrame(NSRect(origin: .zero, size: CGSize(width: NSScreen.main!.frame.midX,
                                                         height: NSScreen.main!.frame.midY)), display: true)
      let windowController = NSWindowController(window: window)
      window.makeKeyAndOrderFront(self)
      windowController.showWindow(self)
      self.window = window
      viewController.documentMap = DocumentMap.decodeContents()
    } else {
      // Fallback on earlier versions
    }
  }

  func applicationWillTerminate(_: Notification) {
    // Insert code here to tear down your application
  }
}
