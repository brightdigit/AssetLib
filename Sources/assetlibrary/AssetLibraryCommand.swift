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

  @Argument(help: "Output directory or file. If this path ends in either 'imageset' or 'appicon', then a directory will be created with a 'Contents.json' file inside. Otherwise, it will be the resulting file path.")
  var output: String

  

  
  
  func run() throws {
    let url = URL(fileURLWithPath: templateFile)
    let details = TemplateDetailsFactory.shared.details(fromFilePath: self.output)

    let outputURL = details.url
    let actual = TemplateParser.shared.template(fromURL: url, withType: details.type)
    
    try TemplateWriter.shared.saveTemplateResult(actual, to: outputURL)
  }
}
