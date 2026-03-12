
//  ButtonStyles.swift
//  Notes
//  Created by Shayan Eivaz Khani on 2022-10-28.

import SwiftUI

struct ClearImageBackground: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}
struct ClearImageBackground2: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
           
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
        
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}
struct ClearImageBackground3: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}
struct InvincibleNothingButton: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .background(sharedAppState.darkMode ?
                        (configuration.isPressed ?  Color.PriorityButtonPositivePositionDarkModeShadow : Color.clear)
                        :
                        (configuration.isPressed ?  Color.PriorityButtonNegativePositionLightModeShadow : Color.clear)
            ).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
             .opacity(configuration.isPressed ? 0.2 : 0.8)
            //.shadow(radius: 3)
    }
}

struct InvincibleNothingButton2: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    let priorityLevel: Int // Parameter to determine background color based on index
    
    // Array of colors for dark mode and light mode
    let darkModeColors: [Color] = [
        .gray.opacity(0.3),
        Color.neuOrangePriority2.opacity(0.5),
        Color.neuOrangePriority4.opacity(0.7),
        Color.neuRed
    ]
    
    let lightModeColors: [Color] = [
        .gray.opacity(0.6),
        Color.neuOrangePriority1.opacity(0.5),
        Color.neuOrangePriority4.opacity(0.75),
        Color.neuRed
    ]
   
    // Initializer to accept priority level (0 to 5)
    init(priorityLevel: Int) {
        self.priorityLevel = priorityLevel
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            //.background(sharedAppState.darkMode ? darkModeColors[priorityLevel] : lightModeColors[priorityLevel])
        
            .overlay(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .stroke( LinearGradient(
                        colors: [(sharedAppState.darkMode ? darkModeColors[priorityLevel%4] : lightModeColors[priorityLevel%4]), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    ), lineWidth: CGFloat(priorityLevel+1))
            )
            .background(sharedAppState.darkMode ?
                        (configuration.isPressed ?  Color.PriorityButtonPositivePositionDarkModeShadow : Color.clear)
                        :
                        (configuration.isPressed ?  Color.PriorityButtonNegativePositionLightModeShadow : Color.clear)
            ).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            //.opacity(configuration.isPressed ? 0.4 : 0.95)
            
    }
}

struct fourButtonStyle: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .padding(10)
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT: Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT: Color.fourButtonGRADIENTBackgroundLightModeRIGHT)]
                ), startPoint: .leading, endPoint: .trailing)
            )
            //.background(sharedAppState.darkMode ? Color.fourButtonBackgroundDarkMode: Color.fourButtonBackgroundLightMode)
        
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        
            //MARK: - 🌈 den färgen knappen får när its being pressed är färgen på dens shadow
            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: (sharedAppState.darkMode ? 0.8 : 1.6), x: -1.2, y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.neuPurp.opacity(0.9) : Color.neuOrangeLighter2.opacity(0.7), radius: 3, x: 1.8, y: 1.5)
            //.shadow(radius: 2)
        
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeIn(duration: 0.05), value: configuration.isPressed)
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}


