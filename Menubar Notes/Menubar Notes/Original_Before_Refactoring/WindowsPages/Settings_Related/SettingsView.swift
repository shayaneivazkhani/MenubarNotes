//
//  SettingsView.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

struct GeneralSettingsView: View {
    
    private enum Tabs: Hashable {
        case general, advanced
    }
    
    var body: some View {
        TabView {
            SettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
        /*
            AboutApplicationView()
                .tabItem {
                    Label("Advanced", systemImage: "star")
                }
                .tag(Tabs.advanced)
        */
        }.padding(20)
         .frame(width: 400, height: 520)
    }
}


struct SettingsView: View {
        //@AppStorage("showPreview") private var showPreview = true
        //@AppStorage("fontSize") private var fontSize: Int = 10
        @AppStorage("TextView Font") private var fontAvenirIfTrueElseTimes = true
        
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            
            VStack (spacing: 5) {
                ZStack {
                    
                    Color.secondary.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    Color.secondary.opacity(0.7).clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(12)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(24)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(36)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(48)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(60)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(72)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(84)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(100)
                    
                    VStack (spacing: 12) {
                        
                        /*Toggle("Use Text Font Avenir Else  ...", isOn: $fontAvenirIfTrueElseTimes)
                            .font(.system(size: 10, weight: .ultraLight))
                            .foregroundColor(colorScheme == .dark ? Color.neuGrayDark : Color.neuGrayLight)
                         */
                    } // VStack (spacing: 12) {
                    
                }.frame(width: 305, height: 299)  // ZStack
                 .preferredColorScheme(.dark)  // MARK: – 💥 Force View to use light or dark mode
            }.frame(width: 305, height: 299) // VStack (spacing: 5) {
        }
}
