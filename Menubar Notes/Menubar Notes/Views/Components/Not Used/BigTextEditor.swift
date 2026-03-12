//
//  BigTextEditor.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-06-17.
//

import Foundation
import SwiftUI
import AppKit
import UniformTypeIdentifiers

/** användning:
 
 if sharedAppState.darkMode {
     DarkModeEditorControllerView(text: $TaskNameText)
         .onNSView(
             added: { nsview in
                 let root = nsview.subviews[0] as! NSScrollView
                 //root.hasVerticalScroller = false
                 root.hasVerticalScroller = true
                 root.hasHorizontalScroller = false
             }
         )
         .multilineTextAlignment(.leading)
         //.font(.custom("Avenir", size: 8))
         .frame(width: 395, height: 554)
         //.frame(width: 305, height: 432)
         .lineSpacing(2.8)
         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
         .cornerRadius(9)
         //.shadow(radius: 4)
         /*.shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
          .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)*/
         .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 2, x: 0, y: 0)
 } else {
     LightModeEditorControllerView(text: $TaskNameText)
         .onNSView(
             added: { nsview in
                 let root = nsview.subviews[0] as! NSScrollView
                 //root.hasVerticalScroller = false
                 root.hasVerticalScroller = true
                 root.hasHorizontalScroller = false
             }
         )
         .multilineTextAlignment(.leading)
         //.font(.custom("Avenir", size: 8))
         .frame(width: 395, height: 554)
         //.frame(width: 305, height: 432)
         .lineSpacing(2.8)
         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
         .cornerRadius(9)
         //.shadow(radius: 4)
         /*.shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
          .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)*/
         .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 2, x: 0, y: 0)
         .preferredColorScheme(sharedAppState.darkMode ? .dark : .light)
 }

 */
// ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️

// MARK: – För att Wrap NSTextView in SwiftUI – Hur man kan använda sig av en TextView i macOS
/**
     An RGB color value represents RED, GREEN, and BLUE light sources.
     An RGBA color value is an extension of RGB with an Alpha channel (opacity).
*/
//var cDarkMode: NSColor = NSColor.init(red: 206, green: 203, blue: 203, alpha: 1.00)
//var cLightMode: NSColor = NSColor.init(red: 0, green: 245, blue: 234, alpha: 0.75)
//var cTextDarkMode: NSColor = NSColor.init(red: 163, green: 161, blue: 161, alpha: 0.75)
//var cTextLightMode: NSColor = NSColor.init(red: 56, green: 52, blue: 52, alpha: 0.75)

/* 1. Create a ViewController that presents the NSTextView */
class EditorController: NSViewController {
    var textView = NSTextView()
    
    override func loadView() {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        
        textView.autoresizingMask = [.width]
        textView.allowsUndo = true
        
        textView.textColor = NSColor.darkGray
        textView.font = NSFont(name: "Avenir", size: 14.0)
        textView.backgroundColor = NSColor(red: 0.87059, green: 0.84706, blue: 0.84706, alpha: 1.0)
        
        scrollView.documentView = textView
        self.view = scrollView
    }
}

/* 2. Create a Representable */
struct EditorControllerView: NSViewControllerRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextStorageDelegate {
        private var parent: EditorControllerView
        var shouldUpdateText = true
        
        init(_ parent: EditorControllerView) {
            self.parent = parent
        }
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            guard shouldUpdateText else { return }
            
            // Ensure that updates are not recursive
            //self.parent.text = textStorage.string
            DispatchQueue.main.async {
                self.parent.text = textStorage.string
            }
        }
    }
    
    func makeNSViewController(context: Context) -> EditorController {
        let vc = EditorController()
        vc.textView.textStorage?.delegate = context.coordinator
        vc.textView.string = text
        return vc
    }
    
    func updateNSViewController(_ nsViewController: EditorController, context: Context) {
        if context.coordinator.shouldUpdateText && nsViewController.textView.string != text {
            context.coordinator.shouldUpdateText = false
            nsViewController.textView.string = text
            context.coordinator.shouldUpdateText = true
        }
    }
}

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

/* 1 a DARKMODE ViewController */
class DarkModeEditorController: NSViewController {
    var textView = NSTextView()
    
    override func loadView() {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasVerticalRuler = true
        scrollView.autohidesScrollers = true
        
        scrollView.appearance = NSAppearance(named: .darkAqua)  // Force dark scrollbars
        //scrollView.appearance = NSAppearance(named: .aqua)  // Force light scrollbars
        
        textView.autoresizingMask = [.width]
        //textView.allowsUndo = true
        textView.allowsUndo = false
        textView.usesFontPanel = false
        textView.isRichText = false // Enforce plain text
        textView.importsGraphics = false // Prevent images from being pasted

        //textView.textColor =  NSColor(red: 0.62745, green: 0.62745, blue: 0.62745, alpha: 1.0)
        textView.textColor =  NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80)
        textView.font = NSFont(name: "Avenir", size: 13.4)
        //textView.backgroundColor = NSColor(red: 0.60784, green: 0.59216, blue: 0.59216, alpha: 1.0)
        //textView.backgroundColor = NSColor(red: 0.25098, green: 0.25098, blue: 0.24314, alpha: 1.0)
        textView.backgroundColor = NSColor(red: 0.16863, green: 0.16863, blue: 0.16863, alpha: 1.0)
        