struct RedBackButton: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
        
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                ]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
        
        /*
            .shadow(color: sharedAppState.darkMode ? Color.neuPurpLight : Color.neuOrangeLight.opacity(0.3), radius: 10, x: -3, y: 0)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        */
        
            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(0.85) : Color.neuOrangeLighter2.opacity(0.4), radius: 1, x: (sharedAppState.darkMode ? -0.9 : -1.2), y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.GreenAdd.opacity(0.8) : Color.neuOrange, radius: (sharedAppState.darkMode ? 1.0 : 1.8), x: (sharedAppState.darkMode ? 0.8 : 1), y: 0.8)
            //.shadow(color: sharedAppState.darkMode ? Color.neuPurp : Color.neuLesserOrange, radius: 2, x: 1, y: 1)
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLight, radius: 2, x: -1, y: -1)
        
        
         //.shadow(color: sharedAppState.darkMode ? Color.GreenAdd : Color.neuOrange.opacity(0.9), radius: 1.7, x: 1, y: 1)
         //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLighter2, radius: 2, x: -1, y: -0.5)
        /* .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: 1.7, x: 1, y: 1)
                                                .shadow(color: sharedAppState.darkMode ? Color.neuPurp : Color.neuOrangeLighter2, radius: 2, x: -1, y: -0.5)
                                            */
        /*.shadow(color: sharedAppState.darkMode ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 2, x: -1, y: -0.5)
                                             .shadow(color: sharedAppState.darkMode ? Color.RedBackButtonDarkModeShadowDown.opacity(0.5) : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1.5, y: 1)
                                             */
        
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeIn(duration: 0.05), value: configuration.isPressed)
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}
struct miniRedBackButton: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(2)
        
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT : Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT : Color.fourButtonGRADIENTBackgroundLightModeLEFT)
                ]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
        
        /*
            .shadow(color: sharedAppState.darkMode ? Color.neuPurpLight : Color.neuOrangeLight.opacity(0.3), radius: 10, x: -3, y: 0)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        */
        
            .shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(0.85) : Color.neuOrangeLighter2.opacity(0.4), radius: (sharedAppState.darkMode ? 0.5 : 1), x: (sharedAppState.darkMode ? -0.6 : -1.2), y: -1)
            .shadow(color: sharedAppState.darkMode ? Color.GreenAdd.opacity(0.8) : Color.neuOrange, radius: (sharedAppState.darkMode ? 0.8 : 1.8), x: (sharedAppState.darkMode ? 0.4 : 1), y: 0.8)
            //.shadow(color: sharedAppState.darkMode ? Color.neuPurp : Color.neuLesserOrange, radius: 2, x: 1, y: 1)
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLight, radius: 2, x: -1, y: -1)
        
        
            //.shadow(color: sharedAppState.darkMode ? Color.GreenAdd : Color.neuOrange.opacity(0.9), radius: 0.75, x: 0.9, y: 0.8)
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrangeLighter2, radius: 1.5, x: -1.2, y: -1)
        
            /*.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon : Color.neuOrange.opacity(0.75), radius: 0.75, x: 0.9, y: 0.8)
                                                        .shadow(color: sharedAppState.darkMode ? Color.neuPurp.opacity(0.6) : Color.neuOrangeLighter2, radius: 1.5, x: -1.2, y: -1)
                                                        */
            /*.shadow(color: sharedAppState.darkMode ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 1, x: -0.6, y: -0.6)
                                                     .shadow(color: sharedAppState.darkMode ? Color.RedBackButtonDarkModeShadowDown : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1, y: 1)
                                                     */
        
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}



struct MarkDoneCheckButton: PrimitiveButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    private var itemIsDone: Bool = false
    
    init(_ isDoneMarkingValue: Bool) {
        itemIsDone = isDoneMarkingValue
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            HStack {
                if !(itemIsDone) {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(sharedAppState.darkMode ? Color.ImageUncheckColorDarkMode : Color.ImageUncheckColorLightMode)
                }
                if itemIsDone {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(sharedAppState.darkMode ? Color.ImageisDoneColorDarkMode : Color.ImageisDoneColorLightMode)
                }
            }
            Button(configuration).buttonStyle(ClearImageBackground())
        }
    }
}

struct MarkDoneCheckButton2: PrimitiveButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    private var itemIsDone: Bool = false
    
    init(_ isDoneMarkingValue: Bool) {
        itemIsDone = isDoneMarkingValue
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            HStack {
                if !(itemIsDone) {
                    Image(systemName: "circlebadge")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(sharedAppState.darkMode ? Color.markButtonTextDarkMode : Color.markButtonTextLightMode)
                }
                if itemIsDone {
                    if sharedAppState.MoveMode {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.foregroundColor(sharedAppState.darkMode ? Color.BlueEdit : Color.BlueEdit)
                            .foregroundColor(sharedAppState.darkMode ? Color.markButtonTextDarkMode : Color.markButtonTextLightMode)
                    }
                    if sharedAppState.DeleteMode {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(sharedAppState.darkMode ? Color.RedTRASHAndRM : Color.RedTRASHAndRM)
                    }
                }
                
            }
            Button(configuration).buttonStyle(ClearImageBackground())
        }
    }
}



