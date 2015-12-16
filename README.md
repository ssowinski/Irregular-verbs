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
Main storyboard name is set in **Info.plist** key “Main storyboard file base name” (*<key>UIMainStoryboardFile</key>*) 

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
4. Edit AppDelegate.swift as below to obtain minimal working app.
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


