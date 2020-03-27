import Foundation

struct MockError: Error, LocalizedError {
  let descriptor: String = UUID().uuidString

  var errorDescription: String? {
    return descriptor
  }
}