struct fourMoveTaskItemButtonStyle: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            //.padding(4)
        
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeLEFT: Color.fourButtonGRADIENTBackgroundLightModeLEFT),
                       (sharedAppState.darkMode ? Color.fourButtonGRADIENTBackgroundDarkModeRIGHT: Color.fourButtonGRADIENTBackgroundLightModeRIGHT)]
                ), startPoint: .leading, endPoint: .trailing)
            )
            //.background(sharedAppState.darkMode ? Color.fourButtonBackgroundDarkMode: Color.fourButtonBackgroundLightMode)
        
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        
            //MARK: - 🌈 den färgen knappen får när its being pressed är färgen på dens shadow
            //.shadow(color: sharedAppState.darkMode ? Color.neuBlueNeon.opacity(1.0) : Color.neuOrange.opacity(0.9), radius: (configuration.isPressed ? 0 : 1), x: 0, y: -1)
            //.shadow(color: sharedAppState.darkMode ? Color.neuPurp.opacity(1.0) : Color.neuOrangeLighter2.opacity(0.7), radius: (configuration.isPressed ? 0 : 1), x: 0, y: 2)
            //.shadow(radius: 0.1)
        
            //.scaleEffect(configuration.isPressed ? 0.985 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            //.animation(.linear(duration: 0.2))
            //.animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}



struct PrimitiveBigTaskItemButton: PrimitiveButtonStyle {
    // MARK: – 💧 Connect our RealmManager to View ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    //@StateObject var realmManager = RealmManager()
    @EnvironmentObject var realmManager: RealmManager
    
    @EnvironmentObject var sharedAppState: AppState
    private var itemID: Int = 0
    private var itemPriority: Int = 0
    private var itemsPage: Int = 0
    
