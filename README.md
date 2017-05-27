
[![License](https://img.shields.io/cocoapods/l/Cache.svg?style=flat)]
[![Platform](https://img.shields.io/cocoapods/p/Cache.svg?style=flat)]
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)

## Table of Contents

* [Description](#description)
* [Key features](#key-features)
* [Usage](#usage)
* [Installation](#installation)
* [Author](#author)
* [License](#license)

## Description

this is simple library for created in Objective C but 100% fully compatible with Swift, Currently it is targitted to IOS but it more flixable to work for other platforms 

## Key features

- Generic protocol to be able to cache any type you want.
- The basic interface includes methods to add, get and remove objects by using its URL 
- Currentlly it work with memory type Cache and the File Cache will be our next thing to do 
- iOS support.

## Usage


**Initialization with default configuration**

```swift
var cacheManager:CacheFileManager = CacheFileManager()
```

**Initialization with custom configuration**

```swift

var cacheManager:CacheFileManager = CacheFileManager()

let configuration = CacheConfiguration(customeConfigurationWithMaximumMemoryCapacityInMBs: Double(kMaxCacheSizeinMBs), withMaximumNumberOfFiles: Int32(kMaxCacheFileNumbers), with: .Memory)

self.cacheManager.applyCacheCustomConfiguration(configuration)

```

**Basic operations**

this code work for evey kind of data you want 
```swift
//general perpose it will work for every kind of file or data 

let operationTimeStamp = cacheManager.getDataFrom(url as URL!) { (file:FileInfo?, error:Error?) in
if (error == nil) && (file != nil) {
self.imageView.image = UIImage(data: (file?.getFileData())!)
}
}

//specific for image 
self.cacheManager.getImageFrom(url) { (image:UIImage?, error:Error?) in
}

// Remove an object from the cache
self.cacheManager.removeFileFromCache(using: url)

// Clean the cache
self.cacheManager.removeAllObjectFromCache()
```
## Installation

the cocoa pods installation is on the way but you can install by simply adding the this project to your app 
## Author

Muhammad Dawood https://www.linkedin.com/in/muhammad-dawood-b661797b

## License

**Cache** is available under the MIT license. See the [LICENSE]() file for more info.
