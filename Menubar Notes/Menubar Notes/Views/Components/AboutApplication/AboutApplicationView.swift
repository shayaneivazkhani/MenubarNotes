//
//  AboutApplicationView.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//
import Foundation
import SwiftUI

struct AboutApplicationView: View {
    
    @EnvironmentObject var sharedAppState: AppState
    //@Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (spacing: 5) {
            
            ZStack {
                /*Color.secondary.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                Color.secondary.opacity(0.7).clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(12)
                Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(24)
                Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(36)
                Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(48)
                Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(60)
                Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(72)
                Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(84)
                */
                
                VStack (spacing: 12) {
                    ZStack {
                        Color.white
                        Image("AboutAppWindow3")
                            .resizable()
                            //.scaledToFit()
                            //.aspectRatio(2, contentMode: .fit)
                            //.cornerRadius(2.0)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(radius: 2)
                    }.frame(width: 70, height: 70)
                        .cornerRadius(16.5)
                    VStack (spacing: 5) {
                        Text("by  Shayan Eivaz Khani")
                            .font(.system(size: 12, weight: .thin))
                            .foregroundColor(sharedAppState.darkMode ? .white : .black)
                        Text("Version 5.1.3 Nr.49 – Built 2025-11-23 ")
                            //.font(.system(size: 10, weight: .regular))
                            .font(.system(size: 9, weight: .bold))
                            .monospaced()
                            //.foregroundColor(sharedAppState.darkMode ? .white : .black)
                        /*HStack {
                            Spacer()
                            /*Text("Version  \(sharedAppState.menubarNotesCurrent_Versions_Build_CATEGORY).\(sharedAppState.menubarNotesCurrent_Versions_Build_SUBCATEGORY).\(sharedAppState.menubarNotesCurrent_Versions_Build_PATCH)  Nr. \(sharedAppState.menubarNotesCurrent_AppStore_Versions_Build_NUMBER)  –  Built \(sharedAppState.menubarNotesCurrent_Versions_Build_YEAR)-\(sharedAppState.menubarNotesCurrent_Versions_Build_MONTH)-\(sharedAppState.menubarNotesCurrent_Versions_Build_DAY) ")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                                //.font(.system(size: 9, weight: .regular)).monospaced().kerning(CGFloat(0.5))
                             */
                            Text("Version  \(sharedAppState.menubarNotesCurrent_Versions_Build_CATEGORY).\(sharedAppState.menubarNotesCurrent_Versions_Build_SUBCATEGORY).\(sharedAppState.menubarNotesCurrent_Versions_Build_PATCH)  Nr. \(sharedAppState.menubarNotesCurrent_AppStore_Versions_Build_NUMBER) ")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Text(" –  Built \(sharedAppState.menubarNotesCurrent_Versions_Build_YEAR)-\(sharedAppState.menubarNotesCurrent_Versions_Build_MONTH)-\(sharedAppState.menubarNotesCurrent_Versions_Build_DAY) ")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Spacer()
                        }.frame(width: 205)
                        */
                    }
                    VStack (spacing: 10) {
                        HStack (spacing: 13) {
                            if #available(macOS 15.0, *) {
                                Link("↗︎Terms of Use", destination: URL(string: "https://shayaneivazkhani.com/apps/menubarnotes/terms-of-use")!)
                                    .font(.system(size: 10, weight: .bold))
                                    .pointerStyle(.link)
                                Link("↗︎Privacy Policy", destination: URL(string: "https://shayaneivazkhani.com/apps/menubarnotes/privacy-policy")!)
                                    .font(.system(size: 10, weight: .bold))
                                    .pointerStyle(.link)
                            } else {
                                Link("↗︎Terms of Use", destination: URL(string: "https://shayaneivazkhani.com/apps/menubarnotes/terms-of-use")!)
                                    .font(.system(size: 10, weight: .bold))
                                Link("↗︎Privacy Policy", destination: URL(string: "https://shayaneivazkhani.com/apps/menubarnotes/privacy-policy")!)
                                    .font(.system(size: 10, weight: .bold))
                            }
                        }
                        VStack (alignment: .center, spacing: 2) {
                            /*Text("Suggest ideas or report problems with the app?")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Text("☛ Email: shayanek.developer@proton.me")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            */
                            /*Text("I develope this app as a hobby beside my CS studies. ")
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Text("")
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Text("older version and new ones, and even though it has never happened, but if you experience ")
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Text("")
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            Text("email: shayanek.developer@proton.me ")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            */
                            //Text("I develope this app as a hobby beside my CS studies. I try to take into careful consideration every aspects of how this app functions for previous users with older version and new ones, and even though it has never happened, but if you experience severe problems with the app, reach out to me by email at shayanek.developer@proton.me")
                            Text("I develope this app as a hobby beside my CS studies. I try to take into careful consideration every aspects of how this app functions, if you experience problems/buggs with the app, reach out to me by email at shayanek.developer@proton.me")
                                .font(.system(size: 10, weight: .thin))
                                //.foregroundColor(sharedAppState.darkMode ? .white : .black)
                        }.frame(width: 305)
                    }
                    //Link("Experience problems or \nto suggest improvements", destination: URL(string: "https://shayaneivazkhani.com/apps/menubarnotes/problems-and-improvements")!).font(.system(size: 10, weight: .bold))
                }
                
            }.frame(width: 345, height: 279)  // ZStack
             //.preferredColorScheme(.dark)  // MARK: – 💥 Force View to use light or dark mode
      
        }.frame(width: 345, height: 279)//.frame(width: 1200, height: 600) // VStack (spacing: 5) {
    }
    
    
    /*func openAboutWindow() {
           // Get focus from other apps
           NSApplication.shared.activate(ignoringOtherApps: true)
           
           // Create the frame to draw window
           let exportWindow = NSWindow(
               contentRect: NSRect(x: 0, y: 0, width: 310, height: 300),
               styleMask: [.titled, .closable, .fullSizeContentView],
               backing: .buffered,
               defer: false
           )
           // Add title
           exportWindow.title = ""
           
           // Keeps window reference active, we need to use this when using NSHostingView
           exportWindow.isReleasedWhenClosed = false
           
           /* NSHostingView lets us use SwiftUI views with AppKit */
           exportWindow.contentView = NSHostingView(rootView: AboutApplicationView())
           
           // Center and bring forward
           exportWindow.center()
           exportWindow.makeKeyAndOrderFront(nil)
       }
     */
}
