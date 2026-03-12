//
//  AppDelegate_ORIGINAL.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-10-05.

/// ❗️FÖLJDANDE 'r original Appdelegate.swift som fanns i repon i Github after commit den 30:de juni 2025 – med SHA–HASH "7de48d7fcc081f04af07b050d13aa91ad1ce3b98"  –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––❗️

/*
// AppDelegate.swift
// functionality: see it as the object (the menubar after menubar big bang, the big bang was in MenuBar_NotesApp.swift) that handles all the configuration & initialization of the menubar
// Used in: StockMenuBarApp.swift
// Date: 2022-05-12
// Created by: Shayan Eivaz Khani

import Foundation
import Cocoa
import SwiftUI

      /* "extends" NSObject, "implements" NSApplicationDelegate */
class AppDelegate: NSObject, NSApplicationDelegate {
    
// MARK: – 💧 Create one instance of RealmManager and pass it down  ・・・・・・・・・・・・・・・・・
    
    /*
        @StateObject is used to create an instance of an ObservableObject that is owned by the view.
        It ensures the object is created only once and persists for the lifecycle of the view.
            
        Alltså i vårt fall vi garanterar att vi skapar endast 1 instance av RealmManager() och skickar den down the heirarchy till contantView (längre ner)
        och alla andra Views som vi skapar inuti ContentView  som i sin tur kommer att använda exakt  denna  kopia.
    */
    var realmManager = RealmManager() // View owns this object
    
// MARK: – 💧Rest of the Initialization  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    var statusItem: NSStatusItem!
    /* NSPopover is a means to display additional content related to existing content on the screen. (i.e. basically a "window" that "pops" up/over) */
    let popover = NSPopover()
    
    private lazy var contentView: NSView? = {
        let view = (statusItem.value(forKey: "window") as? NSWindow)?.contentView  /* the  ... as? NSWindow ... --> means "cast this value optionally as NSWindow */
        return view
    }()
    
    /* pretend its our menubar constructor that is on autocall */
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the activation policy to .regular to enable multiple windows
        //NSApplication.shared.setActivationPolicy(.regular)
        
        //print("⚠️ App Did Finish Launch")
        setupMenuBar()
        setupPopover()
    }
    
    func applicationDidHide(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidResignActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidBecomeActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    
    /* Setup MenuBar */
    func setupMenuBar() {
        /* Returns a newly created status item that has been allotted a specified space within the status bar. */
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        //statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        //statusItem = NSStatusBar.system.statusItem(withLength: 20)
        guard let menuButton = statusItem.button
        else {
            return
        }
        
        //menuButton.image = NSImage(systemSymbolName: "4.circle", accessibilityDescription: nil)
        //menuButton.image = NSImage(systemSymbolName: "cloud.bolt.fill", accessibilityDescription: nil)
        /* systemSymbolName is taken from SF Symbols app that is available for macOS */
        menuButton.image = NSImage(named: "Statusbar-Icon")
        
        /* Defines an action that is assigned to our menubar icon. Everytime it is clicked, menuButtonClicked() is triggered. */
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        /* Register click action */
        menuButton.action = #selector(menuButtonClicked(_:))
        /* Dispatch click states */
        menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    }
}

// MARK: - Menu Bar ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate {

    @objc func menuButtonClicked(_ sender: AnyObject?) {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        //let event = NSApp.currentEvent!
        
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        
        guard let menuButton = statusItem.button else { return }
    
        popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
        popover.contentViewController?.view.window?.makeKey()
    }
}

// MARK: - för Popover som öppnas om man vänster-klickar på Menu Baren •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate: NSPopoverDelegate {
    
    func setupPopover() {
        popover.behavior = .transient                             /* .transient --> means/does: The system will close the popover when the user interacts with a user interface element outside the popover. */
        popover.animates = true                                  /* .animate --> means/does: Specifies if the popover is to be animated. */
        
        //popover.contentSize = .init(width: 320, height: 500)    /* .contentSize --> means/does: Sets the content size of the popover. */
        //popover.contentSize = .init(width: 450, height: 700)
        popover.contentSize = .init(width: 410, height: 630)
        
        popover.contentViewController = NSViewController()     /* .contentViewController --> means/does: The view controller that manages the content of the popover. */
        popover.contentViewController?.view = NSHostingView(  /* NSHostingView --> is/does: An AppKit view that hosts a SwiftUI view hierarchy. */
            rootView:  ContentView().frame(maxWidth: .infinity , maxHeight: .infinity).environmentObject(realmManager)  /* initialiserar SwiftUI View structen ContentView.swift + Inject the environment object using .environmentObject */
        )
    }
}

