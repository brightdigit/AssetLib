import Cocoa

class ViewController: NSViewController {
  override func viewDidLoad() {
    if #available(OSX 10.10, *) {
      super.viewDidLoad()
    } else {
      // Fallback on earlier versions
    }

    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }
}
