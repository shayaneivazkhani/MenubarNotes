//
//  ShutDownToggle.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-16.
//

import SwiftUI

struct ShutDownToggle: ToggleStyle {
    
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        if configuration.isOn {
            Button(
                action: {
                    configuration.isOn.toggle()
                },
                label: {
                    /*Image(systemName: "power")
                                         .font(.system(size: 15))
                                         .foregroundColor(Color.RedTRASHAndRM)
                                         .padding(2)
                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous)) */
                    
                    HStack (spacing: 0) {
                        Text("Q")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.RedTRASHAndRM)
                            //.shadow(radius: 0.3)
                        Text("uit ")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.RedTRASHAndRM)
                            //.shadow(radius: 0.3)
                    }.help(Text("Quit/Shutdown App"))
                }
            ).buttonStyle(ClearImageBackground2())
             .shadow(radius: 0.5)
        } else {
            HStack (spacing: 2) {
                Button(
                    action: {
                        configuration.isOn.toggle()
                        /* a quit button that appears on the popover when the menubar icon is clicked */
                        NSApp.terminate(self) /* this will basically terminate the process of the app */
                    },
                    label: {
                        Text("yes")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            //.font(.custom("Avenir", size: 15))
                            .foregroundColor(Color.RedTRASHAndRM)
                            .help(Text("Shutdown"))
                    }
                ).buttonStyle(ClearImageBackground())
                Text(" or ")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .shadow(radius: 0.6)
                Button(
                    action: {
                        configuration.isOn.toggle()
                    },
                    label: {
                        Text("no ")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            //.font(.custom("Avenir", size: 15))
                            .foregroundColor(Color.BlueEdit)
                            .help(Text("Cancle"))
                    }
                ).buttonStyle(ClearImageBackground())
            }.shadow(radius: 0.5)
        }
    }
}
