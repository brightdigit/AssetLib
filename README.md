![Logo of the project](https://raw.githubusercontent.com/brightdigit/AssetLib/master/logo.png)

# AssetLib

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
[![GitHub](https://img.shields.io/github/license/brightdigit/AssetLib)](https://github.com/brightdigit/AssetLib/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/brightdigit/AssetLib)](https://img.shields.io/github/issues/brightdigit/AssetLib)
[![Beerpay](https://img.shields.io/beerpay/brightdigit/AssetLib.svg)](https://beerpay.io/brightdigit/AssetLib)

[![macOS](https://github.com/brightdigit/AssetLib/workflows/macOS/badge.svg)](https://github.com/brightdigit/AssetLib/actions?query=workflow%3AmacOS)
[![ubuntu](https://github.com/brightdigit/AssetLib/workflows/ubuntu/badge.svg)](https://github.com/brightdigit/AssetLib/actions?query=workflow%3Aubuntu)
[![Travis (.com)](https://img.shields.io/travis/com/brightdigit/AssetLib?logo=travis)](https://travis-ci.com/brightdigit/AssetLib)
[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/AssetLib)](https://codecov.io/gh/brightdigit/AssetLib)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/AssetLib)](https://www.codefactor.io/repository/github/brightdigit/AssetLib)
[![codebeat badge](https://codebeat.co/badges/4f86fb90-f8de-40c5-ab63-e6069cde5002)](https://codebeat.co/projects/github-com-brightdigit-assetlib-master)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/AssetLib)](https://codeclimate.com/github/brightdigit/AssetLib)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/AssetLib?label=debt)](https://codeclimate.com/github/brightdigit/AssetLib)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/AssetLib)](https://codeclimate.com/github/brightdigit/AssetLib)

[![Version](https://img.shields.io/cocoapods/v/AssetLib.svg?style=flat)](https://cocoapods.org/pods/AssetLib)
[![License](https://img.shields.io/cocoapods/l/AssetLib.svg?style=flat)](https://cocoapods.org/pods/AssetLib)
[![Platform](https://img.shields.io/cocoapods/p/AssetLib.svg?style=flat)](https://cocoapods.org/pods/AssetLib)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)


> Build, Create, and Modify Asset Catalogs in Swift or in the Terminal

## Features

Included with this library is the ability:

- [x] Programmatically parse and modify Asset Catalogs
- [x] Create Asset Catalogs based on Template in code or terminal

## Reqirements

- iOS 8.0+ / macOS 10.9+ / tvOS 9.0+ / watchOS 2.0+ / Linux 
- Xcode 10.2+
- Swift 5+

## Installing 

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate AssetLib into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'AssetLib', '~> 0.1.0'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. AssetLib does support its use on supported platforms.

Once you have your Swift package set up, adding AssetLib as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/brightdigit/AssetLib.git", .upToNextMajor(from: "0.1.0"))
]
```

## Usage

### [API Documentation](/Documentation/Reference/README.md)

### Asset Catalog Items (i.e. App Icons and Image Sets)

**AssetLib** contains a type `AssetSpecificationDocument` which can both be constructed, decoded, encoded and more. Typically in Xcode Asset Catalogs, this would be the `Contents.json` file inside an Image set or App Icon set. Therefore to read an `AssetSpecificationDocument`:

```swift
// read the "Contents.json" for either Image Set or App Icon
let dirURL = let outputDirURL = URL(fileURLWithPath: "ImageSet.imageset", isDirectory: true)
let url = dirURL.appendingPathComponent("Contents.json")

let decoder = JSONDecoder()
let data = try Data(contentsOf: url)
let document = decoder.decode(AssetSpecificationDocument.self, from: data)
```

`AssetSpecificationDocument` contains three properties: `info`, `properties`, and `images`. The `images` property contains the specifications for each image used in the Image set or App Icon.

#### Asset Catalog Images 

**AssetLib** contains a type `AssetSpecification` for each image in a `AssetSpecificationDocument`. This could be anything from a 2x image in an Image Set to the image for an iPad notification.

In order to build or modify an `AssetSpecification` use the `AssetSpecificationBuilder` type:

```swift
...
let document = decoder.decode(AssetSpecificationDocument.self, from: data)
let newImages = document.images.map {
  oldImage in
  var builder = AssetSpecificationBuilder(specifications: oldImage)
  builder.locale = Locale(identifier: "fr")
  return builder.assetSpec()
}
let modifiedDocument = AssetSpecificationDocument(
  info: document.info,
  images: newImages,
  properties: document.properties)
```

#### Saving Your Document

In order to save your new `AssetSpecificationDocument`, simply use `JSONEncoder`:

```swift
// save to "Contents.json" for either Image Set or App Icon to work in Xcode
let outputDirURL = let outputDirURL = URL(fileURLWithPath: "NewImageSet.imageset", isDirectory: true)
let outputURL = outputDirURL.appendingPathComponent("Contents.json")

// In order to have it look similar to how Xcode outputs the document
let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted]

let data = try encoder.encode(modifiedDocument)
try data.write(to: outputURL)
```

### Templating

You can build an App Icon for an Asset Catalog based on a template either programmatically or in the terminal. 

#### App Icons

In order to create an `AssetSpecificationDocument`, create an `AppIconTemplate` with the settings of your choice as well as a `AppIconTemplateBuilder`. Then call: `.document(fromTemplate:)` to build the `AssetSpecificationDocument`:

```swift
let template = AppIconTemplate(
  devices: [.car, .ipad, .iphone, .mac, .tv, .watch], 
  specifyGamut: true, 
  prerendered: true)
let builder = AppIconTemplateBuilder()
let document = builder.document(fromTemplate: template)
```

`AppIconTemplate` has three properties which correspond with the properties in available in **Xcode**:

- `devices`: _optional_ `Set<AppIconDevice>` the devices which this AppIcon supports, which are: `.car`, `.ipad`, `.iphone`, `.mac`, `.tv`, `.watch`. If `nil`, assume **all** devices are supported.
- `specifyGamut`: _optional, default: false_ whether to specify separate images for sRGB and the P3 wide gamut color space.
-  `prerendered` : _optional, default: false_ backward compatibile property for iOS 6.0 indicating if the icon includes the mask and shine effect

For more details, check out the documentation on `AppIconTemplate`.

#### Image Sets

In order to create an `AssetSpecificationDocument`, create an `ImageSetTemplate` with the settings of your choice as well as a `ImageSetTemplateBuilder`. Then call: `.document(fromTemplate:)` to build the `AssetSpecificationDocument`:

```swift
let template = ImageSetTemplate(
  renderAs: .template,
  compression: .gpuOptimizedBest,
  preserveVectorData: true,
  devices: Set([.universal]),
  appearances: [
    ValuedAppearance(value: Luminosity.light).eraseToAny(), 
    ValuedAppearance(value: Luminosity.dark).eraseToAny()
  ],
  scaling: .single,
  specifyGamut: true,
  direction: [],
  specifiedWidthClass: nil,
  specifiedHeightClass: nil,
  memorySet: [],
  graphicFSSet: [],
  specifyAWWidth: false,
  autoScaling: false,
  locales: [],
  resourceTags: []
)
let builder = ImageSetTemplateBuilder()
let document = builder.document(fromTemplate: template)
```

For more details, check out the documentation on `ImageSetTemplate`.

#### Command Line Application

In addition to the API, you can build an `AssetSpecificationDocument` i.e. Contents.json file using the executable provided in the Swift package:

```
USAGE: assetlibrary <template-file> <output>

ARGUMENTS:
  <template-file>         JSON template file. 
  <output>                Output directory or file. If this path ends in either
                          'imageset' or 'appicon', then a directory will be
                          created with a 'Contents.json' file inside.
                          Otherwise, it will be the resulting file path. 

OPTIONS:
  -h, --help              Show help information.
```

Simply create a `json` file, with the corresponding properties for a the `ImageSetTemplate` or `AppIconTemplate`. The corresponding JSON properties for each property in Swift are:

| Template Type | Swift Name | JSON Name |
|---------------|--------------|---------------|
| AppIcon | devices | devices |
| AppIcon | specifyGamut | specify-gamut |
| AppIcon | prerendered | pre-rendered |
| ImageSet | templateRenderingIntent | template-rendering-intent |
| ImageSet | compressionType | compression-type |
| ImageSet | preservesVectorRepresentation | preserves-vector-representati |
| ImageSet | devices | devices |
| ImageSet | appearances | appearances |
| ImageSet | scaling | scaling |
| ImageSet | displayGamuts | display-gamuts |
| ImageSet | languageDirections | language-directions |
| ImageSet | widthClass | width-class |
| ImageSet | heightClass | height-class |
| ImageSet | memorySet | memory-set |
| ImageSet | graphicsFeatureSets | graphics-feature-sets |
| ImageSet | appleWatchScreens | apple-watch-screens |
| ImageSet | autoScaling | auto-scaling |
| ImageSet | locales | locales |
| ImageSet | onDemandResourceTags | on-demand-resource-tags |

##### Examples

###### Image Set

- for a template image
- with a specific dark mode
- support for english, spanish, and french
- individual images for each Apple Watch size


**imageset-template.json**

```json
{
  "template-rendering-intent" : "template",
  "appearances" : [
    {
      "appearance" : "luminosity",
      "value" : "dark"
    }
  ],
  "appleWatchScreens" : true,
  "locales" : ["en", "es", "fr"]
}
```

**usage**

```bash
$ assetlibrary Example/Templates/imageset-template.json Example/Templates/Assets.xcassets/Template.imageset
```

###### iPhone and iPad App Icon

**appicon-iOS.json**

```json
{
  "devices" : ["iphone", "ipad"]
}
```

**usage**

```bash
$ assetlibrary Example/Templates/appicon-iOS.json Example/Templates/Assets.xcassets/AppIcon.appiconset
```

###### Multi-Device Image Set (w/ Display Gamuts)

**appicon-gamut.json**

```json
{
  "specify-gamut" : true
}
```

**usage**

```bash
$ assetlibrary Example/Templates/appicon-gamut.json Example/Templates/Assets.xcassets/Gamut.appiconset
```

###### Multi-Device Image Set (w/o CarPlay)

**appicon-devices.json**

```json
{
  "devices" : ["watch", "iphone", "ipad", "mac", "tv"]
}
```

**usage**

```bash
$ assetlibrary Example/Templates/appicon-devices.json Example/Templates/Assets.xcassets/Devices.appiconset
```

## Links

- Asset Catalog Format Overview
  - https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/
- Asset Catalog Image Set Documentation
  - https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/ImageSetType.html#//apple_ref/doc/uid/TP40015170-CH25-SW33
- Asset Catalog App Icon Documentation
  - https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/AppIconType.html#//apple_ref/doc/uid/TP40015170-CH22-SW1

## License

AssetLib is released under the MIT license. [See LICENSE](https://github.com/brightdigit/AssetLib/blob/master/LICENSE) for details.
