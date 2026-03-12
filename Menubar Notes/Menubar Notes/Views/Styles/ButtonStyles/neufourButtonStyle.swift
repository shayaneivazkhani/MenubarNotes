//
//  neufourButtonStyle.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-17.
//

import SwiftUI

struct neufourButtonStyle: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    /*let rainbow: [Color] = [
        Color.red,
        Color.orange,
        Color.yellow,
        Color.green,
        Color.blue,
        Color.purple
    ]*/
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .padding()
            
            .background(

                /*RadialGradient(
                    gradient: Gradient(colors: rainbow),  // Use a Gradient with `colors`
                    center: .bottom,                      // Radial gradient center
                    startRadius: 0,                       // Start radius
                    endRadius: 150                        // End radius
                )*/
                
                
                /*(sharedAppState.darkMode) ?
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.fourButtonGRADIENTBackgroundDarkModeLEFT,
                            Color.fourButtonGRADIENTBackgroundDarkModeRIGHT
                        ]),  // Use a Gradient with `colors`
                        center: .leading,                     // Radial gradient center
                        startRadius: 257,                    // Start radius
                        endRadius: 0                        // End radius
                    )
                : RadialGradient(
                    gradient: Gradient(colors: [
                        Color.fourButtonGRADIENTBackgroundLightModeUP,
                        Color.fourButtonGRADIENTBackgroundLightModeMIDDLE,
                        Color.fourButtonGRADIENTBackgroundLightModeDOWN
                    ]),  // Use a Gradient with `colors`
                    center: .bottom,                      // Radial gradient center
                    startRadius: 277,                    // Start radius
                    endRadius: 0                        // End radius
                )*/
                    
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .trailing : .bottom), endPoint: (sharedAppState.darkMode ? .leading : .center))
                 */
                
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .trailing : .bottom), endPoint: (sharedAppState.darkMode ? .leading : .top))
                 */
                
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .leading : .bottom), endPoint: (sharedAppState.darkMode ? .trailing : .center))
                
                
                //sharedAppState.darkMode ? Color.neuCream: Color.fourButtonGRADIENTBackgroundLightModeLEFT
                
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                ]), startPoint: .leading, endPoint: .trailing)*/
                
                /*LinearGradient(gradient: Gradient(colors: [
                     (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundLightModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                     (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundLightModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                 ]), startPoint: .leading, endPoint: .trailing)
                 */
                
                /*LinearGradient(gradient: Gradient(colors: [
                           (sharedAppState.darkMode ? Color.neuCream: Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                           (sharedAppState.darkMode ? Color.neuCream: Color.fourButtonGRADIENTBackgroundLightModeRIGHT)
                 ]), startPoint: .leading, endPoint: .trailing)
                 */
                
                /*LinearGradient(gradient: Gradient(colors: [
                            (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT: Color.RedBackButtonBackgroundLightMode),
                            (sharedAppState.darkMode ? Color.gray: Color.RedBackButtonBackgroundLightMode)
                 ]), startPoint: .leading, endPoint: .trailing)
                 */
                
               /*LinearGradient(gradient: Gradient(colors: [
                            (sharedAppState.darkMode ? Color.neuGrayDark4: Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                            (sharedAppState.darkMode ? Color.neuGrayDark5: Color.fourButtonGRADIENTBackgroundLightModeRIGHT)
                ]), startPoint: .leading, endPoint: .trailing)
                */
            )
            //.background(sharedAppState.darkMode ? Color.fourButtonBackgroundDarkMode: Color.fourButtonBackgroundLightMode)
        
            //.clipShape(Circle())
            //.clipShape(RoundedRectangle(cornerSize: CGSize(width: 20.57, height: 21.70), style: .continuous)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 60.00, height: 25.00), style: .continuous))
        
            //MARK: - 🌈 den färgen knappen får när its being pressed är färgen på dens shadow
            //.shadow(color: sharedAppState.darkMode ? Color.GreenAdd : Color.neuOrange, radius: 1.9, x: 1, y: 0.8)
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLighter2.opacity(0.5), radius: 1, x: -1.2, y: -1)

            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(0.85) : Color.neuOrangeLighter2.opacity(0.4), radius: 1, x: (sharedAppState.darkMode ? -0.9 : -1.2), y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.GreenAdd.opacity(0.8) : Color.neuOrange, radius: (sharedAppState.darkMode ? 1.0 : 1.8), x: (sharedAppState.darkMode ? 1.05 : 1), y: 0.3)
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrange, radius: 2.2, x: 1, y: 0.8)
            //.shadow(radius: 2)
        
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeIn(duration: 0.05), value: configuration.isPressed)
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}

