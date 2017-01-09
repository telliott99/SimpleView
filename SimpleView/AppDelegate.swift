//
//  AppDelegate.swift
//  SimpleView
//
//  Created by Tom Elliott on 1/9/17.
//  Copyright © 2017 Tom Elliott. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mwc = MainWindowController(windowNibName: "MainWindowController")
        mwc.showWindow(self)
        self.mainWindowController = mwc
    }

}

