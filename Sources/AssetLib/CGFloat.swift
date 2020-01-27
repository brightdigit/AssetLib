import Foundation

extension CGFloat {
  var clean: String {
    truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : description
  }
}
