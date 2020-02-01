import Cocoa

public class Application: NSApplication {
  let appDelegateContainer = AppDelegate()

  override init() {
    super.init()
    delegate = appDelegateContainer
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
