import Foundation

struct MockError: Error {
  let localizedDescription: String = UUID().uuidString
}
