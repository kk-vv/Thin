# ThinX

[![CI Status](https://img.shields.io/travis/soulbind/Thin.svg?style=flat)](https://travis-ci.org/soulbind/ThinX)
[![Version](https://img.shields.io/cocoapods/v/Thin.svg?style=flat)](https://cocoapods.org/pods/ThinX)
[![License](https://img.shields.io/cocoapods/l/Thin.svg?style=flat)](https://cocoapods.org/pods/ThinX)
[![Platform](https://img.shields.io/cocoapods/p/Thin.svg?style=flat)](https://cocoapods.org/pods/ThinX)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


|MAIN|
|----|
|![main](https://github.com/soulbind/Thin/raw/master/img/main.png)|

## USAGE

#### CONFIG PLIST

|CONFIG|
|----|
|![config](https://github.com/soulbind/Thin/raw/master/img/config.png)|


#### NavBarAppearance

- Default Style form config.plist

```
NavBarAppearance.active()
```

- Custom with code 

```
var navBuilder = NavBarBuilder.default
navBuilder.backgroundColor = UIColor.th.rgb(39, 168, 242)
navBuilder.buttonTextColor = UIColor.th.rgb(252, 30, 112)
navBuilder.titleColor = .red
navBuilder.titleFont = UIFont(name: "Copperplate", size: 18)!
navBuilder.isTranslucent = false
navBuilder.showSeparator = false
NavBarAppearance.active(navBuilder)

```

- Set color in viewcontroller

```
self.th.setNavBarBackgroundColor(color)
self.th.setNavSubViewColor(color)
self.th.reloadNavSubViewColor()//reload to config plist define
```

#### TabBarAppearance

- Default style form config.plist

```
TabBarAppearance.active()
```

- Custom with code 

```
var tabBuilder = TabBarBuilder.default
tabBuilder.backgroundColor = UIColor.th.rgb(39, 40, 34)
tabBuilder.selectedColor = UIColor.th.rgb(230, 220, 109)
tabBuilder.normalColor = .cyan
tabBuilder.font = UIFont(name: "Bradley Hand", size: 12)
tabBuilder.isTranslucent = false
tabBuilder.showSeparator = false
TabBarAppearance.active(tabBuilder)

```

- Set backgroundColor in viewcontroller

```
self.th.setTabBarBackgroundColor(color)
```


#### Color Usage (Define in config.plist file)

```
UIColor.th.tint
UIColor.th.subTint
UIColor.th.background
UIColor.th.title
UIColor.th.body
UIColor.th.subBody
UIColor.th.mark1
UIColor.th.mark2
UIColor.th.border
UIColor.th.empty
UIColor.th.random
UIColor.th.rgb(100, 200, 40)
UIColor.th.hexStr("#CCCCCC")
```

#### Font Usage (Define in config.plist file)

```
UIFont.th.title()
UIFont.th.body()
UIFont.th.mark()
UIFont.th.title(size: 30)
UIFont.th.title(fix: -2)
UIFont.th.body(size: 12)
UIFont.th.body(fix: 1)
UIFont.th.font(.title, size: 20)
UIFont.th.pfFont(.medium, size: 20)
UIFont.th.bodyFontSize
UIFont.th.bodyFontName
```

#### UIViewController Extension

- Add NavBarButton

```
self.th.addNavBarButton(iconFontTexts: ["\u{e673}", "\u{e673}"], at: .left, iconFont: UIFont.init(name: "iconfont", size: 22)!, color: UIColor.cyan)
self.th.addNavBarButton(texts: ["Next"], at: .right)
self.th.addNavBarButton(images: ["image1", "image2"], at: .right, useOriginalColor: false)
self.th.clearNavBarBackButtonTitle()
self.th.addNavBarButtonItems(customView: view, at: .left)
```

```
override func rightBarButtonAction(index: Int) {
    let vc = UIViewController()
    vc.view.backgroundColor = UIColor.th.background
    navigationController?.pushViewController(vc, animated: true)
}
    
override func leftBarButtonAction(index: Int) {
    print("🐌 iconfont index: \(index)")
}

```

- KerboardNotification 

```
self.th.addKeyboardNotification()
self.th.removeKeyboardNotification()
```

```
override func keyboardWillShow(duration dt: Double, userInfo: Dictionary<String, Any>) {
    UIView.animate(withDuration: dt) {
        
    }
}
    
override func keyboardWillChangeFrame(beginRect: CGRect, endRect: CGRect, duration dt: Double, userInfo: Dictionary<String, Any>) {
    UIView.animate(withDuration: dt) {
        v.bottom = endRect.height
    }
}
    
override func keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
    UIView.animate(withDuration: dt) {
        
    }
}

```

#### UIAlertViewController

```
UIAlertController.th.showAlert(...)
UIAlertController.th.showActionSheet(...)
```

#### ReuseIdentifier

```
UITableViewCell.th.reuseIdentifier
THTableViewCell.th.nibName
```

#### NSAttributedString

```
let attr =  NSAttributedString.th.string(...)
attr.th.setColor(...)
attr.th.setFont(...)
```

#### UIView Extensions

```
view.th.corners(.left)
view.th.corners(.right)
view.th.corners(.forwardSlash)
...

```

#### String

```
str.th.noticename //NSNotification.Name
str.th.currencyString(...)
str.th.attributedCurrencyStr(...)
...

```

#### UIDevice

```
UIDevice.th.width
UIDevice.th.height
UIDevice.th.isXSeries
UIDevice.th.topBarHeight
UIDevice.th.bottomBarHeight
...

```

#### ...Others

```
... 
```

#### Extension Thin add [th] support

```
extension Thin where Base: [ClassType] {
	static func  
	func 
}

extension Thin where Base == [StructType] {
	static func  
	func 
}

```

## Requirements

## Installation

Thin is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ThinX'
```

## Author

iFallen, hulj1204@yahoo.com

## License

Thin is available under the MIT license. See the LICENSE file for more info.