extension AppDelegate {
    
    @objc func openInfoPage() {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // Create the frame to draw window
        let settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 310, height: 300),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        // Add title
        settingsWindow.title = ""
        
        // Keeps window reference active, we need to use this when using NSHostingView
        settingsWindow.isReleasedWhenClosed = false
        
        /* NSHostingView lets us use SwiftUI views with AppKit */
        settingsWindow.contentView = NSHostingView(rootView: AboutApplicationView())
        
        // Center and bring forward
        settingsWindow.center()
        settingsWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openSettings() {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // Create the frame to draw window
        let settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 310, height: 300),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        // Add title
        settingsWindow.title = "settings"
        
        // Keeps window reference active, we need to use this when using NSHostingView
        settingsWindow.isReleasedWhenClosed = false
        
        /* NSHostingView lets us use SwiftUI views with AppKit */
        settingsWindow.contentView = NSHostingView(rootView: GeneralSettingsView())
        
        // Center and bring forward
        settingsWindow.center()
        settingsWindow.makeKeyAndOrderFront(nil)
        
    }
}

extension AppDelegate {
    @objc func textUpperCase() {
        do {
            // Read from pasteboard
            let pasteboard = NSPasteboard.general
            let pasted = pasteboard.pasteboardItems?.first?.string(forType: .string) ?? " "
            
            let up = pasted.uppercased()
            // Write/Copy to pasteboard
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(up, forType: NSPasteboard.PasteboardType.string)
        } catch {
            print("Error textUpperCase from pasteboard:  \(error)")
        }
    }
    
    @objc func textLowerCase() {
        do {
            // Read from pasteboard
            let pasteboard = NSPasteboard.general
            let pasted = pasteboard.pasteboardItems?.first?.string(forType: .string) ?? " "
            
            let lo = pasted.lowercased()
            // Write/Copy to pasteboard
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(lo, forType: NSPasteboard.PasteboardType.string)
        } catch {
            print("Error textLowerCase from pasteboard:  \(error)")
        }
    }
}
*/

/// ❗️–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––❗️

// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*
extension AppDelegate {
    
    @objc func openInfoPage() {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // Create the frame to draw window
        let settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 310, height: 300),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        // Add title
        settingsWindow.title = ""
        
        // Keeps window reference active, we need to use this when using NSHostingView
        settingsWindow.isReleasedWhenClosed = false
        
        /* NSHostingView lets us use SwiftUI views with AppKit */
        settingsWindow.contentView = NSHostingView(rootView: AboutApplicationView())
        
        // Center and bring forward
        settingsWindow.center()
        settingsWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openSettings() {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // Create the frame to draw window
        let settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 310, height: 300),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        // Add title
        settingsWindow.title = "settings"
        
        // Keeps window reference active, we need to use this when using NSHostingView
        settingsWindow.isReleasedWhenClosed = false
        
        /* NSHostingView lets us use SwiftUI views with AppKit */
        settingsWindow.contentView = NSHostingView(rootView: GeneralSettingsView())
        
        // Center and bring forward
        settingsWindow.center()
        settingsWindow.makeKeyAndOrderFront(nil)
        
    }
}

extension AppDelegate {
    @objc func textUpperCase() {
        do {
            // Read from pasteboard
            let pasteboard = NSPasteboard.general
            let pasted = pasteboard.pasteboardItems?.first?.string(forType: .string) ?? " "
            
            let up = pasted.uppercased()
            // Write/Copy to pasteboard
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(up, forType: NSPasteboard.PasteboardType.string)
        } catch {
            print("Error textUpperCase from pasteboard:  \(error)")
        }
    }
    
    @objc func textLowerCase() {
        do {
            // Read from pasteboard
            let pasteboard = NSPasteboard.general
            let pasted = pasteboard.pasteboardItems?.first?.string(forType: .string) ?? " "
            
            let lo = pasted.lowercased()
            // Write/Copy to pasteboard
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(lo, forType: NSPasteboard.PasteboardType.string)
        } catch {
            print("Error textLowerCase from pasteboard:  \(error)")
        }
    }
}
*/
































































































