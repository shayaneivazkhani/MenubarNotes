//
//  View_Extensions.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-26.
//

import SwiftUI

// MARK: - TabViewModifier •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
/** Användsning:
 
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .clearTabViewBackground()
 */

 struct TabViewBackgroundModifierMakeClear: ViewModifier {
     func body(content: Content) -> some View {
         ZStack {
             Color(.blue)
                 .edgesIgnoringSafeArea(.all)
             content
         }
     }
 }

 extension View {
     func clearTabViewBackground() -> some View {
         modifier(TabViewBackgroundModifierMakeClear())
     }
 }
 
// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/**
 public struct P178_CustomViewModifier: View {
     
     public init() {}
     public var body: some View {
         Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
             .redText(font: .largeTitle)
     }
 }

 fileprivate
 struct RedTextModifier: ViewModifier {
     
     let font: Font
     
     func body(content: Content) -> some View {
         content
             .font(font)
             .padding()
             .foregroundColor(Color.red)
             .cornerRadius(6.0)
     }
 }

 fileprivate
 extension View {
     func redText(font: Font = .callout) -> some View {
         modifier(RedTextModifier(font: font))
     }
 }
 */

/** Användning: Ex.
                    Rectangel()
                        .hoverMod()
 */
/*
fileprivate
struct HoverModifier: ViewModifier {
    
    @State private var s: Bool = false
    
    @State private var i: Int = 0
    
    func body(content: Content) -> some View {
        content
            .onHover(perform: { d in
                s = true
            })
            .onContinuousHover(perform: { HoverPhase in
                i = 0
                for index in 1...50000 {
                    i = i + 1
                }
                s = false
            })
            //.padding()
            .background(s ? Color.red : Color.blue)

            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

fileprivate // 'hoverMod' is inaccessible due to 'fileprivate' protection level
extension View {
    func hoverMod() -> some View {
        modifier(HoverModifier())
    }
}
*/
// MARK: - för att kunna adda Conditional modifiers på Views (Text() och etc.) ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
/*

/*if you only want to apply a modifier if a condition is true,
 the View extension is a good method. For example, you only want
 to add a shadow to your Text if the value of shouldAddShadow is true.
 If it's false, you don't want to add any shadow.
 
 Let's start by creating the View extension. This extension lets us add the .if modifier to our Views and will only apply the modifiers we add if the condition is met. */

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
/*With this extension, we can add the .if modifier to our View!
 This is also better for your application's performance, because
 you can let users disable the shadows and all other CPU-expensive
 modifiers, like blur views, if they have an old device. */
struct ContentView: View {
    @State private var shouldAddShadow: Bool = true
    
    var body: some View {
        Text("Hello, world!")
            .if(shouldAddShadow) { view in
                view.shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
            }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
*/

// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/** För making gradient colored text
 Text("The simplicity of Apple.\nIn a credit card.")
     .multilineTextAlignment(.center)
     .foregroundLinearGradient(
         colors: [.red, .blue, .green, .yellow],
         startPoint: .leading,
         endPoint: .trailing
     )
 */
extension Text {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View {
            self.overlay {
                LinearGradient(
                    colors: colors,
                    startPoint: startPoint,
                    endPoint: endPoint
                ).mask(self)
            }
        }
}

// För How to remove SwiftUI TextField focus border
/*extension NSTextField {
     open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
     }
}
*/

// MARK: -  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*
import SwiftUI
 
struct View_Extensions: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    View_Extensions()
}
*/
