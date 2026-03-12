//
//  WeekFinderOUTER.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import SwiftUI
import Foundation


struct WeekFinderOUTER: View {
        
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
                        WeekFinderINNER()
                    }
                    
                }.frame(width: 325, height: 200)  // ZStack
                    .preferredColorScheme(.light)  // MARK: – 💥 Force View to use light or dark mode
            }.frame(width: 325, height: 200) // VStack (spacing: 5) {
        }
}
struct WeekFinderINNER: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private static var currentDate: Date = Date()
    @State private var selecteddDate: Date = Date()
    
    @State private var weekNumber: Int = DateComparator().weekNumberOf(this: Date())
    @State private var selectedDateDayNameOfTheWeek: String = DateComparator().dayNameOfThis(d: Date())
    
    private var dateMachine = DateComparator()
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom)  {
                //(colorScheme == .dark ? Color.PopOverControllerDarkMode : Color.neuWhite)
                (colorScheme == .dark ? Color.counterBackgroundDarkMode : Color.counterBackgroundLightMode)
                
                VStack (spacing: 5) {
                    HStack (spacing: 0) {
                        Text("")
                        Text(" In which week is: ")
                            .font(.custom("Avenir", size: 12))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        DatePicker("", selection: $selecteddDate, displayedComponents: .date).labelsHidden()
                        Spacer()
                        Text("  ")
                        Button(
                            action: {
                                weekNumber = dateMachine.weekNumberOf(this: selecteddDate)
                                selectedDateDayNameOfTheWeek = dateMachine.dayNameOfThis(d: selecteddDate)
                            },
                            label: {
                                Text("count")
                                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            }
                        ).buttonStyle(ClearImageBackground2())
                    }
                    HStack {
                        HStack (spacing: 6) {
                            Text(" –› A")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            Text("\(selectedDateDayNameOfTheWeek)")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(Color.RedTRASHAndRM)
                            Text("in week")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            Text("\(weekNumber)")
                                .font(.system(size: 13, weight: .bold, design: .monospaced))
                                .foregroundColor(Color.RedTRASHAndRM)
                        }
                        Spacer()
                        
                    } // HStack
                }.padding(10) // VStack
            }.frame(width: 300, height: 60) // ZStack
             .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
             .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
         }.frame(width: 300, height: 420, alignment: .bottom)
    }
}
