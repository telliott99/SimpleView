This write-up describes how to make an app with a custom view in Swift3 using Xcode.  My current version of Xcode is 8.2.1.

### Custom view

Start by making a new Xcode project:

* macOS Cocoa Application
* name:  **SimpleView**
* no tests
* Swift language
* default location (for me, the Desktop)

Next, select the View ***folder*** in the Project navigator.

![](figs/folder.png)

Do:  **File > New > File >**

![](figs/New_File_New.png)

Make this a Cocoa class:

![](figs/Cocoa_class.png)

* macOS Cocoa Class
* name:  **MyView**
* subclassing NSView
* Swift language

![](figs/NSView_subclass.png)

Add the following snippet to the default code generated for the **draw** function in **MyView.swift**:

```css
Swift.print("MyView:  draw")
let backgroundColor = NSColor.cyan
backgroundColor.set()
NSBezierPath.fill(bounds)
```
This uses the new Swift3 syntax, substituting **.cyan** for **.cyanColor()**.

If you want to check this code you *could* perhaps do this:

* click on **MainMenu.xib**
* In the .xib file, click on the window in the middle
* If the Identity Inspector shows NSView it is the window's Content View
* if not, click again
* change the class to MyView
* Build and run

![](figs/cyan_window.png)

Now revert that change.

### Window controller

Life will be better with a Window Controller.  If we create a new .swift file for its code, Xcode will make the corresponding .xib file for us.

As before, select the SimpleView *folder* in the Project view.

Now do:  **File > New > File >**

* macOS Cocoa Class
* name:  **MainWindowController**
* subclassing NSWindowController
* Swift language


Make sure to check **Also create XIB file**. 

![](figs/mwc.png) 

If you build and run at this point you'll see a window but it's not our window.  We have to tell our window we want it to appear on screen.


In the **AppDelegate** just below the Class declaration is the IBOutlet declaration where it says 

```css
@IBOutlet weak var window: NSWindow!
```

 add an additional line so it reads

```css
@IBOutlet weak var window: NSWindow!
var mainWindowController: MainWindowController?
```

There are three more lines to add to **applicationDidFinishLaunching** to set up a window controller.

```css
let mwc = MainWindowController(windowNibName: "MainWindowController")
mwc.showWindow(self)
```
The Hillegass book says:  do setup first, then assignment.  So now set the property to point to the window controller we just made

```css  
self.mainWindowController = mwc
```

I suppose I might have resisted the urge to shorten "mainWindowController" to "mwc" here.

You could remove **applicationWillTerminate** from the file as well.

In the Project navigator, click on the new MainWindowController.xib file.  Drag a custom view from the palette out onto the the window.  

![](figs/custom_view.png) 

With the view selected

![](figs/view_added.png) 

in the Identity Inspector, set its class to MyView.

Run and see the custom view turn cyan.  

![](figs/window_with_view.png) 

### Actions

IBActions are connected to File's Owner seen in the "nib" (generated from the .xib file) which propagates the action to our MainWindowController.  Put this code in **MainWindowController.swift**:

```css
@IBAction func button_pushed(sender: AnyObject) {
    	Swift.print("MWC:  button_pushed")
    }
```

Open **MainWindowController.xib** and drag a button onto the window.  Control-drag from the button to **File's Owner** and select **button_pushedWithSender**.
![](figs/target_action.png) 

**File's Owner** is the blue cube on the left.  The button is first selected before the drag.  In the black box that appears after the drag you will see **button_pushedWithSender**.  

(Our method has had **WithSender** appended to it by Xcode/Interface Builder).

Build and run and the log (in the Debug area) will show the first line of:

```css
MyView:  draw
MWC:  button_pushed
```

You will get the second line after you push the button in the running app.

Our question at this point is how to go from an IBAction to a method in MyView.  Xcode will not allow a direct connection of the button in IB to the Custom View even if code for the function is moved **MyView.swift**.

