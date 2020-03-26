import AssetLib

enum Template {
  case appicon(AppIconTemplate)
  case imageset(ImageSetTemplate)
  case failure(Error)
}

enum TemplateType {
  case appicon
  case imageset
}

AssetLibraryCommand.main()
