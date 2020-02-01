import Cocoa

public class Application: NSApplication {
  let appDelegate = AppDelegate()

  override init() {
    super.init()
    delegate = appDelegate
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
