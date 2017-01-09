//
//  MyView.swift
//  SimpleView
//
//  Created by Tom Elliott on 1/9/17.
//  Copyright © 2017 Tom Elliott. All rights reserved.
//

import Cocoa

class MyView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        Swift.print("MyView:  draw")
        let backgroundColor = NSColor.cyan
        backgroundColor.set()
        NSBezierPath.fill(bounds)
        // Drawing code here.
    }
    
    func myViewDoIt() {
        Swift.print("myViewDoIt")
    }
    
}
