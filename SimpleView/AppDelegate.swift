import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let mwc = MainWindowController(windowNibName: NSNib.Name(rawValue: "MainWindowController"))
        mwc.showWindow(self)
        self.mainWindowController = mwc
        
        window.close()
    }
    
}

