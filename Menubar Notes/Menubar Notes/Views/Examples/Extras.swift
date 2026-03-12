//
//  Extras.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-01.
//



/*
 struct Priority_NotesApp: App {
     var sharedModelContainer: ModelContainer = {
         let schema = Schema([
             Item.self,
         ])
         let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

         do {
             return try ModelContainer(for: schema, configurations: [modelConfiguration])
         } catch {
             fatalError("Could not create ModelContainer: \(error)")
         }
     }()

     var body: some Scene {
         WindowGroup {
             ContentView()
         }
         .modelContainer(sharedModelContainer)
     }
 }
*/


/**
 struct ContentView: View {
     
     @State var unreadNotifications: Int = 0
     // 1
     var badgeValue: String? {
         if unreadNotifications > 99 {
             return "99+"
         } else if unreadNotifications == 0 {
             return nil

         } else {
             return unreadNotifications.description
         }
     }
     
     var body: some View {
         TabView {
             Group {
                 Text("Home")
                     .tabItem {
                         Label("Home", systemImage: "house")
                     }
                 Text("Search")
                     .tabItem {
                         Label("Search", systemImage: "magnifyingglass")
                     }
                 Text("Notification")
                     .tabItem {
                         Label("Notification", systemImage: "bell")
                     }
                     // 2
                     .badge(badgeValue)
                 Text("Settings")
                     .tabItem {
                         Label("Settings", systemImage: "gearshape")
                     }
             }
         }
     }
 }
 */

/*
 @Environment(\.appearsActive) private var appearsActive
 var body: some View {
     VStack {
         Image("balloon-300")
             .resizable()
             .scaledToFit()
             .frame(width: 300)
             .saturation(appearsActive ? 1.0 : 0.3)

         Text("Appears Active: \(appearsActive)")
     }
 }
 */



/*
 #if canImport(UIKit)
 import UIKit
 #endif

 #if canImport(AppKit) && !targetEnvironment(macCatalyst)
 import AppKit
 #endif
 
*/

/*
 #if iOS || macOS || os(tvOS) || os(visionOS)
 private extension RichTextViewComponent {

     func getAttachmentString(
         for image: ImageRepresentable
     ) -> NSMutableAttributedString? {
         guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
         guard let compressed = ImageRepresentable(data: data) else { return nil }
         let attachment = RichTextImageAttachment(jpegData: data)
         attachment.bounds = attachmentBounds(for: compressed)
         return NSMutableAttributedString(attachment: attachment)
     }
 }
 #endif
*/

/*
 #if canImport(UIKit)
 import UIKit
 #elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
 import AppKit
 #endif
 */

/*
 #if macOS
let range = NSRange(location: selectedRange.location - 1, length: 1)
let safeRange = safeRange(for: range)
return richTextAttributes(at: safeRange)
#else
return typingAttributes
#endif
*/


/*
struct FocusedNoteValue: FocusedValueKey {
     typealias Value = NSAttributedString
}
extension FocusedValues {
    var noteValue: FocusedNoteValue.Value? {
        get { self[FocusedNoteValue.self] }
        set { self[FocusedNoteValue.self] = newValue }
    }
}

struct NotePreview: View {
    @FocusedValue(\.noteValue) var note
    var body: some View {
        //Text(effewfew ?? "Note is not focused")
    }
}
*/

/*
    #if os(macOS)
        @State private var shapeIndex: Int = 0
    #else
    public struct P255_DoubleClick: View {
        public init() {}
        public var body: some View {
            EmptyView()
        }
    }
    #endif
*/
    
/*
 /*if #available(macOS 12.0, *) {
     ToastView(toastData: toastData)
         .background(toastData.backgroundColor.opacity(0.3))
         .background(.ultraThinMaterial)
         .cornerRadius(8)
 } else {
     ToastView(toastData: toastData)
         .background(toastData.backgroundColor.opacity(0.8))
         .cornerRadius(8)
 }*/
 #if os(macOS)
             if #available(macOS 12.0, *) {
                 Button("BorderedProminentButtonStyle", action: action)
                     .buttonStyle(BorderedProminentButtonStyle())
             }
             Button("LinkButtonStyle", action: action)
                 .buttonStyle(LinkButtonStyle())
 #else
             Button("BorderedProminentButtonStyle", action: action)
                 .buttonStyle(BorderedProminentButtonStyle())
 #endif
*/
/*
 if #available(macOS 12.0, *) {
                     Button("destructive", role: .destructive) {
                         text = "destructive"
                     }
                     .buttonStyle(.borderedProminent)
                     .tint(Color.purple)
                     
                     Button("cancel", role: .cancel) {
                         text = "cancel"
                     }
                     .buttonStyle(.borderedProminent)
                     .tint(Color.random)
                 } else {
                     Text("@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)")
                 }

*/

/*

 import SwiftUI

 public struct P100_Dismiss: View {
     
     @State private var showDetail: Bool = false
     
     public init() {}
     public var body: some View {
         Button {
             showDetail = true
         } label: {
             Text("Show Detail")
         }
         .sheet(isPresented: $showDetail) {
             if #available(macOS 12.0, *) {
                 DetailView()
             } else {
                 Text("Availability\niOS 15.0+\niPadOS 15.0+\nmacOS 12.0+\nMac Catalyst 15.0+\ntvOS 15.0+\nwatchOS 8.0+")
             }
         }
     }
 }

 @available(macOS 12.0, *)
 fileprivate
 struct DetailView: View {
     
     @Environment(\.dismiss) var dismiss: DismissAction
     
     var body: some View {
         NavigationView {
             Button("Dismiss") {
                 dismiss()
             }
         }
 #if os(macOS)
         .frame(width: 300, height: 400)
 #endif
     }
 }

 struct P100_Dismiss_Previews: PreviewProvider {
     static var previews: some View {
         P100_Dismiss()
     }
 }

*/