/*
 import Foundation
import Cocoa
import SwiftUI
import RichTextKit

      /* "extends" NSObject, "implements" NSApplicationDelegate */
class AppDelegate_ORIGINAL: NSObject, NSApplicationDelegate {
    
// MARK: – 💧 Create one instance of RealmManager and pass it down  ・・・・・・・・・・・・・・・
    
    /*
        @StateObject is used to create an instance of an ObservableObject that is owned by the view.
        It ensures the object is created only once and persists for the lifecycle of the view.
            
        Alltså i vårt fall vi garanterar att vi skapar endast 1 instance av RealmManager() och skickar den down the heirarchy till contantView (längre ner)
        och alla andra Views som vi skapar inuti ContentView  som i sin tur kommer att använda exakt  denna  kopia.
    */
    var realmManager = RealmManager() // View owns this object
    
    var sharedAppState = AppState()
    var context = RichTextContext()
    
// MARK: – 💧Rest of the Initialization  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    var statusItem: NSStatusItem!
    /* NSPopover is a means to display additional content related to existing content on the screen. (i.e. basically a "window" that "pops" up/over) */
    let popover = NSPopover()
    
    /*private lazy var contentView: NSView? = {
        let view = (statusItem.value(forKey: "window") as? NSWindow)?.contentView  /* the  ... as? NSWindow ... --> means "cast this value optionally as NSWindow */
        return view
    }()*/
    
    // Define this at the class level
    private lazy var hostingViewController: NSViewController = {
        let vc = NSViewController()
        vc.view = NSHostingView(
            rootView: ContentView()
                .environmentObject(realmManager)
                .environmentObject(sharedAppState)
                .environmentObject(context)
        )
        return vc
    }()
    
    /* pretend its our menubar constructor that is on autocall */
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the activation policy to .regular to enable multiple windows
        //NSApplication.shared.setActivationPolicy(.regular)
        
        //print("⚠️ App Did Finish Launch")
        setupMenuBar()
        setupPopover()
    }
    
    /*func applicationDidHide(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidResignActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidBecomeActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }*/
    
    /// Called *before* the popover is shown
    /*func popoverWillShow(_ notification: Notification) {
        //print("🔵 Popover will show")
        // Example: Reset a flag, update view, pre-load data, etc.
        // (Optional) access view state or pre-update data in `ContentView`
    }*/

    /// Called *after* the popover closes
    /*func popoverDidClose(_ notification: Notification) {
        print("🔴 Popover did close")
        NSSound(named: "Morse")?.play()
        // Example: Clean up temporary state, stop timers, etc.
    }*/

    /// Called *when the system asks whether to close the popover*
    /*func popoverShouldClose(_ popover: NSPopover) -> Bool {
        print("🟡 Should the popover close?")
        
        // Example use case: Prevent closing if a form is mid-edit
        // Return false to keep the popover open
        //let shouldClose = true // Change this logic as needed
        //return shouldClose
    }*/
    
    /* Setup MenuBar */
    func setupMenuBar() {
        /* Returns a newly created status item that has been allotted a specified space within the status bar. */
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        //statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        //statusItem = NSStatusBar.system.statusItem(withLength: 20)
        guard let menuButton = statusItem.button
        else {
            return
        }
        
        //menuButton.image = NSImage(systemSymbolName: "4.circle", accessibilityDescription: nil)
        //menuButton.image = NSImage(systemSymbolName: "cloud.bolt.fill", accessibilityDescription: nil)
        /* systemSymbolName is taken from SF Symbols app that is available for macOS */
        menuButton.image = NSImage(named: "Statusbar-Icon")
        
        //menuButton.canDrawConcurrently = true
        
        /* Defines an action that is assigned to our menubar icon. Everytime it is clicked, menuButtonClicked() is triggered. */
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        /* Register click action */
        menuButton.action = #selector(menuButtonClicked(_:))
        /* Dispatch click states */
        menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    }
}

// MARK: - Menu Bar ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate {

    @objc func menuButtonClicked(_ sender: AnyObject?) {
        
        /*let event = NSApp.currentEvent!
        switch event.type {
        case .rightMouseUp:
            showContextualMenu()
        default:
            togglePopover()
        }*/
        
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        
        guard let menuButton = statusItem.button else { return }
        
        /// Get focus from other apps – call NSApplication.shared.activate(ignoringOtherApps: true) before showing the popover  in menuButtonClicked(_:) right before popover.show(...) to ensure your popover can accept focus and key events.
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
        popover.contentViewController?.view.window?.makeKey()
    }
}

