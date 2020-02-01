import AppKit
import AssetLib
import Cocoa

final class Cell: NSCollectionViewItem {
  let label = NSTextField()

  override func loadView() {
    view = NSView()
    view.addSubview(label)
    view.wantsLayer = true
  }
}

@available(OSX 10.11, *)
class DocumentsTableViewController: NSViewController, NSCollectionViewDataSource {
  var documentMap: OrderedDictionary<URL, AssetSpecificationDocumentProtocol>? {
    didSet {
      collectionView.reloadData()
    }
  }

  func collectionView(_: NSCollectionView, numberOfItemsInSection _: Int) -> Int {
    return documentMap?.count ?? 0
  }

  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let item = collectionView.makeItem(
      withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"),
      for: indexPath
    )

    guard let cell = item as? Cell else {
      return item
    }

    guard let documentMap = self.documentMap else {
      return cell
    }

    let url = documentMap.keys[indexPath.item]

    cell.label.stringValue = url.deletingLastPathComponent().lastPathComponent
    return cell
  }

  private lazy var collectionView = NSCollectionView()

  override func loadView() {
    view = collectionView
    collectionView.dataSource = self

    collectionView.register(
      Cell.self,
      forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell")
    )
  }
}