    init(_ withID: Int, _ withPriority: Int, _ fromPage: Int) {
        itemID = withID
        itemPriority = withPriority
        itemsPage = fromPage
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        ZStack {
            VStack (spacing: 0) {
                Button(configuration)
                HStack {
                    /*
                    Text(" ")
                        .font(.custom("Avenir", size: 7))
                    HStack (spacing: 0) {
                        Text(realmManager.returnTaskDateForATaskItemWith(ID: itemID, fromPage: itemsPage), style: .date)
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDateDarkMode : Color.ItemTextDateLightMode)
                            .baselineOffset(1)
                        Text(" ∙")
                            .font(.system(size: 7, weight: .medium, design: .default))
                            .baselineOffset(1)
                        Text(realmManager.returnTaskDateForATaskItemWith(ID: itemID, fromPage: itemsPage), style: .time)
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDateDarkMode : Color.ItemTextDateLightMode)
                            .baselineOffset(1)
                    }*/
                    Spacer()
                    if itemPriority == 0 {
                        Text("    𝚘")
                            .font(.custom("Avenir", size: 11))
                            .baselineOffset(1) // flytta Texten en bit upp
                            .foregroundColor(sharedAppState.darkMode ? Color.neuBlueNeonLight : Color.black)
                    }
                    if itemPriority == 1 {
                        Text("     ●")
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(Color.neuOrangePriority2)
                            .baselineOffset(1)
                    }
                    if itemPriority == 2 {
                        Text("    ●●")
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(Color.neuOrangePriority3)
                            .baselineOffset(1)
                    }
                    if itemPriority == 3 {
                        Text("   ●●●")
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(Color.neuOrangePriority1)
                            .baselineOffset(1)
                    }
                    if itemPriority == 4 {
                        Text("  ●●●●")
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(Color.neuOrangePriority4)
                            .baselineOffset(1)
                    }
                    if itemPriority == 5 {
                        Text(" ●●●●●")
                            .font(.custom("Avenir", size: 7))
                            .foregroundColor(Color.neuOrangeAlmostRedPriority5)
                            .baselineOffset(1)
                    }
                    Text(" ")
                        .font(.custom("Avenir", size: 7))
                }.frame(height: 12)
            }//.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }//.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}



struct BigTaskItemButton: ButtonStyle {
    // MARK: – 💧 Connect our RealmManager to View ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    //@StateObject var realmManager = RealmManager()
    @EnvironmentObject var realmManager: RealmManager
    
    @EnvironmentObject var sharedAppState: AppState
    private var itemID: Int = 0
    private var itemPriority: Int = 0
    
    init(_ withID: Int, _ withPriority: Int) {
        itemID = withID
        itemPriority = withPriority
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(1)
            //.background(NeuBackground(TaskPriority: $TaskPriority))
            .background(
                ZStack {
                    VStack (spacing: 0) {
                        HStack (spacing: 0) {
                            Text(" ")
                                .font(.custom("Avenir", size: 7))
                            HStack (spacing: 0) {
                                Text(realmManager.returnP1TaskDateForTaskItemWith(id: itemID), style: .date)
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDateDarkMode : Color.ItemTextDateLightMode)
                                    .baselineOffset(1)
                                Text(" ∙")
                                    .font(.system(size: 7, weight: .heavy, design: .default))
                                Text(realmManager.returnP1TaskDateForTaskItemWith(id: itemID), style: .time)
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDateDarkMode : Color.ItemTextDateLightMode)
                                    .baselineOffset(1)
                            }
                            Spacer()
                            if itemPriority == 0 {
                                Text("    𝚘 ")
                                    .font(.custom("Avenir", size: 11))
                                    .baselineOffset(1) // flytta Texten en bit upp
                                    .foregroundColor(sharedAppState.darkMode ? Color.neuBlueNeonLight : Color.black)
                            }
                            if itemPriority == 1 {
                                Text("     ●")
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(Color.neuOrangePriority2)
                                    .baselineOffset(1)
                            }
                            if itemPriority == 2 {
                                Text("    ●●")
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(Color.neuOrangePriority3)
                                    .baselineOffset(1)
                            }
                            if itemPriority == 3 {
                                Text("   ●●●")
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(Color.neuOrangePriority1)
                                    .baselineOffset(1)
                            }
                            if itemPriority == 4 {
                                Text("  ●●●●")
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(Color.neuOrangePriority4)
                                    .baselineOffset(1)
                            }
                            if itemPriority == 5 {
                                Text(" ●●●●●")
                                    .font(.custom("Avenir", size: 7))
                                    .foregroundColor(Color.neuOrangeAlmostRedPriority5)
                                    .baselineOffset(1)
                            }
                            Text(" ")
                                .font(.custom("Avenir", size: 7))
                        }.frame(height: 15)
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            )
            .opacity(configuration.isPressed ? 0.8 : 1)
        }
}



struct StepperPriorityButtonStyle: ButtonStyle {
    
    @EnvironmentObject var sharedAppState: AppState
    private var priority: Int
    
    init(_ withPriority: Int) {
        priority = withPriority
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(5)
                //.background(NeuBackground(TaskPriority: $TaskPriority))
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                            .shadow(color: sharedAppState.darkMode ? Color.PriorityButtonNegativePositionDarkModeShadow: Color.PriorityButtonNegativePositionLightModeShadow, radius: 2, x: -2, y: 0)
                            .shadow(color: sharedAppState.darkMode ? Color.PriorityButtonPositivePositionDarkModeShadow: Color.PriorityButtonPositivePositionLightModeShadow, radius: 2, x: 0, y: 0)
                            .padding(2)
                        HStack (spacing: 0) {
                            Text("   Priority:")
                                .font(.custom("Avenir", size: 12))
                                .bold()
                            HStack {
                                if priority == 0 {
                                    Text("    𝚘 ")
                                        .font(.custom("Avenir", size: 13))
                                        //.baselineOffset(1) // flytta Texten en bit upp
                                        .foregroundColor(sharedAppState.darkMode ? Color.neuBlueNeonLight : Color.black)
                                }
                                if priority == 1 {
                                    Text("     ●")
                                        .font(.custom("Avenir", size: 9))
                                        .foregroundColor(Color.neuOrangePriority2)
                                        .baselineOffset(-1)
                                }
                                if priority == 2 {
                                    Text("    ●●")
                                        .font(.custom("Avenir", size: 9))
                                        .foregroundColor(Color.neuOrangePriority3)
                                        .baselineOffset(-1)
                                }
                                if priority == 3 {
                                    Text("   ●●●")
                                        .font(.custom("Avenir", size: 9))
                                        .foregroundColor(Color.neuOrangePriority1)
                                        .baselineOffset(-1)
                                }
                                if priority == 4 {
                                    Text("  ●●●●")
                                        .font(.custom("Avenir", size: 9))
                                        .foregroundColor(Color.neuOrangePriority4)
                                        .baselineOffset(-1)
                                }
                                if priority == 5 {
                                    Text("●●●●●")
                                        .font(.custom("Avenir", size: 9))
                                        .foregroundColor(Color.neuOrangeAlmostRedPriority5)
                                        .baselineOffset(-1)
                                }
                            }.frame(width: 39)
                          
                        }.frame(width: 95)
                    }.clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                ).opacity(configuration.isPressed ? 0.8 : 1)
        }
}



struct CopyAndPaste: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
           .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        
           .scaleEffect(configuration.isPressed ? 0.8 : 1)
           .opacity(configuration.isPressed ? 0.6 : 1)
           .animation(.linear(duration: 0.05), value: configuration.isPressed)
    }
}



