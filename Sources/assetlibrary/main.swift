import ArgumentParser
import Foundation

enum TemplateType: String, Codable {
  case appicon
  case imageset
}

struct TemplateArgument: Codable {
  let type: TemplateType
  let url: URL
}

struct Repeat: ParsableCommand {
  @Argument(help: "The phrase to repeat.")
  var templateFile: String

  func run() throws {
    dump(templateFile)
  }
}

Repeat.main()
