import Foundation

extension Float {
  /**
   Removes the floating point is a whole number.
   */
  var clean: String {
    truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : description
  }
}