struct EmojiCopyButton: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
           .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        
           .scaleEffect(configuration.isPressed ? 0.85 : 1)
           .opacity(configuration.isPressed ? 0.3 : 1)
           .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}



struct StepperItemPriorityButtonStyle: PrimitiveButtonStyle {
    let color: Color

    //@EnvironmentObject var sharedAppState: AppState
    @Binding var TaskPriority: Int
    
    func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
            .background(NeuBackground(TaskPriority: $TaskPriority))
            .frame(width: 100)
    }
}



struct NeuBackground : View  {
    @EnvironmentObject var sharedAppState: AppState
    @Binding var TaskPriority: Int
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24).foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                .shadow(color: sharedAppState.darkMode ? Color.PriorityButtonNegativePositionDarkModeShadow: Color.PriorityButtonNegativePositionLightModeShadow, radius: 2, x: 1, y: 0)
                .shadow(color: sharedAppState.darkMode ? Color.PriorityButtonPositivePositionDarkModeShadow: Color.PriorityButtonPositivePositionLightModeShadow, radius: 2, x: 1, y: 0)
                .padding(3)
            HStack (spacing: 0) {
                Text(" Priority:")
                    .font(.custom("Avenir", size: 12))
                    .bold()
                HStack (spacing: 0) {
                    if $TaskPriority.wrappedValue == 0 {
                        Text("     𝚘")
                            .font(.custom("Avenir", size: 14))
                            //.baselineOffset(1) // flytta Texten en bit upp
                            .foregroundColor(sharedAppState.darkMode ? Color.neuBlueNeonLight : Color.black)
                    }
                    if $TaskPriority.wrappedValue == 1 {
                        Text("    ●")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(Color.neuLesserOrangeLight)
                    }
                    if $TaskPriority.wrappedValue == 2 {
                        Text("   ●●")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(Color.neuOrangeLighter2.opacity(1))
                    }
                    if $TaskPriority.wrappedValue == 3 {
                        Text("  ●●●")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(Color.neuOrangeLighter)
                    }
                    if $TaskPriority.wrappedValue == 4 {
                        Text(" ●●●●")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(Color.neuOrange)
                    }
                    if $TaskPriority.wrappedValue == 5 {
                        Text("●●●●●")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(Color.neuRed)
                    }
                }.frame(width: 45)
            }.frame(width: 105)
        }
    }
}



struct NeuBackgroundView : View  {
    let cornerRadius : CGFloat
    @Binding var  opacity : CGFloat
    @Binding var  opacityOp : CGFloat
    @Binding var  shadowRadiusXY : CGFloat
    
    @EnvironmentObject var sharedAppState: AppState
    @Binding var TaskPriority: Int
    
    var body: some View {
        HStack (spacing: 0) {
            Text(" Priority: ")
                .font(.custom("Avenir", size: 12))
                .bold()
            HStack (spacing: 0) {
                if $TaskPriority.wrappedValue == 0 {
                    Text("     𝚘")
                        .font(.custom("Avenir", size: 14))
                    //.baselineOffset(1) // flytta Texten en bit upp
                        .foregroundColor(sharedAppState.darkMode ? Color.neuBlueNeonLight : Color.black)
                }
                if $TaskPriority.wrappedValue == 1 {
                    Text("      ●")
                        .font(.custom("Avenir", size: 10))
                        .foregroundColor(Color.neuLesserOrangeLight)
                }
                if $TaskPriority.wrappedValue == 2 {
                    Text("   ●●")
                        .font(.custom("Avenir", size: 10))
                        .foregroundColor(Color.neuOrangeLighter2.opacity(1))
                }
                if $TaskPriority.wrappedValue == 3 {
                    Text("  ●●●")
                        .font(.custom("Avenir", size: 10))
                        .foregroundColor(Color.neuOrangeLighter)
                }
                if $TaskPriority.wrappedValue == 4 {
                    Text(" ●●●●")
                        .font(.custom("Avenir", size: 10))
                        .foregroundColor(Color.neuOrange)
                }
                if $TaskPriority.wrappedValue == 5 {
                    Text("●●●●●")
                        .font(.custom("Avenir", size: 10))
                        .foregroundColor(Color.neuRed)
                }
            }.frame(width: 50)
        }
    }
}


struct NeuButtonStyle: ButtonStyle {
    
    @State var  opacity : CGFloat = 1
    @State var  opacityOp : CGFloat = 0
    @State var  shadowRadiusXY : CGFloat = 3
    @State var  scale : CGFloat = 1
    let width : CGFloat
    let cornerRadius : CGFloat
    
