//
//  AboutApplicationView_SheetView_Dismiss.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-01.
//

import SwiftUI

public struct AboutApplicationView_SheetView_Dismiss: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    @State private var showDetail: Bool = false
    
    public init() {}
    
    public var body: some View {
        Button {
            sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = true
            showDetail = true
        } label: {
            Text("About")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .shadow(radius: 0.6)
        }.buttonStyle(ClearImageBackground2())
         .sheet(isPresented: $showDetail) {
            if #available(macOS 12.0, *) {
                DetailView()
            } /*else {
                Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
            }*/
        }
        /*Button(
            action: {
                openAboutWindow()
            },
            label: {
                Text("About")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .shadow(radius: 0.6)
            }
        ).buttonStyle(ClearImageBackground2())
        */
    }
    
    
    /*func openAboutWindow() {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // Create the frame to draw window
        let aboutWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 305, height: 299),
            styleMask: [.titled, .closable, .fullSizeContentView],
            //styleMask: [.titled, .closable, .fullSizeContentView, .resizable, .hudWindow],
            backing: .buffered,
            defer: false
        )
        // Add title
        aboutWindow.title = ""
        
        // Keeps window reference active, we need to use this when using NSHostingView
        aboutWindow.isReleasedWhenClosed = false
        
        /* NSHostingView lets us use SwiftUI views with AppKit */
        aboutWindow.contentView = NSHostingView(rootView: AboutApplicationView())
        
        // Center and bring forward
        aboutWindow.center()
        aboutWindow.makeKeyAndOrderFront(nil)
    }*/
}

//@available(macOS 12.0, *)
//fileprivate
struct DetailView: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    //private var selectedMaterial: Material = .ultraThinMaterial

    var body: some View {
        ZStack {
            sharedAppState.darkMode ? Color.generalSheetBackgroundColorDarkMode : Color.generalSheetBackgroundColorLightMode
            
            VStack {
                AboutApplicationView()
                Spacer()
            }.frame(width: 345, height: 310)
            
            VStack {
                Spacer()
                    //.frame(width: 305, height: 299)
                    .frame(width: 345, height: 270)
                
                Button(
                    action: {
                        sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false
                        dismiss()
                    },
                    label: {
                        //Text("Dismiss")
                        Text("Close")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            .shadow(radius: 0.6)
                    }
                )
                Spacer()
            }.frame(width: 345, height: 310)
            
        }.frame(width: 345, height: 310)
        //.background(selectedMaterial)
    }
}

struct AboutApplicationView_SheetView_Dismiss_Previews: PreviewProvider {
    static var previews: some View {
        AboutApplicationView_SheetView_Dismiss()
    }
}


/* Another way to show sheeet
 
 public struct P111_Sheet: View {
     
     @State private var isShowSheet = false
     
     public init() {}
     public var body: some View {
         Button(action: {
             isShowSheet.toggle()
         }) {
             Text("Show Sheet")
         }
         .sheet(isPresented: $isShowSheet,
                onDismiss: didDismiss) {
             SheetDetailView(isShowSheet: $isShowSheet)
         }
     }
     
     func didDismiss() {
         // Handle the dismissing action.
     }
 }

 fileprivate
 struct SheetDetailView: View {
     
     @Binding var isShowSheet: Bool
     
     var body: some View {
         VStack {
             Text("Sheet Detail Screen")
                 .font(.title)
                 .padding(50)
             Button("Dismiss",
                    action: {
                 isShowSheet.toggle()
                 
             })
                 .padding()
         }
     }
 }

 struct P111_Sheet_Previews: PreviewProvider {
     static var previews: some View {
         P111_Sheet()
     }
 }
*/
