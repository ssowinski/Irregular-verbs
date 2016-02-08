# Irregular verbs - example of simple app without storyboard

![app preview](https://github.com/ssowinski/Irregular-verbs/blob/master/appPrev.gif)

---

# My notes

## AppDelegate 

##### UIWindow
Window is a top of app's view hierarchy.

If we'er using storyboard it is initial automatically by the UIApplicationMain function as the app launches.
When we create app without storyboard we have to create the window manualy

```sh
let window = UIWindow(frame: UIScreen.mainScreen().bounds)
// or in iOS9 we can nstantiate UIWindow with no frame
let window = UIWindow()
```
The window must also persist for the lifetime of the app. App delegate class has a strong window property and when app launches,
the UIApplicationMain function instantiates the app delegate class.

##### rootViewController
When we set a viewController as main window rootViewController,this VC main view (VC view property) becomes main window’s root view (top of view hierarchy)

##### makeKeyAndVisible()
To show window content (app’s interface) we have to call window method makeKeyAndVisible.

##### UIWindow in App with storyboard
Main storyboard name is set in **Info.plist** key “Main storyboard file base name” (```<key>UIMainStoryboardFile</key>```) 

*Steps performed automatically (behind the scenes)*

1. **UIApplicationMain** instantiates **UIWindow** (sets its frame) 
2. assigns to the app delegate’s **window property**, 
3. instantiates the storyboard’s initial view controller
4. assigns to the window’s **rootViewController** property
5. call delegate’s application(_ didFinishLaunchingWithOptions)
6. UIApplicationMain calls makeKeyAndVisible on the window, to display your app’s interface. 

##### UIWindow in App without storyboard
*Prepare project and manual (in code) creation and configuration of the window*

1. Edit the target. In the General pane, select “Main” in the Main Interface field and delete it (and press Tab to set this change).
2. Delete Main.storyboard and ViewController.swift from the project.
3. Delete the entire content of AppDelegate.swift.
4. Edit AppDelegate.swift as below to create basic working app without storyboard.
```sh
import UIKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {

var window : UIWindow?

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
self.window = UIWindow()
self.window!.rootViewController = UIViewController()
self.window!.backgroundColor = UIColor.whiteColor()
self.window!.makeKeyAndVisible()
return true
}
}
```

>@UIApplicationMain

>Apply this attribute to a class to indicate that it is the application delegate. Using this attribute is equivalent to calling the UIApplicationMain function and passing this class’s name as the name of the delegate class.

>If you do not use this attribute, supply a main.swift file with a main function that calls the UIApplicationMain(_:_:_:) function. For example, if your app uses a custom subclass of UIApplication as its principal class, call the UIApplicationMain(_:_:_:) function instead of using this attribute. 

## App in Portrait mode
This app is designed to run in portrait mode, to configure the app for this we have to 

1. Select the project in the project navigator and then go to the General tab and make sure only Portrait is checked (Deployment Info section).
2. Modify Info.plist and find the Supported interface orientations (iPad) entry. Delete all entries for landscape.

## Dealing with views
A view has only one superview ```var superview: UIView?```, but it can have many (or zero) subviews ```var subviews: [UIView]``` The order in the subviews array matters, those later in the array are on top of those earlier.

```addSubview(aView: UIView)``` - sent to aView’s (soon to be) superview

```removeFromSuperview()``` - this is sent to the view you want to remove (not its superview)

A view has property ```var window: UIWindow?``` is nil if the view has not yet been added to a window (view is not part of the interface)

A view can clip its subviews to its own bounds or not (the default is not to) ```var clipsToBounds: Bool``` If set to false, subviews whose frames extend beyond the visible bounds of the receiver are not clipped. The default value is *false*.

Always use **CGFloat** instead of Double or Float for anything to do with a UIView’s coordinate system.

```var bounds: CGRect ``` - the boundaries of where drawing happens a view’s internal drawing space’s origin and size. This is the rectangle containing the drawing space in its own coordinate system

```var center: CGPoint ``` - the center of a UIView in its superview’s coordinate system

```var frame: CGRect ``` - the rect containing a UIView in its superview’s coordinate system

Use frame and/or center to position a UIView

```var transform: CGAffineTransform ``` - lets us manipulate its view size, position and rotation.
```sh
imageView.transform = CGAffineTransformMakeScale(2, 2)
imageView.transform = CGAffineTransformMakeTranslation(-100, -100)
imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
imageView.transform = CGAffineTransformIdentity
```

The first one makes an image view double in size (width and height), the second move up and left 100 points, the third spin around 180 degrees (the values are expressed in radians), and the fourth one sets the image view's transform back to "identity" – this means "reset."

#####UIView’s initializer
- initializer if the UIView is created in code ```init(frame: CGRect)```
- initializer if the UIView comes out of a storyboard ```init(coder: NSCoder)```

If you need an initializer, implement them both …
```sh
func setup() { … }

override init(frame: CGRect) { // a designed initializer
super.init(frame: frame)
setup()
}

required init(coder aDecoder: NSCoder) { // a required initializer
super.init(coder: aDecoder)
setup()
}
```

## Creating constraints in code 

```sh
var translatesAutoresizingMaskIntoConstraints: Bool
```
If this property’s value is true, the system creates a set of constraints that duplicate the behavior specified by the view’s autoresizing mask. This also lets you modify the view’s size and location using the view’s frame, bounds, or center properties, allowing you to create a static, frame-based layout within Auto Layout. If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false, and then provide a non ambiguous, nonconflicting set of constraints for the view.


NSLayoutConstraint initializer init(item: attribute: relatedBy: toItem: attribute: multiplier: constant:)
```sh
view1.addConstraint(
NSLayoutConstraint(item: view2, attribute: .Leading, relatedBy: .Equal, toItem: view1, attribute: .Leading, multiplier: 1, constant: 0)
)

view1.addConstraint(
NSLayoutConstraint(item: view2, attribute: .Trailing, relatedBy: .Equal, toItem: view1, attribute: .Trailing, multiplier: 1, constant: 0)
)
```

*Anchor notation*

anchor properties of a UIView:
- topAnchor, bottomAnchor
- leftAnchor, rightAnchor, leadingAnchor, trailingAnchor
- centerXAnchor, centerYAnchor
- firstBaselineAnchor, lastBaselineAnchor

constraint-forming methods:
- constraintEqualToConstant:
- constraintGreaterThanOrEqualToConstant:
- constraintLessThanOrEqualToConstant:
- constraintEqualToAnchor:
- constraintGreaterThanOrEqualToAnchor:
- constraintLessThanOrEqualToAnchor:
- constraintEqualToAnchor:constant:
- constraintGreaterThanOrEqualToAnchor:constant:
- constraintLessThanOrEqualToAnchor:constant:
- constraintEqualToAnchor:multiplier:
- constraintGreaterThanOrEqualToAnchor:multiplier:
- constraintLessThanOrEqualToAnchor:multiplier:
- constraintEqualToAnchor:multiplier:constant:
- constraintGreaterThanOrEqualToAnchor:multiplier:constant:
- constraintLessThanOrEqualToAnchor:multiplier:constant:

```sh
class func activateConstraints(_ constraints: [NSLayoutConstraint])
```

```sh
NSLayoutConstraint.activateConstraints([
view2.leadingAnchor.constraintEqualToAnchor(view1.leadingAnchor),
view2.trailingAnchor.constraintEqualToAnchor(view1.trailingAnchor),
view2.topAnchor.constraintEqualToAnchor(view1.topAnchor),
view2.heightAnchor.constraintEqualToConstant(10),
view3.widthAnchor.constraintEqualToConstant(20),
view3.heightAnchor.constraintEqualToConstant(20),
view3.trailingAnchor.constraintEqualToAnchor(view1.trailingAnchor),
view3.bottomAnchor.constraintEqualToAnchor(view1.bottomAnchor)
])
```

Autolayout is implemented behind the scenes in layoutSubviews; in effect, constraints allow you to write sophisticated layoutSubviews functionality without code.

*Visual format notation*
```sh
let d = ["v2":v2,"v3":v3]
NSLayoutConstraint.activateConstraints([
NSLayoutConstraint.constraintsWithVisualFormat(
"H:|[v2]|", options: [], metrics: nil, views: d),
NSLayoutConstraint.constraintsWithVisualFormat(
"V:|[v2(10)]", options: [], metrics: nil, views: d),
NSLayoutConstraint.constraintsWithVisualFormat(
"H:[v3(20)]|", options: [], metrics: nil, views: d),
NSLayoutConstraint.constraintsWithVisualFormat(
"V:[v3(20)]|", options: [], metrics: nil, views: d)
].flatten().map{$0})
```

>Autoresizing

>Autoresizing is the pre-iOS 6 way of performing layout automatically. When its superview is resized, a subview will respond in accordance with the rules prescribed by its own *autoresizingMask* property value.

*SnapKit* is a DSL to make Auto Layout easy http://snapkit.io

## About ViewControllers 
Relationships between view controllers:

- **Parentage - parent/child** (containment)
A view controller can contain another view controller. Parent view controller (eg. UINavigationController) with a child view controller.

- **Presentation** (modal views)
A view controller can present another view controller. The first view controller is the presenting view controller (not the parent) of the second; the second view controller is the presented view controller (not a child) of the first.

View controllers load their views lazily. Accessing the view property for the first time loads or creates the view controller’s views. There are several ways to specify the views for a view controller:
- The view may be created in the view controller’s own code, manually.
- The view may be created as an empty generic view, automatically.
- The view may be created in its own separate nib.
- The view may be created in a nib, which is the same nib from which the view controller itself is instantiated.

Do not confuse *loadView* with *viewDidLoad*. 
In *loadView* method, create your view hierarchy programmatically and assign the root view of that hierarchy to the view controller’s view property. *viewDidLoad* is called afterward, when the view is set.

```sh
import UIKit

class WordsListViewController: UIViewController {

override func loadView() {
    let view = UIView()
    self.view = view
    }

override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.blueColor()

    let label = UILabel()
    label.text = "Hello, World!"
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activateConstraints([
    label.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor),
    label.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor),
    ])

    self.view.addSubview(label)
    }
}
```

If we don't override the loadView function, then UIViewController’s default implementation of loadView creates a generic UIView object and assigns it to self.view. 

#####View Controller Lifecycle
- Instantiated
- awakeFromNib (all objects that come out of a storyboard)
- segue preparation happens
- outlets get set
- **viewDidLoad**
- These pairs will be called each time your Controller’s view goes on/off screen: 
**viewWillAppear** and **viewDidAppear** ; **viewWillDisappear** and **viewDidDisappear**
- These “geometry changed” methods might be called at any time after viewDidLoad …
**viewWillLayoutSubviews** (… then autolayout happens, then …) **viewDidLayoutSubviews**
- If memory gets low, you might get **didReceiveMemoryWarning**

## Delegation Pattern
A very important use of protocols, implement “blind communication” between a View and its Controller. 

1.Create a delegation protocol.
Defines what the View (CardViewContainer) wants the Controller (WordsListViewController) to take care of.

```sh
protocol CardViewContainerDelegate: class{
    func cardsNumber(cardViewContainer : CardViewContainer) -> Int
    func cardForIndex(cardViewContainer : CardViewContainer, index: Int) -> UIView
}
```

2.Create a delegate property in the View (CardViewContainer) whose type is that delegation protocol

```sh
weak var delegat : CardViewContainerDelegate? {
    didSet {
        showCard(currentIndex, swipeDir: .Left)
    }
}
```
We have to be a little bit careful about delegat because of memory management. When View points Controler and Controler pointer to the View, we create a meory cycle. We used weak to prevent this.

3.Use the delegate property in the View (CardViewContainer) to get/do things it can’t own or control.
We use delegate in few places, e.g. to get card view in showCard.

```sh
private func showCard(index: Int, swipeDir: SwipeDirection) {
    guard let card = delegat?.cardForIndex(self, index: index) else { return }
    addSubview(card)
    .
    .
    .
}
```

4.Controller (WordsListViewController) declares and implements the protocol

```sh
class WordsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonShowMoreDelegate, CardViewContainerDelegate
{
    .
    .
    .
    // MARK: -CardViewContainerDelegate Implemantation
    func cardsNumber(cardViewContainer: CardViewContainer) -> Int {
        return verbsModel.countVerbs()
    }

    func cardForIndex(cardViewContainer: CardViewContainer, index: Int) -> UIView {
        let card = CardView(frame: CGRectMake(0, 0, Const.Size.CardWidth, Const.Size.CardHeight))
        card.verb = verbsModel.getVerb(index)
        return card
    }
}
```

5.Controller (WordsListViewController) sets self as the delegate of the View (CardViewContainer) by setting the property we have created in point 2.

After we create the instance of CardViewContainer, we set self (WordsListViewController) as delegate

```sh
let cardViewContainer = CardViewContainer(frame: self.view.frame, startingIndex: indexPath.row)
cardViewContainer.delegat = self
```
## Bitwise Operators

UIColorExtensions provides convinient init for UIColor

```sh
extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            )
    }
}
```
This is how it works:
```sh
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153
```

This example uses a UInt32 constant called pink to store a Cascading Style Sheets color value for the color pink. The CSS color value #CC6699 is written as 0xCC6699 in Swift’s hexadecimal number representation. This color is then decomposed into its red (CC), green (66), and blue (99) components by the bitwise AND operator (**&**) and the bitwise right shift operator (**>>**).

The red component is obtained by performing a bitwise AND between the numbers 0xCC6699 and 0xFF0000. The zeros in 0xFF0000 effectively “mask” the second and third bytes of 0xCC6699, causing the 6699 to be ignored and leaving 0xCC0000 as the result.

This number is then shifted 16 places to the right (>> 16). Each pair of characters in a hexadecimal number uses 8 bits, so a move 16 places to the right will convert 0xCC0000 into 0x0000CC. This is the same as 0xCC, which has a decimal value of 204.

Similarly, the green component is obtained by performing a bitwise AND between the numbers 0xCC6699 and 0x00FF00, which gives an output value of 0x006600. This output value is then shifted eight places to the right, giving a value of 0x66, which has a decimal value of 102.

Finally, the blue component is obtained by performing a bitwise AND between the numbers 0xCC6699 and 0x0000FF, which gives an output value of 0x000099. There’s no need to shift this to the right, as 0x000099 already equals 0x99, which has a decimal value of 153.

## Unit Testing in Swift
To create a new Unit testing target, go to File -> New -> Target -> Test (under iOS) -> iOS Unit Testing Bundle.

Import with @testable

In your test target, just import the module you want to test using the @testable keyword, the name o module you can find in project settings -> Build Settings -> Packaging -> Product Module Name

Example of simple test

```sh
import XCTest
@testable import Irregular_verbs

class VerbsModelTests: XCTestCase {

    func testGetVerbBeforeFetchVerbs() {
        let verbsModel = VerbsModel()
        XCTAssertEqual(verbsModel.getVerb(1), nil)
    }

    func testGetVerbAfterFetchVerbs() {
        let verbsModel = VerbsModel()
        verbsModel.fetchVerbs()
        XCTAssertNotEqual(verbsModel.getVerb(1), nil)
    }
}
```

## Clouser

#####Capture Danger
We have to be careful about capturing because of memory management Specifically, we don’t want to create a memory cycle
Closures capture pointers (i.e. it keeps what they point to in memory)
If a captured pointer points (directly or indirectly) back at the closure, that’s a problem Because now there will always be a pointer to the closure and to the captured thing Neither will ever be able to leave the heap  

```sh
class Foo {
    var action: () -> Void = { } 	//self points to this closure (via its action property). 

    func show(value: Int) { println(“\(value)”) }
    
    func setupMyAction() {
        var x: Int = 0
        action = { [unowned self] in	// adding [unowned self] prevent memory cycle
        //Now that reference to self inside the closure will not keep self in memory. 
        x = x + 1 
        self.show(x) //closure points to self (memory loop)
        }
    }	 
    func doMyAction10times() { 
        for i in 1...10 { 
            action() 
        } 
    }
}
```


