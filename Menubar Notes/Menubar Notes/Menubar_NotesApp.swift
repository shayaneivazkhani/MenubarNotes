//
//  Menubar_NotesApp.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2022-10-28.
//

import SwiftUI

@main
struct Menubar_NotesApp: App {
    
    /* A property wrapper that is used in App to provide a delegate from AppKit. */
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    /**init() {
        /**
             NSSound. Name ("Basso" )
             NSSound. Name ("Blow")
             NSSound. Name ("Bottle")
             NSSound. Name ("Frog")
             NSSound. Name ("Funk")
             NSSound. Name ("Glass")
             NSSound. Name ("Hero")
             NSSound. Name ("Morse")
             NSSound. Name ("Ping")
             NSSound. Name ("Pop")
             NSSound. Name ("Purr")
             NSSound. Name ("Sosumi")
             NSSound. Name ("Submarine")
             NSSound. Name ("Tink")
         */
        //DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(60)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            NSSound(named: "Pop")?.play()
        }
    }*/
    
    var body: some Scene {
        
        Settings {
            //EmptyView()
            Text("Settings") // "Text("Settings or main app window")" - för att skippa att appen öppnar ett onödig window när den startar
            // adda en if first time opening app then öppna en window som visar hur appen funkar else Text("Settings")
        }
        
        /*UtilityWindow("Utility Window", id: "utility-window") {
            EmptyView()
        }*/
        
        /*WindowGroup {
         Search_Engines().frame(width: 320, height: 500).background(TransparentWindow())
        }.windowStyle(.hiddenTitleBar)*/
         
        
        /*MenuBarExtra("Menu", image: "Statusbar-Icon") {
            ContentView()
                .frame(width: 320, height: 500)
        }.menuBarExtraStyle(.window)*/
    }
}



//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


/*
 struct VisualEffect: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
 }
 .background(VisualEffect())
 */

/*
 
 import SwiftUI
  
 struct VisualEffect: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
 }
  
 @main
 struct VisualEffectApp: App {
   var body: some Scene {
     WindowGroup {
       ContentView()
         .background(VisualEffect().ignoresSafeArea())
     }
     .windowStyle(.hiddenTitleBar)
   }
 }

*/

/**
 // Visual effect est la pour rendre le fond effet transparent
 struct VisualEffect: NSViewRepresentable {
  
   func makeNSView(context: Self.Context) -> NSView {
       let test = NSVisualEffectView()
       test.state = NSVisualEffectView.State.active  // this is this state which says transparent all of the time
       return test
   }
  
   func updateNSView(_ nsView: NSView, context: Context) { }
 }
  
 
 Doesn't seem to work correctly anymore in Xcode 14. When adding .background(VisualEffect().ignoresSafeArea() under ContentView and then .windowStyle(.hiddenTitleBar) to the window group, it still shows a small white title bar ( without text ) that doesn't blur. Are you guys also experiencing this issue?
 Okay I managed to finally do it, I used .isOpaque = false, .hasShadow = false and .toolbar = NSToolbar(). The combo of everything made it work.

 */

/**
/*struct VisualEffect: NSViewRepresentable {
  func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
  func updateNSView(_ nsView: NSView, context: Context) { }
}*/

/*
// Visual effect est la pour rendre le fond effet transparent
struct VisualEffect: NSViewRepresentable {
 
    func makeNSView(context: Self.Context) -> NSView {
        let test = NSVisualEffectView()
        test.state = NSVisualEffectView.State.active  // this is this state which says transparent all of the time
        return test
    }
    func updateNSView(_ nsView: NSView, context: Context) { }
}*/

class TransparentWindowView: NSView {
    override func viewDidMoveToWindow() {
        window?.backgroundColor = .clear
        super.viewDidMoveToWindow()
    }
}
 
struct TransparentWindow: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return TransparentWindowView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
}

@main
struct metaTimerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                //.background(VisualEffect().ignoresSafeArea())
                .background(TransparentWindow())
        }
            .windowStyle(.hiddenTitleBar)
    }
}
*/

//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

