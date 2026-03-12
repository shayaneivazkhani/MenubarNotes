//
//  Preview_Window.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-08-12.
//

import SwiftUI
import AppKit

struct AttributedTextViewDark: NSViewRepresentable {
    
    @EnvironmentObject var sharedAppState: AppState
    var attributedString: NSAttributedString
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.drawsBackground = false
        textView.textContainerInset = NSSize(width: 10, height: 10)
        //textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textView.isRulerVisible = true
        textView.textColor = NSColor(hex: "FFFFFF", alpha: 1.0)
        textView.backgroundColor = NSColor(hex: "1E1F1E", alpha: 1.0)
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.textStorage?.setAttributedString(attributedString)
    }
}

struct AttributedTextViewLight: NSViewRepresentable {
    
    @EnvironmentObject var sharedAppState: AppState
    var attributedString: NSAttributedString
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.drawsBackground = false
        textView.textContainerInset = NSSize(width: 10, height: 10)
        textView.isRulerVisible = true
        //textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.textColor = NSColor(hex: "000000", alpha: 1.0)
        textView.backgroundColor = NSColor(hex: "FFFFFF", alpha: 1.0)
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.textStorage?.setAttributedString(attributedString)
    }
}



struct Preview_Window: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    /*var body: some View {
        return AttributedTextView(attributedString: sharedAppState.preview_textt)
            .frame(width: 300, height: 100)
            .padding()
    }*/
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .center) {
                ScrollView(.vertical) {
                    if ($sharedAppState.darkMode.wrappedValue) {
                        AttributedTextViewDark(attributedString: sharedAppState.preview_textt)
                            .padding()
                    } else {
                        AttributedTextViewLight(attributedString: sharedAppState.preview_textt)
                            .padding()
                    }
                }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                .background(sharedAppState.darkMode ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
           
            }
        }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
            .background(sharedAppState.darkMode ? Color.PopOverControllerDarkMode : Color.PopoverControllerLightMode)
        .preferredColorScheme(sharedAppState.darkMode ? .dark : .light)
    }
}

#Preview {
    Preview_Window()
}



final class PreviewNoteWindowManager: ObservableObject {
    static let shared = PreviewNoteWindowManager()
    
    // Keep track of debug window
    @Published var previeWindow: NSWindow?
    
    //private init() {}
    init() {}
    
    /// Opens (or brings front) the debug helper window
    func openPrevieWindow(_ sharedAppState: AppState) {
        // If already visible, just bring to front
        if let window = previeWindow, window.isVisible {
            window.makeKeyAndOrderFront(nil)
            return
        }
        
        // Create new NSWindow
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 700, height: 500),
            styleMask: [.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "Debug Helper"
        window.isReleasedWhenClosed = false
        
        // Embed your SwiftUI view
        window.contentView = NSHostingView(
            rootView: Preview_Window()
                .environmentObject(sharedAppState)
                .environmentObject(self)
        )
        
        window.hasShadow = true
        window.isMovableByWindowBackground = false
        window.titlebarAppearsTransparent = true
        
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        // Keep reference
        previeWindow = window
        
        // Observe close to clear reference
        NotificationCenter.default.addObserver(
            forName: NSWindow.willCloseNotification,
            object: window,
            queue: .main
        ) { [weak self] _ in
            self?.previeWindow = nil
        }
    }
    
    /// Checks if the debug window is currently open and visible
    func isPrevieWindowOpen() -> Bool {
        return previeWindow?.isVisible == true
    }
    
    /// Closes the debug window if it is open
    func closePrevieWindow() {
        previeWindow?.close()
        previeWindow = nil
    }
}
