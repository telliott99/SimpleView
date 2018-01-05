import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var myView: MyView!
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    @IBAction func button_pushed(sender: AnyObject) {
        Swift.print("MWC:  button_pushed")
        myView.myViewDoIt()
        helperDoIt()
    }
    
    @IBAction func button2_pushed(sender: AnyObject) {
        Swift.print("MWC:  button2_pushed")
        helperDoIt2()
    }

}
