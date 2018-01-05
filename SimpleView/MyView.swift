import Cocoa

class MyView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    Swift.print("MyView:  draw")
    let backgroundColor = NSColor.cyan
    backgroundColor.set()
    NSBezierPath.fill(bounds)
    }
    
    func myViewDoIt() {
        Swift.print("MyView:  myViewDoIt")
    }
}
