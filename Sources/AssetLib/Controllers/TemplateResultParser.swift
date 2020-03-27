import Foundation

/**
 Based on the url, tries to decipher the resulting template.
 */
public struct TemplateResultParser: TemplateResultParserProtocol {
  public static let shared: TemplateResultParserProtocol = TemplateResultParser()

  public static let defaultParser: TemplateDecoder = JSONDecoder()

  public let parser: TemplateDecoder
  public let reader: (URL) throws -> Data

  public init(parser: TemplateDecoder? = nil, reader: ((URL) throws -> Data)? = nil) {
    self.parser = parser ?? Self.defaultParser
    self.reader = reader ?? { try Data(contentsOf: $0) }
  }

  /**
   Based on the url, tries to decipher the resulting template or error.
   - Parameter url: Source file for the template.
   - Parameter type: Optional template type, otherwise both types will be attempted.
   */
  public func template(fromURL url: URL, withType type: TemplateType?) -> TemplateResult {
    let dataResult = Result(catching: { try self.reader(url) })

    if type != .imageset {
      let appiconResult = dataResult.flatMap { data in
        Result(catching: { try parser.decode(AppIconTemplate.self, from: data) })
      }

      do {
        let template = try appiconResult.get()
        return .appicon(template)
      } catch {
        if type == .appicon {
          return .failure(error)
        }
      }
    }

    let imagesetResult = dataResult.flatMap { data in
      Result(catching: { try parser.decode(ImageSetTemplate.self, from: data) })
    }

    do {
      return .imageset(try imagesetResult.get())
    } catch {
      return .failure(error)
    }
  }
}
