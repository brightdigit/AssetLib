import Foundation
public protocol TemplateParser {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: TemplateParser {}
