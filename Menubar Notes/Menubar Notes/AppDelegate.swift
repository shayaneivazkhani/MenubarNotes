
// AppDelegate.swift
// functionality: see it as the object (the menubar after menubar big bang, the big bang was in MenuBar_NotesApp.swift) that handles all the configuration & initialization of the menubar
// Used in: StockMenuBarApp.swift
// Date: 2022-05-12
// Created by: Shayan Eivaz Khani

import Foundation
import Cocoa
import SwiftUI
import RichTextKit


     /* "extends" NSObject, "implements" NSApplicationDelegate and NSSoundDelegate */
class AppDelegate: NSObject, NSApplicationDelegate, NSSoundDelegate {
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
    
    // Global/local event monitors to close the panel
    private var globalMouseMonitor: Any? = nil   // Key event monitor for detecting mouseclicks that occures outside the popover to force a closing of the popover
    private var localMouseMonitor: Any? = nil    // Key event monitor for preventing right-mouse-clicking to get through to RichTextEditor
    private var localKeyMonitor: Any? = nil  // Key event monitor for ESC to close popover
    
    /* pretend its our menubar constructor that is on autocall */
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the activation policy to .regular to enable multiple windows
        //NSApplication.shared.setActivationPolicy(.regular)
        
        //print("⚠️ App Did Finish Launch")
        setupMenuBar()
        setupPopover()
    }
    
    // Cleanup only; –  remove monitors, status item, observers, etc. – don’t try to play sounds here
    func applicationWillTerminate(_ notification: Notification) {
        /// Clean up event monitors after popover closes
        if globalMouseMonitor != nil {
            if let gm = globalMouseMonitor {
                NSEvent.removeMonitor(gm)
                globalMouseMonitor = nil
            }
        }
        if localMouseMonitor != nil {
            if let lm = localMouseMonitor {
                NSEvent.removeMonitor(lm)
                localMouseMonitor = nil
            }
        }
        if localKeyMonitor != nil {
            if let lk = localKeyMonitor {
                NSEvent.removeMonitor(lk)
                localKeyMonitor = nil
            }
        }
        
        if let statusItem {
            NSStatusBar.system.removeStatusItem(statusItem)
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    private var pendingQuitSound: NSSound?
    private var didRequestTerminate = false

    /** applicationShouldTerminate(_:) happens before termination is committed.
        applicationShouldTerminate(_:) is NSApplication’s “are you ready to quit?” hook. AppKit calls it right before committing to terminate, giving you a chance to allow, cancel, or defer quitting.
        
         When it is called
             • User‑initiated quit:
                - Command–Q
                - Choosing “Quit” from your app menu
                - Choosing “Quit” from the Dock menu
                - Calling NSApplication.shared.terminate(_:) (or NSApp.terminate) in your code
             • Indirect quit paths:
                - When the last window closes and your app delegate returns true from applicationShouldTerminateAfterLastWindowClosed(:), AppKit proceeds to terminate and will call applicationShouldTerminate(:) as part of that flow.
             • System‑initiated session end (normally):
                - User logs out, restarts, or shuts down. The system asks apps to terminate; well‑behaved apps receive applicationShouldTerminate(_:) first.
     
        What value you return from applicationShouldTerminate(_:) controls the flow of termination of your app.
         • .terminateNow: AppKit proceeds to tear down the app next and will call applicationWillTerminate(_:) afterward.
         • .terminateCancel: Abort quitting; the app stays running.
         • .terminateLater: You’re deferring the decision (e.g., to save data, play a sound). You must later call NSApp.reply(toApplicationShouldTerminate: true/false). Until you reply, the app remains running.
        
        If termination proceeds, applicationWillTerminate(_:) is called next for cleanup.
    */
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        guard didRequestTerminate == false else { return .terminateNow }
        didRequestTerminate = true

        // Prevent sudden termination while we defer
        ProcessInfo.processInfo.disableSuddenTermination()

        // 1) Try a known system sound (use "Submarine" to verify your pipeline)
        if let sound = NSSound(named: NSSound.Name("Glass")) {
            startQuitSoundAndTerminateWhenDone(sound)
            return .terminateLater
        }

        // 2) Or a bundled sound file (ensure it’s in the app target)
        /*if let url = Bundle.main.url(forResource: "Tink", withExtension: "aiff"),
           let sound = NSSound(contentsOf: url, byReference: false) {
            startQuitSoundAndTerminateWhenDone(sound)
            return .terminateLater
        }*/

        // Couldn’t load any sound; terminate now
        ProcessInfo.processInfo.enableSuddenTermination()
        return .terminateNow
    }
    
    private func startQuitSoundAndTerminateWhenDone(_ sound: NSSound) {
        pendingQuitSound = sound
        sound.delegate = self
        sound.volume = 0.3
        
        if sound.play() {
            // Safety timeout in case the delegate never fires
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1s
                if self.pendingQuitSound != nil {
                    self.pendingQuitSound = nil
                    NSApp.reply(toApplicationShouldTerminate: true)
                    ProcessInfo.processInfo.enableSuddenTermination()
                }
            }
        } else {
            pendingQuitSound = nil
            NSApp.reply(toApplicationShouldTerminate: true)
            ProcessInfo.processInfo.enableSuddenTermination()
        }
    }
    
    
    /*func applicationDidHide(_ notification: Notification) {
        print("applicationDidHide")
    }
    func applicationDidResignActive(_ notification: Notification) {
        print("applicationDidResignActive")
    }
    func applicationDidBecomeActive(_ notification: Notification) {
        print("applicationDidBecomeActive")
    }*/
}


