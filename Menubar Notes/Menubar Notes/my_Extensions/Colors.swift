
//  Colors.swift
//  Notes
//
//  Created by Shayan Eivaz Khani on 2022-06-10.

import Foundation
import SwiftUI


/**
    // NSColor -> Color
    NSColor.white.toColor()

    // NSColor -> RGB
    NSColor.white.toRGB()

    // NSColor -> color code
    NSColor.white.toColorCode()

    // NSColor(hex: color code, alpha: CGFloat)
    NSColor(hex: "FFFFFF", alpha: 1.0)
*/

extension NSColor {
    
    // NSColor -> Color
    func toColor() -> Color {
        if let components = self.cgColor.components {
            return Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
        } else {
            return Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0)
        }
    }
    
    // NSColor -> RGB
    func toRGB() -> (displayP3Red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        if let components = self.cgColor.components {
            return (displayP3Red: components[0], green: components[1], blue: components[2], alpha: components[3])
        } else {
            return (displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    // NSColor -> color code
    func toColorCode() -> String {
        if let components = self.cgColor.components {
            let rgb: [CGFloat] = [components[0], components[1], components[2]]
            return rgb.reduce("") { res, value in
                let intval = Int(round(value * 255))
                return res + (NSString(format: "%02X", intval) as String)
            }
        } else {
            return ""
        }
    }
    
    // NSColor(hex: color code, alpha: CGFloat)
    convenience init(hex: String, alpha: CGFloat) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

// MARK: – Make custom colors

extension Color {
    
    static let testDark = Color(hex: "042069")
    static let testLight = Color(hex: "7eba53")
    
    
    static let miniGeneralButtonsColorDarkMode = Color(hex: "baed7f")
    //static let miniGeneralButtonsColorDarkMode = Color(hex: "30bff2")
    
    //static let miniGeneralButtonsColorLightMode = Color(hex: "aaaaaa")
    static let miniGeneralButtonsColorLightMode = Color(hex: "30bff2")
    
    static let generalButtonsBackgroundColorDarkMode = Color(hex: "686868")
    //static let generalButtonsBackgroundColorLightMode = Color(hex: "dfdfdf")
    static let generalButtonsBackgroundColorLightMode = Color(hex: "e5e5e5")
    
// MARK: –  för Sheet Varning background color
    
    static let generalSheetBackgroundColorDarkMode = Color(hex: "262727")
    static let generalSheetBackgroundColorLightMode = Color(hex: "ffffff")
    
// MARK: – 🌈 för PageController
    
    //static let PopOverControllerDarkMode = Color(hex: "000000")
    //static let PopOverControllerDarkMode = Color(hex: "312e2d")
    //static let PopOverControllerDarkMode = Color(hex: "21201f")
    //static let PopOverControllerDarkMode = Color(hex: "868580")
    //static let PopOverControllerDarkMode = Color(hex: "434240")
    static let PopOverControllerDarkMode = Color(hex: "434240").opacity(0.0)
    static let PopOverDarkShadow1 = Color(hex: "55555a").opacity(0.4)
    static let PopOverDarkShadow2 = Color(hex: "77777a").opacity(0.4)
    
    //static let PopoverControllerLightMode = Color(hex: "ddf2fe")
    //static let PopoverControllerLightMode = Color(hex: "cde1ff")
    static let PopoverControllerLightMode = Color(hex: "cde1ff").opacity(1.0)
    //static let PopoverControllerLightMode = Color(hex: "D8E8FF") // mörkare
    //static let PopoverControllerLightMode = Color(hex: "E5EFFF")  // ljusare
    //static let PopoverControllerLightMode = Color(hex: "eefffe")
    //static let PopoverControllerLightMode = Color(hex: "EAF7FF")
    static let PopoverLightShadow1 = Color(hex: "b8cce5")
    static let PopoverLightShadow2 = Color(hex: "d7e8ff")
 
// MARK: – 🌈 från DesignCOde Neumorphic Button
    
    static let CanvasColor = Color(.sRGB, red: 230/255, green: 240/255, blue: 1, opacity: 1.0)
    
    static let neuDesignColor1 = Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
    static let neuDesignColor2 = Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))
    static let neuDesignColor3 = Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1))
