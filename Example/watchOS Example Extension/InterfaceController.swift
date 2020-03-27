import Foundation
import WatchKit

class DocumentRow: NSObject {
  @IBOutlet var nameLabel: WKInterfaceLabel!
  @IBOutlet var detailLabel: WKInterfaceLabel!
}

class InterfaceController: WKInterfaceController {
  @IBOutlet var tableView: WKInterfaceTable!
  let documentMap = DocumentMap.decodeContents()
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)

    // Configure interface objects here.

    guard let documentMap = self.documentMap else {
      return
    }

    tableView.setNumberOfRows(documentMap.count, withRowType: "document")

    for (index, url) in documentMap.keys.enumerated() {
      guard let row = tableView.rowController(at: index) as? DocumentRow else {
        continue
      }

      guard let document = documentMap.dictionary[url] else {
        continue
      }

      let name = url.deletingLastPathComponent().lastPathComponent

      row.nameLabel.setText("\(name)")

      if document.images.count > 0 {
        row.detailLabel.setText("\(document.images.count) images")
      } else {
        row.detailLabel.setText("group")
      }
    }
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
}
