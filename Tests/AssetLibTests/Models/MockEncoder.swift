import AssetLib
import Foundation

public struct MockEncoder: TemplateEncoder {
  public let data: Data
  public func encode<T>(_: T) throws -> Data where T: Encodable {
    data
  }
}
