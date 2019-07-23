//
//  AppDelegate.swift
//  SCLaunchEve
//
//  Created by Karen Parlato on 7/23/19.
//  Copyright © 2019 Karen Parlato. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var item:NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.close()
        
        // Set up menu icon and menu options
        item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item?.button?.title = "Launch Eve"
        item?.button?.image = NSImage(named: "sclogo")
        item?.button?.action = #selector(AppDelegate.launchEve)
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Launch All", action: #selector(AppDelegate.launchEve), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Launcher Only", action: #selector(AppDelegate.terminalLauncher), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Web Tools Only", action: #selector(AppDelegate.launchWebsites), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        item?.menu = menu
        
    }

    @objc func launchEve() {
        // "Launch All"
        terminalLauncher()
        launchWebsites()
    }
    
    @objc func launchWebsites() {
        // "Web Tools Only"
        launchInDefaultBrowser(url: URL(string: "https://evescoutrescue.com/copilot/index.php"))
        launchInDefaultBrowser(url: URL(string: "https://tripwire.eve-apps.com"))
    }
    
    
    @objc func terminalLauncher() {
        // "Launcher Only"
        // sends the terminal command "eveonline" to launch the Wine version of the launcher
        
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.arguments = ["-c", "/usr/local/bin/wine ~/.wine/drive_c/EVE/eve.exe &> /dev/null &disown"]
     
        do {
            try task.run()
            print ("Task running")
        } catch {
            print ("Error running task: \(error)")
        }
        
        task.waitUntilExit()
        
    }
    
    
    func launchInDefaultBrowser(url:URL?){
        if url != nil {
            NSWorkspace.shared.open(url!)
        }
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
