import Foundation

public struct TemplateParser: TemplateParserProtocol {
  public static let shared: TemplateParserProtocol = TemplateParser()

  let jsonDecoder = JSONDecoder()

  public func template(fromURL url: URL, withType type: TemplateType?) -> TemplateResult {
    let dataResult = Result(catching: { try Data(contentsOf: url) })

    if type != .imageset {
      let appiconResult = dataResult.flatMap { data in
        Result(catching: { try jsonDecoder.decode(AppIconTemplate.self, from: data) })
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
      Result(catching: { try jsonDecoder.decode(ImageSetTemplate.self, from: data) })
    }

    do {
      return .imageset(try imagesetResult.get())
    } catch {
      return .failure(error)
    }
  }
}
