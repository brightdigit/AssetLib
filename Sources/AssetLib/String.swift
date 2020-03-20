import Foundation

extension String {
  public func firstMatchGroups(regex: NSRegularExpression) -> [String]? {
    let range = NSRange(0 ..< count)

    guard let result = regex.firstMatch(in: self, options: [], range: range) else {
      return nil
    }

    return (0 ..< result.numberOfRanges).map(result.range(at:)).compactMap { Range($0, in: self) }.map { String(self[$0]) }
  }
}