/*
     Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1))
     Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
     Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1))
     Color.white
*/
    
// MARK: – 🌈 färgerna för 4 första knapparna –––––––––––––––––––––
    
    //static let fourButtonTextDarkMode = Color(hex: "0000ff")
    //static let fourButtonTextDarkMode = Color(hex: "cdcfd8")
    //static let fourButtonTextDarkMode = Color(hex: "6786f4")
    //static let fourButtonTextDarkMode = Color(hex: "94aaf7")
      //static let fourButtonTextDarkMode = Color(hex: "6f6d70")
    //static let fourButtonTextDarkMode = Color(hex: "664BFB").opacity(0.9)
    //static let fourButtonTextDarkMode = Color(hex: "907cff")
    //static let fourButtonTextDarkMode = Color(hex: "2b1e8e")
    static let fourButtonTextDarkMode = Color(hex: "242426")
    //static let fourButtonTextDarkMode = Color(hex: "5b5f7f")
    //static let fourButtonTextDarkMode = Color(hex: "323232")
    static let fourButtonTextLightMode = Color(hex: "6f6d70")
    //static let fourButtonTextLightMode2 = Color(hex: "9b989d") //speciellt gjord för "The Empty Set Markeringen", 2 grader ljusare än fourButtonTextLightMode
    
    static let fourButtonBackgroundDarkMode = Color(hex: "4c4c4c")
    static let fourButtonBackgroundLightMode = Color(hex: "ffffff")
    
    static let fourButtonShadowDarkModeLEFT = Color(hex: "4c4c4c")
    static let fourButtonShadowDarkModeRIGHT = Color(hex: "f7f7f7")
    static let fourButtonShadowLightModeLEFT = Color(hex: "ffffff")
    static let fourButtonShadowLightModeRIGHT = Color(hex: "9b989d")

    //static let fourButtonGRADIENTBackgroundDarkModeLEFT = Color(hex: "4c4c4c")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "9b989d")
    //static let fourButtonGRADIENTBackgroundDarkModeLEFT = Color(hex: "4c4c4c")
    //static let fourButtonGRADIENTBackgroundDarkModeLEFT = Color(hex: "343434")
    static let fourButtonGRADIENTBackgroundDarkModeLEFT = Color(hex: "2e2a2a")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "9b989d")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "615c64")
    static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "c3bbbb")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "8d8b8b")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "9a9494")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "a3a7aa")
    //static let fourButtonGRADIENTBackgroundDarkModeRIGHT = Color(hex: "f7f7f7")
    
    //static let fourButtonGRADIENTBackgroundLightModeLEFT = Color(hex: "ffffff")
    //static let fourButtonGRADIENTBackgroundLightModeRIGHT = Color(hex: "9b989d")
    static let fourButtonGRADIENTBackgroundLightModeLEFT = Color(hex: "ffffff")
    static let fourButtonGRADIENTBackgroundLightModeRIGHT = Color(hex: "9b989d")
    //static let fourButtonGRADIENTBackgroundLightModeRIGHT = Color(hex: "c3c1c4")
    static let fourButtonGRADIENTBackgroundLightModeUP = Color(hex: "ffffff")
    static let fourButtonGRADIENTBackgroundLightModeMIDDLE = Color(hex: "efefef")
    //static let fourButtonGRADIENTBackgroundLightModeDOWN = Color(hex: "d8d8d8")
    //static let fourButtonGRADIENTBackgroundLightModeDOWN = Color(hex: "c2c2c2")
    static let fourButtonGRADIENTBackgroundLightModeDOWN = Color(hex: "e3e3e3")
    
// MARK: – 🌈 färgerna för Datumet längst ner på start sidan  ––––––––––
    
    static let startPageDateDarkMode = Color(hex: "8793ff")
    static let startPageDateLightMode = Color(hex: "8793ff")
    //static let dotDarkMode = Color(hex: "8793ff")
    //static let dotDarkMode = Color(hex: "3E2CCC")
    static let dotDarkMode = Color(hex: "8b80e0")
    //static let dotDarkMode = Color(hex: "0000ff")
    //static let dotDarkMode = Color(hex: "4fcaa2")
    //static let dotDarkMode2 = Color(hex: "555555")
    static let dotLightMode = Color(hex: "ff804c")
    
