import ArgumentParser
import AssetLib
import Foundation

enum Template {
  case appicon(AppIconTemplate)
  case imageset(ImageSetTemplate)
  case failure(Error)
}

enum TemplateType {
  case appicon
  case imageset
}

struct Assetlibrary: ParsableCommand {
  @Argument(help: "JSON template file.")
  var templateFile: String

  @Argument(help: "Output directory or file. If this path ends in either 'imageset' or 'appicon', then a directory will be created with a 'Contents.json' file inside. Otherwise, it will be the resulting file path.")
  var output: String

  func template(withType type: TemplateType?) -> Template {
    let jsonDecoder = JSONDecoder()
    let url = URL(fileURLWithPath: templateFile)
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

  func run() throws {
    let type: TemplateType?
    if let ext = output.components(separatedBy: ".").last {
      if ext == "imageset" {
        type = .imageset
      } else if ext == "appiconset" {
        type = .appicon
      } else {
        type = nil
      }
    } else {
      type = nil
    }

    let outputURL: URL
    if type != nil {
      let outputDirURL = URL(fileURLWithPath: output, isDirectory: true)
      try? FileManager.default.createDirectory(at: outputDirURL, withIntermediateDirectories: false, attributes: nil)
      outputURL = outputDirURL.appendingPathComponent("Contents.json")
    } else {
      outputURL = URL(fileURLWithPath: output)
    }

    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = [.prettyPrinted]
    let actual = template(withType: type)
    let document: AssetSpecificationDocumentProtocol
    switch actual {
    case let .appicon(template):
      let builder = AppIconTemplateBuilder()
      document = builder.document(fromTemplate: template)
    case let .imageset(template):
      let builder = ImageSetTemplateBuilder()
      document = builder.document(fromTemplate: template)

    case let .failure(error):
      throw error
    }

    let data = try jsonEncoder.encode(AssetSpecificationDocument(info: document.info, images: document.images, properties: document.properties))
    try data.write(to: outputURL)
  }
}

Assetlibrary.main()