// MARK: - för Popover som öppnas om man vänster-klickar på Menu Baren •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate: NSPopoverDelegate {
    
    func setupPopover() {
        popover.behavior = .transient                             /* .transient --> means/does: The system will close the popover when the user interacts with a user interface element outside the popover. */
        //popover.behavior = .semitransient
        
        
        popover.animates = true                                   /* .animate --> means/does: Specifies if the popover is to be animated. */
        
        //popover.contentSize = .init(width: 320, height: 500)    /* .contentSize --> means/does: Sets the content size of the popover. */
        //popover.contentSize = .init(width: 450, height: 700)
        //🍎popover.contentSize = .init(width: 410, height: 630)
        //popover.contentSize = .init(width: 570, height: 690)
        //popover.contentSize = .init(width: 570, height: 630)
        popover.contentSize = .init(width: 510, height: 710)
        
        /*popover.contentViewController = NSViewController()     /* .contentViewController --> means/does: The view controller that manages the content of the popover. */
        popover.contentViewController?.view = NSHostingView(  /* NSHostingView --> is/does: An AppKit view that hosts a SwiftUI view hierarchy. */
            rootView:  ContentView().frame(maxWidth: .infinity , maxHeight: .infinity).background(TransparentWindow()).environmentObject(realmManager)  /* initialiserar SwiftUI View structen ContentView.swift + Inject the environment object using .environmentObject */
        )
        */
        
        popover.contentViewController = hostingViewController
        
        /**
         Apple's NSPopoverDelegate protocol includes useful methods such as:
             popoverShouldClose(_:) – ask whether the popover should close (e.g. maybe prevent it from closing in certain cases).
             popoverWillShow(_:) – perform custom actions right before the popover appears.
             popoverDidClose(_:) – clean up or update UI/state when the popover is closed.
         
         popover.delegate = self ––> telling the NSPopover to call methods like popoverDidClose(_:), on your AppDelegate when certain events occur, only if AppDelegate conforms to NSPopoverDelegate — which it does here: extension AppDelegate: NSPopoverDelegate { }
        */
        popover.delegate = self
    }
}


 // MARK: - ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
// MARK: - ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

 
 
 
 import Foundation
 import Cocoa
 import SwiftUI
 import RichTextKit
 
 
/*
      /* "extends" NSObject, "implements" NSApplicationDelegate */
class AppDelegate: NSObject, NSApplicationDelegate {
    
// MARK: – 💧 Create one instance of RealmManager and pass it down  ・・・・・・・・・・・・・・・
    
    /*
        @StateObject is used to create an instance of an ObservableObject that is owned by the view.
        It ensures the object is created only once and persists for the lifecycle of the view.
            
        Alltså i vårt fall vi garanterar att vi skapar endast 1 instance av RealmManager() och skickar den down the heirarchy till contantView (längre ner)
        och alla andra Views som vi skapar inuti ContentView  som i sin tur kommer att använda exakt  denna  kopia.
    */
    var realmManager = RealmManager() // View owns this object
    
    var sharedAppState = AppState()
    var context = RichTextContext()
    
// MARK: – 💧Rest of the Initialization  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //var statusItem: NSStatusItem!
    private var statusItem: NSStatusItem? // Safer than implicitly-unwrapped optional
    
    /* NSPopover is a means to display additional content related to existing content on the screen. (i.e. basically a "window" that "pops" up/over) */
    let popover = NSPopover()
    
    // Key event monitor for ESC to close popover
    private var escMonitor: Any?
    