// MARK: – 🌈 färgerna för counter rektangeln som öppnas  ––––––––––
        
    //static let counterBackgroundDarkMode = Color(hex: "484d53")
    //static let counterBackgroundDarkMode = Color(hex: "301c27")
    //static let counterBackgroundDarkMode = Color(hex: "1d1b1b")
    static let counterBackgroundDarkMode = Color(hex: "363534")
    static let counterShadowDarkModeUP = Color(hex: "3f3e3d")
    static let counterShadowDarkModeDOWN = Color(hex: "7b7a79")
    
    static let counterBackgroundLightMode = Color(hex: "ffffff")
    //static let counterBackgroundLightMode = Color(hex: "cfcfcf")
    static let counterShadowLightModeUP = Color(hex: "3f3e3d")
    static let counterShadowLigthModeDOWN = Color(hex: "ddf2fe")
    
    //static let counterTextBackgroundDarkMode = Color(hex: "838382")
    static let counterTextBackgroundDarkMode = Color(hex: "ddf2fe")
    static let counterTextBackgroundLightMode = Color(hex: "454242")
    
    static let counterDividerBackgroundDarkMode = Color(hex: "444444")
    static let counterDividerBackgroundLightMode = Color(hex: "e7e7e7")
    
// MARK: – 🌈 färgerna för texter ––––––––––––––––––––––––––––––––––
    // används ej just nu
    static let ListPageNameDarkMode = Color(hex: "8793ff")
    static let ListPageNameLightMode = Color(hex: "aaaaaa")

// MARK: – 🌈 färgerna för texter autoLaunch toggle på StartSidan
    
    static let AutolaunchDarkMode = Color(hex: "8793ff")
    static let AutoLaunchLightMode = Color(hex: "aaaaaa")
    
// MARK: – 🌈 färgerna för Listan (i.e. Elevator) ––––––––––––––––––
    
    //static let ListPageBackgroundDarkMode = Color(hex: "1d1d1d")
    //static let ListPageBackgroundDarkMode = Color(hex: "545353")
    //static let ListPageBackgroundDarkMode = Color(hex: "5b5958")
    //static let ListPageBackgroundDarkMode = Color(hex: "363534")
    static let ListPageBackgroundDarkMode = Color(hex: "2B2B2B")
    static let ListPageBackgroundDarkMode2 = Color(hex: "2B2B2B")
    static let ListElevatorShadowDarkModeUP = Color(hex: "000000")
    static let ListElevatorShadowDarkModeDOWN = Color(hex: "040404")
    
    static let ListPageBackgroundLightMode = Color(hex: "fbfbfb")
    static let ListPageBackgroundLightMode2 = Color(hex: "fbfbfb")
    //static let ListElevatorShadowLightModeUP = Color(hex: "afafaf")
    //static let ListElevatorShadowLightModeDOWN = Color(hex: "afafaf")
    //static let ListElevatorShadowLightModeUP = Color(hex: "acaeb9")
    static let ListElevatorShadowLightModeUP = Color(hex: "868790")
    static let ListElevatorShadowLightModeDOWN = Color(hex: "acaeb9")
  
// MARK: – 🌈 färgerna för USER Input texten i Show/TextField ––––––
    
    static let showBarTextFieldTextBackgroundDarkMode = Color(hex: "baed7f")
    static let showBarTextFieldTextBackgroundLightMode = Color(hex: "423f4b")
    
// MARK: – 🌈 färgerna för Divider() –––––––––––––––––––––––––––––––
    
    //static let DividerBackgroundDarkMode = Color(hex: "8793ff")
    //static let DividerBackgroundDarkMode = Color(hex: "3E2CCC")
    static let DividerBackgroundDarkMode = Color(hex: "8b80e0")
    static let DividerBackgroundLightMode = Color(hex: "aaaaaa")
    
