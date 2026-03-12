//
//  DarkModeToggle.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-16.
//

import SwiftUI

struct DarkModeToggle: ToggleStyle {
    
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button(
                action: {
                    configuration.isOn.toggle()
                },
                label: {
                    Image(systemName: configuration.isOn ? "moon.stars.fill" : "sun.min.fill")
                    //.renderingMode(.template)
                        .foregroundColor(configuration.isOn ? .neuPurpLight : .yellow)
                        .font(.system(size: 20))
                }
            ).buttonStyle(ClearImageBackground())
        }.padding(3)
    }
}



struct DarkModeToggle2: ToggleStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            //Divider()
                //.background(colorScheme == .dark ? Color.green : Color.black)
                //.background(colorScheme == .dark ? Color.PaintbrushMarkDown : Color.gray)
                //.rotationEffect(.degrees(90))
                //.padding(.vertical, 1) // Optional: Add vertical padding for spacing
                //.offset(CGSize(width: 0, height: 80))
            Rectangle()
                .fill(sharedAppState.darkMode ? Color.PaintbrushMarkDown : Color.gray)
                .frame(width: 2.1, height: configuration.isOn ? 100 : 109)
                //.frame(width: 2, height: 200) // Set the width and height of the line
            
            HStack {
                Button(
                    action: {
                        //configuration.isOn.toggle() – trodde felet va här hihi men this is not fel
                        
                        withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.55, blendDuration: 0.25)) {
                            configuration.isOn.toggle()
                            //sharedAppState.dummy_darkMode.toggle()  – configuration.isOn.toggle() trodde felet därför addade den plus denna linen för dummy hihi 
                        }
                        
                        /**  Basic Animations:
                                 easeInOut: Animates with a combination of ease-in and ease-out timing.
                                 easeIn: Animates with ease-in timing.
                                 easeOut: Animates with ease-out timing.
                                 linear: Animates with a constant speed.
                         */
                        /*withAnimation(.easeInOut(duration: 0.5)) { // Change to different animation
                            configuration.isOn.toggle()
                        }*/
                        
                        /**  Spring Animations:
                                 spring(response:dampingFraction:blendDuration:): Creates a spring animation with configurable response, damping, and blend duration.
                                 interpolatingSpring(stiffness:damping:): Creates a spring animation with configurable stiffness and damping.
                         */
                        /* withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                                 configuration.isOn.toggle()
                                                 }*/
                        
                        /**  Custom Timing Curves:
                                 timingCurve(_:_:_:_:): Creates a custom cubic Bézier timing curve animation.
                                 interactiveSpring(response:dampingFraction:blendDuration:): Creates an interactive spring animation with configurable response, damping, and blend duration.
                         */
                        /*withAnimation(.timingCurve(0.2, 0.8, 0.2, 1.0, duration: 0.6)) {
                                                 configuration.isOn.toggle()
                                                 } */
                    },
                    label: {
                        //Image(systemName: configuration.isOn ? "moon.stars.fill" : "sun.min.fill")
                        //Image(systemName: configuration.isOn ? "lightbulb" : "lightbulb.max.fill")
                        //Image(systemName: configuration.isOn ? "lightbulb.slash" : "lightbulb.max.fill")
                        //Image(systemName: configuration.isOn ? "lightbulb.slash" : "lightbulb.fill")
                        Image(systemName: configuration.isOn ? "lightbulb" : "lightbulb.max.fill")
                            .renderingMode(.template)
                            //.renderingMode(.template) //MARK: – 🩸 hur väljer en "tema" av SF Symbol Image
                            //.renderingMode(.original)
                            //.renderingMode(.original)
                            //.foregroundColor(configuration.isOn ? .gray : .dotLightMode)
                            //.foregroundColor(configuration.isOn ? .gray : Color.neuOrangePriority2)
                            .foregroundColor(configuration.isOn ? .gray : Color.dotLightMode)
                            //.font(.system(size: configuration.isOn  ? 26 : 28))
                            .font(.system(size: configuration.isOn  ? 28 : 30))
                            .rotationEffect(.degrees(180)) // Rotate the image 180 degrees
                            .help(Text("Dark/Light mode"))
                            /*Image(systemName: configuration.isOn ? "lightbulb.slash" : "lightbulb.fill")
                                                 .font(.system(size: 16))
                                                 .foregroundColor(colorScheme == .dark ? Color.dotDarkMode : Color.dotLightMode)
                             */
                        
                            /*Text(configuration.isOn ? "Dark" : "Ligth")
                                                 .font(.system(size: 11, weight: .bold, design: .monospaced))
                             */
                    }
                ).buttonStyle(ClearImageBackground())
            }.shadow(radius: 0.5)
             .offset(CGSize(width: 0, height: -8))
        }//.offset(CGSize(width: 0, height: ))
         //.offset(y: configuration.isOn ? -235 : -220) // Apply vertical offset
         //.offset(y: configuration.isOn ? -275 : -260)
         //.offset(y: configuration.isOn ? -315 : -310)
         .offset(y: configuration.isOn ? -310 : -295)
    }
}