// MARK: - för Popover som öppnas om man vänster-klickar på Menu Baren •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate: NSPopoverDelegate {
    
    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength) /// Returns a newly created status item that has been allotted a specified space within the status bar.
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
        menuButton.toolTip = "Menubar Notes"
        
        /* Defines an action that is assigned to our menubar icon. Everytime it is clicked, menuButtonClicked() is triggered. */
        //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        /* Register click action */
        menuButton.action = #selector(menuButtonClicked(_:))
        //menuButton.target = self // WHY <––   – ensure the action is delivered here
        /* Dispatch click states */
        menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])    // sendAction(on:): You set .leftMouseUp and .rightMouseUp, but in menuButtonClicked you commented out the right click handler. If you intend right-click menu later, either implement it or don’t register for right clicks to avoid unexpected behavior.
    }
    
    func setupPopover() {
        popover.contentViewController = hostingViewController
        popover.contentViewController?.view.canDrawConcurrently = true
        
        //popover.behavior = .transient                              /* .transient --> means/does: The system will close the popover when the user interacts with a user interface element outside the popover. */
        popover.behavior = .semitransient                        /* .semitransient --> means/does: Because of this popover can be detached then therefor we should use .semitransient */
        //popover.behavior = .applicationDefined
        
        popover.animates = true                                    /* .animate --> means/does: Specifies if the popover is to be animated. */
        
        //popover.contentViewController?.view.window?.hasShadow = true
        
        //NSApplication.shared.helpMenu  ≤–– wtf is this HelpMenu??
        
        //popover.contentSize = .init(width: 320, height: 500)    /* .contentSize --> means/does: Sets the content size of the popover. */
        //popover.contentSize = .init(width: 450, height: 700)
        //🍎popover.contentSize = .init(width: 410, height: 630)
        //popover.contentSize = .init(width: 570, height: 690)
        //popover.contentSize = .init(width: 570, height: 630)
        //popover.contentSize = .init(width: 510, height: 710)
        popover.contentSize = NSSize(width: 510, height: 710)
        
        /*popover.contentViewController = NSViewController()     /* .contentViewController --> means/does: The view controller that manages the content of the popover. */
        popover.contentViewController?.view = NSHostingView(  /* NSHostingView --> is/does: An AppKit view that hosts a SwiftUI view hierarchy. */
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
    
    
    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }
    func popoverDidDetach(_ popover: NSPopover) {
        Task { @MainActor in
            self.sharedAppState.popOverHasBeenDetachedByUser = true
            
            /// no need for monitoring external mouse events
            if globalMouseMonitor != nil {
                if let gm = globalMouseMonitor {
                    NSEvent.removeMonitor(gm)
                    globalMouseMonitor = nil
                }
            }
        }
    }
    
    
    /// Called *when the system asks whether to close the popover* – maybe you want to prevent the popover closing while an operation is ongoing
    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        //let shouldClose = !(self.sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet)
        //print("🟡 Should the popover close?  " + String(shouldClose))
        
        /*if !shouldClose {
            if let lm = localMouseMonitor {
                /// dont do anything since the event monitor exists
            } else {
                /// Close on user pressing Key ESC (escape-button)
                localKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
                    //print("pressed " + String(event.keyCode))
                    if event.keyCode == 53 {
                        //print("pressed ESC")
                        self?.popover.performClose(nil)
                        
                        return nil
                    }
                    return event
                }
            }
        }*/
        
        return !(self.sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet)
    }
    
    
   /// Called *before* the popover is shown –  Example: Reset a flag, update view, pre-load data, etc. – (Optional) access view state or pre-update data in `ContentView`
   func popoverWillShow(_ notification: Notification) {
       //print("🔵 Popover will show")
       //NSSound(named: "Morse")?.play()
      
       /*if let gm = globalMouseMonitor {
           NSEvent.removeMonitor(gm)
           globalMouseMonitor = nil
       }
       if let lm = localMouseMonitor {
           NSEvent.removeMonitor(lm)
           localMouseMonitor = nil
       }
       if let lk = localKeyMonitor {
           NSEvent.removeMonitor(lk)
           localKeyMonitor = nil
       }
       */
   }
    
    /// Called *after* the popover is shown
    func popoverDidShow(_ notification: Notification) {
        //print("🔵 Popover did show")
    }

   /// Called *after* the popover closes
   func popoverDidClose(_ notification: Notification) {
       //print("🔴 Popover did close")
       //NSSound(named: "Morse")?.play()
       
       self.sharedAppState.popOverHasBeenDetachedByUser = false
       
       /// Clean up event monitors after popover closes
       if globalMouseMonitor != nil {
           if let gm = globalMouseMonitor {
               NSEvent.removeMonitor(gm)
               globalMouseMonitor = nil
           }
       }
       if localMouseMonitor != nil {
           if let lm = localMouseMonitor {
               NSEvent.removeMonitor(lm)
               localMouseMonitor = nil
           }
       }
       if localKeyMonitor != nil {
           if let lk = localKeyMonitor {
               NSEvent.removeMonitor(lk)
               localKeyMonitor = nil
           }
       }
   }
}


