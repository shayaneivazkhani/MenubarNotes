//
//  RoundButtonToggle.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-06-28.
//

import SwiftUI

/** Användning:
 
 struct ContentView: View {
     @State private var isActive = false

     var body: some View {
         VStack {
             RoundToggleButton(isOn: $isActive)

             Text("State is \(isActive ? "ON" : "OFF")")
                 .padding()
         }
     }
 }
 */
struct RoundToggleButton: View {
    @Binding var isOn: Bool
    @Binding var changedStyle: Bool

    var body: some View {
        Button(action: {
            isOn.toggle()
            changedStyle = true
        }) {
            Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                //.frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(isOn ? Color.green : Color.red)
                )
        }
        .buttonStyle(PlainButtonStyle()) // removes default button styling
    }
}