We can get "key events" in the view by doing this:

```css
override var acceptsFirstResponder: Bool { return true }
```

but that's another story.

So, we have to receive the action of the button in the MWC, but then call code elsewhere.  Which files have their functions visible across our code?

It turns out that most simple Swift files are visible, but **MyView.swift** is not.  We need to explicitly hook it up.  Put this in **MyView.swift**

```
func myViewDoIt() {
        Swift.print("MyView:  myViewDoIt")
    }
```

As mentioned, this code cannot be called directly from the MWC, even if we add this to **MainWindowController.swift**

```
@IBAction func button_pushed(sender: AnyObject) {
        Swift.print("MWC:  button_pushed")
        myViewDoIt()
    }
```

![](figs/unresolved_identifier.png) 

We need to let the MainWindowController "know about" MyView.  

One way to solve this is to put this code into **MainWindowController.swift** just after the class declaration.

```css
class MainWindowController: NSWindowController {
    
    @IBOutlet weak var myView: MyView!
```

Then go to the .xib file and control drag from **File's Owner** to the custom view.  It helps to select the custom view first.  It will show "Outlets".  Choose "myView".  Finally, change the code in **MainWindowController.swift** slightly to


```css
@IBAction func button_pushed(sender: AnyObject) {
        Swift.print("MWC:  button_pushed")
        myView.myViewDoIt()
    }
```

The log reads:

```css
MyView:  draw
MWC:  button_pushed
MyView:  myViewDoIt
```

Select the View ***folder*** in the Project view, do:  **File > New > File >** and make a new Swift file called **Helper.swift**.

![](figs/swift_file.png) 

In the new file, place this function:

```css
import Foundation

func helperDoIt() {
    Swift.print("Helper:  helperDoIt")
}
```

and modify the call in **MainWindowController.swift** to read:

```css
    @IBAction func button_pushed(sender: AnyObject) {
        Swift.print("MWC:  button_pushed")
        myView.myViewDoIt()
        helperDoIt()
    }
```

Build and run the app, and push the button, and the log will read

```css
MyView:  draw
MWC:  button_pushed
MyView:  myViewDoIt
Helper:  helperDoIt
```

We can pass data from the helper to the calling function just by returning the right data structure.  

However, you may occasionally need to obtain a reference to the MainWindowController (or the View) from somewhere like **Helper.swift**.

We obtain a reference to the App Delegate and MWC with:

```css
import Cocoa

let ad = NSApplication.shared().delegate as! AppDelegate
let mwc = ad.mainWindowController!
```

This can be at the top of the file in **Helper.swift**.  

Note that the default import is to **import Foundation**.  But for our swift code to know what **NSApplication** is, we need Cocoa.

Put a second button on the window and connect it to File's Owner and thus to MainWindowController

```csss
@IBAction func button2_pushed(sender: AnyObject) {
    Swift.print("MWC:  button2_pushed")
    helperDoIt2()
}
```

in **MainWindowController.swift**.  Put the following into **Helper.swift**:

```css
func helperDoIt2() {
    Swift.print("Helper:  helperDoIt2")
    mwc.myView.myViewDoIt()
}
```

The log shows:

```css
MyView:  draw
MWC:  button2_pushed
Helper:  helperDoIt2
MyView:  myViewDoIt
```

We have propagated an action from the button to the MWC to the Helper;  grabbed a reference there to the App Delegate and thus to the MWC, passed the action to its outlet myView, and then finally called a function in the view.

One last detail about views.  It happens that code can change the status of the model, but the view is not appropriately updated.  

The way to force the view to redraw itself is to put something like this in the view

```css
    func refreshScreen() {
        Swift.print("MyView:  refreshScreen")
        self.needsDisplay = true
    }
```

and when necessary call it through some variation on what we have above.

That's it for this basic introduction.  Hope this is useful to you, I know it will be for me.