        scrollView.documentView = textView
        self.view = scrollView
    }
}

/* 2 a DARKMODE Representable */
struct DarkModeEditorControllerView: NSViewControllerRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextStorageDelegate {
        private var parent: DarkModeEditorControllerView
        var shouldUpdateText = true
        
        init(_ parent: DarkModeEditorControllerView) {
            self.parent = parent
        }
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            guard shouldUpdateText else { return }
            
            // Ensure that updates are not recursive
            //self.parent.text = textStorage.string
            DispatchQueue.main.async {
                self.parent.text = textStorage.string
            }
        }
    }
    
    func makeNSViewController(context: Context) -> DarkModeEditorController {
        let vc = DarkModeEditorController()
        vc.textView.textStorage?.delegate = context.coordinator
        vc.textView.string = text
        return vc
    }
    
    func updateNSViewController(_ nsViewController: DarkModeEditorController, context: Context) {
        if context.coordinator.shouldUpdateText && nsViewController.textView.string != text {
            context.coordinator.shouldUpdateText = false
            nsViewController.textView.string = text
            context.coordinator.shouldUpdateText = true
        }
    }
}


/* 1. a LIGHTMODE ViewController */
class LightModeEditorController: NSViewController {
    var textView = NSTextView()
    
    override func loadView() {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        
        textView.autoresizingMask = [.width]
        //textView.allowsUndo = true
        textView.allowsUndo = false
        textView.usesFontPanel = false
        textView.isRichText = false // Enforce plain text
        textView.importsGraphics = false // Prevent images from being pasted
        
        textView.textColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        textView.font = NSFont(name: "Avenir", size: 13.4)
        textView.backgroundColor = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        scrollView.documentView = textView
        self.view = scrollView
    }
    
    override func viewDidAppear() {
        //self.view.window?.makeFirstResponder(self.view) // vill inte att den ska focus på textViewen så fort den visas upp på en sida
    }
}

/* 2. a LIGHTMODE Representable */
struct LightModeEditorControllerView: NSViewControllerRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextStorageDelegate {
        private var parent: LightModeEditorControllerView
        var shouldUpdateText = true
        
        init(_ parent: LightModeEditorControllerView) {
            self.parent = parent
        }
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            guard shouldUpdateText else { return }
            
            // Ensure that updates are not recursive
            //self.parent.text = textStorage.string
            DispatchQueue.main.async {
                self.parent.text = textStorage.string
            }
        }
    }
    
    func makeNSViewController(context: Context) -> LightModeEditorController {
        let vc = LightModeEditorController()
        vc.textView.textStorage?.delegate = context.coordinator
        vc.textView.string = text
        return vc
    }
    
    func updateNSViewController(_ nsViewController: LightModeEditorController, context: Context) {
        if context.coordinator.shouldUpdateText && nsViewController.textView.string != text {
            context.coordinator.shouldUpdateText = false
            nsViewController.textView.string = text
            context.coordinator.shouldUpdateText = true
        }
    }
}

// MARK: – START ––> Hide scroller of NSScrollView (i.e. hide the scrollen för TextEditorn)
/**
 följande cod: This Swift code is a custom SwiftUI extension that allows you to access and interact with the underlying NSView (AppKit view) of a SwiftUI view when it's rendered in a macOS app.
 
 .onNSView { nsView in
     // do something with nsView
 }

 
 Användsning i ditt fall:
 
 LightModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
     .onNSView(
         added: { nsview in
             let root = nsview.subviews[0] as! NSScrollView
             root.hasVerticalScroller = true
             root.hasHorizontalScroller = false
        }
    )
 */
/*
extension View {
    func onNSView(added: @escaping (NSView) -> Void) -> some View {
        NSViewAccessor(onNSViewAdded: added) { self }
    }
}
struct NSViewAccessor<Content>: NSViewRepresentable where Content: View {
    var onNSView: (NSView) -> Void
    var viewBuilder: () -> Content
    
    init(onNSViewAdded: @escaping (NSView) -> Void, @ViewBuilder viewBuilder: @escaping () -> Content) {
        self.onNSView = onNSViewAdded
        self.viewBuilder = viewBuilder
    }
    
    func makeNSView(context: Context) -> NSViewAccessorHosting<Content> {
        return NSViewAccessorHosting(onNSView: onNSView, rootView: self.viewBuilder())
    }
    
    func updateNSView(_ nsView: NSViewAccessorHosting<Content>, context: Context) {
        nsView.rootView = self.viewBuilder()
    }
}
class NSViewAccessorHosting<Content>: NSHostingView<Content> where Content : View {
    var onNSView: ((NSView) -> Void)
    
    init(onNSView: @escaping (NSView) -> Void, rootView: Content) {
        self.onNSView = onNSView
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: NSView) {
        super.didAddSubview(subview)
        onNSView(subview)
    }
}
*/
// MARK: – END ––> Hide scroller of NSScrollView (i.e. hide the scrollen för TextEditorn)
