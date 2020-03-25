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

### App Icons

There are three types of tracking objects: Events, Timing, and Exceptions.

#### Image Sets

For tracking events, you can create an `AnalyticsEvent` with a category and action:

```swift
    let event = AnalyticsEvent(category: "category", action: "action")
    tracker.track(event) { result in
      if case let .failure(error) = result {
        debugPrint(error)
      }
    }
```

You can read [more details about events on the Google Analytics Measurement Protocol documentation.](https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide#event)

#### Templating

You can build an App Icon for an Asset Catalog based on a template either programmatically or in the terminal. 

##### App Icons

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

##### Image Sets

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

##### Command Line Application

In addition to the API, you can build an `AssetSpecificationDocument` i.e. Contents.json file using the executable provided in the Swift package. 

Simply create a `json` file, with the corresponding properties for a the `ImageSetTemplate` or `AppIconTemplate`. 

For an `AppIconTemplate`, the corresponding `json` properties are:

- `devices` : `devices`
- `specifyGamut` : `specify-gamut`
- `prerendered` : `pre-rendered`

| Template Type | Swift Name | JSON Name |
|---------------|--------------|---------------|
| AppIcon | devices | devices |
| AppIcon | specifyGamut | specify-gamut |
| AppIcon | prerendered | pre-rendered |
|  |  |  |

## Links

- Asset Catalog Format Overview
  - https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/
- Asset Catalog Image Set Documentation
  - https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/ImageSetType.html#//apple_ref/doc/uid/TP40015170-CH25-SW33
- Asset Catalog App Icon Documentation
  - https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/AppIconType.html#//apple_ref/doc/uid/TP40015170-CH22-SW1

## License

AssetLib is released under the MIT license. [See LICENSE](https://github.com/brightdigit/AssetLib/blob/master/LICENSE) for details.