extension AppDelegate {

   @objc func menuButtonClicked(_ sender: AnyObject?) {
       /** Använd något som liknar följande ifall du vill skilja på vilken typ av mus–klick som USER gjorde, alltså höger-klick på manubarIcon eller Vänster-klickade USER på menubarIkonen i sin datorns menu bar
        let event = NSApp.currentEvent!
           switch event.type {
               case .leftMouseUp:
                   leftClickAction()
               case .rightMouseUp:
                   rightClickAction()
                   showContextualMenu()
               default:
                   togglePopover()
       }*/
       
       //print("menubutton pressed")
       
       if popover.isDetached {
           if globalMouseMonitor != nil {
               globalMouseMonitor = nil
           }
       } else {
           if globalMouseMonitor == nil {
               //print("globalMouseMonitor did not exist, creating a new one")
               /// Close the popover on click outside only if sheet is not showing
               globalMouseMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown, .otherMouseDown]) { [weak self] event in
                   guard let self else { return }
                   if (self.popover.isShown) && !(self.popover.isDetached) {
                       /// Event location is already in screen coordinates for global monitors
                       
                       //let clickLocationInScreen = event.locationInWindow // for global monitor, this is in screen coords
                       if ((self.popover.contentViewController?.view.window?.doesContain(event.locationInWindow)) != nil) {
                           /// if the mouse event is not occuring inside the popover then control flow will pass through this block else it will go through the "elese {}" block
                           //print("USER pressed button outside popover")
                           
                           if self.sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet != true {
                               //print("close popover🟡")
                               self.popover.performClose(nil)
                           } else {
                               NSApplication.shared.activate(ignoringOtherApps: true)
                               
                               if let button = self.statusItem.button {
                                   self.popover.show(
                                    relativeTo: button.bounds,
                                    of: button,
                                    preferredEdge: .maxY
                                   )
                                   self.popover.contentViewController?.view.window?.makeKey()
                               }
                           }
                       } else {
                           /// if the mouse event is  occuring inside the popover then control flow will pass through this block
                           //print("USER pressed button inside popover") // will never execute
                       }
                   } else {
                       //print("USER pressed mouse button but popover is either not showing or it is detached")
                   }
                   
                   return
               }
           }
       }
       if localMouseMonitor == nil {
           //print("localMouseMonitor did not exist, creating a new one")
           /// prevent Right-clicking
           localMouseMonitor = NSEvent.addLocalMonitorForEvents(matching: .rightMouseDown) { [weak self] _ in
               //NSSound(named: "Glass")?.play()
               //print("Mouse click rightMouseDown")
               return nil
           }
       }
       if localKeyMonitor == nil {
           /// Close on user pressing Key ESC (escape-button)
           //print("localKeyMonitor key event monitor for ESC-button did not exist so creating a new one")
           localKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
               if event.keyCode == 53 {
                   //print("pressed ESC")
                   //print("pressed ESC" + String(event.keyCode))
                   
                   if (self?.popover.isShown ?? false) {
                       //print("pressed ESC while popover is showing")
                       if (self?.sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet != true) {
                           self?.popover.performClose(nil)
                           return nil
                       } else {
                           return nil
                       }
                   }
               }
               return event
           }
       }
       
       /// Get focus from other apps – call NSApplication.shared.activate(ignoringOtherApps: true) before showing the popover  in menuButtonClicked(_:) right before popover.show(...) to ensure your popover can accept focus and key events.
       ///  Forcing app activation: NSApplication.shared.activate(ignoringOtherApps: true) before showing the popover can be jarring (steals focus). It’s sometimes necessary for text input, but try the lighter approach: popover.behavior = .transient and let the system handle first responder. If you need focus for editors, consider activate(ignoringOtherApps: false) or only call it when your content requires key events (e.g., when a text field is first responder).
       NSApplication.shared.activate(ignoringOtherApps: true)
       
       if popover.isShown {
           /*if (self.sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet) {
               //popover.contentViewController?.view.window?.makeKey()
               //popover.contentViewController?.view.window?.makeKeyAndOrderFront(nil)
               
               //return
           } else {*/
               self.popover.performClose(nil)
               return
           /*}*/
       }
       
       guard let menuButton = statusItem.button else { return }
       
       popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
       popover.contentViewController?.view.window?.makeKey()
   }
}


