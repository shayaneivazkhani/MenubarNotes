//
//  Text_OR_Markdown.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-16.
//

import SwiftUI

struct Text_OR_Markdown: View {
    
    @State private var boolDummy = false
    @Binding var txtifTrueElseMarkDownPreviewStyle: Bool
    
    init(_ textORMarkdown: Binding<Bool>) {
        self._txtifTrueElseMarkDownPreviewStyle = textORMarkdown
    }
    
    var body: some View {
        
        HStack (spacing: 3) {
            Text(".txt")
                .font(.system(.footnote, design: .monospaced))
                .opacity($txtifTrueElseMarkDownPreviewStyle.wrappedValue ? 1 : 0.5)
            Toggle("", isOn: $txtifTrueElseMarkDownPreviewStyle)
                .toggleStyle(CustomToggle())
                .labelsHidden()
                .tint(.green)
            Text(".md ")
                .font(.system(.footnote, design: .monospaced))
                .opacity($txtifTrueElseMarkDownPreviewStyle.wrappedValue ? 0.5 : 1)
        }.frame(width: 103)
    }
}

struct CustomToggle: ToggleStyle {
    
    @Environment(\.colorScheme) var colorScheme
    let width: CGFloat = 45
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack (spacing: 0) {
            configuration.label
            
            ZStack(alignment: configuration.isOn ? .leading : .trailing) {
                Capsule()
                    .frame(width: width, height: width / 2)
                    //.foregroundColor(configuration.isOn ? Color.ImageisDoneColorDarkMode : Color.ImageisDoneColorLightMode)
                    .foregroundColor(colorScheme == .dark ? Color.txtORMarkDownColorDarkMode : Color.txtORMarkDownColorLightMode)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }.shadow(radius: 0.8)
                
                Capsule()
                    .frame(width: (width / 2) - 4, height: width / 2 - 4)
                    .padding(2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.25)) {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
            }
        }
    }
}