// MARK: – 🌈 för textfärgen på tenxen som finns på itemsen som visas på listan
    
    //static let ItemTextDarkMode = Color(hex: "dddddd")
    static let ItemTextDarkMode = Color(hex: "cccccc")
    static let ItemTextLightMode = Color(hex: "121210")
    
    static let ItemTextDateDarkMode = Color(hex: "aaaaaa")
    static let ItemTextDateLightMode = Color(hex: "121210")
    
    //static let ItemBackgroundDarkMode = Color(hex: "5a5756")
    //static let ItemBackgroundDarkMode = Color(hex: "898685")
    //static let TaskItemBackgroundDarkMode = Color(hex: "72706f")
    static let TaskItemBackgroundDarkMode = Color(hex: "bdbcbc")
    //static let TaskItemShadowDarkModeUP = Color(hex: "2b2929")
    static let TaskItemShadowDarkModeUP = Color(hex: "acb9cc")
    static let TaskItemShadowDarkModeDOWN = Color(hex: "2b2929")
    
    static let TaskItemBackgroundLightMode = Color(hex: "ffffff")
    static let TaskItemShadowLightModeUP = Color(hex: "f4f3f4")
    static let TaskItemShadowLightModeDOWN = Color(hex: "f4f3f4")
    
    static let TaskItemSlideShadowDarkModeUP = Color(hex: "664BFB")
    static let TaskItemSlideShadowDarkModeDOWN = Color(hex: "0000ff")
    static let TaskItemSlideShadowLightModeUP = Color(hex: "ff552f")
    static let TaskItemSlideShadowLightModeDOWN = Color(hex: "ff7859")

    static let ItemDatePriorityBackgroundDarkMode = Color(hex: "2b2929") // MARK: – 🌈 väls likadant som  ListPageBackgroundDarkMode
    //static let ItemDatePriorityBackgroundDarkMode = Color(hex: "5b5958")
    static let ItemDatePriorityBackgroundLightMode = Color(hex: "dad9d9") // MARK: – 🌈 väls likadant som  ListPageBackgroundLightMode
    //static let ItemDatePriorityBackgroundLightMode = Color(hex: "fbfbfb")
    
// MARK: – 🌈 generella färger som används lite överallt
    
    static let BlueEdit = Color(hex: "30bff2")
    static let BlueEdit2 = Color(hex: "2acaea")
    
    static let GreenAdd = Color(hex: "09ff00")
    static let RedTRASHAndRM = Color(hex: "ff0000")
    
    static let PaintbrushMarkDown = Color(hex: "4fcaa2")
    static let PaintbrushMarkDown2 = Color(hex: "b6fcd5")
    static let PaintbrushMarkDown3 = Color(hex: "baed7f")
    
// MARK: – 🌈 till IsDone och !isDone check/uncheck knapparna som finns på varje textItem som visas på listorna
            
    static let ImageCheckColor = Color(hex: "4fcaa2") // ANVÄNDS VID DELETEMODE
    
    static let ImageUncheckColorDarkMode = Color(hex: "696969")
    static let ImageUncheckColorLightMode = Color(hex: "ececec")
    
    //static let ImageisDoneColorDarkMode = Color(hex: "81d8d0")
    //static let ImageisDoneColorDarkMode = Color(hex: "6c747f")
    //static let ImageisDoneColorDarkMode = Color(hex: "C6E2FF")
    static let ImageisDoneColorDarkMode = Color(hex: "bebaba")
    //static let ImageisDoneColorLightMode = Color(hex: "4fcaa2")
    static let ImageisDoneColorLightMode = Color(hex: "60cfab")
    //static let ImageisDoneColorLightMode = Color(hex: "C6E2FF")
    
// MARK: – 🌈 till MARK och UNMARK knapparna vid sidan av Task Itemsen som visas på 4 Listorna
    
    //static let markButtonTextDarkMode = Color(hex: "6786f4")
    //static let markButtonTextDarkMode = Color(hex: "94aaf7")
    //static let markButtonTextDarkMode = Color(hex: "b3c2f9")
    //static let markButtonTextDarkMode = Color(hex: "313131")
    static let markButtonTextDarkMode = Color(hex: "d3d3d4")
    static let markButtonTextLightMode = Color(hex: "8b8a8c")
    
// MARK: – 🌈 till dividern som finns till vänster om IsDone och !isDone check/uncheck knapparna som finns på varje textItem som visas på listorna
                
    static let DividerLeftOfCheckButtonDarkMode = Color(hex: "4b4b4b")
    static let DividerLeftOfCheckButtonLightMode = Color(hex: "f4f4f4")
    
