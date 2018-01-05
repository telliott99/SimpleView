import Cocoa

let ad = NSApplication.shared.delegate as! AppDelegate
let mwc = ad.mainWindowController!

func helperDoIt() {
    Swift.print("Helper:  helperDoIt")
}

func helperDoIt2() {
    Swift.print("Helper:  helperDoIt2")
    mwc.myView.myViewDoIt()
}
