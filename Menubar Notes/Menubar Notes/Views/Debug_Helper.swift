//
//  Debug_Helper.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-26.
//

/*import Foundation
import SwiftUI
import AppKit

struct Debug_Helper: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    @State private var selection: Int = 0
    
    var body: some View {
        VStack (alignment: .leading) {
            if #available(macOS 15.0, *) {
                TabView(selection: $selection) {
                    Tab("Print() Debugging", systemImage: "1.square", value: 0) {
                        ScrollView(.vertical) {
                            Text(sharedAppState.debug_window_print_debugging)
                                //.selectionDisabled(false)
                                .textSelection(.enabled)
                                //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                .font(.custom("Avenir", size: 11))
                                .bold()
                                //.frame(width: 500, height: 500)
                                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                                //.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .leading)
                                .padding(2)
                                //.background(Color.gray.opacity(0.2))
                        }//.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                        /*Button(
                            action: {
                                sharedAppState.debug_window_print_debugging = ""
                            },
                            label: {
                                Text(" Clear Output")
                                    .font(.system(size: 14))
                                    //.foregroundColor(sharedAppState.darkMode ? Color.neuPurpLight: Color.neuOrangeLight)
                                    .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                    //.frame(width: 85, height: 18)
                                    .frame(width: 110, height: 18)
                            }
                        ).buttonStyle(miniRedBackButton())
                         */
                    }
                    Tab("Print() Debugging Sorted", systemImage: "1.square", value: 1) {
                        ScrollView(.vertical) {
                            Text(sharedAppState.debug_window_print_debuggingSORTED)
                                //.selectionDisabled(false)
                                .textSelection(.enabled)
                                //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                .font(.custom("Avenir", size: 11))
                                .bold()
                                //.frame(width: 500, height: 500)
                                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                                .padding(2)
                                //.background(Color.gray.opacity(0.2))
                        }//.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                    }
                    Tab("Attention", systemImage: "1.square", value: 2) {
                        ScrollView(.vertical) {
                            Text(sharedAppState.debug_window_attention)
                                //.selectionDisabled(false)
                                .textSelection(.enabled)
                                //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                .font(.custom("Courier", size: 11))
                                .bold()
                                //.frame(width: 500, height: 500)
                                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                                .padding(2)
                                //.background(Color.gray.opacity(0.2))
                        }//.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                    }
                    Tab("Attention SORTED", systemImage: "1.square", value: 3) {
                        ScrollView(.vertical) {
                            Text(sharedAppState.debug_window_attentionSORTED)
                                //.selectionDisabled(false)
                                .textSelection(.enabled)
                                //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                .font(.custom("Courier", size: 11))
                                .bold()
                                //.frame(width: 500, height: 500)
                                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                                .padding(2)
                                //.background(Color.gray.opacity(0.2))
                        }//.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                    }
                }
            } else {
                ScrollView(.vertical) {
                    Text(sharedAppState.debug_window_attention)
                        //.font(.system(size: 11, weight: .bold, design: .monospaced))
                        .font(.custom("Courier", size: 11))
                        .bold()
                        //.frame(width: 500, height: 500)
                        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                        .padding(2)
                        //.background(Color.gray.opacity(0.2))
                }//.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
            }
        }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}

final class WindowManager: ObservableObject {
    static let shared = WindowManager()
    
    // Keep track of debug window
    @Published var debugWindow: NSWindow?
    
    //private init() {}
    init() {}
    
    /// Opens (or brings front) the debug helper window
    func openDebugWindow(_ sharedAppState: AppState) {
        // If already visible, just bring to front
        if let window = debugWindow, window.isVisible {
            window.makeKeyAndOrderFront(nil)
            return
        }
        
        // Create new NSWindow
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1650, height: 500),
            styleMask: [.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "Debug Helper"
        window.isReleasedWhenClosed = false
        
        // Embed your SwiftUI view
        window.contentView = NSHostingView(
            rootView: Debug_Helper()
                .environmentObject(sharedAppState)
                .environmentObject(self)
        )
        
        window.hasShadow = true
        window.isMovableByWindowBackground = false
        //window.titlebarAppearsTransparent = true
        
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        // Keep reference
        debugWindow = window
        
        // Observe close to clear reference
        NotificationCenter.default.addObserver(
            forName: NSWindow.willCloseNotification,
            object: window,
            queue: .main
        ) { [weak self] _ in
            self?.debugWindow = nil
        }
    }
    
    /// Checks if the debug window is currently open and visible
    func isDebugWindowOpen() -> Bool {
        return debugWindow?.isVisible == true
    }
    
    /// Closes the debug window if it is open
    func closeDebugWindow() {
        debugWindow?.close()
        debugWindow = nil
    }
}
*/

// MARK: - Exempel  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*
extension View {
    
    /** ANVÄNDNING:
     
     struct ContentView: View {
         var body: some View {
             VStack {
                 printUI("ContentView", "1")
                 printUI("ContentView", "2", separator: ", ", terminator: "\n.\n.\n")
                 printUI("ContentView", "3", separator: "; ")

                 Text("Hello, World!")
             }
         }
     }
     */
    func printUI(_ args: Any..., separator: String = " ", terminator: String = "\n") -> EmptyView {
            let output = args.map(String.init(describing:)).joined(separator: separator)
            print(output, terminator: terminator)
            return EmptyView()
    }
 
    /** ANVÄNDNING:
     
     struct ContentView: View {
     var body: some View  {
         VStack() {
             Text("hello To SwiftUI")
             printv("its easy to code in SwiftUI")
         }
       }
     }
     */
    func printv( _ data : Any) -> EmptyView {
     print(data)
     return EmptyView()
    }
    
    
    /** ANVÄNDNING:
     
     struct ContentView: View {
         var body: some View {
             VStack {
                 ForEach((1...5), id: \.self) { number in
                     Text("\(number)")
                         .Print(number)
                 }
             }
         }
     }
     */
    func Print(_ item: Any) -> some View {
        #if DEBUG
        print(item)
        #endif
        return self
    }
}
*/