// MARK: – 🌈 för RedBackButton
    
    static let RedBackButtonImageDarkMode = Color(hex: "8793FF")
    static let RedBackButtonImageLightMode = Color(hex: "ff7859")
    
    static let RedBackButtonBackgroundDarkMode = Color(hex: "f2ebeb")
    static let RedBackButtonDarkModeShadowUP = Color(hex: "0000ff")
    static let RedBackButtonDarkModeShadowDown = Color(hex: "664BFB")
    
    static let RedBackButtonBackgroundLightMode = Color(hex: "fdfdfd")
    static let RedBackButtonLightModeShadowUP = Color(hex: "ff552f")
    static let RedBackButtonLightModeShadowDOWN = Color(hex: "ff7859")
    
// MARK: – 🌈 för sidan med 2 TextEditor som visas upp när EditorPage == true
    
    static let TextViewShadowDarkModeUP = Color(hex: "000000")
    static let TextViewShadowDarkModeDOWN = Color(hex: "040404")
    
    static let TextViewShadowLightModeUP = Color(hex: "868790")
    //static let TextViewShadowLightModeUP = Color(hex: "afafaf")
    //static let TextViewShadowLightModeDOWN = Color(hex: "afafaf")
    
    static let EditorPageTaskDatePriorityDarkModeShadowUP = Color(hex: "3f3e3d")
    static let EditorPageTaskDatePriorityDarkModeShadowDOWN = Color(hex: "7b7a79")
    
    static let EditorPageTaskDatePriorityLightModeShadowUP = Color(hex: "ececec")
    static let EditorPageTaskDatePriorityLightModeShadowDOWN = Color(hex: "ececec")
    
// MARK: – 🌈 för ZStacken med Date Picker och Prioritybuttonsen när EditorPage == true
        
    static let DatePriorityBackgroundDarkMode = Color(hex: "1d1b1b")
    //static let DatePriorityBackgroundDarkMode = Color(hex: "000000")
    
    static let DatePriorityBackgroundLightMode = Color(hex: "fffffff")
    
    static let PriorityButtonNegativePositionDarkModeShadow = Color(hex: "0000ff")
    static let PriorityButtonPositivePositionDarkModeShadow = Color(hex: "664BFB")
    
    static let PriorityButtonNegativePositionLightModeShadow = Color(hex: "ff552f")
    static let PriorityButtonPositivePositionLightModeShadow = Color(hex: "ff7859")
    
    
    static let neuOrangePriority1 = Color(hex: "ff5f32")
    static let neuOrangePriority2 = Color(hex: "fda6a6")
    static let neuOrangePriority3 = Color(hex: "fd7979")
    static let neuOrangePriority4 = Color(hex: "ff3800")
    static let neuOrangePriority5 = Color(hex: "ff7e7e")
    static let neuOrangeAlmostRedPriority5 = Color(hex: "ff0000")
    
// MARK: – 🌈 till MarkdowPage
    
    //static let MarkdowPageBackgroundDarkMode = Color(hex: "777777")
    //static let MarkdowPageBackgroundDarkMode = Color(hex: "9b9797")
    //static let MarkdowPageBackgroundDarkMode = Color(hex: "2B2B2B")
    static let MarkdowPageBackgroundDarkMode = Color(hex: "1E1F1E")
    static let MarkdowPageBackgroundLightMode = Color(hex: "ffffff")
    
    //static let MarkdowPageTextDarkMode = Color(hex: "A0A0A0")
    static let MarkdowPageTextDarkMode = Color(hex: "BBBAB3")
    static let MarkdowPageTextLightMode = Color(hex: "000000")
  
// ----- används av NeuButtonBackgroundView
    
    static let neuBackgroundDark = Color(hex: "aa99cc")
    static let neuBackgroundLight = Color(hex: "f0f0f3")
    
    //static let txtORMarkDownColorDarkMode = Color(hex: "818b99")
    //static let txtORMarkDownColorDarkMode = Color(hex: "6c747f")
    static let txtORMarkDownColorDarkMode = Color(hex: "242323")
    static let txtORMarkDownColorLightMode = Color(hex: "4b4b4b")
    