    @EnvironmentObject var sharedAppState: AppState
    @Binding var TaskPriority: Int
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: width)
            .foregroundColor(.primary)
            .background(NeuButtonBackgroundView(cornerRadius: cornerRadius, opacity: $opacity, opacityOp: $opacityOp, shadowRadiusXY: $shadowRadiusXY))
            .scaleEffect(scale)
            .onChange(of: configuration.isPressed) { newValue in
                if (!configuration.isPressed) {
                    withAnimation(.spring(dampingFraction: 0.5).speed(2)) {
                        opacity = 0
                        scale = 0.95
                        opacityOp = 1
                        shadowRadiusXY = 0
                    }
                } else {
                    withAnimation(.spring(dampingFraction: 0.5).speed(2)) {
                        opacity = 1
                        scale = 1
                        opacityOp = 0
                        shadowRadiusXY = 3
                    }
                }
            }
    }
}
struct NeuButtonBackgroundView: View {
    
    let cornerRadius : CGFloat
    @Binding var  opacity : CGFloat
    @Binding var  opacityOp : CGFloat
    @Binding var  shadowRadiusXY : CGFloat
    
    var body: some View {
        ZStack {
            //Button shape and color
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
            //Button's dark edge (top left)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.neuBackgroundDark.opacity(opacityOp), lineWidth: 2)
                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors:[Color.neuBackgroundDark.opacity(opacityOp), Color.clear], startPoint: .top, endPoint: .bottom)))
            //Button's inner dark shadow (top left)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.neuBackgroundDark, lineWidth: 2)
                .blur(radius: 3)
                .offset(x: 1, y: 1)
                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color.neuBackgroundDark.opacity(opacityOp), Color.clear], startPoint: .top, endPoint: .bottom)))
            //Button's inner light edge (bottom right)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.neuBackgroundLight.opacity(opacityOp), lineWidth: 2)
                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color.clear, Color.neuBackgroundLight.opacity(opacityOp)], startPoint: .top, endPoint: .bottom)))
        }
        //Button's outer light shadow (top left)
        .shadow(color: Color.neuBackgroundDark.opacity(opacity), radius: shadowRadiusXY, x: -shadowRadiusXY, y: -shadowRadiusXY)
        //Button's outer dark shadow (bottom right)
        .shadow(color: Color.neuBackgroundLight.opacity(opacity), radius: shadowRadiusXY, x: shadowRadiusXY, y: shadowRadiusXY)
    }
}


/*
 public struct P115_PrimitiveButtonStyle: View {
     
     public init() {}
     public var body: some View {
         VStack {
             Button("Button Style 1") { }
             .buttonStyle(LongPrimitiveButtonStyle())
             
             Divider().frame(width: 44)
             
             Button("Button Style 2") { }
             .buttonStyle(LongPrimitiveButtonStyle(minDuration: 1.5, pressedColor: Color.red))
         }
     }
 }

 fileprivate
 struct  LongPrimitiveButtonStyle: PrimitiveButtonStyle {
     
     var minDuration = 0.5
     var pressedColor: Color = Color.blue
     
     func makeBody(configuration: Configuration) -> some View {
         ButtonStyleBody(configuration: configuration,
                         minDuration: minDuration,
                         pressedColor: pressedColor)
     }
     
     private struct ButtonStyleBody: View {
         
         let configuration: Configuration
         let minDuration: CGFloat
         let pressedColor: Color
         @GestureState private var isPressed = false
         
         var body: some View {
             let longPress = LongPressGesture(minimumDuration: minDuration)
                 .updating($isPressed) { value, state, _ in
                     state = value
                 }
                 .onEnded { _ in
                     self.configuration.trigger()
                 }
             return configuration.label
                 .padding()
                 .background(
                     GeometryReader { proxy in
                         RoundedRectangle(cornerRadius: isPressed ? proxy.size.height / 2 : 8)
                             .fill(isPressed ? pressedColor : Color.fabulaPrimary)
                     }
                     
                 )
                 .foregroundColor(.white)
                 .gesture(longPress)
                 .scaleEffect(isPressed ? 0.7 : 1.0)
                 .animation(.easeInOut, value: isPressed)
         }
     }
 }

 struct P115_PrimitiveButtonStyle_Previews: PreviewProvider {
     static var previews: some View {
         P115_PrimitiveButtonStyle()
     }
 }

 */
