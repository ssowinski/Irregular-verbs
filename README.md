# Irregular verbs - example of app without storyboard

### window - UIWindow
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


### UIView
A view has only one superview ```var superview: UIView?```, but it can have many (or zero) subviews ```var subviews: [UIView]``` The order in the subviews array matters, those later in the array are on top of those earlier.

A view has property ```var window: UIWindow?``` is nil if the view has not yet been added to a window (view is not part of the interface)

A view can clip its subviews to its own bounds or not (the default is not to) ```var clipsToBounds: Bool``` If set to false, subviews whose frames extend beyond the visible bounds of the receiver are not clipped. The default value is *false*.

```addSubview(aView: UIView)``` // sent to aView’s (soon to be) superview
```removeFromSuperview()``` // this is sent to the view you want to remove (not its superview)

#####UIView’s initializer
-initializer if the UIView is created in code ```init(frame: CGRect)```
-initializer if the UIView comes out of a storyboard ```init(coder: NSCoder)```

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

###ViewController
Relationships between view controllers:

- *Parentage - parent/child* (containment)
A view controller can contain another view controller. Parent view controller (eg. UINavigationController) with a child view controller.

- *Presentation* (modal views)
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
```sh

If we don't override the loadView function, then UIViewController’s default implementation of loadView creates a generic UIView object and assigns it to self.view. 