/*extention AppDelegate {
    /** Call this from your SwiftUI button in ContentView() like:
         
        Button("Shutdown") {
             (NSApp.delegate as? AppDelegate)?.requestQuitApplication()
        }
    */
    func requestQuitApplication() {
        // Start the terminate flow; AppKit will call applicationShouldTerminate
        NSApp.terminate(nil)
    }
}
*/


// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••










































/*
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var realmManager = RealmManager() // View owns this object
    var sharedAppState = AppState()
    var context = RichTextContext()
    
    private var statusItem: NSStatusItem!
    private let popover = NSPopover()
    
    // Event monitors (keep if you later switch to applicationDefined behavior)
    private var globalMouseMonitor: Any?
    private var localKeyMonitor: Any?
    
    // A tiny helper window used when we must detach from the status item (fullscreen + autohide)
    private var detachedAnchorWindow: NSWindow?
    
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
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
        setupPopover()
        
        // Close popover when app resigns active, to avoid dangling UI when spaces change
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidResignActive), name: NSApplication.didResignActiveNotification, object: nil)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        tearDownMonitors()
        tearDownDetachedAnchorWindow()
        if let statusItem {
            NSStatusBar.system.removeStatusItem(statusItem)
        }
        popover.delegate = nil
        NotificationCenter.default.removeObserver(self)
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
    func popoverDidClose(_ notification: Notification) {
        //print("🔴 Popover did close")
        NSSound(named: "Morse")?.play()
        
        /// Example: Clean up temporary state, stop timers, etc.
        if let gm = globalMouseMonitor {
            NSEvent.removeMonitor(gm)
            globalMouseMonitor = nil
        }
        /*if let lm = localKeyMonitor {
         NSEvent.removeMonitor(lm)
         localKeyMonitor = nil
         }*/
        
        // Extra safety: clean up monitors and helper window regardless of how it closed
        tearDownMonitors()
        tearDownDetachedAnchorWindow()
    }
    
    /// Called *when the system asks whether to close the popover*
    /*func popoverShouldClose(_ popover: NSPopover) -> Bool {
        print("🟡 Should the popover close?")
        
        /// Example use case: Prevent closing if a form is mid-edit – Return false to keep the popover open
        /*let shouldClose = true // Change this logic as needed
         //return shouldClose
         */
        
        return (sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet != true)
    }*/
}
extension AppDelegate {
    
    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        guard let menuButton = statusItem.button else { return }
        
