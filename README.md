# Balad
<img src="https://digitalagencynetwork.com/wp-content/uploads/2016/05/near-me-searches-google.jpg" alt="" />

This application helps user to find  venues  which are near user location.In this application focused on caching data after receiving data.

![Platform](https://img.shields.io/cocoapods/p/SnapKit.svg?style=flat)

#### ⚠️ **To use with Swift 5.x please ensure you are using >= 5.0.0** ⚠️ 

## Contents

- [Requirements](#requirements)
- [Migration Guides](#migration-guides)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Requirements

- iOS 11.0+
- Xcode 12.0+
- Swift 5.0+

## Communication

- If you **need help**, use <a href="mailto:jelodar.mozhgan@gmail.com?">jelodar.mozhgan@gmail.com</a>
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build.

Trun project,Open terminal then go to project folder. Then, run the following command:

```bash
$ pod install
```
# Viper Desin pattern
Viper is a design pattern that implements ‘separation of concern’ paradigm. Mostly like MVP or MVC it follows a modular approach. One feature, one module. For each module VIPER has five different classes with distinct roles. No class go beyond its sole purpose. These classes are following.
- ### View:
Class that has all the code to show the app interface to the user and get their responses. Upon receiving a response View alerts the Presenter.
- ### Presenter:
Nucleus of a module. It gets user response from the View and work accordingly. Only class to communicate with all the other components. Calls the router for wire-framing, Interactor to fetch data (network calls or local data calls), view to update the UI.
- ### Interactor:
Has the business logics of an app. e.g if business logic depend on making network calls then it is Interactor’s responsibility to do so.
- ### Router: 
 Does the wire-framing. Listens from the presenter about which screen to present and executes that.
- ###  Entity: 
 Contains plain model classes used by the Interactor.
## Below shows a simple diagram of VIPER
[![](https://miro.medium.com/max/1400/1*-Mfew6qvLQ-t-DSOkY23Aw.png)](https://miro.medium.com/max/1400/1*-Mfew6qvLQ-t-DSOkY23Aw.png)


### Resources

- [Network](https://github.com/Moya/Moya)
- [Persist](https://github.com/realm/realm-cocoa)
- [Image caching](https://github.com/onevcat/Kingfisher)
- [Auto layout](https://github.com/SnapKit/SnapKit)
- [Viper] 
## Credits

- Mozhgan Jelodar ([@Mozhganii](https://twitter.com/Mozhganii))

#### App Demo
<img width = "205" height = "448" src="https://github.com/mozhgan/NearMe/blob/develop/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-31%20at%2016.25.10.png" alt="" />
<img width = "205" height = "448" src="https://github.com/mozhgan/NearMe/blob/develop/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-31%20at%2016.25.18.png" alt="" />
<img width = "205" height = "448" src="https://github.com/mozhgan/NearMe/blob/develop/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-31%20at%2016.29.45.png" alt="" />
<img width = "205" height = "448" src="https://github.com/mozhgan/NearMe/blob/develop/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202021-03-31%20at%2016.29.51.png" alt="" />



