//
//  Helper.swift
//  SimpleView
//
//  Created by Tom Elliott on 1/9/17.
//  Copyright © 2017 Tom Elliott. All rights reserved.
//

import Cocoa

let ad = NSApplication.shared().delegate as! AppDelegate
let mwc = ad.mainWindowController!

func helperDoIt() {
    Swift.print("helperDoIt")
}

func helperDoIt2() {
    Swift.print("Helper:  helperDoIt2")
    mwc.myView.myViewDoIt()
}
