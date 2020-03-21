public struct ImageIdiomDisplayGamut: ImageIdiomDisplayGamutProtocol {
  public let supportedImageIdioms: [ImageIdiom]

  public func supportsDisplayGamut(_ idiom: ImageIdiom) -> Bool {
    return supportedImageIdioms.contains(idiom)
  }
}
