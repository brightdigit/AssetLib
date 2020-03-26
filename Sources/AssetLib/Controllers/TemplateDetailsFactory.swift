//
//  File.swift
//  
//
//  Created by Leo Dion on 3/26/20.
//

import Foundation

public struct TemplateDetailsFactory : TemplateDetailsFactoryProtocol {
  public static let shared : TemplateDetailsFactoryProtocol = TemplateDetailsFactory()
  public func details(fromFilePath path: String) -> TemplateDetails {
    let type: TemplateType?
    if let ext = path.components(separatedBy: ".").last {
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
      let outputDirURL = URL(fileURLWithPath: path, isDirectory: true)
      try? FileManager.default.createDirectory(at: outputDirURL, withIntermediateDirectories: false, attributes: nil)
      outputURL = outputDirURL.appendingPathComponent("Contents.json")
    } else {
      outputURL = URL(fileURLWithPath: path)
    }
    return TemplateDetails(url: outputURL, type: type)
  }
}
