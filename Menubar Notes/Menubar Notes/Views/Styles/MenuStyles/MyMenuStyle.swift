//
//  MyMenuStyle.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

struct MyMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("myBackColor"))
            ).menuStyle(BorderlessButtonMenuStyle())
    }
}

struct MyMenuStyle2: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("myBackColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            ).menuStyle(BorderlessButtonMenuStyle())
    }
}

struct MyMenuStyle3: MenuStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        
        Menu(configuration)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    //.fill(colorScheme == .light ? Color.neuCream: Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                    .fill(Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    //.shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: 0.7, x: 1, y: 0.7)
                    //.shadow(color: colorScheme == .dark ? Color.neuPurp.opacity(0.6) : Color.neuOrangeLighter2.opacity(0.7), radius: 0.9, x: -1.0, y: -0.8)
                //.overlay(Color.blue.opacity(0.8), ignoresSafeAreaEdges: .bottom)
                //.foregroundColor(colorScheme == .dark ? Color.neuGray : Color.neuGray)
            ).menuStyle(BorderlessButtonMenuStyle())
    }
}
