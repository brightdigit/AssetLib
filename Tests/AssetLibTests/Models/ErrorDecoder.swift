import AssetLib
import Foundation

struct ErrorDecoder: TemplateDecoder {
  public let error: Error
  func decode<T>(_: T.Type, from _: Data) throws -> T where T: Decodable {
    throw error
  }
}
