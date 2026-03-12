
//  Toggles.swift
//  Created by Shayan Eivaz Khani on 2022-10-28.

import SwiftUI

struct AutoLaunchToggle: ToggleStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button(
                action: {
                    //configuration.isOn.toggle()
                    
                    withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.55, blendDuration: 0.25)) {
                        configuration.isOn.toggle()
                        //sharedAppState.dummy_darkMode.toggle()  – configuration.isOn.toggle() trodde felet därför addade den plus denna linen för dummy hihi
                    }
                },
                label: {
                    HStack (spacing: 0) {
                        Image(systemName: configuration.isOn ? "bolt.badge.a.fill" : "bolt.slash.fill")
                            //.renderingMode(.template)
                            .foregroundColor(configuration.isOn ? .green : .gray)
                            .font(.system(size: 26))
                    }
                    //Text(configuration.isOn ? "" : "\nAutolaunch")
                    Text(configuration.isOn ? "Autolaunch Enabled" : "Launch at Login")
                        .font(.custom("Avenir", size: 13))
                        //.font(.system(size: 9, weight: .light, design: .monospaced))
                        //.foregroundColor(sharedAppState.darkMode ? Color.AutolaunchDarkMode : Color.AutoLaunchLightMode)
                        .frame(alignment: .bottom)
                        //.font(Font.system(size: 10, design: .serif))
                }
            ).buttonStyle(ClearImageBackground())
        }.frame(height: 70)
         .padding(1)
    }
}


struct iPhoneToggleStyle: ToggleStyle {
    
    let width: CGFloat = 50
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .frame(width: width, height: width / 2)
                    .foregroundColor(configuration.isOn ? .green : .red)
                
                Capsule()
                    .frame(width: (width / 2) - 4, height: width / 2 - 6)
                    .padding(4)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
            }
        }
    }
}



struct TrashToggle: ToggleStyle {
    
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button(
                action: {
                    configuration.isOn.toggle()
                },
                label: {
                    Image(systemName: configuration.isOn ? "trash" : "trash.slash")
                    //.renderingMode(.template)
                        .foregroundColor(configuration.isOn ? .neuRed : .gray)
                        .font(.system(size: 15))
                }
            ).buttonStyle(ClearImageBackground())
        }.padding(3)
    }
}
