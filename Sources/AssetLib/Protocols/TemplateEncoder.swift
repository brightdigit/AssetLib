import Foundation
public protocol TemplateEncoder {
  func encode<T>(_ value: T) throws -> Data where T: Encodable
}

extension JSONEncoder: TemplateEncoder {}