// MARK: – 🌈 till Copy och Paste knapparna som finns på 2 TextEditor/NSTextView sidorna
        
    static let CopyPasteImageColorDarkMode = Color(hex: "8793ff")
    static let CopyPasteImageColorLightMode = Color(hex: "aaaaaa")
    
// MARK: – 🌈 extra färger 🌈
    
    static let neuWhite = Color(hex: "ffffff")
    static let neuWhiteDark = Color(hex: "fdfdfd")
    static let neuWhiteCream = Color(hex: "fbf7f5")
    static let neuWhiteLightPurple = Color(hex: "f0effc")
    static let neuCreamDark = Color(hex: "cccccc")
    static let neuCream = Color(hex: "f2ebeb")
    static let neuCream2 = Color(hex: "beb2ac")
    static let neuCream3 = Color(hex: "dddddd")
    
    static let neuGrayButtonDisable = Color(hex: "8E8E93")
    static let neuGrayLight = Color(hex: "f7f7f7")
    static let neuGray = Color(hex: "717b62")
    static let neuGray2 = Color(hex: "cccccc")
    static let neuGray3 = Color(hex: "686666")
    static let neuGray4 = Color(hex: "3f3e3d")
    static let neuGrayDark = Color(hex: "0f0f0f")
    static let neuGrayDark2 = Color(hex: "4c4540")
    static let neuGrayDark3 = Color(hex: "4d4544")
    static let neuGrayDark4 = Color(hex: "2f2f28")
    static let neuGrayDark5 = Color(hex: "5a5756")
    static let neuGrayDark6 = Color(hex: "121111")
    static let neuSpaceGray = Color(hex: "a7adba")
    static let neuGrayPart2Light = Color(hex: "cfcfcf")
    
    //static let neuOrange = Color(hex: "ff552f")
    static let neuOrange = Color(hex: "ff804c")
    static let neuOrange2 = Color(hex: "ff8811")
    static let neuOrangeLight = Color(hex: "ff7859")
    static let neuOrangeLighter = Color(hex: "ff9f8a")
    static let neuOrangeLighter2 = Color(hex: "ffbbad")
    static let neuOrangeLighter3 = Color(hex: "ffbbad")
    static let neuOrangeSalmon = Color(hex: "FFC2CE")
    static let neuLessOrange = Color(hex: "f5793b")
    static let neuLesserOrange = Color(hex: "fff4f3")
    static let neuLesserOrangeLight = Color(hex: "fbeded")
    
    static let neuRed = Color(hex: "ff0000")
    static let neuRedDark = Color(hex: "ff0000")
    static let neuRedDark2 = Color(hex: "961516")
    
    static let neuGreen = Color(hex: "baed7f")
    static let neuGreen2 = Color(hex: "33ff99")
    static let neuGreen3 = Color(hex: "55ff66")
    static let neuGreenLight = Color(hex: "4fcaa2")
    static let neuGreenNeon = Color(hex: "ffff66")
    static let neuGreenMidnightShineNeon = Color(hex: "52EC16")
    
    static let neuBlueDark = Color(hex: "224499")
    static let neuBlueNeon = Color(hex: "0000ff")
    static let neuBlueNeonLight = Color(hex: "8793ff")
    static let neuBlueLightWhite = Color(hex: "b0c1e0")
    
    static let neuPurp = Color(hex: "664BFB")
    static let neuPurpLight = Color(hex: "664BFB")
    static let neuPurpLightWhite = Color(hex: "cfd3fd")
}

extension Color {
    /*init(hex: String) {
     let scanner = Scanner(string: hex)
     scanner.scanLocation = 0
     var rgbValue: UInt64 = 0
     scanner.scanHexInt64(&rgbValue)
     
     let r = (rgbValue & 0xff0000) >> 16
     let g = (rgbValue & 0xff00) >> 8
     let b = rgbValue & 0xff
     
     self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
     }
     */
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Int((rgbValue & 0xff0000) >> 16)
        let g = Int((rgbValue & 0xff00) >> 8)
        let b = Int(rgbValue & 0xff)
        
        self.init(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0)
    }
}