struct neufourButtonStyle2: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .padding(10)
            
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .leading : .bottom), endPoint: (sharedAppState.darkMode ? .trailing : .center))
                
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                ]), startPoint: .leading, endPoint: .trailing)*/
            )
            //.background(sharedAppState.darkMode ? Color.fourButtonBackgroundDarkMode: Color.fourButtonBackgroundLightMode)
        
            //.clipShape(Circle())
            //.clipShape(RoundedRectangle(cornerSize: CGSize(width: 20.57, height: 21.70), style: .continuous)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50.00, height: 25.00), style: .continuous))
        
            //MARK: - 🌈 den färgen knappen får när its being pressed är färgen på dens shadow
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLighter2.opacity(0.5), radius: 1, x: -1.2, y: -1)
            //.shadow(color: sharedAppState.darkMode ? Color.GreenAdd : Color.neuOrange, radius: 1.9, x: 1, y: 0.8)
            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(0.85) : Color.neuOrangeLighter2.opacity(0.4), radius: 1, x: (sharedAppState.darkMode ? -0.9 : -1.2), y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.GreenAdd.opacity(0.8) : Color.neuOrange, radius: (sharedAppState.darkMode ? 1.0 : 1.8), x: (sharedAppState.darkMode ? 1.25 : 1), y: 0.8)
            //.shadow(radius: 2)
        
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeIn(duration: 0.05), value: configuration.isPressed)
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}

struct neufourButtonStyle3: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .padding(10)
            
            .background(
                /*(sharedAppState.darkMode) ?
                    RadialGradient(
                        gradient: Gradient(colors: [
                            (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                            (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                        ]),  // Use a Gradient with `colors`
                        center: .leading,                      // Radial gradient center
                        startRadius: 257,                       // Start radius
                        endRadius: 0                        // End radius
                    )
                : RadialGradient(
                    gradient: Gradient(colors: [
                        (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                        (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                    ]),  // Use a Gradient with `colors`
                    center: .bottom,                      // Radial gradient center
                    startRadius: 257,                       // Start radius
                    endRadius: 0                        // End radius
                )*/
                
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .trailing : .bottom), endPoint: (sharedAppState.darkMode ? .leading : .top))
                 */
                
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .leading : .bottom), endPoint: (sharedAppState.darkMode ? .trailing : .center))
                
                
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                ]), startPoint: .leading, endPoint: .trailing)*/
            )
            //.background(sharedAppState.darkMode ? Color.fourButtonBackgroundDarkMode: Color.fourButtonBackgroundLightMode)
        
            //.clipShape(Circle())
            //.clipShape(RoundedRectangle(cornerSize: CGSize(width: 20.57, height: 21.70), style: .continuous)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50.00, height: 25.00), style: .continuous))
        
            //MARK: - 🌈 den färgen knappen får när its being pressed är färgen på dens shadow
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLighter2.opacity(0.5), radius: 1, x: -1.2, y: -1)
            //.shadow(color: sharedAppState.darkMode ? Color.GreenAdd : Color.neuOrange, radius: 1.9, x: 1, y: 0.8)
            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(0.85) : Color.neuOrangeLighter2.opacity(0.4), radius: 1, x: (sharedAppState.darkMode ? -0.9 : -1.2), y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.GreenAdd.opacity(0.8) : Color.neuOrange, radius: (sharedAppState.darkMode ? 1.0 : 1.8), x: (sharedAppState.darkMode ? 1.25 : 1), y: 0.8)
            //.shadow(radius: 2)
        
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeIn(duration: 0.05), value: configuration.isPressed)
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}

struct neufourButtonStyle4: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .padding(13)
            
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeDOWN),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeUP)
                ]), startPoint: (sharedAppState.darkMode ? .leading : .bottom), endPoint: (sharedAppState.darkMode ? .trailing : .center))
                
                /*LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                ]), startPoint: .leading, endPoint: .trailing)
                */
            )
            //.background(sharedAppState.darkMode ? Color.fourButtonBackgroundDarkMode: Color.fourButtonBackgroundLightMode)
        
            //.clipShape(Circle())
            //.clipShape(RoundedRectangle(cornerSize: CGSize(width: 20.57, height: 21.70), style: .continuous)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50.00, height: 25.00), style: .continuous))
        
            //MARK: - 🌈 den färgen knappen får när its being pressed är färgen på dens shadow
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLighter2.opacity(0.5), radius: 1, x: -1.2, y: -1)
            //.shadow(color: sharedAppState.darkMode ? Color.GreenAdd : Color.neuOrange, radius: 1.9, x: 1, y: 0.8)
            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(0.85) : Color.neuOrangeLighter2.opacity(0.4), radius: 1, x: (sharedAppState.darkMode ? -0.9 : -1.2), y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.GreenAdd.opacity(0.8) : Color.neuOrange, radius: (sharedAppState.darkMode ? 1.0 : 1.8), x: (sharedAppState.darkMode ? 1.25 : 1), y: 0.8)
            //.shadow(radius: 2)
        
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeIn(duration: 0.05), value: configuration.isPressed)
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}
