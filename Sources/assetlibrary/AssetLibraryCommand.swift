import ArgumentParser
import AssetLib
import Foundation
struct AssetLibraryCommand: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "assetlibrary",
    abstract: "Builds App Icons and Image Sets based on templates."
  )

  @Argument(help: "JSON template file.")
  var templateFile: String

  // swiftlint:disable line_length
  @Argument(help: """
  Output directory or file.
  If this path ends in either 'imageset' or 'appicon', then a directory will be created with a 'Contents.json' file inside.
  Otherwise, it will be the resulting file path.
  """)
  // swiftlint:enable line_length
  var output: String

  func run() throws {
    let url = URL(fileURLWithPath: templateFile)
    let type = TemplateTypeParser().templateType(fromPath: output)
    let outputURL = try AssetURLInitializer().url(fromPath: output, withType: type)

    let actual = TemplateResultParser.shared.template(fromURL: url, withType: type)

    try TemplateWriter.shared.saveTemplateResult(actual, to: outputURL)
  }
}
