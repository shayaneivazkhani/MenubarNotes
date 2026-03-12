//
//  DayCounter.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import SwiftUI
import Foundation

struct DayCounter: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var dateMachine = DateComparator()
    
    @Binding var fromThisDate: Date
    @Binding var toThisDate: Date
    
    @Binding var itIsThisManyYears: Int
    @Binding var itIsThisManyMonths: Int
    @Binding var itIsThisManyDays: Int
    
    init(_ thisDat: Binding<Date>, _ thatDat: Binding<Date>, _ y: Binding<Int>, _ m: Binding<Int>, _ d: Binding<Int>) {
        self._fromThisDate = thisDat
        self._toThisDate = thatDat
        self._itIsThisManyYears = y
        self._itIsThisManyMonths = m
        self._itIsThisManyDays = d
    }
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .bottom)  {
                //(colorScheme == .dark ? Color.PopOverControllerDarkMode : Color.neuWhite)
                (colorScheme == .dark ? Color.counterBackgroundDarkMode : Color.counterBackgroundLightMode)
                
                VStack (spacing: 5) {
                    HStack (spacing: 0) {
                        Text("")
                        Text(" from: ")
                            .font(.custom("Avenir", size: 12))
                            //.foregroundColor(colorScheme == .dark ? Color.counterTextBackgroundDarkMode : Color.counterTextBackgroundLightMode)
                        DatePicker("", selection: $fromThisDate, displayedComponents: .date).labelsHidden()
                        Spacer()
                        Text(" to: ")
                            .font(.custom("Avenir", size: 12))
                            //.foregroundColor(colorScheme == .dark ? Color.counterTextBackgroundDarkMode : Color.counterTextBackgroundLightMode)
                        DatePicker("", selection: $toThisDate, displayedComponents: .date).labelsHidden()
                        Text(" ")
                    }
                    HStack {
                        HStack (spacing: 6) {
                            Text(" –›")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            //Text(" ")
                            if self.itIsThisManyYears != 0 {
                                HStack (spacing: 0) {
                                    Text("\(itIsThisManyYears)")
                                        .font(.custom("Avenir", size: 12))
                                        .bold()
                                        .foregroundColor(colorScheme == .dark ? Color.neuGrayLight : Color.counterTextBackgroundLightMode)
                                    Text(" y")
                                        .font(.custom("Avenir", size: 11))
                                        .bold()
                                        .foregroundColor(Color.neuOrange)
                                }
                            }
                            if self.itIsThisManyMonths != 0 {
                                HStack (spacing: 0) {
                                    Text("\(itIsThisManyMonths)")
                                        .font(.custom("Avenir", size: 12))
                                        .bold()
                                        .foregroundColor(colorScheme == .dark ? Color.neuGrayLight : Color.counterTextBackgroundLightMode)
                                    Text(" m")
                                        .font(.custom("Avenir", size: 11))
                                        .bold()
                                        .foregroundColor(Color.neuOrange)
                                }
                            }
                            if self.itIsThisManyDays != 0 {
                                HStack (spacing: 0) {
                                    Text("\(itIsThisManyDays)")
                                        .font(.custom("Avenir", size: 12))
                                        .bold()
                                        .foregroundColor(colorScheme == .dark ? Color.neuGrayLight : Color.counterTextBackgroundLightMode)
                                    Text(" d")
                                        .font(.custom("Avenir", size: 11))
                                        .bold()
                                        .foregroundColor(Color.neuOrange)
                                }
                            } else {
                                HStack (spacing: 0) {
                                    Text("\(itIsThisManyDays)")
                                        .font(.custom("Avenir", size: 12))
                                        .bold()
                                        .foregroundColor(colorScheme == .dark ? Color.neuGrayLight : Color.counterTextBackgroundLightMode)
                                    Text(" d")
                                        .font(.custom("Avenir", size: 11))
                                        .bold()
                                        .foregroundColor(Color.neuOrange)
                                }
                            }
                        }
                        Spacer()
                        HStack (spacing: 3) {
                            Button(
                                action: {
                                    /*itIsThisManyYears = dateMachine.compareDate(this: fromThisDate, that: toThisDate, byYears: true, byMonths: false, byDays: false)
                                                                        itIsThisManyMonths = dateMachine.compareDate(this: fromThisDate, that: toThisDate, byYears: false, byMonths: true, byDays: false)
                                                                        itIsThisManyDays = dateMachine.compareDate(this: fromThisDate, that: toThisDate, byYears: false, byMonths: false, byDays: true)
                                                                        
                                                                        if itIsThisManyYears > 0 && itIsThisManyMonths < 0 {
                                                                            itIsThisManyYears = itIsThisManyYears - 1
                                                                            itIsThisManyMonths = itIsThisManyMonths + 12
                                                                        }
                                                                        if itIsThisManyMonths > 0 && itIsThisManyDays < 0 {
                                                                            itIsThisManyMonths = itIsThisManyMonths - 1
                                                                            itIsThisManyDays = itIsThisManyDays + dateMachine.howManyDaysDoesCurrentMonthHave()
                                                                        }
                                                                        
                                                                        if itIsThisManyYears < 0 && itIsThisManyMonths > 0 {
                                                                            itIsThisManyYears = itIsThisManyYears + 1
                                                                            itIsThisManyMonths = itIsThisManyMonths - 12
                                                                        }
                                                                        if itIsThisManyMonths < 0 && itIsThisManyDays > 0 {
                                                                            itIsThisManyMonths = itIsThisManyMonths + 1
                                                                            itIsThisManyDays = itIsThisManyDays - dateMachine.howManyDaysDoesCurrentMonthHave()
                                                                        }*/
                                    
                                    itIsThisManyDays = dateMachine.numberOfDaysBetween(fromThisDate, toThisDate)
                                },
                                label: {
                                    Text("count")
                                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                                }
                            ).buttonStyle(ClearImageBackground2())
                             .help(Text("Count the days (start date excluded)"))
                            Text("∙")
                                .foregroundColor(colorScheme == .dark ? Color.dotDarkMode : Color.dotLightMode)
                            Button(
                                action: {
                                    self.fromThisDate = Date()
                                    self.toThisDate = Date()
                                    
                                    self.itIsThisManyYears = 0
                                    self.itIsThisManyMonths = 0
                                    self.itIsThisManyDays = 0
                                },
                                label: {
                                    Text("clear")
                                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                                        //.foregroundColor(Color.RedTRASHAndRM)
                                /*
                                                                     Image(systemName: "arrow.counterclockwise.circle.fill")
                                                                        .renderingMode(.template) //MARK: – 🩸 hur väljer en "tema" av SF Symbol Image
                                                                        .foregroundColor(colorScheme == .dark ? Color.PaintbrushMarkDown3 : Color.PaintbrushMarkDown3)
                                                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                                */
                                }
                            ).buttonStyle(ClearImageBackground())
                        }//.frame(alignment: .bottom)
                    } // HStack
                }.padding(10) // VStack
                /*.background(
                                     ZStack {
                                         if colorScheme == .dark {
                                             Color.PopOverControllerDarkMode
                                             RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                 .foregroundColor(.black)
                                                 .blur(radius: 4)
                                                 .offset(x: -8, y: -8)
                                             RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                 .fill(LinearGradient(gradient: Gradient(colors: [Color.neuGrayDark6, Color.neuGray4]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                                 .padding(2)
                                                 .blur(radius: 2)
                                         } else {
                                             Color.neuDesignColor1
                                             RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                 .foregroundColor(.white)
                                                 .blur(radius: 4)
                                                 .offset(x: -8, y: -8)
                                             RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                 .fill(LinearGradient(gradient: Gradient(colors: [Color.neuDesignColor1, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                                 .padding(2)
                                                 .blur(radius: 2)
                                         }
                                     }
                                 ) */
            }.frame(width: 300, height: 60) // ZStack
             .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
             .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
            
            /*.shadow(color: colorScheme == .dark ? Color.ListElevatorShadowDarkModeUP: Color.ListElevatorShadowLightModeUP, radius: 1, x: -1, y: -1) // MARK: Elevator – 🌈 shadow runt Listan med Itemsen
                         .shadow(color: colorScheme == .dark ? Color.ListElevatorShadowDarkModeDOWN : Color.ListElevatorShadowLightModeDOWN, radius: 1, x: 1, y: 1) // MARK: Elevator – 🌈 shadow runt Listan med Itemsen */
             
            /*.shadow(color: colorScheme == .dark ? Color.counterShadowDarkModeUP: Color.counterShadowLightModeUP, radius: 1, x: -1, y: -1)
                        .shadow(color: colorScheme == .dark ? Color.counterShadowDarkModeDOWN : Color.counterShadowLigthModeDOWN, radius: 1.5, x: 1, y: 1) */
            
            /*.shadow(color: colorScheme == .dark ? Color.ListElevatorShadowDarkModeUP: Color.ListElevatorShadowLightModeUP, radius: 1, x: -1, y: -1)
                         .shadow(color: colorScheme == .dark ? Color.ListElevatorShadowDarkModeDOWN : Color.ListElevatorShadowLightModeDOWN, radius: 1, x: 1, y: 1) */
            
            /*.shadow(color: colorScheme == .dark ? Color.neuDesignColor2: Color.neuDesignColor2, radius: 20, x: -1, y: -1)
                         .shadow(color: colorScheme == .dark ? Color.neuDesignColor3 : Color.neuDesignColor3, radius: 20, x: 1, y: 1) */
         }.frame(width: 300, height: 420, alignment: .bottom)
    }
}