        if let image = NSImage(named: "Statusbar-Icon") {
            image.isTemplate = true // correct light/dark rendering
            menuButton.image = image
        }
        menuButton.toolTip = "Menubar Notes"
        menuButton.setAccessibilityLabel("Menubar Notes")
        
        // Register click action for left (and optionally right) click
        menuButton.target = self
        menuButton.action = #selector(menuButtonClicked(_:))
        menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
    
    private func setupPopover() {
        // Prefer transient: lets AppKit manage outside-click and ESC to close,
        // and usually coordinates better with the menu bar in fullscreen.
        popover.behavior = .transient
        popover.animates = true
        popover.contentSize = NSSize(width: 510, height: 710)
        popover.contentViewController = hostingViewController
        popover.delegate = self
    }
}

extension AppDelegate {
    
    // MARK: - Click handling
    @objc func menuButtonClicked(_ sender: AnyObject?) {
        // Toggle close if already shown
        if popover.isShown {
            /*if sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet != true {
             closePopover()
             }
             return
             */
            
            /*if (sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet != true) {
             popover.performClose(nil)
             return
             }*/
            popover.performClose(nil)
            return
        }
        
        // Make the app active so the popover can receive key events and
        // the menu bar is more likely to remain visible while shown.
        NSApplication.shared.activate(ignoringOtherApps: false)
        
        // Decide whether it is safe to anchor to the status item.
        if canAnchorToStatusItem(), let button = statusItem.button {
            showPopoverAnchored(to: button)
        } else {
            showPopoverDetachedFromStatusItem()
        }
    }
    
    
    // MARK: - Anchor decision
    private func canAnchorToStatusItem() -> Bool {
        // If the status item button has a window, the menu bar is currently realized
        // in this space and we can anchor safely. In fullscreen with autohide, this
        // can be nil or become nil as the bar hides.
        guard let button = statusItem.button, let window = button.window else {
            return false
        }
        // Additional guard: ensure window is visible and on a screen
        return window.isVisible && window.screen != nil
    }
    
    // MARK: - Show helpers
    private func showPopoverAnchored(to button: NSStatusBarButton) {
        // .minY shows below the menu bar; .maxY would try above
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        
        // Optional: an ESC local monitor if you later switch behavior; .transient already handles ESC.
        installLocalESCMonitorIfNeeded()
    }
    
