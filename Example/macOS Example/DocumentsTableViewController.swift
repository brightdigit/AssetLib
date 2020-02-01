import AppKit
import AssetLib
import Cocoa

final class Cell: NSTableCellView {
  let label = NSTextField()
}

class DocumentsTableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
  var documentMap: OrderedDictionary<URL, AssetSpecificationDocumentProtocol>? {
    didSet {
      tableView.reloadData()
    }
  }

  var initialized = false
  let scrollView = NSScrollView()
  let tableView = NSTableView()

  override func loadView() {
    view = NSView()
  }

  override func viewDidLayout() {
    if !initialized {
      initialized = true
      setupView()
      setupTableView()
    }
  }

  func setupView() {
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))
  }

  func setupTableView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 23))
    view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    tableView.frame = scrollView.bounds
    tableView.delegate = self
    tableView.dataSource = self
    tableView.headerView = nil
    scrollView.backgroundColor = NSColor.clear
    scrollView.drawsBackground = false
    tableView.backgroundColor = NSColor.clear
    if #available(OSX 10.10, *) {
      tableView.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
    }

    let col = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "name"))
    col.minWidth = 200
    tableView.addTableColumn(col)

    let details = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "details"))
    details.minWidth = 200
    tableView.addTableColumn(details)

    scrollView.documentView = tableView
    scrollView.hasHorizontalScroller = false
    scrollView.hasVerticalScroller = true
  }

  func numberOfRows(in _: NSTableView) -> Int {
    return documentMap?.count ?? 0
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cell = NSTableCellView()
    let text = NSTextField()
    guard let documentMap = self.documentMap else {
      return cell
    }

    let url = documentMap.keys[row]
    let document = documentMap.dictionary[url]
    let name = url.deletingLastPathComponent().lastPathComponent
    if tableColumn == tableView.tableColumns[0] {
      text.stringValue = name
    } else {
      let details: String
      if let imageCount = document?.images?.count {
        details = "\(imageCount) images"
      } else {
        details = "group"
      }
      text.stringValue = details
    }

    cell.addSubview(text)
    text.drawsBackground = false
    text.isBordered = false
    text.translatesAutoresizingMaskIntoConstraints = false
    cell.addConstraint(NSLayoutConstraint(item: text, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1, constant: 0))
    cell.addConstraint(NSLayoutConstraint(item: text, attribute: .left, relatedBy: .equal, toItem: cell, attribute: .left, multiplier: 1, constant: 13))
    cell.addConstraint(NSLayoutConstraint(item: text, attribute: .right, relatedBy: .equal, toItem: cell, attribute: .right, multiplier: 1, constant: -13))
    return cell
  }

  func tableView(_: NSTableView, rowViewForRow _: Int) -> NSTableRowView? {
    let rowView = NSTableRowView()
    rowView.isEmphasized = false
    return rowView
  }
}
