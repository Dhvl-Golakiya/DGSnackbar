# DGSnackbar


## Author

Dhvl-Golakiya, dhvl.golakiya@gmail.com


[![CI Status](http://img.shields.io/travis/Dhvl-Golakiya/DGSnackbar.svg?style=flat)](https://travis-ci.org/Dhvl-Golakiya/DGSnackbar)
[![Version](https://img.shields.io/cocoapods/v/DGSnackbar.svg?style=flat)](http://cocoapods.org/pods/DGSnackbar)
[![License](https://img.shields.io/cocoapods/l/DGSnackbar.svg?style=flat)](http://cocoapods.org/pods/DGSnackbar)
[![Platform](https://img.shields.io/cocoapods/p/DGSnackbar.svg?style=flat)](http://cocoapods.org/pods/DGSnackbar)

## About

Currently snackbar is using in Android application and also insome iOS application like Gmail. Using DGSnackbar, you can implement snackbar in your iOS application. DGSnackbar has also setting image for action button feature. So you can set image on action button instead of only text.

DGSnackbar demostration with action button text:

![Action Button text](http://i58.tinypic.com/c0qdk.png)

DGSnackbar demostration with action button image:

![Action Button image](http://i61.tinypic.com/2ih46xy.png)

## Installation

DGSnackbar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DGSnackbar"
```


## Usage

For using DGSnackbar there are two methods for it.

```
Action button with Text
makeSnackbar(message : String?, 
actionButtonTitle : String?, 
interval : NSTimeInterval , 
actionButtonBlock : (DGSnackbar -> Void), 
dismisBlock : (DGSnackbar -> Void))-> ()

Action button with Image
makeSnackbar(message : String?, 
actionButtonImage : UIImage?, 
interval : NSTimeInterval , 
actionButtonBlock : (DGSnackbar -> Void), 
dismisBlock : (DGSnackbar -> Void))-> ()
```

You can user both blocks for delegate methods for your view.


## License

DGSnackbar is available under the MIT license.

Copyright (c) 2015 Dhvl-Golakiya <dhvl.golakiya@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