    private func showPopoverDetachedFromStatusItem() {
        // Create a tiny, invisible borderless window near the top of the active screen
        // and anchor the popover to it so it doesn't jump when the menu bar hides.
        let screen = statusItem.button?.window?.screen ?? NSScreen.main
        guard let screen else { return }
        
        let visible = screen.visibleFrame
        let size = popover.contentSize
        
        // Position horizontally centered near the top of the visible area
        let x = visible.midX - size.width / 2
        // A few points below the top to avoid clipping under the hidden menu bar area
        let y = visible.maxY - 8
        
        // Create or reuse the helper window
        let anchorWindow: NSWindow
        if let existing = detachedAnchorWindow {
            anchorWindow = existing
            anchorWindow.setFrame(NSRect(x: x, y: y, width: 1, height: 1), display: false)
            anchorWindow.level = .statusBar
            anchorWindow.orderFrontRegardless()
        } else {
            anchorWindow = NSWindow(contentRect: NSRect(x: x, y: y, width: 1, height: 1),
                                    styleMask: [.borderless],
                                    backing: .buffered,
                                    defer: false,
                                    screen: screen)
            anchorWindow.isOpaque = false
            anchorWindow.backgroundColor = .clear
            anchorWindow.level = .statusBar
            anchorWindow.ignoresMouseEvents = true
            anchorWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            anchorWindow.orderFrontRegardless()
            
            let anchorView = NSView(frame: NSRect(x: 0, y: 0, width: 1, height: 1))
            anchorWindow.contentView = anchorView
            
            detachedAnchorWindow = anchorWindow
        }
        
        // Show popover relative to the helper view/rect
        if let anchorView = anchorWindow.contentView {
            popover.show(relativeTo: NSRect(x: 0, y: 0, width: size.width, height: 1),
                         of: anchorView,
                         preferredEdge: .minY)
        }
        
        // Ensure we clean up the helper window when the popover closes
        // (also handled in popoverDidClose)
        NotificationCenter.default.addObserver(self, selector: #selector(cleanupAfterPopoverCloseNotification(_:)), name: NSPopover.willCloseNotification, object: popover)
        
        installLocalESCMonitorIfNeeded()
    }
    
    // MARK: - Close helpers
    @MainActor
    private func closePopover() {
        popover.performClose(nil)
        tearDownMonitors()
        tearDownDetachedAnchorWindow()
    }
    
    private func tearDownDetachedAnchorWindow() {
        if let window = detachedAnchorWindow {
            window.orderOut(nil)
            detachedAnchorWindow = nil
        }
    }
    
    // MARK: - Monitors
    private func installLocalESCMonitorIfNeeded() {
        // With .transient this is not strictly necessary; keep it in case behavior changes.
        guard localKeyMonitor == nil else { return }
        localKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self else { return event }
            if event.keyCode == 53 { // ESC
                //self.closePopover()
                popover.performClose(nil)
                return nil
            }
            return event
        }
    }
    
    private func tearDownMonitors() {
        if let gm = globalMouseMonitor {
            NSEvent.removeMonitor(gm)
            globalMouseMonitor = nil
        }
        if let lm = localKeyMonitor {
            NSEvent.removeMonitor(lm)
            localKeyMonitor = nil
        }
    }
    
    @objc private func handleAppDidResignActive() {
        // Close popover when app loses focus; prevents “stuck” popover when spaces change.
        if popover.isShown {
            //closePopover()
            popover.performClose(nil)
        }
    }
    
    @objc private func cleanupAfterPopoverCloseNotification(_ notification: Notification) {
        // Ensure helper window is removed on all close paths
        tearDownDetachedAnchorWindow()
        NotificationCenter.default.removeObserver(self, name: NSPopover.willCloseNotification, object: popover)
    }
}
*/











































// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
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
*/