    /*private lazy var contentView: NSView? = {
        let view = (statusItem.value(forKey: "window") as? NSWindow)?.contentView  /* the  ... as? NSWindow ... --> means "cast this value optionally as NSWindow */
        return view
    }()*/
    
    // Define this at the class level
    // Use NSHostingController but store as NSViewController to avoid generic type mismatch.
    // This fixes: "Cannot convert value of type 'NSHostingController<some View>' to closure result type 'NSHostingController<ContentView>'"
    private lazy var hostingController: NSViewController = {
        let root = ContentView()
            .environmentObject(realmManager)
            .environmentObject(sharedAppState)
            .environmentObject(context)
        return NSHostingController(rootView: root)
    }()
    
    /* pretend its our menubar constructor that is on autocall */
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the activation policy to .regular to enable multiple windows
        //NSApplication.shared.setActivationPolicy(.regular)
        
        //print("⚠️ App Did Finish Launch")
        setupMenuBar()
        setupPopover()
    }
    
    /*func applicationDidHide(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidResignActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidBecomeActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }*/
    
    /// Called *before* the popover is shown
    /*func popoverWillShow(_ notification: Notification) {
        //print("🔵 Popover will show")
        // Example: Reset a flag, update view, pre-load data, etc.
        // (Optional) access view state or pre-update data in `ContentView`
    }*/

    /// Called *after* the popover closes
    /*func popoverDidClose(_ notification: Notification) {
        print("🔴 Popover did close")
        NSSound(named: "Morse")?.play()
        // Example: Clean up temporary state, stop timers, etc.
    }*/

    /// Called *when the system asks whether to close the popover*
    /*func popoverShouldClose(_ popover: NSPopover) -> Bool {
        print("🟡 Should the popover close?")
        
        // Example use case: Prevent closing if a form is mid-edit
        // Return false to keep the popover open
        //let shouldClose = true // Change this logic as needed
        //return shouldClose
    }*/
    
    /* Setup MenuBar */
    func setupMenuBar() {
        /*/* Returns a newly created status item that has been allotted a specified space within the status bar. */
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        //statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        //statusItem = NSStatusBar.system.statusItem(withLength: 20)
        guard let menuButton = statusItem.button
        else {
            return
        }
        
        //menuButton.image = NSImage(systemSymbolName: "4.circle", accessibilityDescription: nil)
        //menuButton.image = NSImage(systemSymbolName: "cloud.bolt.fill", accessibilityDescription: nil)
        /* systemSymbolName is taken from SF Symbols app that is available for macOS */
        menuButton.image = NSImage(named: "Statusbar-Icon")
        */
        
        /* Returns a newly created status item that has been allotted a specified space within the status bar. */
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem = item
        
        guard let menuButton = item.button else { return }
        
        //menuButton.image = NSImage(systemSymbolName: "4.circle", accessibilityDescription: nil)
        //menuButton.image = NSImage(systemSymbolName: "cloud.bolt.fill", accessibilityDescription: nil)
        /* systemSymbolName is taken from SF Symbols app that is available for macOS */
        menuButton.image = NSImage(named: "Statusbar-Icon")
        
        //menuButton.accessibilityLabel = "Notes" // Accessibility
        menuButton.toolTip = "Notes"
        
        menuButton.canDrawConcurrently = true
        
        /* Defines an action that is assigned to our menubar icon. Everytime it is clicked, menuButtonClicked() is triggered. */
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        /* Register click action */
        menuButton.action = #selector(menuButtonClicked(_:))
        menuButton.target = self // ensure the action is delivered here
        /* Dispatch click states */
        menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    }
}


// MARK: - för Popover Transparent Background •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
/*class TransparentWindowView: NSView {
    override func viewDidMoveToWindow() {
        window?.backgroundColor = .clear
        super.viewDidMoveToWindow()
    }
}
struct TransparentWindow: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return TransparentWindowView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
}
// ContentView.background(TransparentWindow())
*/

// MARK: - för Popover som öppnas om man vänster-klickar på Menu Baren •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate: NSPopoverDelegate {
    
    func setupPopover() {
        
        // Use NSHostingController for proper focus/responder chain integration.
        popover.contentViewController = hostingController
        popover.contentViewController?.view.translatesAutoresizingMaskIntoConstraints = true
        popover.contentViewController?.view.canDrawConcurrently = true
        popover.behavior = .transient          /* .transient --> means/does: The system will close the popover when the user interacts with a user interface element outside the popover. */
        //popover.behavior = .semitransient
        
        popover.animates = true
        
        //popover.contentSize = .init(width: 320, height: 500)    /* .contentSize --> means/does: Sets the content size of the popover. */
        //popover.contentSize = .init(width: 450, height: 700)
        //🍎popover.contentSize = .init(width: 410, height: 630)
        //popover.contentSize = .init(width: 570, height: 690)
        //popover.contentSize = .init(width: 570, height: 630)
        popover.contentSize = .init(width: 510, height: 710)
        
        /*popover.contentViewController = NSViewController()     /* .contentViewController --> means/does: The view controller that manages the content of the popover. */
        popover.contentViewController?.view = NSHostingView(   /* NSHostingView --> is/does: An AppKit view that hosts a SwiftUI view hierarchy. */
            rootView:  ContentView().frame(maxWidth: .infinity , maxHeight: .infinity).background(TransparentWindow()).environmentObject(realmManager)  /* initialiserar SwiftUI View structen ContentView.swift + Inject the environment object using .environmentObject */
        )
        */
        
        /**
         Apple's NSPopoverDelegate protocol includes useful methods such as:
             popoverShouldClose(_:) – ask whether the popover should close (e.g. maybe prevent it from closing in certain cases).
             popoverWillShow(_:) – perform custom actions right before the popover appears.
             popoverDidClose(_:) – clean up or update UI/state when the popover is closed.
         
         popover.delegate = self ––> telling the NSPopover to call methods like popoverDidClose(_:), on your AppDelegate when certain events occur, only if AppDelegate conforms to NSPopoverDelegate — which it does here: extension AppDelegate: NSPopoverDelegate { }
        */
        popover.delegate = self
    }
}

