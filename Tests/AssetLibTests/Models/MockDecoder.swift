import AssetLib
import Foundation

struct MockDecoder<ResultType>: TemplateDecoder {
  public let result: ResultType
  public let error: Error
  func decode<T>(_: T.Type, from _: Data) throws -> T where T: Decodable {
    if let actual = result as? T {
      return actual
    } else {
      throw error
    }
  }
}