// MARK: - Menu Bar ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate {

    /*@objc func menuButtonClicked(_ sender: AnyObject?) {
        /*let event = NSApp.currentEvent!
        switch event.type {
            case .rightMouseUp:
                showContextualMenu()
            default:
                togglePopover()
        }*/
        
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        
        guard let menuButton = statusItem.button else { return }
        
        /// Get focus from other apps – call NSApplication.shared.activate(ignoringOtherApps: true) before showing the popover  in menuButtonClicked(_:) right before popover.show(...) to ensure your popover can accept focus and key events.
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // For a status bar popover, use the bottom edge (.minY) so it appears below the status item.
        //popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
        
        // Ensure the popover can accept key events if needed (often not necessary, but harmless).
        popover.contentViewController?.view.window?.makeKeyAndOrderFront(nil)
    }*/
    
    @objc func menuButtonClicked(_ sender: AnyObject?) {
        // Support right-click for contextual menu
        /*if let event = NSApp.currentEvent, event.type == .rightMouseUp {
            showContextualMenu()
            return
        }*/
        
        
        if popover.isShown {
            popover.performClose(nil)
            return
        }
        
        guard let menuButton = statusItem?.button else { return }
        
        /// Get focus from other apps – call NSApplication.shared.activate(ignoringOtherApps: true) before showing the popover  in menuButtonClicked(_:) right before popover.show(...) to ensure your popover can accept focus and key events.
        NSApplication.shared.activate(ignoringOtherApps: true)
        popover.contentViewController?.view.window?.becomeFirstResponder()
        // Ensure the popover can accept key events if needed.
        popover.contentViewController?.view.window?.makeKeyAndOrderFront(nil)
        
        // For a status bar popover, use the bottom edge (.minY) so it appears below the status item.
        popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
        //let positioningRect = NSRect(x: menuButton.bounds.midX, y: menuButton.bounds.maxY, width: 0, height: 0)
        //let positioningRect = NSRect(x: menuButton.bounds.minX, y: menuButton.bounds.minY, width: 510, height: 710)
        //popover.show(relativeTo: positioningRect, of: menuButton, preferredEdge: .minY)
        //popover.show(relativeTo: menuButton.safeAreaRect.insetBy(dx: 0, dy: -1), of: menuButton, preferredEdge: .maxY)
        
        
        
        
        // Add ESC handler to close the popover
        escMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 { // ESC
                self?.popover.performClose(nil)
                return nil
            }
            return event
        }
        
        // Optional: auto-size to SwiftUI content's fitting size on next runloop
        /*DispatchQueue.main.async { [weak self] in
            guard let self, let view = self.popover.contentViewController?.view else { return }
            view.layoutSubtreeIfNeeded()
            // Clamp to reasonable minimums if desired
            self.popover.contentSize = NSSize(width: 510, height: 710)
            
            /*let size = view.fittingSize
            // Clamp to reasonable minimums if desired
            self.popover.contentSize = NSSize(width: max(360, size.width), height: max(300, size.height))
            */
        }*/
    }
    
    /*private func showContextualMenu() {
        guard let button = statusItem?.button else { return }
        let menu = NSMenu()
        menu.addItem(withTitle: "Open", action: #selector(menuButtonClicked(_:)), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        menu.items.forEach { $0.target = self }
        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: button)
    }
    @objc private func quitApp() {
        NSApp.terminate(nil)
    }
    */
}
*/
*/
