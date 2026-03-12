
//  Created by Shayan Eivaz Khani on 2022-05-22.

import SwiftUI
import AppKit
import UniformTypeIdentifiers
import LaunchAtLogin
import RichTextKit

struct ContentView: View {
    
    //@StateObject var previewNoteWindowManager = PreviewNoteWindowManager()
    
// MARK: – för din egna debugging av appen ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・

///❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌
    //@StateObject var windowManager = WindowManager()  // ❗️Disable this code by commenting it out if Debugging
///❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌❗️🔴❌
    
// MARK: – för alerting/showing messege to user ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@State private var showToast = false
    //@State private var isShowAlert: Bool = false
    //@State private var isShowPopover = false
    
// MARK: – för hantera focusstate på RichTextEditor ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@FocusState private var isFocused: Bool // används inte
    // @Environment(\.isFocused) var isFocused
    @FocusState private var textEditorIsFocused: Bool
    
// MARK: – for shutdown button ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var shutdownAppButtonIfTrueElseYorN: Bool = true
    
// MARK: – values of User preferenses/settings ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Environment(\.colorScheme) var colorScheme
    
// MARK: – 💧 Connect our RealmManager to View ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @EnvironmentObject var realmManager: RealmManager
    
// MARK: –  AppStorage section för att behålla page view values/settings i USERDEFAULTS istället för Realm
    
    //@StateObject private var sharedAppState = AppState()
    @EnvironmentObject var sharedAppState: AppState
    
// MARK: – TabView Select which array of notes to preview from realmManager in ListOfNotes ・・・・・
    
    @AppStorage("selectionIMPandURGNotesTabView") private var selectionIMPandURGNotesTabView: Int = -1
    @AppStorage("selectionIMPNotesTabView") private var selectionIMPNotesTabView: Int = -1
    @AppStorage("selectionURGNotesTabView") private var selectionURGNotesTabView: Int = -1
    @AppStorage("selectionNOTHINGNotesTabView") private var selectionNOTHINGNotesTabView: Int = -1
    
// MARK: – For Editing the text inside RichTextKit in the 2Editor Page ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @AppStorage("richTextTest") var richTextTest: String = "" // Används inte längre men när skulle implementera richtexten den användes därför referar några exempel-funktioner på denna
    
    //@AppStorage("richTextInitialize") var richTextInitialize: String = "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGuCwwVGSAqKyw0Nz9AQ0ZVJG51bGzUDQ4PEBESExRYTlNTdHJpbmdaTlNEZWxlZ2F0ZVxOU0F0dHJpYnV0ZXNWJGNsYXNzgAKAAIAEgA3SEBYXGFlOUy5zdHJpbmeAA1Eg0hobHB1aJGNsYXNzbmFtZVgkY2xhc3Nlc18QD05TTXV0YWJsZVN0cmluZ6McHh9YTlNTdHJpbmdYTlNPYmplY3TTISIQIyYpV05TLmtleXNaTlMub2JqZWN0c6IkJYAFgAaiJyiAB4AJgAxfEBBOU1BhcmFncmFwaFN0eWxlVk5TRm9udNQtLi8QEjEyM1pOU1RhYlN0b3BzW05TQWxpZ25tZW50XxAfTlNBbGxvd3NUaWdodGVuaW5nRm9yVHJ1bmNhdGlvboAAEAQQAYAI0hobNTZfEBBOU1BhcmFncmFwaFN0eWxlojUf1Dg5OhA7PD0+Vk5TU2l6ZVhOU2ZGbGFnc1ZOU05hbWUjQCoAAAAAAAAQEIAKgAtbQXZlbmlyLUJvb2vSGhtBQlZOU0ZvbnSiQR/SGhtERVxOU0RpY3Rpb25hcnmiRB/SGhtHSF1OU1RleHRTdG9yYWdlpElKSx9dTlNUZXh0U3RvcmFnZV8QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmdfEBJOU0F0dHJpYnV0ZWRTdHJpbmcACAARABoAJAApADIANwBJAEwAUQBTAGIAaABxAHoAhQCSAJkAmwCdAJ8AoQCmALAAsgC0ALkAxADNAN8A4wDsAPUA/AEEAQ8BEgEUARYBGQEbAR0BHwEyATkBQgFNAVkBewF9AX8BgQGDAYgBmwGeAacBrgG3Ab4BxwHJAcsBzQHZAd4B5QHoAe0B+gH9AgICEAIVAiMCPwAAAAAAAAIBAAAAAAAAAEwAAAAAAAAAAAAAAAAAAAJU"
    
    @State private var wordCount: Int = 0 // conts words of textt.string
    
    //@State var textt = NSAttributedString(string: " ") // Själva RichTexten som visas i 2Editor pagen
    
    //@StateObject var context = RichTextContext() // varför inte @ObservedObject??
    @EnvironmentObject var context: RichTextContext
    
    /**
     Button("Replace Text Safely") {
          replaceTextSafely(in: NSRange(location: 0, length: 5), with: "Hi")
     }
     
     func replaceTextSafely(in range: NSRange, with newText: String) {
            // Ensure thread-safe and UI-safe operations
            DispatchQueue.main.async {
                // Get the safe range
                let safeRange = RichTextReader().safeRange(for: range)

                // Replace text using context.trigger
                context.trigger(.replaceText(in: safeRange, with: newText))
            }
        }
    */
    //@State var textt_str = NSAttributedString(string: " ") // Gets set when a USER presses a note on ListOfNOtes page, then gets used in comparing with the context.attributedtext so that if user have made any changes then the USER shall have the option to choose if he/she wants to save recent changes made to the note before returning
    
// MARK: – För Changing RichTextStyle av sharedAppState.textt i RichTextEditor ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・

    /**
     If you don’t want to conform the struct to Hashable, you can use a different identifier like id: \.name instead (assuming name is unique):
        ForEach(fontSizeOptions, id: \.name) { option in
     */
    /*struct FontSizeOption: Hashable {
        let name: String
        let size: CGFloat
    }*/
    struct FontSizeOption: Hashable {
        let name: String
        let size: CGFloat
        let name_bold: Bool
        let name_size: CGFloat
    }
    let fontSizeOptions: [FontSizeOption] = [
        FontSizeOption(name: "Title 30",     size: 30, name_bold: true,  name_size: 18),
        FontSizeOption(name: "Title 28",     size: 28, name_bold: true,  name_size: 16.9),
        FontSizeOption(name: "Title 26",     size: 26, name_bold: true,  name_size: 16),
        FontSizeOption(name: "Heading 24",   size: 24, name_bold: true,  name_size: 15),
        FontSizeOption(name: "Heading 22",   size: 22, name_bold: true,  name_size: 14),
        FontSizeOption(name: "Heading 20",   size: 20, name_bold: true,  name_size: 13),
        FontSizeOption(name: "Subheading 18",size: 18, name_bold: false, name_size: 12),
        FontSizeOption(name: "Subheading 16",size: 16, name_bold: false, name_size: 11),
        FontSizeOption(name: "Body 14",      size: 14, name_bold: false, name_size: 11),
        FontSizeOption(name: "Body 13",      size: 13, name_bold: false, name_size: 10.5),
        FontSizeOption(name: "Body 12",      size: 12, name_bold: false, name_size: 10.5),
        FontSizeOption(name: "Body 10",      size: 10, name_bold: false, name_size: 10)
    ]
    
    // fonts to choose from
    //@State private var selectedFont: Int = 0
    //@State private var selectedFont: String = ""
    @State private var fontNames: [String] = [
        "Avenir",
        "Avenir Next",
        "Helvetica",
        "Helvetica Neue",
        "Trebuchet MS",
        "Verdana",
        "Optima",
        "Times New Roman",
        "Georgia",
        "Cochin",
        "Didot",
        "Menlo",
        "PT Mono",
        "Courier",
    ]
    
    struct textStyleOption: Hashable {
        let name: String
        let size: CGFloat
        let name_bold: Bool
        let name_underline: Bool
        let name_size: CGFloat
    }
    let textStyleOptions: [textStyleOption] = [
        textStyleOption(name: "Title",      size: 24, name_bold: true,  name_underline: false, name_size: 15.5),
        textStyleOption(name: "Heading",    size: 20, name_bold: false, name_underline: true,  name_size: 13),
        textStyleOption(name: "Subheading", size: 16, name_bold: true,  name_underline: false, name_size: 11),
        textStyleOption(name: "Body",       size: 12, name_bold: false, name_underline: false, name_size: 10.5),
    ]
    /**
     let textStyleOptions: [textStyleOption] = [
         textStyleOption(name: "Title – 26 Bold",      size: 26, name_bold: true,  name_underline: false, name_size: 15.5),
         textStyleOption(name: "Heading – 22 Underline",    size: 22, name_bold: false, name_underline: true,  name_size: 13),
         textStyleOption(name: "Subheading – 16 Bold", size: 16, name_bold: true,  name_underline: false, name_size: 11),
         textStyleOption(name: "Body – 12",       size: 12, name_bold: false, name_underline: false, name_size: 10.5),
     ]
     */
    
    
/** not used
    struct textStyleOption2: Hashable {
        let name: String
        let size: CGFloat
        let name_font: String
        let name_bold: Bool
        let name_underline: Bool
        let name_highlighted: Bool
        let name_size: CGFloat
    }
    let textStyleOptions2: [textStyleOption2] = [
        textStyleOption2(name: "Title",      size: 26, name_font: "Didot",        name_bold: true,   name_underline: false, name_highlighted: false, name_size: 15.5),
        textStyleOption2(name: "Heading",    size: 20, name_font: "Trebuchet MS", name_bold: false,  name_underline: true,  name_highlighted: true,  name_size: 13),
        textStyleOption2(name: "Subheading", size: 16, name_font: "Optima",       name_bold: true,   name_underline: true,  name_highlighted: false, name_size: 11),
        textStyleOption2(name: "Body",       size: 13, name_font: "Optima",       name_bold: false,  name_underline: false, name_highlighted: false, name_size: 10.5),
    ]
*/
    
    struct highlightOption: Hashable {
        let name: String
        let col: Color
        let real_col: NSColor
    }
    let highlight_colors: [highlightOption] = [
        highlightOption(name: "clear",    col: Color.clear,            real_col: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)),
        highlightOption(name: " 🔴 ",       col: Color.red,              real_col: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.7)),
        highlightOption(name: " 🟡 ",       col: Color.yellow,           real_col: NSColor(red:1.00000, green:0.90196, blue:0.13924, alpha:0.4000)),
        highlightOption(name: " 🟢 ",       col: Color.green,            real_col: NSColor(red:0.00000, green:1.0, blue:0.0, alpha:0.4000)),
        highlightOption(name: " 🔵 ",       col: Color(hex: "4FBBDD"),   real_col: NSColor(red:0.30980, green:0.73333, blue:0.86667, alpha:0.60000))
    ]
    /*let highlight_colors: [Color] = [
        highlightOption(name: "clear", col: Color.clear, real_col: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
        highlightOption(name: "red",   col: Color.red,   real_col: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        Color.orange,
        Color.yellow,
        Color.green,
        Color.blue,
        Color.purple
    ]*/
// MARK: – För miniRadBackButton Dialog (save & Exit or just exit) inside the 2Editor Page ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@State private var isShow = false
    //@State private var selectMenu = "None"
    
    @State private var showingConfirmationDialogEmptyNote: Bool = false
    private var confirmationDialogTitleEmptyNote: String = "This note is empty, do \nyou want to remove it?"
    private var confirmationDialogMessageEmptyNote: String = ""
    
    //@State private var wasNoteHavingTextBeforeOpeningTextEditorButIsNowEmptyBeforeExiting: Bool = false
    
    //@State private var anyNewChanges: Bool = false
    //@State private var anyNewChangesInOnlyTextColor: Bool = false
    @State private var showingConfirmationDialog: Bool = false
    private var confirmationDialogTitle: String = "Do you want to save the recent changes made to this note?"
    private var confirmationDialogMessage: String = "" //"If you choose option 2 ’Exit’ no changes will be saved"
    
// MARK: – För multi windowed app ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    /*@Environment(\.openWindow) var openWindow
     
     Button(action: {
         openWindow(id: "utility-window")
     }) {
         Text("Open Utility Window")
     }
     */
    
// MARK: – For Editing the text inside the 2Editor Page ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var CurrentItemID = 0
    @State private var ShowEditor = false
    
    @State private var text = ""
    
    @State private var TaskNameText: String = ""
    @State private var TaskDescriptionText: String = ""
    

    @State private var TaskPriority: Int = 0
    
    @State private var rmTaskNameTextChooseOptionIfTrueElseYorN = false
    @State private var rmTaskDescriptionTextChooseOptionIfTrueElseYorN = false
    
    @State private var restoreTaskNameTextChooseOptionIfTrueElseYorN = false
    @State private var restoreTaskDescriptionChooseOptionIfTrueElseYorN = false
    
    @State private var TaskDate: Date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 0000, month: 0, day: 0)
        let endComponents = DateComponents(year: 9999, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    
    /* När user trycker på md mode så ska hela Stringen splittas baserad på \n och
     sedan ska markdown() functionen appliceras på elementen av dessa 2 arrayen */
    @State var TaskNameSplitForMarkDownMode: [String] = []
    @State var TaskDescriptionSplitForMarkDownMode: [String] = []
    
// MARK: – ⭐️ För Priority Picker・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@State private var priorities = [ "𝚘", "●", "●●", "●●●", "●●●●", "●●●●●"]
    //@State private var priorities = [ "0", "1", "2", "3", "4", "5"]
    //@State private var priorities = [ "0", "1", "2"]
    @State private var priorities = [ "0  – No priority", "1  – Low", "2  – Elevated", "3  – High"]
    @State private var pickedPriority = 0
    
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
    
// MARK: – ⭐️ För Share Button ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    /*var shareText: String {
        get {
            sharedAppState.textt.string
        }
        set {
            sharedAppState.textt.string = newValue
        }
    }*/
    /*var shareText: Binding<String> {
         Binding<String>(
             get: {
                 sharedAppState.textt.string
             },
             set: {
                 sharedAppState.textt.string = $0
             }
         )
    }*/
    @State private var shareText: String = " "
    
// MARK: – For Export single note on 2EditorPage notes as AttributedString  –  FILE Single EXPORTER ・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var showExportNoteSheetDetail: Bool = false
    
    ///WTF se till att nulla dessa så att du inte exporterar din egna värde till folk
    @AppStorage("SINGLENOTERICHTEXTATTRIBUTEDSTRINGEXPORT") private var singleNoteRichTextAttributedStringExport: String = ""
    @AppStorage("SINGLENOTERICHTEXTSTRINGEXPORT") private var singleNoteRichTextStringExport: String = ""
    
// MARK: – For Export all notes as String operation –  FILE EXPORTER skriva ut 4 Listorna i varsin .txt fil varsin  ・・・・・・・・・・・・・・・・
    
    @AppStorage("PAGE1EXPORT") private var p1FileExportString: String = ""
    @AppStorage("PAGE2EXPORT") private var p2FileExportString: String = ""
    @AppStorage("PAGE3EXPORT") private var p3FileExportString: String = ""
    @AppStorage("PAGE4EXPORT") private var p4FileExportString: String = ""
    
// MARK: –  markdown ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var MDmode = false
    @State private var MDname: AttributedString = ""
    @State private var MDtext: AttributedString = ""
    
    @State private var txtifTrueElseMarkDownPreviewStyle = true
    
    @State private var MD_Mode_Text_Size: Double = 13
    @State private var MD_Mode_Text_Space: CGFloat = 2
    @State private var MD_Mode_Text_Width: CGFloat = 0
    //@State private var MD_Mode_Text_Kerning: Double = 32
    //State private var MD_Mode_Text_Tracking: Double = 32
    
    func formatVal(_ v: Double) -> String {
        return String(format: "%.2f", v)
    }
    func formatVal2(_ v: Double) -> String {
        return String(format: "%.0f", v)
    }
    func formatVal3(_ v: Double) -> String {
        return String(format: "%.1f", v)
    }
    
// MARK: – to show the current date on the first page & välja Task Itemsens Date() ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var currenttimetext = Date()
    @State private var timetext = Date()
    
    @State var selectedDate = Date()
    
// MARK: – ⚠️ Developer Settings (ghost set everything behind the scenes) & expiration Date + SET week number ・・・・・・・・・・・・・・・・・・・・・
    
    @State private var showDeveloperSettingsToggleButton: Bool = false
    @State private var developerSettings: Bool = false
    
    @State private var countSettingsObjectsInRealm = 0
    
// MARK: – for using the Date and calender time thingis ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@Environment(\.calendar) var calendar: Calendar /* Behövs ej eftersom du har ju redan let calendar = Calendar.current i din DateComparator */
    
    @State private var dateMachine = DateComparator()
    @State private var fromThisDate: Date = Date()
    @State private var toThisDate: Date = Date()
    
    @State private var itIsThisManyYears = 0
    @State private var itIsThisManyMonths = 0
    @State private var itIsThisManyDays = 0
    
    @State private var todaysDate: Date = Date()
    @State private var todaysWeekDayName: String = ""
    
    @State private var weekNumberOfYear = 0
    
    /*@State private var ifAppisNotPastExpirationDate: Bool = false
     // för setting the Expiration Date for the app
     @State private var expirationDate: Date = Date()
     @State private var forSettingTheExpirationDate: Date = Date()
     
     @State private var forCheckingWhichExpirationDateIsSettInRealm: Date = Date()
     */
    
    @State private var showDayCounter = false
    @State private var showWeekFinder = false
    
    /** – checka ifall today är/förbi den expiration datument som appen har. Ifall den är/förbi då gör så att knapparna som navigerar till listorna förvinner
     func isDatePastApplicationExpirationDate() {
         //💧bara för att placera det någonstans att appen ska checka för expiration date
         let currentExpirationDate = realmManager.getApplicationExpiraitonDate()
         
         let YearsToExpiration = dateMachine.compareDate(this: todaysDate, that: currentExpirationDate, byYears: true, byMonths: false, byDays: false)
         let MonthsToExpiration = dateMachine.compareDate(this: todaysDate, that: currentExpirationDate, byYears: false, byMonths: true, byDays: false)
         let DaysToExpiration = dateMachine.compareDate(this: todaysDate, that: currentExpirationDate, byYears: false, byMonths: false, byDays: true)
         
         if (YearsToExpiration <= 0) && (MonthsToExpiration <= 0) && (DaysToExpiration < 0) {
            ifAppisNotPastExpirationDate = false
         } else {
            ifAppisNotPastExpirationDate = true
         }
     } */
    
// MARK: – for using the Date and calender time thingis ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @AppStorage("engine_name") private var engine_url_name: String = "Google"
    @AppStorage("showAddEngineOverlay") var showAddEngineOverlay: Bool = false
    @AppStorage("newEngineName") var newEngineName: String = ""
    @AppStorage("newEngineURL") var newEngineURL: String = ""
    
    @AppStorage("multi_function_button") private var multi_func_button: String = "Day Counter"
    
// MARK: – for "↗︎Feedback" Button in 0StartPage ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    private var app_review_url: URL = URL(string: "https://apps.apple.com/app/menubar-notes/id6444069615?l?action=write-review")!
    
// MARK: – Initialize ContentView ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    public init() {
        selectionIMPandURGNotesTabView = -1
        selectionIMPNotesTabView = -1
        selectionURGNotesTabView = -1
        selectionNOTHINGNotesTabView = -1
        
        singleNoteRichTextAttributedStringExport = ""
        singleNoteRichTextStringExport = ""
        
        p1FileExportString = ""
        p2FileExportString = ""
        p3FileExportString = ""
        p4FileExportString = ""
    }
    
// MARK: - 💥Start var body: some View { ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    
    /* 💥Inne i var body definierar man saker som "popover" när du klickar på menubar iconen. */
    var body: some View {
        
// MARK: - 🚌 Start PopoverPageController・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        /**     pagecount increases if moving further "into" the popover UI layers (further == to left).
                Value on pageCount defines how many pages is "navigatble" from the first page when the popver, pops open.
         
                currentPopoverPage = 0 ––> the start page (i.e. 4 Big Buttons)
                currentPopoverPage = 1 ––> the page where list of Items are on with their editors
         */
        PopoverPageController(pageCount: 2, currentIndex: $sharedAppState.currentPopoverPage) {
            
            
// MARK: – 🔵 sida nr 1 på PopoverPageController (startsidan)
            VStack {
                ZStack { // MARK: – ZWorld 1 Start・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
                    
                    VStack (spacing: 5) {
                        
// MARK: – Launch at login Toggle &  Dark/Light mode Toggle, ABOUT & SHUTDOWN–Button
                        VStack (alignment: .leading) {
                            HStack (spacing: 0) {
                                if $sharedAppState.popOverHasBeenDetachedByUser.wrappedValue {
                                    Spacer().frame(width: 25.00)
                                }
                                
                                HStack (spacing: 0) {
                                    LaunchAtLogin.Toggle()
                                        .toggleStyle(AutoLaunchToggle())
                                        .help(Text("When computer starts this app will start and appear in menubar automatically"))
                                    Spacer()
                                }.frame(width: 120, alignment: .leading) //.frame(width: (sharedAppState.popOverHasBeenDetachedByUser ? 110 : 120), alignment: .leading)
                                 .offset(CGSize(width: 1.00, height: -6.00))
                                 //.offset(CGSize(width: (sharedAppState.popOverHasBeenDetachedByUser ? 10.00 : 1.00), height: -6.00))
                                 .padding(2)
                                /*.padding(.horizontal, 10)
                                 .padding(.all, 10.00)
                                 .padding([.leading, .trailing, .bottom], 10.00)
                                 .padding([.leading, .trailing, .bottom], 50.00)
                                 .padding([.leading, .trailing, .bottom], -100.00)
                                 .padding([], 10.00)
                                 .padding([.top, .leading], 10.00)
                                 .padding(EdgeInsets(top: 10.00, leading: 10.00, bottom: 20.00, trailing: 10.00))
                                 .padding(EdgeInsets(top: 10.00, leading: -100.00, bottom: 20.00, trailing: 10.00))
                                 .padding(.horizontal)
                                 .padding(.vertical, 6)
                                 .background(RoundedRectangle(cornerRadius: 6).stroke())
                                 //.frame(maxWidth: 600)
                                 */
                                
                                Spacer()
                                
                                HStack (spacing: 2) {
                                    if $shutdownAppButtonIfTrueElseYorN.wrappedValue {
                                        if #available(macOS 15.0, *) {
                                            Button(
                                                action: {
                                                    NSWorkspace.shared.open(app_review_url)
                                                },
                                                label: {
                                                    //Text("Rate App")
                                                    //Text("Give Feedback")
                                                    Text("↗︎Feedback")
                                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                    //.shadow(radius: 0.6)
                                                }
                                            ).buttonStyle(ClearImageBackground2())
                                             .pointerStyle(.link)
                                             .shadow(radius: 0.5)
                                        } else {
                                            Button(
                                                action: {
                                                    NSWorkspace.shared.open(app_review_url)
                                                },
                                                label: {
                                                    //Text("Rate App")
                                                    //Text("Give Feedback")
                                                    Text("↗︎Feedback")
                                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                    //.shadow(radius: 0.6)
                                                }
                                            ).buttonStyle(ClearImageBackground2())
                                             .shadow(radius: 0.5)
                                        }
                                        
                                        Text("∙")
                                            .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        
                                        /**
                                        Button(
                                            action: {
                                                p1FileExportString = realmManager.getAllP1Notes()
                                                p2FileExportString = realmManager.getAllP2Notes()
                                                p3FileExportString = realmManager.getAllP3Notes()
                                                p4FileExportString = realmManager.getAllP4Notes()
                                                
                                                openExportWindow()
                                            },
                                            label: {
                                                Text("Export")
                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                    .shadow(radius: 0.6)
                                            }
                                        ).buttonStyle(ClearImageBackground2())
                                         .help(Text("Export all notes"))
                                         
                                         Text("∙")
                                            .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                         */
                                        
                                        AboutApplicationView_SheetView_Dismiss()
                                        
                                        Text("∙")
                                            .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        
                                        Button(
                                            action: {
                                                self.shutdownAppButtonIfTrueElseYorN = false
                                            },
                                            label: {
                                                HStack (spacing: 0) {
                                                    Text("Q")
                                                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                                                        .foregroundColor(Color.RedTRASHAndRM)
                                                        //.shadow(radius: 0.3)
                                                    Text("uit ")
                                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                        .foregroundColor(Color.RedTRASHAndRM)
                                                        //.shadow(radius: 0.3)
                                                }.help(Text("Quit/Shutdown App"))
                                            }
                                        ).buttonStyle(ClearImageBackground2())
                                         .shadow(radius: 0.5)
                                    } else {
                                        HStack (spacing: 2) {
                                            Text("Shutdown? ")
                                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                                .shadow(radius: 0.6)
                                            Button(
                                                action: {
                                                    self.shutdownAppButtonIfTrueElseYorN = true
                                                    
                                                    NSApp.terminate(self) /* this will call the method applicationShouldTerminate(_:) in AppDelegate.swift */
                                                    //(NSApp.delegate as? AppDelegate)?.requestQuitApplication()
                                                },
                                                label: {
                                                    Text("yes")
                                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                                        //.font(.custom("Avenir", size: 15))
                                                        .foregroundColor(Color.RedTRASHAndRM)
                                                        .help(Text("Shutdown"))
                                                }
                                            ).buttonStyle(ClearImageBackground())
                                            Text(" or ")
                                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                .shadow(radius: 0.6)
                                            Button(
                                                action: {
                                                    self.shutdownAppButtonIfTrueElseYorN = true
                                                },
                                                label: {
                                                    Text("no ")
                                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                                        //.font(.custom("Avenir", size: 15))
                                                        .foregroundColor(Color.BlueEdit)
                                                        .help(Text("Cancle"))
                                                }
                                            ).buttonStyle(ClearImageBackground())
                                        }.shadow(radius: 0.5)
                                    }
                                }.frame(width: 225, alignment: .trailing)
                                 .offset(CGSize(width: 0.00, height: -12.00))
                                
                                /*if !($sharedAppState.popOverHasBeenDetachedByUser.wrappedValue) {
                                    Button("Hide") {
                                        /*if let appDelegate = NSApplication.delegate as? AppDelegate {
                                         appDelegate.popover.performClose(nil)
                                         }*/
                                        /*if let appDelegate = NSApp?.delegate as? AppDelegate {
                                         appDelegate.popover.performClose(nil)
                                         }*/ 
                                        NSApp.delegate.hide(self)
                                    }.offset(CGSize(width: 0.00, height: -12.00))
                                }*/
                            }
                            
                            VStack (spacing: 4) {
                                Text("➲ Press ESC–button to hide popover, as long as no form/dialogue section is open")
                                    //.foregroundColor(sharedAppState.darkMode ? Color.dotLightMode : Color.dotLightMode)
                                    .foregroundColor(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.fourButtonTextLightMode)
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .frame(width: 407)
                                    .offset(CGSize(width: -5.00, height: 0.00))
                                Text("➲ Left-Click & drag background/body to move popover to any region – drag this 📍")
                                    //.foregroundColor(sharedAppState.darkMode ? Color.dotLightMode : Color.dotLightMode)
                                    .foregroundColor(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.fourButtonTextLightMode)
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .frame(width: 407)
                            }.frame(alignment: .trailing)
                             .offset(CGSize(width: 0.00, height: 85.00))
                             .padding(1)
                        }.frame(width: 507, alignment: .trailing) //.frame(width: 567, alignment: .trailing) //.frame(width: 407, alignment: .trailing) //.frame(width: 317, alignment: .trailing)
                         .offset(CGSize(width: 0.00, height: -12.00))
                         .padding(1)
                        
                        Spacer().padding()
                        
//  MARK: – 4 Big Buttons --> List of Items
                        if $sharedAppState.p0StarterPageWith4Buttons.wrappedValue {
                            VStack (spacing: 8) {
                                HStack (spacing: 8) {
                                    Button(
                                        action: {
                                            sharedAppState.choosenAtleastOneNote = 0
                                            show(pageItemList: 1)
                                        },
                                        label: {
                                            Text("Important")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.foregroundColor(sharedAppState.darkMode ? Color.neuGrayDark : Color.fourButtonTextLightMode)
                                                //.fontWeight(.light)
                                                .font(.system(size: 36, weight: .light, design: .default))
                                                //.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                //.frame(alignment: .topTrailing)
                                                .frame(width: 210, height: 94)
                                                //.shadow(radius: 0.4)
                                        }
                                    ).buttonStyle(neufourButtonStyle())
                                     .offset(CGSize(width: -20.00, height: -55.00))
                                    Button(
                                        action: {
                                            sharedAppState.choosenAtleastOneNote = 0
                                            show(pageItemList: 2)
                                        },
                                        label: {
                                            Text("Useful")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.fontWeight(.light)
                                                .font(.system(size: 31, weight: .light, design: .default))
                                                .frame(width: 145, height: 80, alignment: .center)
                                                //.shadow(radius: 0.4)
                                        }
                                    ).buttonStyle(neufourButtonStyle2())
                                     .offset(CGSize(width: 0.00, height: 17.00))
                                }
                                HStack (spacing: 8) {
                                    Button(
                                        action: {
                                            sharedAppState.choosenAtleastOneNote = 0
                                            show(pageItemList: 3)
                                        },
                                        label: {
                                            Text("Urgent")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.fontWeight(.light)
                                                .font(.system(size: 27, weight: .light, design: .default))
                                                .frame(width: 140, height: 70, alignment: .center)
                                                //.shadow(radius: 0.4)
                                        }
                                    ).buttonStyle(neufourButtonStyle3())
                                     .offset(CGSize(width: 3.00, height: -28.00))
                                    Button(
                                        action: {
                                            sharedAppState.choosenAtleastOneNote = 0
                                            show(pageItemList: 4)
                                        },
                                        label: {
                                            Text("Other")
                                            //Text("\(realmManager.p4Tasks.count) Other")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.fontWeight(.ultraLight)
                                                .font(.system(size: 23, weight: .light, design: .default))
                                                .frame(width: 90, height: 50, alignment: .center)
                                                //.shadow(radius: 0.2)
                                        }
                                    ).buttonStyle(neufourButtonStyle4())
                                     .offset(CGSize(width: 25.00, height: 25.00))
                                }
                            }.frame(alignment: .center)
                             .offset(CGSize(width: 7.00, height: 13.00))
                        }
                        
                        Spacer().padding()
                        
// MARK: – HStack med Datumet längst ner på första sidan
                        VStack (alignment: .leading) {
                            HStack {
                                HStack (spacing: 2) {
                                    Text("\(todaysWeekDayName)")
                                        //.font(.custom("Avenir", size: 12))
                                        .font(.custom("Avenir", size: 16).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        .shadow(radius: 0.6)
                                    Text("∙")
                                        .font(.system(size: 15, weight: .bold, design: .monospaced))
                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        .shadow(radius: 0.6)
                                    Text(todaysDate, style: .date)
                                        //.font(.custom("Avenir", size: 12))
                                        .font(.custom("Avenir", size: 16).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                        .shadow(radius: 0.6)
                                    Text("∙")
                                        .font(.system(size: 15, weight: .bold, design: .monospaced))
                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        .shadow(radius: 0.6)
                                    //Text("w")
                                    Text("Week ")
                                        //.font(.custom("Avenir", size: 12))
                                        .font(.custom("Avenir", size: 16).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                        .shadow(radius: 0.6)
                                    Text("\(weekNumberOfYear)")
                                        .font(.custom("Avenir", size: 16).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                        .shadow(radius: 0.6)
                                }.frame(alignment: .bottomLeading)
                                 .offset(CGSize(width: 0, height: 2))
                                
                                Spacer()
// MARK: - ❗️🔴❌
//#if DEBUG
                                /*if $sharedAppState.app_DEBUG_MODE.wrappedValue {
                                    Button(
                                        action: {
                                            //openDebugWindow()
                                            WindowManager.shared.openDebugWindow(sharedAppState)
                                        },
                                        label: {
                                            HStack (spacing: 0) {
                                                /*if #available(macOS 14.0, *) {
                                                    Image(systemName: "plus.circle.fill")
                                                        .symbolEffect(.pulse, options: .repeating, isActive: false)
                                                        //.contentTransition(.symbolEffect(.replace))
                                                } else {
                                                    Image(systemName: "plus.circle.fill")
                                                }*/
                                                Text("Open Debug")
                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                    //.shadow(radius: 0.6)
                                            }.foregroundColor(sharedAppState.darkMode ? Color.GreenAdd : Color.GreenAdd)
                                        }
                                    )//.buttonStyle(ClearImageBackground2())
                                    Button(
                                        action: {
                                            WindowManager.shared.closeDebugWindow()
                                        },
                                        label: {
                                            HStack (spacing: 0) {
                                                /*if #available(macOS 14.0, *) {
                                                    Image(systemName: "minus.circle.fill")
                                                        .symbolEffect(.pulse, options: .repeating, isActive: true)
                                                        //.contentTransition(.symbolEffect(.replace))
                                                } else {
                                                    Image(systemName: "minus.circle.fill")
                                                }*/
                                                //.font(.caption)
                                                Text("Close Debug")
                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                    //.shadow(radius: 0.6)
                                            }.foregroundColor(sharedAppState.darkMode ? Color.GreenAdd : Color.GreenAdd)
                                        }
                                    )//.buttonStyle(ClearImageBackground2())
                                }*/
//#endif
                                /*Button(
                                    action: {
                                        //openDebugWindow()
                                    },
                                    label: {
                                        HStack (spacing: 0) {
                                            /*if #available(macOS 14.0, *) {
                                                Image(systemName: "plus.circle.fill")
                                                    .symbolEffect(.pulse, options: .repeating, isActive: false)
                                                    //.contentTransition(.symbolEffect(.replace))
                                            } else {
                                                Image(systemName: "plus.circle.fill")
                                            }*/
                                            Text(sharedAppState.currentAppVersion)
                                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                //.shadow(radius: 0.6)
                                        }.foregroundColor(sharedAppState.darkMode ? Color.GreenAdd : Color.GreenAdd)
                                    }
                                )//.buttonStyle(ClearImageBackground2())
                                */
                                
                            }
                        }.frame(width: 495, height: 35, alignment: .bottom) //.frame(width: 555, height: 35, alignment: .bottom) //.frame(width: 395, height: 35, alignment: .bottom) //.frame(width: 310, height: 35, alignment: .bottom)
                         .padding(3)
                        
                    }.frame(width: 500, height: 710) //.frame(width: 560, height: 630) //.frame(width: 400, height: 630) //.frame(width: 315, height: 500) // MARK: –  VStack INSIDE ZSTACK
                     .padding(1)
                     .background(
                        Toggle("Dark/Light mode Toggle",isOn: $sharedAppState.darkMode)
                            .toggleStyle(DarkModeToggle2())
                     )
                     .onAppear() {
                         if (todaysWeekDayName != dateMachine.dayNameOfWeek()) {
                             todaysDate = Date()
                             todaysWeekDayName = dateMachine.dayNameOfWeek()
                             weekNumberOfYear = dateMachine.weekNumber()
                         }
                     }
                     .onHover() { isHovering in
                         /// mouse triggered the hover state change
                         if (todaysWeekDayName != dateMachine.dayNameOfWeek()) {
                             todaysDate = Date()
                             todaysWeekDayName = dateMachine.dayNameOfWeek()
                             weekNumberOfYear = dateMachine.weekNumber()
                         }
                         /*/// mouse just entered
                         if isHovering {
                             
                         } else { /// mouse just exited
                             
                         }*/
                     }
                }
            } // MARK: – VStack för page 0
            
// MARK: – 💥💥💥💥💥START💥💥💥💥💥 sidan på POPOVERpageController som innehåller Listan med TaskItemsen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
            
            VStack {
                ZStack { //  ZStacken where the taskItems lists och everthing kommer att visas på・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
                    
// MARK: – List of Items in PAGE
                    if !($ShowEditor.wrappedValue) {
                        VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                            VStack (spacing: 8) { // VStack som håller ihop Edit knappen och page name + Elevator
                                
                                if !$sharedAppState.p0StarterPageWith4Buttons.wrappedValue {
// HStacken ovanpå listofNotes som innehåller alla edit och sort buttons
                                    ListPage_TopMenu($sharedAppState.addedOneTask)
                                    
                                    ZStack {
                                        /*if #available(macOS 26.0, *) {
                                            Color.clear.opacity(0.7).frame(width: 366, height: 10).glassEffect(.clear.interactive(), in: .rect(cornerRadius: 2.0)).offset(CGSize(width: 0.0, height: -285.0))
                                        }
                                        */
                                        if $sharedAppState.p1showPageIMPandURGPopUp.wrappedValue {
// MARK: –  PAGE 1 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                            if #available(macOS 15.0, *) {
                                                TabView(selection: $selectionIMPandURGNotesTabView) {
                                                    Tab("𝐀𝐥𝐥", systemImage: "1.square", value: -1) {
                                                        Elevator {
                                                            ForEach(realmManager.p1Tasks, id: \.id) { p1TaskItem in
                                                                
                                                                HStack (spacing: 3) {
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1 // will be marked
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p1TaskItem.taskNAME
                                                                                TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                                TaskDate = p1TaskItem.taskDate
                                                                                let priority = p1TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p1TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 1)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p1TaskItem.taskNAME)")
                                                                                    Text("  \(p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p1TaskItem.taskPriority))
                                                                         //.help(Text("\(p1TaskItem.taskNAME)"))
                                                                         //.help(Text(p1TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("All", systemImage: "3.square") {
                                                    
                                                    Tab("𝐧𝐨 priority", systemImage: "1.square", value: 0) {
                                                        Elevator {
                                                            ForEach(realmManager.p1TasksPriorityZero, id: \.id) { p1TaskItem in
                                                                
                                                                HStack (spacing: 3) {
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1 // will be marked
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p1TaskItem.taskNAME
                                                                                TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                                TaskDate = p1TaskItem.taskDate
                                                                                let priority = p1TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p1TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 1)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p1TaskItem.taskNAME)")
                                                                                    Text("  \(p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p1TaskItem.taskPriority))
                                                                         //.help(Text("\(p1TaskItem.taskNAME)"))
                                                                         //.help(Text(p1TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("No Priority", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟏", systemImage: "2.square", value: 1) {
                                                        Elevator {
                                                            ForEach(realmManager.p1TasksPriorityOne, id: \.id) { p1TaskItem in
                                                                
                                                                HStack (spacing: 3) {
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1 // will be marked
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p1TaskItem.taskNAME
                                                                                TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                                TaskDate = p1TaskItem.taskDate
                                                                                let priority = p1TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p1TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 1)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p1TaskItem.taskNAME)")
                                                                                    Text("  \(p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p1TaskItem.taskPriority))
                                                                         //.help(Text("\(p1TaskItem.taskNAME)"))
                                                                         //.help(Text(p1TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("Priority 1", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟐", systemImage: "3.square", value: 2) {
                                                        Elevator {
                                                            ForEach(realmManager.p1TasksPriorityTwo, id: \.id) { p1TaskItem in
                                                                
                                                                HStack (spacing: 3) {
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1 // will be marked
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p1TaskItem.taskNAME
                                                                                TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                                TaskDate = p1TaskItem.taskDate
                                                                                let priority = p1TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p1TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 1)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p1TaskItem.taskNAME)")
                                                                                    Text("  \(p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p1TaskItem.taskPriority))
                                                                         //.help(Text("\(p1TaskItem.taskNAME)"))
                                                                         //.help(Text(p1TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("Priority 2", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟑", systemImage: "3.square", value: 3) {
                                                        Elevator {
                                                            ForEach(realmManager.p1TasksPriorityThree, id: \.id) { p1TaskItem in
                                                                
                                                                HStack (spacing: 3) {
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1 // will be marked
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p1TaskItem.taskNAME
                                                                                TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                                TaskDate = p1TaskItem.taskDate
                                                                                let priority = p1TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p1TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 1)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p1TaskItem.taskNAME)")
                                                                                    Text("  \(p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p1TaskItem.taskPriority))
                                                                         //.help(Text("\(p1TaskItem.taskNAME)"))
                                                                         //.help(Text(p1TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("Priority 3", systemImage: "3.square") {
                                                    
                                                } // TabView {
                                                .offset(CGSize(width: 0, height: 5))
                                            } else { // if #available(macOS 15.0, *) {
                                                Elevator {
                                                    ForEach(realmManager.p1Tasks, id: \.id) { p1TaskItem in
                                                        
                                                        HStack (spacing: 3) {
                                                            if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1 // will be marked
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                            
                                                            if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p1TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                            
                                                            ZStack {
                                                                Button(
                                                                    action: {
                                                                        CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                        TaskNameText = p1TaskItem.taskNAME
                                                                        TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                        TaskDate = p1TaskItem.taskDate
                                                                        let priority = p1TaskItem.taskPriority
                                                                        TaskPriority = priority
                                                                        pickedPriority = priority
                                                                        
                                                                        let name = p1TaskItem.taskNAME
                                                                        let richtext = loadTexttFromAppStorage2(name)
                                                                        let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                        sharedAppState.textt = str
                                                                        sharedAppState.textt_str = str
                                                                        
                                                                        sharedAppState.anyNewChanges = false
                                                                        sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                        
                                                                        if (!str.string.hasSuffix("  \n")) {
                                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                sharedAppState.added_NEWLINE_CHAR = true
                                                                            }
                                                                        }
                                                                        
                                                                        textEditorIsFocused = true
                                                                        sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                        
                                                                        MDmode = false
                                                                        showListofTasksIfTrueElseTwoEditors(false)

                                                                        sharedAppState.choosenAtleastOneNote = 0
                                                                        resetEditModeValuesAndCountTasksFor(page: 1)
                                                                    },
                                                                    label: {
                                                                        ZStack {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                            Text("                                                                                ")
                                                                            //Text("  \(p1TaskItem.taskNAME)")
                                                                            Text("  \(p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION)")
                                                                                .font(.custom("Avenir", size: 14))
                                                                                .lineLimit(1)
                                                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                        }.frame(height: 30)
                                                                    }
                                                                )//.buttonStyle(InvincibleNothingButton())
                                                                 .buttonStyle(InvincibleNothingButton2(priorityLevel: p1TaskItem.taskPriority))
                                                                 //.help(Text("\(p1TaskItem.taskNAME)"))
                                                                 //.help(Text(p1TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                 .help(Text((p1TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p1TaskItem.taskNAME) : p1TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                            }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                             .shadow(radius: 1.8)
                                                        }.padding(1.5)
                                                    } // ForEach
                                                } // Elevator {
                                            } // End of if #available(macOS 15.0, *) {
                                        } else if $sharedAppState.p2showPageIMPPopUp.wrappedValue {
// MARK: –  PAGE 2 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                            if #available(macOS 15.0, *) {
                                                TabView(selection: $selectionIMPNotesTabView) {
                                                    Tab("𝐀𝐥𝐥", systemImage: "1.square", value: -1) {
                                                        Elevator {
                                                            ForEach(realmManager.p2Tasks, id: \.id) { p2TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p2TaskItem.taskNAME
                                                                                TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                                TaskDate = p2TaskItem.taskDate
                                                                                let priority = p2TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p2TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 2)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p2TaskItem.taskNAME)")
                                                                                    Text("  \(p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p2TaskItem.taskPriority))
                                                                        //.help(Text("\(p2TaskItem.taskNAME)"))
                                                                        //.help(Text(p2TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("All", systemImage: "3.square") {
                                                    
                                                    Tab("𝐧𝐨 priority", systemImage: "1.square", value: 0) {
                                                        Elevator {
                                                            ForEach(realmManager.p2TasksPriorityZero, id: \.id) { p2TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p2TaskItem.taskNAME
                                                                                TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                                TaskDate = p2TaskItem.taskDate
                                                                                let priority = p2TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p2TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 2)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p2TaskItem.taskNAME)")
                                                                                    Text("  \(p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p2TaskItem.taskPriority))
                                                                        //.help(Text("\(p2TaskItem.taskNAME)"))
                                                                        //.help(Text(p2TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("No Priority", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟏", systemImage: "2.square", value: 1) {
                                                        Elevator {
                                                            ForEach(realmManager.p2TasksPriorityOne, id: \.id) { p2TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p2TaskItem.taskNAME
                                                                                TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                                TaskDate = p2TaskItem.taskDate
                                                                                let priority = p2TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p2TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 2)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p2TaskItem.taskNAME)")
                                                                                    Text("  \(p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p2TaskItem.taskPriority))
                                                                        //.help(Text("\(p2TaskItem.taskNAME)"))
                                                                        //.help(Text(p2TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("Priority 1", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟐", systemImage: "3.square", value: 2) {
                                                        Elevator {
                                                            ForEach(realmManager.p2TasksPriorityTwo, id: \.id) { p2TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p2TaskItem.taskNAME
                                                                                TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                                TaskDate = p2TaskItem.taskDate
                                                                                let priority = p2TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p2TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 2)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p2TaskItem.taskNAME)")
                                                                                    Text("  \(p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p2TaskItem.taskPriority))
                                                                        //.help(Text("\(p2TaskItem.taskNAME)"))
                                                                        //.help(Text(p2TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("Priority 2", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟑", systemImage: "3.square", value: 3) {
                                                        Elevator {
                                                            ForEach(realmManager.p2TasksPriorityThree, id: \.id) { p2TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p2TaskItem.taskNAME
                                                                                TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                                TaskDate = p2TaskItem.taskDate
                                                                                let priority = p2TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p2TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 2)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p2TaskItem.taskNAME)")
                                                                                    Text("  \(p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p2TaskItem.taskPriority))
                                                                        //.help(Text("\(p2TaskItem.taskNAME)"))
                                                                        //.help(Text(p2TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    }  // End of Tab("Priority 3", systemImage: "3.square") {
                                                    
                                                } // TabView {
                                                .offset(CGSize(width: 0, height: 5))
                                            } else { // if #available(macOS 15.0, *) {
                                                Elevator {
                                                    ForEach(realmManager.p2Tasks, id: \.id) { p2TaskItem in
                                                        HStack (spacing: 3) {
                                                            
                                                            if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                            
                                                            if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p2TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                            
                                                            ZStack {
                                                                Button(
                                                                    action: {
                                                                        CurrentItemID = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                        TaskNameText = p2TaskItem.taskNAME
                                                                        TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                        TaskDate = p2TaskItem.taskDate
                                                                        let priority = p2TaskItem.taskPriority
                                                                        TaskPriority = priority
                                                                        pickedPriority = priority
                                                                        
                                                                        let name = p2TaskItem.taskNAME
                                                                        let richtext = loadTexttFromAppStorage2(name)
                                                                        let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                        sharedAppState.textt = str
                                                                        sharedAppState.textt_str = str
                                                                        
                                                                        sharedAppState.anyNewChanges = false
                                                                        sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                        
                                                                        if (!str.string.hasSuffix("  \n")) {
                                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                sharedAppState.added_NEWLINE_CHAR = true
                                                                            }
                                                                        }
                                                                        
                                                                        textEditorIsFocused = true
                                                                        sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                        
                                                                        MDmode = false
                                                                        showListofTasksIfTrueElseTwoEditors(false)

                                                                        sharedAppState.choosenAtleastOneNote = 0
                                                                        resetEditModeValuesAndCountTasksFor(page: 2)
                                                                    },
                                                                    label: {
                                                                        ZStack {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                            Text("                                                                                ")
                                                                            //Text("  \(p2TaskItem.taskNAME)")
                                                                            Text("  \(p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION)")
                                                                                .font(.custom("Avenir", size: 14))
                                                                                .lineLimit(1)
                                                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                        }.frame(height: 30)
                                                                    }
                                                                )//.buttonStyle(InvincibleNothingButton())
                                                                .buttonStyle(InvincibleNothingButton2(priorityLevel: p2TaskItem.taskPriority))
                                                                //.help(Text("\(p2TaskItem.taskNAME)"))
                                                                //.help(Text(p2TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                .help(Text((p2TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p2TaskItem.taskNAME) : p2TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                            }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                             .shadow(radius: 1.8)
                                                        }.padding(1.5)
                                                    } // ForEach
                                                } // Elevator {
                                            } // End of if #available(macOS 15.0, *) {
                                        } else if $sharedAppState.p3showPageURGPopUp.wrappedValue {
// MARK: –  PAGE 3 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                            if #available(macOS 15.0, *) {
                                                TabView(selection: $selectionURGNotesTabView) {
                                                    Tab("𝐀𝐥𝐥", systemImage: "1.square", value: -1) {
                                                        Elevator {
                                                            ForEach(realmManager.p3Tasks, id: \.id) { p3TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p3TaskItem.taskNAME
                                                                                TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                                TaskDate = p3TaskItem.taskDate
                                                                                let priority = p3TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p3TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 3)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p3TaskItem.taskNAME)")
                                                                                    Text("  \(p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p3TaskItem.taskPriority))
                                                                        //.help(Text("\(p3TaskItem.taskNAME)"))
                                                                        //.help(Text(p3TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // End of Tab("All", systemImage: "3.square") {
                                                    
                                                    Tab("𝐧𝐨 priority", systemImage: "1.square", value: 0) {
                                                        Elevator {
                                                            ForEach(realmManager.p3TasksPriorityZero, id: \.id) { p3TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p3TaskItem.taskNAME
                                                                                TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                                TaskDate = p3TaskItem.taskDate
                                                                                let priority = p3TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p3TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 3)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p3TaskItem.taskNAME)")
                                                                                    Text("  \(p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p3TaskItem.taskPriority))
                                                                        //.help(Text("\(p3TaskItem.taskNAME)"))
                                                                        //.help(Text(p3TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // End of Tab("No Priority", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟏", systemImage: "2.square", value: 1) {
                                                        Elevator {
                                                            ForEach(realmManager.p3TasksPriorityOne, id: \.id) { p3TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p3TaskItem.taskNAME
                                                                                TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                                TaskDate = p3TaskItem.taskDate
                                                                                let priority = p3TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p3TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 3)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p3TaskItem.taskNAME)")
                                                                                    Text("  \(p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p3TaskItem.taskPriority))
                                                                        //.help(Text("\(p3TaskItem.taskNAME)"))
                                                                        //.help(Text(p3TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // End of Tab("Priority 1", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟐", systemImage: "3.square", value: 2) {
                                                        Elevator {
                                                            ForEach(realmManager.p3TasksPriorityTwo, id: \.id) { p3TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p3TaskItem.taskNAME
                                                                                TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                                TaskDate = p3TaskItem.taskDate
                                                                                let priority = p3TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p3TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 3)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p3TaskItem.taskNAME)")
                                                                                    Text("  \(p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p3TaskItem.taskPriority))
                                                                        //.help(Text("\(p3TaskItem.taskNAME)"))
                                                                        //.help(Text(p3TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // End of Tab("Priority 2", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟑", systemImage: "3.square", value: 3) {
                                                        Elevator {
                                                            ForEach(realmManager.p3TasksPriorityThree, id: \.id) { p3TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p3TaskItem.taskNAME
                                                                                TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                                TaskDate = p3TaskItem.taskDate
                                                                                let priority = p3TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                                
                                                                                let name = p3TaskItem.taskNAME
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 3)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p3TaskItem.taskNAME)")
                                                                                    Text("  \(p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION)")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                        .buttonStyle(InvincibleNothingButton2(priorityLevel: p3TaskItem.taskPriority))
                                                                        //.help(Text("\(p3TaskItem.taskNAME)"))
                                                                        //.help(Text(p3TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                        .help(Text((p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                        .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // End of Tab("Priority 3", systemImage: "3.square") {
                                                    
                                                } // TabView {
                                                .offset(CGSize(width: 0, height: 5))
                                            } else { // if #available(macOS 15.0, *) {
                                                Elevator {
                                                    ForEach(realmManager.p3Tasks, id: \.id) { p3TaskItem in
                                                        HStack (spacing: 3) {
                                                            
                                                            if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                            
                                                            if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p3TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                            
                                                            ZStack {
                                                                Button(
                                                                    action: {
                                                                        CurrentItemID = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                        TaskNameText = p3TaskItem.taskNAME
                                                                        TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                        TaskDate = p3TaskItem.taskDate
                                                                        let priority = p3TaskItem.taskPriority
                                                                        TaskPriority = priority
                                                                        pickedPriority = priority
                                                                        
                                                                        let name = p3TaskItem.taskNAME
                                                                        let richtext = loadTexttFromAppStorage2(name)
                                                                        let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                        sharedAppState.textt = str
                                                                        sharedAppState.textt_str = str
                                                                        
                                                                        sharedAppState.anyNewChanges = false
                                                                        sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                        
                                                                        if (!str.string.hasSuffix("  \n")) {
                                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                sharedAppState.added_NEWLINE_CHAR = true
                                                                            }
                                                                        }
                                                                        
                                                                        textEditorIsFocused = true
                                                                        sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                        
                                                                        MDmode = false
                                                                        showListofTasksIfTrueElseTwoEditors(false)

                                                                        sharedAppState.choosenAtleastOneNote = 0
                                                                        resetEditModeValuesAndCountTasksFor(page: 3)
                                                                    },
                                                                    label: {
                                                                        ZStack {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                            Text("                                                                                ")
                                                                            //Text("  \(p3TaskItem.taskNAME)")
                                                                            Text("  \(p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION)")
                                                                                .font(.custom("Avenir", size: 14))
                                                                                .lineLimit(1)
                                                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                        }.frame(height: 30)
                                                                    }
                                                                )//.buttonStyle(InvincibleNothingButton())
                                                                .buttonStyle(InvincibleNothingButton2(priorityLevel: p3TaskItem.taskPriority))
                                                                //.help(Text("\(p3TaskItem.taskNAME)"))
                                                                //.help(Text(p3TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                .help(Text((p3TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p3TaskItem.taskNAME) : p3TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                            }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                             .shadow(radius: 1.8)
                                                        }.padding(1.5)
                                                    } // ForEach
                                                } // Elevator {
                                            } // End of if #available(macOS 15.0, *) {
                                        } else if $sharedAppState.p4showPageNOTHINGPopUp.wrappedValue {
// MARK: –  PAGE 4 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                           if #available(macOS 15.0, *) {
                                                TabView(selection: $selectionNOTHINGNotesTabView) {
                                                    Tab("𝐀𝐥𝐥", systemImage: "1.square", value: -1) {
                                                        Elevator {
                                                            ForEach(realmManager.p4Tasks, id: \.id) { p4TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p4TaskItem.taskNAME
                                                                                TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                                TaskDate = p4TaskItem.taskDate
                                                                                let priority = p4TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                            
                                                                                let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 4)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p4TaskItem.taskNAME)")
                                                                                    //Text("  \(String(data: Data(base64Encoded: p4TaskItem.taskNAME) ?? Data(), encoding: .utf8) ?? p4TaskItem.taskNAME)")
                                                                                    Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                                    //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                    /*HStack {
                                                                                         Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                                         //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                             .font(.custom("Avenir", size: 14))
                                                                                             .lineLimit(1)
                                                                                             .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                             .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                         Button(
                                                                                             action: {
                                                                                                 let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                                                 let richtext = loadTexttFromAppStorage2(name)
                                                                                                 let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                                 sharedAppState.preview_textt = recolorAttributedString(str)
                                                                                                 sharedAppState.preview_noteID = p4TaskItem.id
                                                                                                 sharedAppState.preview_noteBelongsToPage = 4
                                                                                                 PreviewNoteWindowManager.shared.openPrevieWindow(sharedAppState)
                                                                                             },
                                                                                             label: {
                                                                                                 HStack (spacing: 0) {
                                                                                                     /*if #available(macOS 14.0, *) {
                                                                                                         Image(systemName: "macbook.and.ipad")
                                                                                                             .symbolEffect(.pulse, options: .repeating, isActive: false)
                                                                                                             //.contentTransition(.symbolEffect(.replace))
                                                                                                     } else {
                                                                                                         Image(systemName: "macbook.and.ipad")
                                                                                                     }*/
                                                                                                     Image(systemName: "macbook.and.ipad")
                                                                                                 }.foregroundColor(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                     //.background(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                             }
                                                                                         )
                                                                                     }
                                                                                     */
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p4TaskItem.taskPriority))
                                                                         //.help(Text("\(p4TaskItem.taskNAME)"))
                                                                         //.help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         //.help(Text(p4TaskItem.taskDESCRIPTION.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // Tab("All", systemImage: "3.square") {

                                                    Tab("𝐧𝐨 priority", systemImage: "1.square", value: 0) {
                                                        Elevator {
                                                            ForEach(realmManager.p4TasksPriorityZero, id: \.id) { p4TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p4TaskItem.taskNAME
                                                                                TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                                TaskDate = p4TaskItem.taskDate
                                                                                let priority = p4TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                            
                                                                                let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 4)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p4TaskItem.taskNAME)")
                                                                                    //Text("  \(String(data: Data(base64Encoded: p4TaskItem.taskNAME) ?? Data(), encoding: .utf8) ?? p4TaskItem.taskNAME)")
                                                                                    Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                                    //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p4TaskItem.taskPriority))
                                                                         //.help(Text("\(p4TaskItem.taskNAME)"))
                                                                         //.help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         //.help(Text(p4TaskItem.taskDESCRIPTION.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // Tab("No Priority", systemImage: "1.square") {
                                                    
                                                    Tab("priority  𝟏", systemImage: "2.square", value: 1) {
                                                        Elevator {
                                                            ForEach(realmManager.p4TasksPriorityOne, id: \.id) { p4TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p4TaskItem.taskNAME
                                                                                TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                                TaskDate = p4TaskItem.taskDate
                                                                                let priority = p4TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                            
                                                                                let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 4)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p4TaskItem.taskNAME)")
                                                                                    //Text("  \(String(data: Data(base64Encoded: p4TaskItem.taskNAME) ?? Data(), encoding: .utf8) ?? p4TaskItem.taskNAME)")
                                                                                    Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                                    //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p4TaskItem.taskPriority))
                                                                         //.help(Text("\(p4TaskItem.taskNAME)"))
                                                                         //.help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         //.help(Text(p4TaskItem.taskDESCRIPTION.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // Tab("Priority 1", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟐", systemImage: "3.square", value: 2) {
                                                        Elevator {
                                                            ForEach(realmManager.p4TasksPriorityTwo, id: \.id) { p4TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p4TaskItem.taskNAME
                                                                                TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                                TaskDate = p4TaskItem.taskDate
                                                                                let priority = p4TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                            
                                                                                let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 4)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p4TaskItem.taskNAME)")
                                                                                    //Text("  \(String(data: Data(base64Encoded: p4TaskItem.taskNAME) ?? Data(), encoding: .utf8) ?? p4TaskItem.taskNAME)")
                                                                                    Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                                    //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p4TaskItem.taskPriority))
                                                                         //.help(Text("\(p4TaskItem.taskNAME)"))
                                                                         //.help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         //.help(Text(p4TaskItem.taskDESCRIPTION.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // Tab("Priority 2", systemImage: "3.square") {
                                                    
                                                    Tab("priority  𝟑", systemImage: "3.square", value: 3) {
                                                        Elevator {
                                                            ForEach(realmManager.p4TasksPriorityThree, id: \.id) { p4TaskItem in
                                                                HStack (spacing: 3) {
                                                                    
                                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                    
                                                                    if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                        VStack (spacing: 0) {
                                                                            Button(
                                                                                action: {
                                                                                    let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                                    isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                                    
                                                                                    if (isMarked) {
                                                                                        sharedAppState.choosenAtleastOneNote += 1
                                                                                    } else {
                                                                                        sharedAppState.choosenAtleastOneNote -= 1
                                                                                    }
                                                                                    
                                                                                    if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                        callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                                    } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                        realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                    } else {
                                                                                        if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                            setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                        }
                                                                                    }
                                                                                },
                                                                                label: {
                                                                                    Text("    ")
                                                                                }
                                                                            ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                        }.frame(width: 17)
                                                                    } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                    
                                                                    ZStack {
                                                                        Button(
                                                                            action: {
                                                                                CurrentItemID = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                                TaskNameText = p4TaskItem.taskNAME
                                                                                TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                                TaskDate = p4TaskItem.taskDate
                                                                                let priority = p4TaskItem.taskPriority
                                                                                TaskPriority = priority
                                                                                pickedPriority = priority
                                                                            
                                                                                let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                                sharedAppState.textt = str
                                                                                sharedAppState.textt_str = str
                                                                                
                                                                                sharedAppState.anyNewChanges = false
                                                                                sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                                
                                                                                if (!str.string.hasSuffix("  \n")) {
                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                        sharedAppState.added_NEWLINE_CHAR = true
                                                                                    }
                                                                                }
                                                                                
                                                                                textEditorIsFocused = true
                                                                                sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                                
                                                                                MDmode = false
                                                                                showListofTasksIfTrueElseTwoEditors(false)

                                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                                resetEditModeValuesAndCountTasksFor(page: 4)
                                                                            },
                                                                            label: {
                                                                                ZStack {
                                                                                    RoundedRectangle(cornerRadius: 8)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                                    Text("                                                                                ")
                                                                                    //Text("  \(p4TaskItem.taskNAME)")
                                                                                    //Text("  \(String(data: Data(base64Encoded: p4TaskItem.taskNAME) ?? Data(), encoding: .utf8) ?? p4TaskItem.taskNAME)")
                                                                                    Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                                    //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                        .font(.custom("Avenir", size: 14))
                                                                                        .lineLimit(1)
                                                                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                        .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                                }.frame(height: 30)
                                                                            }
                                                                        )//.buttonStyle(InvincibleNothingButton())
                                                                         .buttonStyle(InvincibleNothingButton2(priorityLevel: p4TaskItem.taskPriority))
                                                                         //.help(Text("\(p4TaskItem.taskNAME)"))
                                                                         //.help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         //.help(Text(p4TaskItem.taskDESCRIPTION.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                         .help(Text((p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                                    }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                                     .shadow(radius: 1.8)
                                                                }.padding(1.5)
                                                            } // ForEach
                                                        } // Elevator {
                                                    } // Tab("Priority 3", systemImage: "3.square") {
                                                    
                                                } // TabView {
                                                //.clearTabViewBackground()
                                                .offset(CGSize(width: 0, height: 5))
                                                //.offset(CGSize(width: 0, height: -20))
                                                //.tabViewStyle(.automatic)
                                                //.tabViewStyle(.tabBarOnly)
                                                //.tabViewStyle(.grouped)
                                                //.border(Color.gray)
                                                /*.safeAreaInset(edge: .bottom) {
                                                    HStack(spacing: 50) {
                                                        Image(systemName: "person")
                                                            .symbolEffect(.pulse, options: .repeating, isActive: true)
                                                            .font(.title2)
                                                            .foregroundStyle(.blue)
                                                            .padding(.bottom)
                                                            .onTapGesture {
                                                                selectionNOTHINGNotesTabView = 1
                                                            }
                                                        
                                                        Image(systemName: "star")
                                                            .symbolEffect(.pulse, options: .repeating, isActive: true)
                                                            .font(.title2)
                                                            .foregroundStyle(.blue)
                                                            .padding(.bottom)
                                                            .onTapGesture {
                                                                selectionNOTHINGNotesTabView = 3
                                                            }
                                                    }
                                                }
                                             */
                                            } else { // if #available(macOS 15.0, *) {
                                                Elevator {
                                                    ForEach(realmManager.p4Tasks, id: \.id) { p4TaskItem in
                                                        HStack (spacing: 3) {
                                                            
                                                            if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                            
                                                            if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                                VStack (spacing: 0) {
                                                                    Button(
                                                                        action: {
                                                                            let isMarked: Bool = (p4TaskItem.isCurrentlyMarked == false)
                                                                            isMarked ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                            
                                                                            if (isMarked) {
                                                                                sharedAppState.choosenAtleastOneNote += 1
                                                                            } else {
                                                                                sharedAppState.choosenAtleastOneNote -= 1
                                                                            }
                                                                            
                                                                            if sharedAppState.Sorted && !sharedAppState.Showing {
                                                                                callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                                                                                realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                            } else {
                                                                                if sharedAppState.Showing && !sharedAppState.Sorted {
                                                                                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                                }
                                                                            }
                                                                        },
                                                                        label: {
                                                                            Text("    ")
                                                                        }
                                                                    ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                                }.frame(width: 17)
                                                            } // if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) {
                                                            
                                                            ZStack {
                                                                Button(
                                                                    action: {
                                                                        CurrentItemID = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                        TaskNameText = p4TaskItem.taskNAME
                                                                        TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                        TaskDate = p4TaskItem.taskDate
                                                                        let priority = p4TaskItem.taskPriority
                                                                        TaskPriority = priority
                                                                        pickedPriority = priority
                                                                    
                                                                        let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                        let richtext = loadTexttFromAppStorage2(name)
                                                                        let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                        sharedAppState.textt = str
                                                                        sharedAppState.textt_str = str
                                                                        
                                                                        sharedAppState.anyNewChanges = false
                                                                        sharedAppState.anyNewChangesInOnlyTextColor = false
                                                                        
                                                                        if (!str.string.hasSuffix("  \n")) {
                                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                                                sharedAppState.added_NEWLINE_CHAR = true
                                                                            }
                                                                        }
                                                                        
                                                                        //print_to_debug_window_SEQUENTIAL("📍 START Button() ForEach(realmManager.p4Tasks before textEditorIsFocused = true")
                                                                        //print_to_debug_window_ASYNC("📍 START/EnD Button() ForEach(realmManager.p4Tasks before textEditorIsFocused = true –> DispatchQueue.main.async {")
                                                                        
                                                                        textEditorIsFocused = true
                                                                        sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                                                        
                                                                        //print_to_debug_window_SEQUENTIAL("📍 START Button() ForEach(realmManager.p4Tasks after textEditorIsFocused = true")
                                                                        //print_to_debug_window_ASYNC("📍 START2/END Button() ForEach(realmManager.p4Tasks after textEditorIsFocused = true –> DispatchQueue.main.async {")
                                                                        
                                                                        MDmode = false
                                                                        showListofTasksIfTrueElseTwoEditors(false)

                                                                        sharedAppState.choosenAtleastOneNote = 0
                                                                        resetEditModeValuesAndCountTasksFor(page: 4)
                                                                        
                                                                        //print_to_debug_window_SEQUENTIAL("     END Button() ForEach(realmManager.p4Tasks")
                                                                    },
                                                                    label: {
                                                                        ZStack {
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                                            Text("                                                                                ")
                                                                            //Text("  \(p4TaskItem.taskNAME)")
                                                                            //Text("  \(String(data: Data(base64Encoded: p4TaskItem.taskNAME) ?? Data(), encoding: .utf8) ?? p4TaskItem.taskNAME)")
                                                                            
                                                                            Text("  \(p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION)")
                                                                            //Text("  \(loadTexttFromAppStorage3(p4TaskItem.taskDESCRIPTION))")
                                                                                .font(.custom("Avenir", size: 14))
                                                                                .lineLimit(1)
                                                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                                .foregroundColor(sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                        }.frame(height: 30)
                                                                    }
                                                                )//.buttonStyle(InvincibleNothingButton())
                                                                 .buttonStyle(InvincibleNothingButton2(priorityLevel: p4TaskItem.taskPriority))
                                                                 //.help(Text("\(p4TaskItem.taskNAME)"))
                                                                 //.help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                 //.help(Text(p4TaskItem.taskDESCRIPTION.insertingLineBreaks(every: 50).truncatedToLines()))
                                                                 .help(Text((p4TaskItem.taskDESCRIPTION.isEmpty ? loadTexttFromAppStorage3(p4TaskItem.taskNAME) : p4TaskItem.taskDESCRIPTION).insertingLineBreaks(every: 50).truncatedToLines()))
                                                            }.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                             .shadow(radius: 1.8)
                                                        }.padding(1.5)
                                                    } // ForEach
                                                } // Elevator {
                                            } // End of Else if #available(macOS 15.0, *) {
                                        } // MARK: – för if $p4showPageNOTHINGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) {
                                    }.frame(width: 495, height: 620) //.frame(width: 555, height: 540) //.frame(width: 395, height: 540) //.frame(width: 305, height: 410)   /* hur stor ska listan vara */
                                     .background(sharedAppState.darkMode ? Color.ListPageBackgroundDarkMode : Color.ListPageBackgroundLightMode)
                                     //.background(sharedAppState.darkMode ? Color.ListPageBackgroundDarkMode2 : Color.ListPageBackgroundLightMode2)
                                     .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)) // MARK: 🌈 bestämmer shapen på List Backgrounder (i.e. denna ZStacken)
                                     //.shadow(radius: 4) // MARK: 🌈 shadow runt ZStacken som är List backgrounden
                                     /*.shadow(color: sharedAppState.darkMode ? Color.ListElevatorShadowDarkModeUP: Color.ListElevatorShadowLightModeUP, radius: 2, x: -1, y: -1) // MARK: Elevator – 🌈 shadow runt Listan med Itemsen
                                     .shadow(color: sharedAppState.darkMode ? Color.ListElevatorShadowDarkModeDOWN : Color.ListElevatorShadowLightModeDOWN, radius: 2, x: 1, y: 1) // MARK: Elevator – 🌈 shadow runt Listan med Itemsen */
                                     .shadow(color: sharedAppState.darkMode ? Color.ListElevatorShadowDarkModeDOWN : Color.ListElevatorShadowLightModeUP, radius: 4, x: 0, y: 0)
                                
                                 
                                    Button(
                                        action: {
                                            let onThepage = sharedAppState.isOnPage
                                            show2(pageItemList: 0)
                                            
                                            if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                                                sharedAppState.ShowSortRequirementAfterUnshow = true
                                                sharedAppState.ShowFilterAndSortMode = false
                                                sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
                                            }
                                            
                                            sharedAppState.choosenAtleastOneNote = 0
                                            resetEditModeValuesAndCountTasksFor2(page: onThepage)
                                            sharedAppState.SetTheViewingStateOfAPageInRealm(forPage: onThepage)
                                        },
                                        label: {
                                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                                .font(.system(size: 25))
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.neuOrangeLight)
                                                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                .frame(width: 462, height: 9) //.frame(width: 522, height: 9) //.frame(width: 362, height: 9) //.frame(width: 272, height: 9) // MARK: –  RedbackButton 🌈 styra storleken direkt med värden för Bilden
                                        }
                                    ).buttonStyle(RedBackButton())
                                }
                            }
                            .onChange(of: sharedAppState.addedOneTask) { newValue in
                                //print_to_debug_window_SEQUENTIAL("📍 START .onChange(of: sharedAppState.addedOneTask) {")
                                //print_to_debug_window_ASYNC("📍 START/END .onChange(of: sharedAppState.addedOneTask) { –> DispatchQueue.main.async {")
                                
                                let page = sharedAppState.isOnPage
                                
                                if page == 1 {
                                    CurrentItemID = realmManager.p1Tasks[0].id
                                    TaskNameText = realmManager.p1Tasks[0].taskNAME
                                    TaskDescriptionText = realmManager.p1Tasks[0].taskDESCRIPTION
                                    TaskDate = realmManager.p1Tasks[0].taskDate
                                    let priority = realmManager.p1Tasks[0].taskPriority
                                    TaskPriority = priority
                                    pickedPriority = priority
                                    
                                    let str = loadTexttFromAppStorage3()
                                    sharedAppState.textt = str
                                    sharedAppState.textt_str = str
                                    sharedAppState.currentNoteIsNew = true
                                    
                                    sharedAppState.anyNewChanges = false
                                    sharedAppState.anyNewChangesInOnlyTextColor = false
                                    
                                    textEditorIsFocused = true
                                    sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                    
                                    MDmode = false
                                    showListofTasksIfTrueElseTwoEditors(false)
                                    
                                    sharedAppState.choosenAtleastOneNote = 0
                                    resetEditModeValuesAndCountTasksFor(page: page)
                                } else if page == 2 {
                                    CurrentItemID = realmManager.p2Tasks[0].id
                                    TaskNameText = realmManager.p2Tasks[0].taskNAME
                                    TaskDescriptionText = realmManager.p2Tasks[0].taskDESCRIPTION
                                    TaskDate = realmManager.p2Tasks[0].taskDate
                                    let priority = realmManager.p2Tasks[0].taskPriority
                                    TaskPriority = priority
                                    pickedPriority = priority
                                    
                                    let str = loadTexttFromAppStorage3()
                                    sharedAppState.textt = str
                                    sharedAppState.textt_str = str
                                    sharedAppState.currentNoteIsNew = true
                                    
                                    sharedAppState.anyNewChanges = false
                                    sharedAppState.anyNewChangesInOnlyTextColor = false
                                    
                                    textEditorIsFocused = true
                                    sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                    
                                    MDmode = false
                                    showListofTasksIfTrueElseTwoEditors(false)
                                    
                                    sharedAppState.choosenAtleastOneNote = 0
                                    resetEditModeValuesAndCountTasksFor(page: page)
                                } else if page == 3 {
                                    CurrentItemID = realmManager.p3Tasks[0].id
                                    TaskNameText = realmManager.p3Tasks[0].taskNAME
                                    TaskDescriptionText = realmManager.p3Tasks[0].taskDESCRIPTION
                                    TaskDate = realmManager.p3Tasks[0].taskDate
                                    let priority = realmManager.p3Tasks[0].taskPriority
                                    TaskPriority = priority
                                    pickedPriority = priority
                                    
                                    let str = loadTexttFromAppStorage3()
                                    sharedAppState.textt = str
                                    sharedAppState.textt_str = str
                                    sharedAppState.currentNoteIsNew = true
                                    
                                    sharedAppState.anyNewChanges = false
                                    sharedAppState.anyNewChangesInOnlyTextColor = false
                                    
                                    textEditorIsFocused = true
                                    sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                    
                                    MDmode = false
                                    showListofTasksIfTrueElseTwoEditors(false)
                                    
                                    sharedAppState.choosenAtleastOneNote = 0
                                    resetEditModeValuesAndCountTasksFor(page: page)
                                } else if page == 4 {
                                    CurrentItemID = realmManager.p4Tasks[0].id
                                    TaskNameText = realmManager.p4Tasks[0].taskNAME
                                    TaskDescriptionText = realmManager.p4Tasks[0].taskDESCRIPTION
                                    TaskDate = realmManager.p4Tasks[0].taskDate
                                    let priority = realmManager.p4Tasks[0].taskPriority
                                    TaskPriority = priority
                                    pickedPriority = priority
                                    
                                    let str = loadTexttFromAppStorage3()
                                    sharedAppState.textt = str
                                    sharedAppState.textt_str = str
                                    sharedAppState.currentNoteIsNew = true
                                    
                                    sharedAppState.anyNewChanges = false
                                    sharedAppState.anyNewChangesInOnlyTextColor = false
                                    
                                    textEditorIsFocused = true
                                    sharedAppState.textEditorJustOpenedAndBecameFocused = true
                                    
                                    MDmode = false
                                    showListofTasksIfTrueElseTwoEditors(false)
                                    
                                    sharedAppState.choosenAtleastOneNote = 0
                                    resetEditModeValuesAndCountTasksFor(page: page)
                                }
                                //print_to_debug_window_SEQUENTIAL("📍 END .onChange(of: sharedAppState.addedOneTask) {")
                                //print_to_debug_window_ASYNC("  END/START2 .onChange(of: sharedAppState.addedOneTask) { –> DispatchQueue.main.async {")
                            }
                        }.frame(width: 480, height: 625) //.frame(width: 550, height: 625) //.frame(width: 390, height: 625) //.frame(width: 305, height: 495) // VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                    } // Avslut för if !($ShowEditor.wrappedValue) {
                    
// MARK: – 💧📺  2Editor Page💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                    if $ShowEditor.wrappedValue {
                        VStack (spacing: 2) { // väljer avståndet mellan (Elevator + ForEach)} och Den .bottom HStacken som har SAVE och .md
                            
                            VStack (spacing: 0) {
                                VStack {
                                    ZStack {
                                        
// MARK: – Top RichText Hidden attributes Buttons
                                        VStack (spacing: 1) {
                                            Spacer()
                                                .frame(height: 600)
                                            HStack (spacing: 10) {
                                                Button(
                                                    action: {
                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                        
                                                        if (context.hasSelectedRange) {
                                                            DispatchQueue.main.async {
                                                                //let len_check = sharedAppState.textt.attributedString.length
                                                                let cursor_position_UPP = context.selectedRange.upperBound
                                                                let cursor_position_LOW = context.selectedRange.lowerBound
                                                                let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                let emptyRange = NSRange(location: cursor_position_LOW, length: 0)
                                                                
                                                                let copy = sharedAppState.textt.attributedSubstring(from: initialUserSelectionRange).string
                                                                copyToPasteboard(copy)
                                                                
                                                                context.handle(.setAttributedString(recolorAttributedString(ensureSuffixWithSpacesAndNewline(removingText(in: sharedAppState.textt, range: initialUserSelectionRange)))))
                                                                
                                                                context.resetSelectedRange()
                                                                context.trigger(.selectRange(emptyRange))
                                                                
                                                                //context.resetSelectedRange()
                                                                
                                                                sharedAppState.anyNewChanges = true
                                                                
                                                                sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                            }
                                                        } else {
                                                            withAnimation {
                                                                sharedAppState.showToast = true
                                                            }
                                                        }
                                                    },
                                                    label: {
                                                        Text("Cut")
                                                            .font(.system(size: 13))
                                                            .frame(width: 28, height: 15.5)
                                                    }
                                                ).buttonStyle(ClearImageBackground3())
                                                 .disabled(!textEditorIsFocused)
                                                 .keyboardShortcut("x", modifiers: [.command])
                                                
                                                Button(
                                                    action: {
                                                        if (context.hasSelectedRange) {
                                                            //DispatchQueue.main.async {
                                                                let cursor_position_UPP = context.selectedRange.upperBound
                                                                let cursor_position_LOW = context.selectedRange.lowerBound
                                                                let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                
                                                                let copy = sharedAppState.textt.attributedSubstring(from: initialUserSelectionRange).string
                                                                copyToPasteboard(copy)
                                                                
                                                                /*context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline2(sharedAppState.textt)))
                                                                context.resetSelectedRange()
                                                                context.trigger(.selectRange(initialUserSelectionRange))
                                                                */
                                                                sharedAppState.triggerTextHasSuffixCheckuppInRichTextEditor.toggle()
                                                                //context.handle(.setAttributedString(recolorAttributedString(sharedAppState.textt)))
                                                                //printAttributedStringDetails(sharedAppState.textt)
                                                                //context.handle(.setAttributedString(outlinedAttributedString(from: sharedAppState.textt, strokeColor: .systemRed, strokeWidthPercent: 10.0, fontScale: 2.0)))
                                                                //context.handle(.setAttributedString(boldWhiteWithDropShadow(from: sharedAppState.textt)))
                                                            //}
                                                        } else {
                                                            //context.fontName = name
                                                            withAnimation {
                                                                sharedAppState.showToast = true
                                                            }
                                                        }
                                                    },
                                                    label: {
                                                        Text("Copy")
                                                            .font(.system(size: 13))
                                                            .frame(width: 28, height: 15.5)
                                                    }
                                                ).buttonStyle(ClearImageBackground3())
                                                 .disabled(!textEditorIsFocused)
                                                 .keyboardShortcut("c", modifiers: [.command])
                                                
                                                Button(
                                                    action: {
                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                        
                                                        let paste = pasteFromPasteboard()
                                                        if (context.hasSelectedRange) {
                                                            DispatchQueue.main.async {
                                                                let cursor_position_UPP = context.selectedRange.upperBound
                                                                let cursor_position_LOW = context.selectedRange.lowerBound
                                                                let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                
                                                                let deleteSelectedRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                let removed_txt = ensureSuffixWithSpacesAndNewline(removingText(in: sharedAppState.textt, range: deleteSelectedRange))
                                                                context.handle(.setAttributedString(recolorAttributedString(insertStringPreservingAttributes(in: removed_txt, at: cursor_position_LOW, stringToInsert: paste))))
                                                                
                                                                let len_Cursor = cursor_position_LOW + paste.count
                                                                //let newCursorPosition = NSRange(location: len_Cursor, length: 0)
                                                                //let newCursorPosition = NSRange(location: cursor_position_LOW, length: len_Cursor)
                                                                let newCursorPosition = NSRange(location: len_Cursor, length: 0)
                                                                context.trigger(.selectRange(newCursorPosition))
                                                                
                                                                //context.resetSelectedRange()
                                                                
                                                                sharedAppState.anyNewChanges = true
                                                                
                                                                sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                            }
                                                        } else { // if (❗️context.hasSelectedRange) {
                                                            DispatchQueue.main.async {
                                                                let cursorPosition = context.selectedRange.location // This is always the caret position if no selection
                                                                    
                                                                context.handle(.setAttributedString(recolorAttributedString(ensureSuffixWithSpacesAndNewline(insertStringPreservingAttributes(in: sharedAppState.textt, at: cursorPosition, stringToInsert: paste)))))
                                                                let len_Cursor = cursorPosition + paste.count
                                                                let newCursorPosition = NSRange(location: len_Cursor, length: 0)
                                                                context.trigger(.selectRange(newCursorPosition))
                                                                
                                                                //context.resetSelectedRange()
                                                                
                                                                sharedAppState.anyNewChanges = true
                                                                
                                                                sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                            }
                                                        }
                                                    },
                                                    label: {
                                                        Text("Paste")
                                                            .font(.system(size: 13))
                                                            .frame(width: 28, height: 15.5)
                                                    }
                                                ).buttonStyle(ClearImageBackground3())
                                                 .disabled(!textEditorIsFocused)
                                                 .keyboardShortcut("v", modifiers: [.command])
                                            }
                                        }.frame(width: 495, height: 664)
                                        
// MARK: – Top RichText Visible Edit attributes Buttons
                                        VStack (spacing: 1) {
                                            HStack (spacing: 10) {
                                                
                                                VStack {
                                                    HStack (spacing: 0) {
                                                        if $sharedAppState.popOverHasBeenDetachedByUser.wrappedValue {
                                                            Spacer().frame(width: 7.00, height: 3.00)
                                                        }
                                                        if (context.hasSelectedRange) {
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        //DispatchQueue.main.async {
                                                                            let cursor_position_UPP = context.selectedRange.upperBound
                                                                            let cursor_position_LOW = context.selectedRange.lowerBound
                                                                            let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                            let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                            
                                                                            let copy = sharedAppState.textt.attributedSubstring(from: initialUserSelectionRange).string
                                                                            copyToPasteboard(copy)
                                                                            
                                                                            /*context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline2(sharedAppState.textt)))
                                                                            context.resetSelectedRange()
                                                                            context.trigger(.selectRange(initialUserSelectionRange))
                                                                            */
                                                                            sharedAppState.triggerTextHasSuffixCheckuppInRichTextEditor.toggle()
                                                                            //context.handle(.setAttributedString(recolorAttributedString(sharedAppState.textt)))
                                                                            //printAttributedStringDetails(sharedAppState.textt)
                                                                            //context.handle(.setAttributedString(outlinedAttributedString(from: sharedAppState.textt, strokeColor: .systemRed, strokeWidthPercent: 10.0, fontScale: 2.0)))
                                                                            //context.handle(.setAttributedString(boldWhiteWithDropShadow(from: sharedAppState.textt)))
                                                                        //}
                                                                    } else {
                                                                        //context.fontName = name
                                                                        withAnimation {
                                                                            sharedAppState.showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Text("Copy ")
                                                                        /*.font(.system(size: 13))
                                                                        .frame(width: 28, height: 15.5)*/
                                                                        .foregroundColor(textEditorIsFocused ? Color.BlueEdit : Color.neuGrayButtonDisable)
                                                                        .bold()
                                                                        .font(sharedAppState.popOverHasBeenDetachedByUser ? .subheadline : .headline)
                                                                        .frame(alignment: .leading)
                                                                }
                                                            ).buttonStyle(ClearImageBackground3())
                                                             .disabled(!textEditorIsFocused)
                                                            //.disabled(!$textEditorIsFocused.wrappedValue)
                                                             /*.onCopyCommand {
                                                                 // Play system sound
                                                                 DispatchQueue.main.async {
                                                                     NSSound(named: "Pop")?.play()
                                                                 }
                                                             }*/
                                                        }
                                                        if (!context.hasSelectedRange) {
                                                            Button(
                                                                action: {
                                                                    sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                    
                                                                    let paste = pasteFromPasteboard()
                                                                    if (context.hasSelectedRange) {
                                                                        DispatchQueue.main.async {
                                                                            let cursor_position_UPP = context.selectedRange.upperBound
                                                                            let cursor_position_LOW = context.selectedRange.lowerBound
                                                                            let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                            
                                                                            let deleteSelectedRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                            let removed_txt = ensureSuffixWithSpacesAndNewline(removingText(in: sharedAppState.textt, range: deleteSelectedRange))
                                                                            context.handle(.setAttributedString(recolorAttributedString(insertStringPreservingAttributes(in: removed_txt, at: cursor_position_LOW, stringToInsert: paste))))
                                                                            
                                                                            let len_Cursor = cursor_position_LOW + paste.count
                                                                            //let newCursorPosition = NSRange(location: len_Cursor, length: 0)
                                                                            //let newCursorPosition = NSRange(location: cursor_position_LOW, length: len_Cursor)
                                                                            let newCursorPosition = NSRange(location: len_Cursor, length: 0)
                                                                            context.trigger(.selectRange(newCursorPosition))
                                                                            
                                                                            //context.resetSelectedRange()
                                                                            
                                                                            sharedAppState.anyNewChanges = true
                                                                            
                                                                            sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                        }
                                                                    } else { // if (❗️context.hasSelectedRange) {
                                                                        DispatchQueue.main.async {
                                                                            let cursorPosition = context.selectedRange.location // This is always the caret position if no selection
                                                                                
                                                                            context.handle(.setAttributedString(recolorAttributedString(ensureSuffixWithSpacesAndNewline(insertStringPreservingAttributes(in: sharedAppState.textt, at: cursorPosition, stringToInsert: paste)))))
                                                                            let len_Cursor = cursorPosition + paste.count
                                                                            let newCursorPosition = NSRange(location: len_Cursor, length: 0)
                                                                            context.trigger(.selectRange(newCursorPosition))
                                                                            
                                                                            //context.resetSelectedRange()
                                                                            
                                                                            sharedAppState.anyNewChanges = true
                                                                            
                                                                            sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Text("Paste")
                                                                        /*.font(.system(size: 13))
                                                                        .frame(width: 28, height: 15.5)*/
                                                                        .foregroundColor(textEditorIsFocused ? Color.BlueEdit : Color.neuGrayButtonDisable)
                                                                        .bold()
                                                                        .font(sharedAppState.popOverHasBeenDetachedByUser ? .subheadline : .headline)
                                                                        .frame(alignment: .leading)
                                                                }
                                                            ).buttonStyle(ClearImageBackground3())
                                                             .disabled(!textEditorIsFocused)
                                                        }
                                                        
                                                        //Spacer()
                                                    }
                                                    Spacer()
                                                }.frame(width: 40, height: 50)
                                                 .offset(CGSize(width: -15.00, height: 1.00))
                                                
                                                VStack {
                                                    HStack (spacing: 0) {
                                                        Button(
                                                            action: {
                                                                if (context.hasSelectedRange) {
                                                                    sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                    
                                                                    DispatchQueue.main.async {
                                                                        /*if (context.binding(for: .bold).wrappedValue) {
                                                                            context.handle(.setStyle(.bold, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.bold, true))
                                                                        }*/
                                                                        /*context.styles.hasStyle(.bold)
                                                                        context.handle(.setStyle(.bold, true))
                                                                        */
                                                                        
                                                                        let cursor_position_UPP = context.selectedRange.upperBound
                                                                        let cursor_position_LOW = context.selectedRange.lowerBound
                                                                        let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                        let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                        
                                                                        if (context.binding(for: .bold).wrappedValue) {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleBold2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, makeBold: false))))
                                                                        } else {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleBold2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, makeBold: true))))
                                                                        }
                                                                        
                                                                        context.resetSelectedRange()
                                                                        
                                                                        //context.handle(.selectRange(emptyRange))
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        context.handle(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        
                                                                        //context.resetSelectedRange()
                                                                        
                                                                        //context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(sharedAppState.textt)))
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        
                                                                        sharedAppState.anyNewChanges = true
                                                                        
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                    }
                                                                } else {
                                                                    //context.fontName = name
                                                                    withAnimation {
                                                                        sharedAppState.showToast = true
                                                                    }
                                                                }
                                                            },
                                                            label: {
                                                                Image(systemName: "bold")
                                                                    .font(.system(size: 14))
                                                                    .frame(width: 28, height: 19.5)
                                                                    .foregroundColor(sharedAppState.darkMode ? .white : .black)
                                                                    .padding(2)
                                                                    .background(context.binding(for: .bold).wrappedValue ?
                                                                                Color.accentColor.opacity(0.91) : (sharedAppState.darkMode ? Color.generalButtonsBackgroundColorDarkMode : Color.generalButtonsBackgroundColorLightMode))
                                                                    //.clipShape(Circle())
                                                                    .clipShape(Rectangle())
                                                                    /*.onTapGesture {
                                                                        withAnimation {
                                                                            sharedAppState.showToast = true
                                                                        }
                                                                    }*/
                                                            }
                                                        ).buttonStyle(ClearImageBackground3())
                                                         .disabled(!textEditorIsFocused)
                                                         .keyboardShortcut("b", modifiers: [.command])
                                                        
                                                        Divider()
                                                            .frame(width: 1, height: 19)
                                                            .background(sharedAppState.darkMode ? .black : Color.neuGray2)
                                                        
                                                        Button(
                                                            action: {
                                                                if (context.hasSelectedRange) {
                                                                    sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                    
                                                                    DispatchQueue.main.async {
                                                                        /*if (context.binding(for: .italic).wrappedValue) {
                                                                            context.handle(.setStyle(.italic, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.italic, true))
                                                                        }*/
                                                                        
                                                                        let cursor_position_UPP = context.selectedRange.upperBound
                                                                        let cursor_position_LOW = context.selectedRange.lowerBound
                                                                        let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                        let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                        
                                                                        if (context.binding(for: .italic).wrappedValue) {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleItalic2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, makeItalic: false))))
                                                                        } else {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleItalic2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, makeItalic: true))))
                                                                        }
                                                                        
                                                                        context.resetSelectedRange()
                                                                        
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        context.handle(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        
                                                                        //context.resetSelectedRange()
                                                                        
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        
                                                                        sharedAppState.anyNewChanges = true
                                                                        
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                    }
                                                                } else {
                                                                    withAnimation {
                                                                        sharedAppState.showToast = true
                                                                    }
                                                                }
                                                            },
                                                            label: {
                                                                Image(systemName: "italic")
                                                                    .font(.system(size: 14))
                                                                    .frame(width: 28, height: 19.5)
                                                                    .foregroundColor(sharedAppState.darkMode ? .white : .black)
                                                                    .padding(2)
                                                                    .background(context.binding(for: .italic).wrappedValue ?
                                                                                Color.accentColor.opacity(0.91) : (sharedAppState.darkMode ? Color.generalButtonsBackgroundColorDarkMode : Color.generalButtonsBackgroundColorLightMode))
                                                                    //.clipShape(Circle())
                                                                    .clipShape(Rectangle())
                                                            }
                                                        ).buttonStyle(ClearImageBackground3())
                                                         .disabled(!textEditorIsFocused)
                                                         .keyboardShortcut("i", modifiers: [.command])
                                                        
                                                        Divider()
                                                            .frame(width: 1, height: 19)
                                                            .background(sharedAppState.darkMode ? .black : Color.neuGray2)
                                                        
                                                        Button(
                                                            action: {
                                                                if (context.hasSelectedRange) {
                                                                    sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                    
                                                                    DispatchQueue.main.async {
                                                                        /*if (context.binding(for: .underlined).wrappedValue) {
                                                                            context.handle(.setStyle(.underlined, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.underlined, true))
                                                                        }*/
                                                                        
                                                                        let cursor_position_UPP = context.selectedRange.upperBound
                                                                        let cursor_position_LOW = context.selectedRange.lowerBound
                                                                        let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                        let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                        
                                                                        if (context.binding(for: .underlined).wrappedValue) {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleUnderlineRed2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, underline: false))))
                                                                        } else {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleUnderlineRed2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, underline: true))))
                                                                        }
                                                                        
                                                                        context.resetSelectedRange()
                                                                        
                                                                        //context.handle(.selectRange(emptyRange))
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        context.handle(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        
                                                                        //context.resetSelectedRange()
                                                                        
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        
                                                                        sharedAppState.anyNewChanges = true
                                                                        
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                    }
                                                                } else {
                                                                    withAnimation {
                                                                        sharedAppState.showToast = true
                                                                    }
                                                                }
                                                            },
                                                            label: {
                                                                Image(systemName: "underline")
                                                                    .font(.system(size: 13))
                                                                    .frame(width: 28, height: 19.5)
                                                                    .foregroundColor(sharedAppState.darkMode ? .white : .black)
                                                                    .padding(2)
                                                                    .background(context.binding(for: .underlined).wrappedValue ?
                                                                                Color.accentColor.opacity(0.91) : (sharedAppState.darkMode ? Color.generalButtonsBackgroundColorDarkMode : Color.generalButtonsBackgroundColorLightMode))
                                                                    .clipShape(Rectangle())
                                                            }
                                                        ).buttonStyle(ClearImageBackground3())
                                                         .disabled(!textEditorIsFocused)
                                                         .keyboardShortcut("u", modifiers: [.command])
                                                        
                                                        Divider()
                                                            .frame(width: 1, height: 19)
                                                            .background(sharedAppState.darkMode ? .black : Color.neuGray2)
                                                            //.frame(width: 1, height: 12, alignment: .bottom)
                                                            //.padding(.horizontal, 1)
                                                        
                                                        Button(
                                                            action: {
                                                                if (context.hasSelectedRange) {
                                                                    sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                    
                                                                    DispatchQueue.main.async {
                                                                        /*if (context.binding(for: .strikethrough).wrappedValue) {
                                                                            context.handle(.setStyle(.strikethrough, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.strikethrough, true))
                                                                        }*/
                                                                        
                                                                        let cursor_position_UPP = context.selectedRange.upperBound
                                                                        let cursor_position_LOW = context.selectedRange.lowerBound
                                                                        let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                        let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                        
                                                                        if (context.binding(for: .strikethrough).wrappedValue) {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleStrikethroughRed2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, applyStrikethrough: false))))
                                                                        } else {
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(toggleStrikethroughRed2(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, applyStrikethrough: true))))
                                                                        }
                                                                        
                                                                        context.resetSelectedRange()
                                                                        
                                                                        //context.handle(.selectRange(emptyRange))
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        context.handle(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                        
                                                                        //context.resetSelectedRange()
                                                                        
                                                                        //context.trigger(.selectRange(initialUserSelectionRange))
                                                                        
                                                                        sharedAppState.anyNewChanges = true
                                                                        
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                    }
                                                                } else {
                                                                    withAnimation {
                                                                        sharedAppState.showToast = true
                                                                    }
                                                                }
                                                            },
                                                            label: {
                                                                Image(systemName: "strikethrough")
                                                                    .font(.system(size: 16))
                                                                    //.resizable()
                                                                    //.scaledToFit()
                                                                    .frame(width: 28, height: 19.5)
                                                                    .foregroundColor(sharedAppState.darkMode ? .white : .black)
                                                                    .padding(2)
                                                                    .background(context.binding(for: .strikethrough).wrappedValue ?
                                                                                Color.accentColor.opacity(0.91) : (sharedAppState.darkMode ? Color.generalButtonsBackgroundColorDarkMode : Color.generalButtonsBackgroundColorLightMode))
                                                                    //.clipShape(Circle())
                                                                    .clipShape(Rectangle())
                                                            }
                                                        ).buttonStyle(ClearImageBackground3())
                                                         .disabled(!textEditorIsFocused)
                                                         .keyboardShortcut("s", modifiers: [.command])
                                                         //.buttonStyle(.borderless)
                                                         //.buttonStyle(.borderedProminent)
                                                         //.clipShape(Circle())
                                                         //.clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                                                         //.clipShape(Rectangle())
                                                    }.background(sharedAppState.darkMode ? Color.generalButtonsBackgroundColorDarkMode : Color.generalButtonsBackgroundColorLightMode)
                                                     .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                                                     //RoundToggleButton(isOn: $context.hasStyle(RichTextStyle.bold))
                                                     //.controlSize(.small)
                                                     .controlSize(.regular)
                                                    Spacer()
                                                }.frame(width: 110, height: 50)
                                                 .offset(CGSize(width: -5.00, height: 0.00))
                                                 //.offset(CGSize(width: -10.00, height: 0.00))
                                                 //.offset(CGSize(width: -6.00, height: 0.00))
                                                
                                                VStack {
                                                    Menu {
                                                        //ForEach(fontNames.indices, id: \.self) { index in
                                                        ForEach(fontSizeOptions, id: \.self) { option in
                                                            
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                        
                                                                        DispatchQueue.main.async {
                                                                            //context.fontSize = option.size
                                                                            
                                                                            let has_NEWLINE = sharedAppState.textt.string.hasSuffix("\n")
                                                                            let len = sharedAppState.textt.attributedString.length
                                                                            let cursor_position_UPP = context.selectedRange.upperBound
                                                                            let cursor_position_LOW = context.selectedRange.lowerBound
                                                                            let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                            let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                            
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(setFontSize(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, fontSize: option.size))))
                                                                            
                                                                            context.resetSelectedRange()
                                                                            
                                                                            //context.handle(.selectRange(emptyRange))
                                                                            //context.trigger(.selectRange(initialUserSelectionRange))
                                                                            //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                            context.handle(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                            
                                                                            //context.resetSelectedRange()
                                                                            
                                                                            //context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(sharedAppState.textt)))
                                                                            //context.trigger(.selectRange(initialUserSelectionRange))
                                                                            
                                                                            sharedAppState.anyNewChanges = true
                                                                            
                                                                            sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                        }
                                                                    } else {
                                                                        withAnimation {
                                                                            sharedAppState.showToast = true
                                                                        }
                                                                        
                                                                        //context.fontSize = option.size
                                                                    }
                                                                },
                                                                label: {
                                                                    Text(option.name)
                                                                        .font(.system(size: option.name_size))
                                                                        .bold(option.name_bold)
                                                                }
                                                            ).disabled(!textEditorIsFocused)
                                                        }
                                                    } label: {
                                                        //Text("Font Size: \(Int(context.fontSize))")
                                                        Text("\(Int(context.fontSize))")
                                                            .font(.system(size: 12))
                                                    }
                                                    //.controlSize(.small)
                                                    .controlSize(.regular)
                                                    Spacer()
                                                }.frame(width: 50, height: 50)
                                                 //.offset(CGSize(width: -10.00, height: 0.00))
                                                 .offset(CGSize(width: 8.00, height: 0.00))
                                                
                                                VStack {
                                                    Menu {
                                                        //ForEach(fontNames.indices, id: \.self) { index in
                                                        ForEach(fontNames, id: \.self) { name in
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                        
                                                                        DispatchQueue.main.async {
                                                                            //context.fontName = name
                                                                            
                                                                            let cursor_position_UPP = context.selectedRange.upperBound
                                                                            let cursor_position_LOW = context.selectedRange.lowerBound
                                                                            let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                            let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                            
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(setFontNamePreservingTraits(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, fontName: name))))
                                                                            
                                                                            context.resetSelectedRange()
                                                                            
                                                                            //context.handle(.selectRange(emptyRange))
                                                                            //context.trigger(.selectRange(initialUserSelectionRange))
                                                                            //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                            context.handle(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                                            
                                                                            //context.resetSelectedRange()
                                                                            
                                                                            sharedAppState.anyNewChanges = true
                                                                            
                                                                            sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                        }
                                                                    } else {
                                                                        withAnimation {
                                                                            sharedAppState.showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Text(name)
                                                                        .font(.custom(name, size: 11))
                                                                }
                                                            ).disabled(!textEditorIsFocused)
                                                        }
                                                    } label: {
                                                        Text("Font")
                                                        //Text(context.fontName)
                                                            .font(.system(size: 12))
                                                    }
                                                    .help(Text(context.fontName))
                                                    //.controlSize(.small)
                                                    .controlSize(.regular)
                                                    Spacer()
                                                }.frame(width: 62, height: 50)
                                                 //.offset(CGSize(width: 5.00, height: 0.00))
                                                 //.offset(CGSize(width: -10.00, height: 0.00))
                                                 .offset(CGSize(width: 10.00, height: 0.00))
                                                
                                                VStack {
                                                    Menu {
                                                        ForEach(textStyleOptions, id: \.self) { option in
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                        
                                                                        DispatchQueue.main.async {
                                                                            let has_NEWLINE = sharedAppState.textt.string.hasSuffix("\n")
                                                                            let len = sharedAppState.textt.attributedString.length
                                                                            let cursor_position_UPP = context.selectedRange.upperBound
                                                                            let cursor_position_LOW = context.selectedRange.lowerBound
                                                                            let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                            let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                            let emptyRange = NSRange(location: cursor_position_UPP, length: 0)
                                                                            
                                                                            //context.fontSize = option.size
                                                                            
                                                                            var txt: NSAttributedString = sharedAppState.textt.attributedString
                                                                            
                                                                            txt = setFontSize(in: txt, range: initialUserSelectionRange, fontSize: option.size)
                                                                            txt = setBackgroundColor(in: txt, range: initialUserSelectionRange, color: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                                            
                                                                            if (option.name_bold) {
                                                                                txt = toggleBold(in: txt, range: initialUserSelectionRange, makeBold: true)
                                                                            } else {
                                                                                txt = toggleBold(in: txt, range: initialUserSelectionRange, makeBold: false)
                                                                            }
                                                                            if (option.name_underline) {
                                                                                txt = toggleUnderlineRed(in: txt, range: initialUserSelectionRange, underline: true)
                                                                            } else {
                                                                                txt = toggleUnderlineRed(in: txt, range: initialUserSelectionRange, underline: false)
                                                                            }
                                                                            txt = toggleItalic(in: txt, range: initialUserSelectionRange, makeItalic: false)
                                                                            txt = toggleStrikethroughRed(in: txt, range: initialUserSelectionRange, applyStrikethrough: false)
                                                                            
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(txt)))
                                                                            
                                                                            context.resetSelectedRange()
                                                                            
                                                                            //context.trigger(.selectRange(emptyRange))
                                                                            context.handle(.selectRange(emptyRange))
                                                                            
                                                                            //context.resetSelectedRange()
                                                                            
                                                                            sharedAppState.anyNewChanges = true
                                                                            
                                                                            sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                        }
                                                                    } else {
                                                                        withAnimation {
                                                                            sharedAppState.showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Text(option.name)
                                                                        .font(.system(size: option.name_size))
                                                                        .bold(option.name_bold)
                                                                        .underline(option.name_underline, color: .red)
                                                                        //.strikethrough(true, color: Color.blue)
                                                                }
                                                            ).disabled(!textEditorIsFocused)
                                                        }
                                                    } label: {
                                                        //Text("Font Size: \(Int(context.fontSize))")
                                                        Text("Style")
                                                            .font(.system(size: 12))
                                                    }
                                                    //.controlSize(.small)
                                                    .controlSize(.regular)
                                                    Spacer()
                                                }.frame(width: 63, height: 50)
                                                 //.offset(CGSize(width: -10.00, height: 0.00))
                                                 .offset(CGSize(width: 12.00, height: 0.00))
                                                
                                                VStack {
                                                    Menu {
                                                        ForEach(highlight_colors, id: \.self) { hi_option in
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                                        
                                                                        DispatchQueue.main.async {
                                                                            //let len = sharedAppState.textt.attributedString.length
                                                                            let cursor_position_UPP = context.selectedRange.upperBound
                                                                            let cursor_position_LOW = context.selectedRange.lowerBound
                                                                            let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                                            let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                                            let emptyRange = NSRange(location: cursor_position_UPP, length: 0)
                                                                            
                                                                            /*if (hi_option.name == "clear") {
                                                                                context.setColor(RichTextColor.background, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.7))
                                                                                context.setColor(RichTextColor.background, to: hi_option.real_col)
                                                                            } else {
                                                                                context.setColor(RichTextColor.background, to: hi_option.real_col)
                                                                            }*/
                                                                            
                                                                            context.handle(.setAttributedString(ensureSuffixWithSpacesAndNewline(setBackgroundColor(in: sharedAppState.textt.attributedString, range: initialUserSelectionRange, color: hi_option.real_col))))
                                                                            
                                                                            context.resetSelectedRange()
                                                                            
                                                                            //context.trigger(.selectRange(emptyRange))
                                                                            context.handle(.selectRange(emptyRange))
                                                                            
                                                                            //context.resetSelectedRange()
                                                                        
                                                                            sharedAppState.anyNewChanges = true
                                                                            
                                                                            sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                                        }
                                                                    } else {
                                                                        withAnimation {
                                                                            sharedAppState.showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Text(hi_option.name)
                                                                        .font(.custom("Avenir", size: 12))
                                                                        .bold()
                                                                        //.frame(width: 85)
                                                                }
                                                            ).disabled(!textEditorIsFocused)
                                                        }
                                                    } label: {
                                                        //Text("Highlight")
                                                        Text("Mark")
                                                            .font(.system(size: 12))
                                                    }
                                                    //.controlSize(.small)
                                                    .controlSize(.regular)
                                                    Spacer()
                                                }.frame(width: 62, height: 50)
                                                //.offset(CGSize(width: -10.00, height: 0.00))
                                                .offset(CGSize(width: 13.00, height: 0.00))
                                                
                                            }.frame(width: 495)
                                            
                                            Spacer()
                                                //.frame(height: 490)
                                                //🍎.frame(height: 520)
                                                .frame(height: 600)
                                        }.frame(width: 495, height: 664) //.frame(width: 555, height: 584) //🍎.frame(width: 395, height: 584) //.frame(width: 395, height: 554)
// MARK: – RichText Editor
                                        VStack (spacing: 1) {
                                            HStack (spacing: 0) {
                                                Spacer()
                                                    //.frame(height: 25)
                                                    .frame(height: 30)
                                            }
                                            RichTextEditor(
                                                text: $sharedAppState.textt,
                                                /*text: Binding(
                                                    get: { sharedAppState.textt },
                                                    set: { sharedAppState.textt = $0 }
                                                ),*/
                                                context: context,
                                                format: .archivedData,
                                                viewConfiguration: { richTextView in
                                                    richTextView.textContentInset = CGSize(width: 0, height: 10)
                                                    
                                                    //richTextView.setRichTextColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: sharedAppState.textt.length))
                                                    //richTextView.setRichTextColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(hex: "000000", alpha: 1.0) : NSColor(hex: "FFFFFF", alpha: 1.0), at: NSRange(location: 0, length: sharedAppState.textt.length))
                                                    //richTextView.setRichTextColor(RichTextColor.foreground, to: NSColor(hex: "000000", alpha: 1.0), at: NSRange(location: 0, length: sharedAppState.textt.length))
                                                    richTextView.setRichTextColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(hex: "FFFFFF", alpha: 1.0) : NSColor(hex: "000000", alpha: 1.0), at: NSRange(location: 0, length: sharedAppState.textt.length))
                                                    richTextView.setRichTextColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: sharedAppState.textt.length))
                                                    richTextView.setRichTextColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: sharedAppState.textt.length))
                                                    
                                                    //richTextView.isFirstResponder = true
                                                    
                                                    //if let textView = richTextView as? CustomTextView {
                                                    if let textView = richTextView as? NSTextView {
                                                        //print_to_debug_window_SEQUENTIAL("📍 START  if let textView = richTextView as? NSTextView {")
                                                        //print_to_debug_window_ASYNC("📍 START/END  if let textView = richTextView as? NSTextView { –> DispatchQueue.main.async {")
                                                        
                                                        
                                                        textView.isAutomaticSpellingCorrectionEnabled = false
                                                        textView.isContinuousSpellCheckingEnabled = false
                                                        textView.allowsUndo = false
                                                        textView.importsGraphics = false // Prevent images from being pasted
                                                        textView.menu = nil // Disables right-click context menu
                                                        
                                                        //textView.isRichText = true
                                                        //textView.isHorizontallyResizable = true
                                                        //textView.isVerticallyResizable = true
                                                        
                                                        //textView.font = NSFont(name: "Avenir", size: 12)
                                                        
                                                        //textView.textColor = sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                                                        //textView.backgroundColor = sharedAppState.darkMode ? NSColor(red: 0.60784, green: 0.59216, blue: 0.59216, alpha: 1.0) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                                                        //textView.textColor = sharedAppState.darkMode ? NSColor(hex: "FFFFFF", alpha: 1.0) : NSColor(hex: "000000", alpha: 1.0)
                                                        //textView.textColor = NSColor(hex: "000000", alpha: 1.0)
                                                        textView.textColor = sharedAppState.darkMode ? NSColor(hex: "FFFFFF", alpha: 1.0) : NSColor(hex: "000000", alpha: 1.0)
                                                        //textView.backgroundColor = sharedAppState.darkMode ? NSColor(hex: "1E1F1E", alpha: 1.0) : NSColor(hex: "FFFFFF", alpha: 1.0)
                                                        //textView.backgroundColor = sharedAppState.darkMode ? NSColor(hex: "242323", alpha: 1.0) : NSColor(hex: "FFFFFF", alpha: 1.0)
                                                        //textView.backgroundColor = sharedAppState.darkMode ? NSColor(hex: "9B9897", alpha: 1.0) : NSColor(hex: "FFFFFF", alpha: 1.0)
                                                        textView.backgroundColor = sharedAppState.darkMode ? NSColor(hex: "1E1F1E", alpha: 1.0) : NSColor(hex: "FFFFFF", alpha: 1.0)


                                                        //print_to_debug_window_SEQUENTIAL("     END  if let textView = richTextView as? NSTextView {")
                                                        //print_to_debug_window_ASYNC("📍  START2/END   if let textView = richTextView as? NSTextView { –> DispatchQueue.main.async {")
                                                    }
                                                }
                                            )//.id(textt) .id(context.attributedString.richText) // Forces view refresh when text changes
                                            /**.onReceive(context.actionPublisher) { action in
                                                // Listen for ENTER key, then select all text as a workaround.
                                                /*if case .insertText(let inserted) = action, inserted == "\n" {
                                                    //context.resetSelectedRange()
                                                }*/
                                                //dropEntered()
                                            }*/
                                            //.richTextEditorConfig(editorConf)
                                            //.richTextEditorStyle(.init(backgroundColor: .red))
                                             .focused($textEditorIsFocused)
                                            //.focusedValue(\.noteValue, textt) // whenever this becomes focused, write value of "textt" to .noteValue
                                             /*.onAppear() {
                                                /*if (!sharedAppState.anyNewChangesInOnlyTextColor) {
                                                    //if (textt_str != context.attributedString.richText) {
                                                    if (sharedAppState.textt_str != context.attributedString) {
                                                    //if (textt_str.richText != context.attributedString.richText) {
                                                    //if (textt_str != sharedAppState.textt) {
                                                        //dropEntered2()
                                                        
                                                        sharedAppState.anyNewChangesInOnlyTextColor = true
                                                 
                                                    }
                                                }
                                                context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                */
                                                //print_to_debug_window_SEQUENTIAL("📍 START .onAppear()")
                                                
                                                /// will run only when the color of sharedAppState.textt != darkmode/lightmode color when opening RichTextEditor from ListOfNotes page
                                                /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(60)) {
                                                    //print_to_debug_window_SEQUENTIAL("📍 START .onAppear() { –> DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {")
                                                    
                                                    /// will run only when
                                                    //let has = context.attributedString.string.hasSuffix("\n")
                                                    // if (!has) {
                                                    if (!sharedAppState.textt_str.string.hasSuffix("\n")) {
                                                        let len = context.attributedString.length
                                                        context.handle(.selectRange(NSRange(location: len, length: 0)))
                                                        
                                                        context.fontSize = CGFloat(13)
                                                        context.fontName = "Courier"
                                                        
                                                        let insertion = RichTextInsertion<String>(
                                                           content: "\n",
                                                           index: context.attributedString.length, // the position where you want to paste
                                                           moveCursor: false // or false, depending on whether you want the cursor to move
                                                        )
                                                        context.handle(.pasteText(insertion))
                                                        
                                                        //sharedAppState.textt_str = context.attributedString.richText
                                                        self.added_NEWLINE_CHAR = true
                                                    }
                                                    /*let string = context.attributedString.string
                                                    if (!string.hasSuffix("\n")) {
                                                        let insertion = RichTextInsertion<String>(
                                                            content: "\n",
                                                            index: context.attributedString.length, // the position where you want to paste
                                                            moveCursor: false // or false, depending on whether you want the cursor to move
                                                        )
                                                        
                                                        context.trigger(.pasteText(insertion))
                                                        
                                                        added_NEWLINE_CHAR = true
                                                    }*/
                                                    context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                    context.resetSelectedRange()
                                                    
                                                    //print_to_debug_window_SEQUENTIAL("     END .onAppear() { –> DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {")
                                                }
                                                 */
                                                 
                                                 //print_to_debug_window_SEQUENTIAL("    END .onAppear()")
                                            }*/
                                             //.onChange(of: textEditorIsFocused) { newValue in
                                             /*.onChange(of: textEditorIsFocused) { _ in
                                                 if (textEditorIsFocused && textEditorJustOpenedAndBecameFocused) {
                                                     textEditorJustOpenedAndBecameFocused = false
                                                     
                                                     //print_to_debug_window_SEQUENTIAL("📍 START .onChange(of: textEditorIsFocused) –> if (textEditorIsFocused && textEditorJustOpenedAndBecameFocused ")
                                                     
                                                     //print_to_debug_window_ASYNC("📍 START  .onChange(of: textEditorIsFocused) –> if (textEditorIsFocused && textEditorJustOpenedAndBecameFocused –> DispatchQueue.main.async {")
                                                     
                                                     //DispatchQueue.main.async {
                                                     /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(110)) {
                                                         let str = context.attributedString.richText.string
                                                         if (!str.hasSuffix("\n")) {
                                                             let insertion = RichTextInsertion<String>(
                                                                content: "\n",
                                                                index: context.attributedString.length, // the position where you want to paste
                                                                moveCursor: false // or false, depending on whether you want the cursor to move
                                                             )
                                                             context.handle(.pasteText(insertion))
                                                         }
                                                         
                                                         context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                         context.resetSelectedRange()
                                                         
                                                         textt_str = context.attributedString.richText
                                                     }*/
                                                     //print_to_debug_window_SEQUENTIAL("      END .onChange(of: textEditorIsFocused)")
                                                     //print_to_debug_window_ASYNC("       END/START2  .onChange(of: textEditorIsFocused) –> if (textEditorIsFocused && textEditorJustOpenedAndBecameFocused –> DispatchQueue.main.async {")
                                                 }
                                             }*/
                                             /*.onChange(of: sharedAppState.textt.length) { newValue in
                                                 //print_to_debug_window_ASYNC("\(newValue)", "      .onChange(of: sharedAppState.textt) { newValue in")
                                                 
                                             }*/
                                             /*.onCopyCommand(perform: {
                                                 DispatchQueue.main.async {
                                                     NSSound(named: "Pop")?.play()
                                                 }
                                             })
                                             */
                                             .onChange(of: textEditorIsFocused) { newValue in
                                                 /** Handle focus change
                                                     if textEditorIsFocused == newValue {
                                                         dropEntered()
                                                     }
                                                 */
                                                 
                                                 if (textEditorIsFocused && sharedAppState.textEditorJustOpenedAndBecameFocused) {
                                                     sharedAppState.textEditorJustOpenedAndBecameFocused = false
                                                     //DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                     DispatchQueue.main.async {
                                                         if (sharedAppState.textt_str != context.attributedString) {
                                                             //if (textt_str.richText != context.attributedString.richText) {
                                                             //if (textt_str != sharedAppState.textt) {
                                                             
                                                             sharedAppState.anyNewChangesInOnlyTextColor = true
                                                             //context.attributedString.richText
                                                             
                                                             //print_to_debug_window_print_debugging("0", " .onChange(of: textEditorIsFocused)  –>  if  –>  if ")
                                                             //dropEntered2()
                                                         }
                                                         
                                                         //context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                         context.trigger(.selectRange(NSRange(location: 0, length: 0)))
                                                         context.resetSelectedRange()
                                                     }
                                                 }
                                             }/*.onReceive(sharedAppState.$textt) { value in
                                                 //DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                 DispatchQueue.main.async {
                                                     if (!value.string.hasSuffix("\n")) {
                                                         let insertion = RichTextInsertion<String>(
                                                            content: "  \n",
                                                            index: value.attributedString.length, // the position where you want to paste
                                                            moveCursor: false // or false, depending on whether you want the cursor to move
                                                        )
                                                        //print("dropEntered()")
                                                     }
                                                 }
                                             }*/
                                             //.onReceive(context.$fontName) { value in
                                             .onChange(of: context.fontName) { value in
                                                //print_to_debug_window_SEQUENTIAL("📍 START .onChange(of: context.fontName)")
                                                //print_to_debug_window_ASYNC("📍 START .onChange(of: context.fontName) { value in –> DispatchQueue.main.async {")
                                                 
                                                 if (!sharedAppState.someActionInChangingRichTextEditorsTextIsActive) {
                                                     if (textEditorIsFocused) {
                                                         //print_to_debug_window_SEQUENTIAL("     .onChange(of: context.fontName) ––> if (textEditorIsFocused) {")
                                                         
                                                         let t = (context.fontSize == 16) && (context.fontName == ".AppleSystemUIFont")
                                                         if t {
                                                             //print_to_debug_window_SEQUENTIAL("         .onChange(fontName) ––> if –> if t ")
                                                             //if textt.string.isEmpty {
                                                             //if context.attributedString.string.isEmpty {
                                                             if context.attributedString.richText.string.isEmpty {
                                                                 //dropEntered() // make a sound så i know this block was executed
                                                                 //print_to_debug_window_SEQUENTIAL("             .onChange(fontName) ––> if –> if t –> if string.isEmpty {🟣 ")
                                                                 
                                                                 //print_to_debug_window_print_debugging("  X", " .onChange(of: context.fontName) –> if contextisEmpty –>")
                                                                 //textEditorIsFocused = false
                                                                 context.isEditingText = false
                                                                 
                                                                 
                                                                 //DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(60)) {
                                                                 DispatchQueue.main.async {
                                                                     context.fontSize = CGFloat(12)
                                                                     context.fontName = "Avenir"
                                                                     
                                                                     let str = loadTexttFromAppStorage3()
                                                                     context.handle(.setAttributedString(str))
                                                                     
                                                                     do {
                                                                         context.handle(.selectRange(NSRange(location: 0, length: 3)))
                                                                         context.fontSize = CGFloat(12)
                                                                         context.fontName = "Avenir"
                                                                         //context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                         context.setColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                         context.setColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                         context.setColor(RichTextColor.background, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                                     } catch {
                                                                         //print("⚠️ Caught error: \(error.localizedDescription)")
                                                                     }
                                                                     
                                                                     //textEditorIsFocused = true
                                                                     context.isEditingText = true
                                                                     context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                                 }
                                                                 
                                                                 /*context.handle(.setAttributedString(NSAttributedString(string: " ")))
                                                                 
                                                                 //let fullRange = NSRange(location: 0, length: textt.length)
                                                                 let fullRange = NSRange(location: 0, length: context.attributedString.length)
                                                                     //let emptyRange = NSRange(location: textt.length, length: textt.length)
                                                                     //let emptyRange = NSRange(location: 1, length: 0)
                                                                 //let emptyRange = NSRange(location: 0, length: 0)
                                                                 
                                                                 context.handle(.selectRange(fullRange))
                                                                 
                                                                 context.fontSize = CGFloat(12)
                                                                 context.fontName = "Avenir"
                                                                 
                                                                 context.setColor(RichTextColor.foreground, to: !sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                 
                                                                 //Text("Is bold: \(context.styles.hasStyle(.bold))")
                                                                 context.handle(.setStyle(RichTextStyle.bold, false))
                                                                 context.handle(.setStyle(RichTextStyle.underlined, false))
                                                                 context.handle(.setStyle(RichTextStyle.italic, false))
                                                                 context.handle(.setStyle(RichTextStyle.strikethrough, false))
                                                                 context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                 
                                                                 context.setColor(RichTextColor.background, to:  NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                                 
                                                                 let string = context.attributedString.string
                                                                 if (!string.hasSuffix("\n")) {
                                                                     let insertion = RichTextInsertion<String>(
                                                                         content: "\n",
                                                                         index: context.attributedString.length, // the position where you want to paste
                                                                         moveCursor: false // or false, depending on whether you want the cursor to move
                                                                     )
                                                                     
                                                                     context.trigger(.pasteText(insertion))
                                                                     
                                                                     sharedAppState.added_NEWLINE_CHAR = true
                                                                     //print_to_debug_window_print_debugging("  X", " .onChange(of: context.fontName) –> if contextisEmpty –> if (!string.hasSuffix")
                                                                 }
                                                                 /*let insertion = RichTextInsertion<String>(
                                                                     content: "\n",
                                                                     index: context.attributedString.length, // the position where you want to paste
                                                                     moveCursor: false // or false, depending on whether you want the cursor to move
                                                                 )
                                                                 context.trigger(.pasteText(insertion))
                                                                 sharedAppState.added_NEWLINE_CHAR = true
                                                                 */
                                                                 
                                                                 //context.trigger(.selectRange(emptyRange))
                                                                 //context.handle(.selectRange(emptyRange))
                                                                 context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                                 context.resetSelectedRange()
                                                                 
                                                                 //textEditorIsFocused = false
                                                                 textEditorIsFocused = true
                                                                 context.isEditingText = true
                                                                 
                                                                 let str = sharedAppState.textt_str.string
                                                                 let words = str.split { $0 == " " || $0.isNewline }
                                                                 let count = words.count
                                                                 
                                                                 if (count <= 0) {
                                                                     sharedAppState.anyNewChanges = false
                                                                     //print_to_debug_window_print_debugging("  X", " .onChange(of: context.fontName) –> if (count <= 0) {")
                                                                 } else {
                                                                     sharedAppState.anyNewChanges = true // checka ifall textt_str word count är == 0 ––> sharedAppState.anyNewChanges = false else sharedAppState.anyNewChanges = true
                                                                     //print_to_debug_window_print_debugging("  X", " .onChange(of: context.fontName) –> if (count > 0) {")
                                                                 }*/
                                                             }
                                                         }
                                                     }
                                                 }
                                             }
                                             //.onAppear() {
                                             .onReceive(sharedAppState.$added_NEWLINE_CHAR) { value in
                                                 
                                                 DispatchQueue.main.async {
                                                     if (value) {
                                                         sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                         context.isEditingText = false
                                                         
                                                         let len = sharedAppState.textt.attributedString.length
                                                         let insertion = RichTextInsertion<String>(
                                                            content: "  \n",
                                                            index: len, // the position where you want to paste
                                                            moveCursor: false // or false, depending on whether you want the cursor to move
                                                         )
                                                         context.handle(.pasteText(insertion))
                                                         
                                                         do {
                                                             context.handle(.selectRange(NSRange(location: len, length: 3)))
                                                             context.fontSize = CGFloat(12)
                                                             context.fontName = "Avenir"
                                                             //context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                             context.setColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                             context.setColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                             context.setColor(RichTextColor.background, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                         } catch {
                                                             //print("⚠️ Caught error: \(error.localizedDescription)")
                                                         }
                                                         
                                                         context.isEditingText = true
                                                         
                                                         context.handle(.selectRange(NSRange(location: 0, length: 0)))
                                                         
                                                         let temp = sharedAppState.textt
                                                         sharedAppState.textt_str_NEWLINE_CHAR = temp // kopiera för att checka vid Exit Note
                                                         
                                                         /*sharedAppState.textt.isEqual(to: context.attributedString) ? print("is equal") : print("is not equal")
                                                         print(context.attributedString.string)
                                                         print(sharedAppState.textt.string)
                                                         let temp = sharedAppState.textt
                                                         sharedAppState.textt_str_NEWLINE_CHAR = temp // kopiera för att checka vid Exit Note
                                                         temp.isEqual(to: sharedAppState.textt_str_NEWLINE_CHAR) ? print("is equal") : print("is not equal")
                                                         print(sharedAppState.textt_str_NEWLINE_CHAR.string)
                                                         print("\n\n✅Added newline to a note that just got opened")
                                                         //dropEntered()
                                                         */
                                                         
                                                         sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                     }
                                                 }
                                             }
                                            //.onChange(of: sharedAppState.triggerTextHasSuffixCheckuppInRichTextEditor) { _ in
                                             .onReceive(sharedAppState.$triggerTextHasSuffixCheckuppInRichTextEditor) { value in
                                                 
                                                 //if (value) {
                                                 if (textEditorIsFocused && !sharedAppState.someActionInChangingRichTextEditorsTextIsActive) {
                                                     sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                     //context.isEditingText = false
                                                     
                                                     //DispatchQueue.main.asyncAfter(deadline: .now()  + .milliseconds(50)) {
                                                     //DispatchQueue.main.async {
                                                         if (context.hasSelectedRange) {
                                                             //DispatchQueue.main.async {
                                                             let cursor_position_UPP = context.selectedRange.upperBound
                                                             let cursor_position_LOW = context.selectedRange.lowerBound
                                                             let cursor_len = cursor_position_UPP - cursor_position_LOW
                                                             let initialUserSelectionRange = NSRange(location: cursor_position_LOW, length: cursor_len)
                                                             
                                                             //DispatchQueue.main.asyncAfter(deadline: .now()  + .milliseconds(100)) {
                                                             let len = sharedAppState.textt.attributedString.length
                                                             //let len = sharedAppState.textt.length
                                                             let has_NEWLINE = sharedAppState.textt.string.hasSuffix("\n")
                                                             if (!has_NEWLINE) {
                                                                 //context.isEditingText = false
                                                                 
                                                                 context.handle(.selectRange(NSRange(location: len, length: 0)))
                                                                 context.fontSize = CGFloat(12)
                                                                 context.fontName = "Avenir"
                                                                 
                                                                 let insertion = RichTextInsertion<String>(
                                                                    content: "  \n",
                                                                    index: len, // the position where you want to paste
                                                                    moveCursor: false // or false, depending on whether you want the cursor to move
                                                                 )
                                                                 context.handle(.pasteText(insertion))
                                                                 
                                                                 do {
                                                                     context.handle(.selectRange(NSRange(location: len, length: 3)))
                                                                     context.fontSize = CGFloat(12)
                                                                     context.fontName = "Avenir"
                                                                     context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                     context.setColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                     context.setColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                     context.setColor(RichTextColor.background, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                                 } catch {
                                                                     //print("⚠️ Caught error: \(error.localizedDescription)")
                                                                 }
                                                                 
                                                             }
                                                             //context.isEditingText = true
                                                             //context.resetSelectedRange()
                                                             //context.trigger(.selectRange(NSRange(location: cursor_position_UPP, length: 0)))
                                                             context.handle(.selectRange(initialUserSelectionRange))
                                                             //context.resetSelectedRange()
                                                            
                                                         } else { //❗️ if (context.hasSelectedRange) {
                                                             let cursorPosition = context.selectedRange.location // This is always the caret position if no selection
                                                             
                                                             //DispatchQueue.main.asyncAfter(deadline: .now()  + .milliseconds(100)) {
                                                             let len = sharedAppState.textt.attributedString.length
                                                             //let len = sharedAppState.textt.length
                                                             let has_NEWLINE = sharedAppState.textt.string.hasSuffix("\n")
                                                             if (!has_NEWLINE) {
                                                                 //context.isEditingText = false
                                                                 
                                                                 context.handle(.selectRange(NSRange(location: len, length: 0)))
                                                                 context.fontSize = CGFloat(12)
                                                                 context.fontName = "Avenir"
                                                                 
                                                                 let insertion = RichTextInsertion<String>(
                                                                    content: "  \n",
                                                                    index: len, // the position where you want to paste
                                                                    moveCursor: false // or false, depending on whether you want the cursor to move
                                                                 )
                                                                 context.handle(.pasteText(insertion))
                                                                 
                                                                 do {
                                                                     context.handle(.selectRange(NSRange(location: len, length: 3)))
                                                                     context.fontSize = CGFloat(12)
                                                                     context.fontName = "Avenir"
                                                                     context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                     context.setColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                     context.setColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                                     context.setColor(RichTextColor.background, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                                 } catch {
                                                                     //print("⚠️ Caught error: \(error.localizedDescription)")
                                                                 }
                                                             }
                                                             context.handle(.selectRange(NSRange(location: cursorPosition, length: 0)))
                                                             //context.resetSelectedRange()
                                                         }
                                                         sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                     //}
                                                 }
                                                 //}
                                             }
                                             /*//.onReceive(sharedAppState.$triggerTextForegroundColorCheckuppInRichTextEditor) { value in
                                             .onChange(of: sharedAppState.triggerTextForegroundColorCheckuppInRichTextEditor) { value in
                                                 if (textEditorIsFocused && !sharedAppState.someActionInChangingRichTextEditorsTextIsActive) {
                                                     
                                                     sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
                                                     //context.isEditingText = false
                                                     
                                                     let cursorPosition = context.selectedRange.location // This is always the caret position if no selection
                                                     let len = sharedAppState.textt.attributedString.length
                                                     
                                                     //let fullRange = NSRange(location: 0, length: context.attributedString.length)
                                                     //let fullRange = NSRange(location: 0, length: sharedAppState.textt.attributedString.length)
                                                     let fullRange = NSRange(location: 0, length: len)
                                                     
                                                     context.handle(.selectRange(fullRange))
                                                     //context.trigger(.selectRange(fullRange))
                                                     
                                                     do {
                                                         context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                         context.setColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                         context.setColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                     } catch {
                                                         //print("⚠️ Caught error: \(error.localizedDescription)")
                                                     }
                                                     
                                                     context.handle(.selectRange(NSRange(location: cursorPosition, length: 0)))
                                                     context.resetSelectedRange()
                                                     
                                                     sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                     //context.isEditingText = true
                                                     
                                                     DispatchQueue.main.async {
                                                         NSSound(named: "Submarine")?.play()
                                                     }
                                                 }
                                             }*/
                                             .onDisappear {
                                                 DispatchQueue.main.async {
                                                     context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                     sharedAppState.someActionInChangingRichTextEditorsTextIsActive = false
                                                     //context.resetAttributedString()
                                                 }
                                             }

                                        
                                        }.frame(width: 495, height: 664) //.frame(width: 555, height: 584) //🍎.frame(width: 395, height: 584)//.frame(width: 395, height: 554)
                                         .offset(CGSize(width: 4.00, height: 0.00))
                                        
                                        
                                        //if $sharedAppState.userHasMadeSelectionPrepareEditorForSelectResett.wrappedValue {
                                        /*if (context.hasSelectedRange && textEditorIsFocused) { // lägg till en || sharedAppState.userHasMadeSelectionPrepareEditorForSelectResett.wrappedValue sedan ifall skilj på att direkt visa
                                            // RoundedRectangle(cornerRadius: 9, style: .continuous)
                                            // lägg en execute after 500 milliseconds ifall typ user är aktiv och andra triggers etc. ite utför kod, then lägg en appear rectangle that appears only if context. har fortfarande selectedRange
                                            VStack (spacing: 1) {
                                                HStack (spacing: 0) {
                                                    Spacer()
                                                        //.frame(height: 25)
                                                        .frame(height: 30)
                                                }
                                                RoundedRectangle(cornerRadius: 9, style: .continuous)
                                                    .fill(Color.clear)
                                                    .frame(width: 495, height: 634)
                                                    .onTapGesture(count: 2, perform: {
                                                        //DispatchQueue.main.async {
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                                            if (context.hasSelectedRange && !context.isEditingText) {
                                                                //let len = sharedAppState.textt.attributedString.length
                                                                //let cursor_position_UPP = context.selectedRange.upperBound
                                                                let cursor_position_LOW = context.selectedRange.lowerBound
                                                                
                                                                context.handle(.selectRange(NSRange(location: cursor_position_LOW, length: 0)))
                                                                context.resetAttributedString()
                                                            }
                                                        }
                                                    })
                                            }.frame(width: 495, height: 664)
                                        }*/
                                    
                                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [
                                                        sharedAppState.darkMode
                                                            ? darkModeColors[pickedPriority % 4]
                                                            : lightModeColors[pickedPriority % 4],
                                                        .clear
                                                    ],
                                                    startPoint: .center,
                                                    endPoint: .bottom
                                                ),
                                                lineWidth: CGFloat(pickedPriority + pickedPriority + 2 + (pickedPriority == 1 ? 1 : 0))
                                            )
                                            //.stroke(lineWidth: CGFloat(pickedPriority + pickedPriority + 1))
                                            //.foregroundColor(lightModeColors[pickedPriority % 4])
                                    }.frame(width: 495, height: 664) //.frame(width: 555, height: 584) //🍎.frame(width: 395, height: 584) //.frame(width: 395, height: 554)
                                     //.background(sharedAppState.darkMode ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                }.frame(width: 495, height: 664) //.frame(width: 555, height: 584) //🍎.frame(width: 395, height: 584) //.frame(width: 395, height: 554)
                                 //.background(sharedAppState.darkMode ? NSColor(red: 0.16863, green: 0.16863, blue: 0.16863, alpha: 1.0) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                 .background(sharedAppState.darkMode ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                 //.clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                 /*.background(
                                  Rectangle()
                                     .fill(sharedAppState.darkMode ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                        .overlay(
                                            Rectangle()
                                                .stroke(lightModeColors[pickedPriority % 3], lineWidth: CGFloat(pickedPriority + pickedPriority + 1))
                                            )
                                 )
                                 */
                                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                .cornerRadius(9)
                                //.border(lightModeColors[pickedPriority % 3], lineWidth: CGFloat(pickedPriority + pickedPriority + 1))
                                //.shadow(radius: 4)
                                /*.shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                 .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                */
                                .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 2, x: 0, y: 0)
                                //.preferredColorScheme(sharedAppState.darkMode ? .dark : .light)
                                .preferredColorScheme(.dark)
                                /*.padding(.horizontal, 5)
                                 .padding(.bottom, 10)
                                 .padding(.vertical, 5)
                                */
                                   
                                //Spacer()
                            }.frame(width: 495, height: 668, alignment: .top) //🍎.frame(width: 395, height: 588, alignment: .top) //.frame(width: 395, height: 581, alignment: .top) //.frame(width: 305, height: 458)
                             //.preferredColorScheme(colorScheme == .dark ? .dark : .light)
                             //.preferredColorScheme(.light)
                            
// 💧📺 2Editor – Knapperna  .md💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                            HStack (spacing: 8) {
                                HStack (spacing: 3) {
                                    Button(
                                        action: {
                                            sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = true
                                            
                                            //textEditorIsFocused = false
                                            
                                            //let s1 = context.attributedString.richText
                                            let s1 = sharedAppState.textt.attributedString.richText
                                            //let str = context.attributedString.string
                                            let str = s1.string
                                            let str_trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
                                            let words = str.split { $0 == " " || $0.isNewline }
                                            let count = words.count
                                            
                                            let s2 = sharedAppState.textt_str.attributedString.richText
                                            let str_start = s2.string
                                            let str_start_trimmed = str_start.trimmingCharacters(in: .whitespacesAndNewlines)
                                            let words_start = str_start.split { $0 == " " || $0.isNewline }
                                            let count_start = words_start.count
                                            
                                            let s3 = sharedAppState.textt_str_NEWLINE_CHAR.attributedString.richText
                                            let str_start_NEWLINE_CHAR = s3.string
                                            let str_start_NEWLINE_CHAR_trimmed = str_start_NEWLINE_CHAR.trimmingCharacters(in: .whitespacesAndNewlines)
                                            
                                            var is_Equal_maybe: Bool = false
                                            let encoded = encodeAttributedString(s1)
                                            let encoded3 = encodeAttributedString(s3)
                                            if encoded == encoded3 {
                                                is_Equal_maybe = true
                                            }
                                            
                                            //print("\n\n🚀EXIT Note start\n")
                                            if (count <= 0) {
                                                if (count_start <= 0) {
                                                    showingConfirmationDialogEmptyNote = true
                                                } else {
                                                    sharedAppState.wasNoteHavingTextBeforeOpeningTextEditorButIsNowEmptyBeforeExiting = true
                                                    
                                                    showingConfirmationDialog = true // adda en count_star_var_not_noll ––> if showingConfirmationDialog = true och USER vill revert changes --> fråga om USER vill radera noten??
                                                }
                                            } else {
                                                if (sharedAppState.currentNoteIsNew && (count_start <= 0)) {
                                                    saveTexttToAppStorage3(context.attributedString.richText) // Only the textColor has changed, dont need to ask USER for confirmation
                                                    
                                                    exit2EditorPageButtonAction()
                                                    
                                                    /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                        context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                        //context.resetAttributedString()
                                                    }*/
                                                } else {
                                                    if (sharedAppState.anyNewChangesInOnlyTextColor) {
                                                        if (!sharedAppState.anyNewChanges) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && sharedAppState.textt_str.string.trimmingCharacters(in: .whitespacesAndNewlines) == context.attributedString.richText.string.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && (str_trimmed == str_start_trimmed)) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && (str_trimmed == str_start_NEWLINE_CHAR_trimmed)) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && (str == str_start_NEWLINE_CHAR)) {
                                                            if (sharedAppState.added_NEWLINE_CHAR && (is_Equal_maybe) && (s1.length == s3.length) && (s1.string == s3.string) && (str.count == str_start_NEWLINE_CHAR.count) && str == str_start_NEWLINE_CHAR && str_trimmed == str_start_NEWLINE_CHAR_trimmed && str_trimmed == str_start_trimmed) {
                                                                saveTexttToAppStorage3(context.attributedString.richText) // Only the textColor has changed, dont need to ask USER for confirmation
                                                                
                                                                exit2EditorPageButtonAction()
                                                                
                                                                /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                                    context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                    //context.resetAttributedString()
                                                                }*/
                                                                
                                                                //print("if (sharedAppState.anyNewChangesInOnlyTextColor) { ––> if (!sharedAppState.anyNewChanges) { ––> 💧if (sharedAppState.added_NEWLINE_CHAR && (s1.isEqual(to: s3)  && (s1.isEqual(to: s3) && (s1.attributedString.richText == s3.attributedString.richText ))) {")
                                                            } else {
                                                                //if (sharedAppState.textt_str.string != context.attributedString.richText.string) {
                                                                //if ((sharedAppState.textt_str != context.attributedString.richText) || (sharedAppState.textt_str.string != context.attributedString.richText.string)) {
                                                                if (str != str_start) {
                                                                    showingConfirmationDialog = true
                                                                    //print("🟠if (str != str_start)")
                                                                } else {
                                                                    exit2EditorPageButtonAction()
                                                                    
                                                                    /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                                        context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                        //context.resetAttributedString()
                                                                    }*/
                                                                    //print("🟠if (str == str_start)")
                                                                }
                                                            }
                                                        } else {
                                                            showingConfirmationDialog = true
                                                        }
                                                    } else {
                                                        if (!sharedAppState.anyNewChanges) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && sharedAppState.textt_str.string.trimmingCharacters(in: .whitespacesAndNewlines) == context.attributedString.richText.string.trimmingCharacters(in: .whitespacesAndNewlines)) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && (str_trimmed == str_start_trimmed)) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && (str_trimmed == str_start_NEWLINE_CHAR_trimmed)) {
                                                            //if (sharedAppState.added_NEWLINE_CHAR && (str == str_start_NEWLINE_CHAR)) {
                                                            if (sharedAppState.added_NEWLINE_CHAR && (is_Equal_maybe) && (s1.length == s3.length) && (s1.string == s3.string) && (str.count == str_start_NEWLINE_CHAR.count) && str == str_start_NEWLINE_CHAR && str_trimmed == str_start_NEWLINE_CHAR_trimmed && str_trimmed == str_start_trimmed) {
                                                                saveTexttToAppStorage3(context.attributedString.richText) // Only the textColor has changed, dont need to ask USER for confirmation
                                                                
                                                                exit2EditorPageButtonAction()
                                                                
                                                                /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                                    context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                    //context.resetAttributedString()
                                                                }*/
                                                                //print("if (❗️sharedAppState.anyNewChangesInOnlyTextColor) { ––> if (!sharedAppState.anyNewChanges) { ––> 💧 if (sharedAppState.added_NEWLINE_CHAR && (s1 == s3) && s1.length == s3.length && str == str_start_NEWLINE_CHAR && str_trimmed == str_start_NEWLINE_CHAR_trimmed && str_trimmed == str_start_trimmed) {")
                                                            } else {
                                                                if (s1 != s2) {
                                                                    showingConfirmationDialog = true
                                                                    //print("🟠 if (s1 != s2) ")
                                                                } else {
                                                                    exit2EditorPageButtonAction()
                                                                    
                                                                    /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                                        context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                        //context.resetAttributedString()
                                                                    }*/
                                                                    
                                                                    //print("🟠if (s1 == s2) ")
                                                                }
                                                            }
                                                        } else {
                                                            showingConfirmationDialog = true
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            //print_to_debug_window_print_debugging("END    exit button")
                                            /*
                                             if (count <= 0) {
                                                 //dropEntered()
                                                 showingConfirmationDialogEmptyNote = true
                                             } else {
                                                 if (sharedAppState.anyNewChangesInOnlyTextColor) {
                                                     //if ((sharedAppState.anyNewChanges) || (textt_str.string != textt.string)) {
                                                     if (sharedAppState.anyNewChanges) {
                                                         if  (!added_NEWLINE_CHAR && (textt_str.string != context.attributedString.richText.string)) {
                                                             showingConfirmationDialog = true
                                                         } else {
                                                             showingConfirmationDialog = true
                                                         }
                                                     } else {
                                                         saveTexttToAppStorage3(context.attributedString.richText) // Only the textColor has changed, dont need to ask USER for confirmation
                                                         
                                                         exit2EditorPageButtonAction()
                                                         context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                     }
                                                 } else {
                                                     if (((textt_str != context.attributedString.richText) || (sharedAppState.anyNewChanges) || (textt_str.string != context.attributedString.richText.string)) && added_NEWLINE_CHAR) {
                                                         showingConfirmationDialog = true
                                                     } else {
                                                         exit2EditorPageButtonAction()
                                                         context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                     }
                                                 }
                                             }
                                             */
                                        },
                                        label: {
                                            //Text(" Back")
                                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                                .font(.system(size: 14))
                                                //.foregroundColor(sharedAppState.darkMode ? Color.neuPurpLight: Color.neuOrangeLight)
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                //.frame(width: 85, height: 18)
                                                .frame(width: 165, height: 22)
                                        }
                                    ).buttonStyle(miniRedBackButton())
                                     .confirmationDialog(Text(confirmationDialogTitleEmptyNote), isPresented: $showingConfirmationDialogEmptyNote, titleVisibility: .automatic,
                                                            actions: {
                                            //Button("Delete", role: .destructive) { }
                                            Button("Yes – Delete") {
                                                saveTexttToAppStorage3(context.attributedString.richText)
                                                
                                                // Bestäm här att checka ifall texttattributedstring är empty då fråga USER ifall man vill radera denna noten redan nu??
                                                //func removeSelectedTasks() {
                                                 let page = sharedAppState.isOnPage
                                                
                                                 if page == 1 {
                                                     realmManager.updateP1ItemisCurrentlyMarkedMarking(id: CurrentItemID, isMarked: true)
                                                     realmManager.deleteAllP1ItemisCurrentlyMarkedMarking()
                                                     //CountIMPandURGTasks()
                                                         let isThereAny = realmManager.isThereAnyP1Item()
                                                         let isThereMore = realmManager.isThereMoreP1Items()
                                                         sharedAppState.isThereAnyIMPandURGItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneIMPandURGItem = isThereMore
                                                         
                                                         sharedAppState.isThereAnyItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneItem = isThereMore
                                                 } else if page == 2 {
                                                     realmManager.updateP2ItemisCurrentlyMarkedMarking(id: CurrentItemID, isMarked: true)
                                                     realmManager.deleteAllP2ItemisCurrentlyMarkedMarking()
                                                     //CountIMPTasks()
                                                         let isThereAny = realmManager.isThereAnyP2Item()
                                                         let isThereMore = realmManager.isThereMoreP2Items()
                                                         sharedAppState.isThereAnyIMPItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneIMPItem = isThereMore
                                                         
                                                         sharedAppState.isThereAnyItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneItem = isThereMore
                                                 } else if page == 3 {
                                                     realmManager.updateP3ItemisCurrentlyMarkedMarking(id: CurrentItemID, isMarked: true)
                                                     realmManager.deleteAllP3ItemisCurrentlyMarkedMarking()
                                                     //CountURGTasks()
                                                         let isThereAny = realmManager.isThereAnyP3Item()
                                                         let isThereMore = realmManager.isThereMoreP3Items()
                                                         sharedAppState.isThereAnyURGItem =  isThereAny
                                                         sharedAppState.isThereMoreThanOneURGItem = isThereMore
                                                         
                                                         sharedAppState.isThereAnyItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneItem = isThereMore
                                                 } else if page == 4 {
                                                     realmManager.updateP4ItemisCurrentlyMarkedMarking(id: CurrentItemID, isMarked: true)
                                                     realmManager.deleteAllP4ItemisCurrentlyMarkedMarking()
                                                     //CountNOTHINGTasks()
                                                         let isThereAny = realmManager.isThereAnyP4Item()
                                                         let isThereMore = realmManager.isThereMoreP4Items()
                                                         sharedAppState.isThereAnyNOTHINGItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneNOTHINGItem = isThereMore
                                                         
                                                         sharedAppState.isThereAnyItem = isThereAny
                                                         sharedAppState.isThereMoreThanOneItem = isThereMore
                                                 }
                                                 
                                                 if !sharedAppState.isThereAnyItem {
                                                    resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                                 }
                                                
                                                exit2EditorPageButtonAction()
                                            }
                                            Button("No – Keep") {
                                                saveTexttToAppStorage3(context.attributedString.richText)
                                                
                                                exit2EditorPageButtonAction()
                                            }
                                            Button("Cancel", role: .cancel) {
                                                textEditorIsFocused = true
                                                
                                                sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false
                                            }
                                        },
                                                            message: {
                                            confirmationDialogMessageEmptyNote == "" ? nil : Text(confirmationDialogMessageEmptyNote)
                                        }
                                    )
                                     .confirmationDialog(Text(confirmationDialogTitle), isPresented: $showingConfirmationDialog, titleVisibility: .automatic,
                                                          actions: {
                                                              //Button("Save", role: .destructive) { }
                                                              Button("Save recent changes") {
                                                                  if (sharedAppState.wasNoteHavingTextBeforeOpeningTextEditorButIsNowEmptyBeforeExiting) {
                                                                      textEditorIsFocused = true
                                                                      
                                                                      DispatchQueue.main.async {
                                                                          showingConfirmationDialogEmptyNote = true
                                                                      }
                                                                  } else {
                                                                      saveTexttToAppStorage3(context.attributedString.richText)
                                                                      
                                                                      exit2EditorPageButtonAction()
                                                                      //context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                      //DispatchQueue.main.async {
                                                                      /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                                          context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                          //context.resetAttributedString()
                                                                      }*/
                                                                  }
                                                              }
                                                              Button("Revert Changes") {
                                                                  exit2EditorPageButtonAction()
                                                                  
                                                                  /*DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
                                                                      context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                      //context.resetAttributedString()
                                                                  }*/
                                                              }
                                                              Button("Cancel", role: .cancel) {
                                                                  textEditorIsFocused = true
                                                                  
                                                                  sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false
                                                              }
                                                          },
                                                          message: {
                                                              confirmationDialogMessage == "" ? nil : Text(confirmationDialogMessage)
                                                          }
                                    )//.offset(CGSize(width: -4, height: 1))
                                    
                                    Spacer()
                                    
                                    HStack {
                                        HStack (spacing: 0) {
                                            /**❗️🔴 Använd Detta ifall du endast vill copiera base64 representationen av den texten so visas i RichTextEditor, Exempelvis ifall du vill uppdatera värdet på sharedAppState.richTextInitializeDarkModeSpaceCharThenNewLineChar
                                             Button(
                                                action: {
                                                    if let encoded = encodeAttributedString(sharedAppState.textt) {
                                                        copyToPasteboard(encoded)
                                                        dropEntered2()
                                                    }
                                                },
                                                label: {
                                                    Text("Copy")
                                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                        .shadow(radius: 0.6)
                                                }
                                            ).buttonStyle(ClearImageBackground2())
                                            */
                                            
                                            HStack {
                                                Menu {
                                                    ForEach(0..<priorities.count, id: \.self) { index in
                                                        Button(action: {
                                                            pickedPriority = index
                                                            textEditorIsFocused = false
                                                        }) {
                                                            Text(priorities[index])
                                                                .font(.custom("Avenir", size: 10))
                                                                .bold()
                                                                .frame(alignment: .trailing)
                                                                .onHover { Bool in
                                                                    textEditorIsFocused = false
                                                                }
                                                        }
                                                    }
                                                } label: {
                                                    //Label("Priority: \(priorities[pickedPriority])", systemImage: "line.horizontal.3.decrease.circle")
                                                    Text("Priority")
                                                        .font(.custom("Avenir", size: 11))
                                                        .bold()
                                                }//.menuStyle(MyMenuStyle3())
                                                 .menuStyle(.button)
                                                 //.buttonStyle(.borderless)
                                            }.frame(width: 82, height: 27)
                                        }.controlSize(.large)
                                        
                                        Button(
                                            action: {
                                                textEditorIsFocused = false
                                                
                                                let exportRichText = context.attributedString
                                                let exportPlainText = context.attributedString.string
                                                
                                                singleNoteRichTextAttributedStringExport = saveTexttToAppStorage4(exportRichText)
                                                singleNoteRichTextStringExport = exportPlainText
                                                
                                                sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = true
                                                showExportNoteSheetDetail = true
                                            },
                                            label: {
                                                /*Text("Export")
                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                    .shadow(radius: 0.6)
                                                //Label("share", systemImage:  "square.and.arrow.up")*/
                                                HStack (spacing: 1) {
                                                    Image(systemName: "document.badge.arrow.up")
                                                    Text("Export")
                                                        //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                                        .font(.custom("Avenir", size: 11))
                                                        .bold()
                                                        //.shadow(radius: 0.3)
                                                        //.foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                        .frame(width: 36, height: 18)
                                                }
                                            }
                                        )//.buttonStyle(ClearImageBackground2())
                                         .controlSize(.large)
                                         .sheet(isPresented: $showExportNoteSheetDetail) {
                                             if #available(macOS 12.0, *) {
                                                 ExportNoteSheetView()
                                             }
                                         }
                                        
                                        //ShareLink(item: textt.string) {
                                        //ShareLink(item: context.attributedString.richText.string) {
                                        //ShareLink(item: sharedAppState.textt.string) {
                                        ShareLink(item: shareText) {
                                            //Label("share", systemImage:  "square.and.arrow.up")
                                            HStack (spacing: 1) {
                                                Image(systemName: "square.and.arrow.up")
                                                    .offset(CGSize(width: 0, height: -2))
                                                Text("Share")
                                                    //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                                    .font(.custom("Avenir", size: 11))
                                                    .bold()
                                                    //.shadow(radius: 0.3)
                                                    //.foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                    .frame(width: 30, height: 18)
                                            }
                                        }
                                        .onHover(perform: { value in
                                            if (value) {
                                                self.shareText = sharedAppState.textt.string
                                                /*DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                    NSSound(named: "Submarine")?.play()
                                                }
                                                */
                                            }
                                        })
                                        /*.onTapGesture {
                                            //dropEntered()
                                            textEditorIsFocused = false
                                            self.shareText = sharedAppState.textt.string
                                        }*/
                                        .controlSize(.large)
                                    } // HStack {
                                    
                                }//.frame(width: 382, height: 18) //.frame(width: 292, height: 18) // HStack (spacing: 0) {
                                
                            }.frame(width: 493, height: 28) //.frame(width: 553, height: 28) //.frame(width: 393, height: 28) //.frame(width: 290, height: 18) // HStack (spacing: 0) {
                             //.padding(5)
                             
                        }.frame(width: 495, height: 705, alignment: .center) //.frame(width: 555, height: 625, alignment: .center) //.frame(width: 395, height: 625, alignment: .center) //.frame(width: 305, height: 495, alignment: .center) // för VStack (spacing: 8) {
                         //.padding(5)
                         .preferredColorScheme(.dark)
                        //.preferredColorScheme(colorScheme == .dark ? .dark : .light)
                        
                    } // Avslut för if $ShowEditor.wrappedValue {
                    
// MARK: – 💥💥💥💥💥AVSLUT💥💥💥💥💥 sidan på POPOVERpageController som innehåller Listan med TaskItemsen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
                    
                } // ZWorld End・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
                .showToast(showToast: $sharedAppState.showToast.animation(), content: FabulaToast(showToast: $sharedAppState.showToast.animation(), toastData: FabulaToast.ToastData(title: "Attention❗️", message: "This operation is only available if a selection has been made", backgroundColor: Color.white), position: .top))
                /*.onDisappear(perform: {
                    dropEntered()
                })*/
                /*.alert(isPresented: $isShowAlert) {
                    Alert(title: Text("Title"), message: Text("This is a alert message"), dismissButton: .default(Text("Dismiss")))
                }*/
            }.padding(8)  // MARK: – VStack för page 1 – VStacken som alla page kommer appear on på ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・⭐️
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center) // MARK: - 🚌 Avslut PopoverPageController・・・・・・・・・・・・
         .autocorrectionDisabled()
         //.scrollDisabled(true)
         //.frame(width: 320, height: 500, alignment: .center)
         .environmentObject(sharedAppState) // Injecting sharedSettings as environment object for all children i.e by declaring the property  @EnvironmentObject var sharedAppState: AppState  in these children viewes, then those children will have the same reference to same AppState property here in Contentview
         .preferredColorScheme(sharedAppState.darkMode ? .dark : .light) // In SwiftUI, preferredColorScheme(_:) is a view modifier that allows you to override the system’s color scheme (light or dark mode) for a specific view.
        //.preferredColorScheme(.dark)
    } // 💥Avslut var body: some View {
} // Avslut struct ContentView


// MARK: - FOR RichTextEditor  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

extension ContentView {

    //func recolorAttributedString(_ input: NSAttributedString, dark: Bool) -> NSAttributedString {
     func recolorAttributedString(_ input: NSAttributedString) -> NSAttributedString {
        // Make a mutable copy
        let mutable = NSMutableAttributedString(attributedString: input)
        
        // Decide on color
        //let color: NSColor = dark ? .black : .white
        let color: NSColor = sharedAppState.darkMode ? NSColor.white : NSColor.black
        
        // Apply to the full range
        mutable.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: mutable.length))
        
        // Return as immutable NSAttributedString
        return NSAttributedString(attributedString: mutable)
    }
    
    /// Ensures an NSAttributedString ends with "  \n", appending if necessary.
    /// - Parameters:
    ///   - input: Original attributed string.
    ///   - white: If true, appended text is white; otherwise black.
    /// - Returns: Updated NSAttributedString (immutable).
    func ensureSuffixWithSpacesAndNewline(_ input: NSAttributedString) -> NSAttributedString {
        // Check suffix
        if input.string.hasSuffix("  \n") {
            return input
        }
        
        // Create mutable copy to append
        let mutable = NSMutableAttributedString(attributedString: input)
        
        // Attributes for appended text
        let appendAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont(name: "Avenir", size: 12) ?? NSFont.systemFont(ofSize: 12),
            .foregroundColor: sharedAppState.darkMode ? NSColor.white : NSColor.black
        ]
        
        // Append "  \n"
        let suffixString = NSAttributedString(string: "  \n", attributes: appendAttributes)
        mutable.append(suffixString)
        
        return NSAttributedString(attributedString: mutable)
    }
    func ensureSuffixWithSpacesAndNewline2(_ input: NSAttributedString) -> NSAttributedString {
        // Check suffix
        if input.string.hasSuffix("  \n") {
            return input
        }
        
        // Create mutable copy to append
        let mutable = NSMutableAttributedString(attributedString: input)
        
        // Attributes for appended text
        let appendAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont(name: "Avenir", size: 12) ?? NSFont.systemFont(ofSize: 12),
            .foregroundColor: sharedAppState.darkMode ? NSColor.white : NSColor.black
        ]
        
        let insertedAttrString = NSAttributedString(string: "  \n", attributes: appendAttributes)
        
        mutable.insert(insertedAttrString, at: mutable.length)
        
        return NSAttributedString(attributedString: mutable)
    }

    /// Removes text at a given range from an NSAttributedString.
    /// - Parameters:
    ///   - input: The original attributed string.
    ///   - range: The range of text to remove.
    /// - Returns: A new NSAttributedString with the specified range removed.
    ///            If the range is invalid, returns the original string unchanged.
    
    /** ANVÄNDNING:
         let original = NSAttributedString(string: "Hello beautiful world",
                                           attributes: [.font: NSFont.systemFont(ofSize: 14)])

         // Remove "beautiful "
         let rangeToRemove = (original.string as NSString).range(of: "beautiful ")
         let result = removingText(in: original, range: rangeToRemove)

         print("Original:", original.string)
         print("Result:", result.string)
     */
    func removingText(in input: NSAttributedString, range: NSRange) -> NSAttributedString {
        // Validate range against string length
        guard NSMaxRange(range) <= input.length && range.length > 0 else {
            return input
        }
        
        // Make a mutable copy and remove the range
        let mutable = NSMutableAttributedString(attributedString: input)
        mutable.deleteCharacters(in: range)
        
        return NSAttributedString(attributedString: mutable)
    }
    
    

    /// Inserts a string at a given index in an NSAttributedString, preserving the font and attributes of the character before the index.
    /// - Parameters:
    ///   - input: The original attributed string.
    ///   - index: The insertion index (must be between 0 and input.length).
    ///   - stringToInsert: The string to insert.
    /// - Returns: A new NSAttributedString with the string inserted, or original if index invalid.
    /** ANVÄNDNING:
         let original = NSMutableAttributedString(string: "Hello World",
                                                  attributes: [
                                                     .font: NSFont.systemFont(ofSize: 14),
                                                     .foregroundColor: NSColor.red
                                                  ])

         // Insert " Swift" after "Hello"
         let result = insertStringPreservingAttributes(in: original, at: 5, stringToInsert: " Swift")

         print(result.string)  // "Hello Swift World"
     */
    func insertStringPreservingAttributes(
        in input: NSAttributedString,
        at index: Int,
        stringToInsert: String
    ) -> NSAttributedString {
        
        guard index >= 0 && index <= input.length else {
            // Invalid index, return original
            return input
        }
        
        let mutable = NSMutableAttributedString(attributedString: input)
        
        // Determine attributes from character before insertion index
        var attributes: [NSAttributedString.Key: Any] = [:]
        if index > 0 {
            attributes = input.attributes(at: index - 1, effectiveRange: nil)
        }
        
        let insertedAttrString = NSAttributedString(string: stringToInsert, attributes: attributes)
        
        mutable.insert(insertedAttrString, at: index)
        
        return NSAttributedString(attributedString: mutable)
    }


    /// Replaces text at a given range with a new string, preserving the original range's font and attributes.
    /// - Parameters:
    ///   - input: Original attributed string.
    ///   - range: Range of text to replace.
    ///   - replacement: New plain string to insert.
    /// - Returns: A new NSAttributedString with the replacement applied.
    ///            If the range is invalid, returns the original string unchanged.
    func replacingTextPreservingFont(
        in input: NSAttributedString,
        range: NSRange,
        with replacement: String
    ) -> NSAttributedString {
        
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }
        
        let mutable = NSMutableAttributedString(attributedString: input)
        
        // Get attributes from the first character in the range (if range length is 0, get previous char attributes if possible)
        var attributes: [NSAttributedString.Key: Any] = [:]
        if range.length > 0 {
            attributes = input.attributes(at: range.location, effectiveRange: nil)
        } else if range.location > 0 {
            attributes = input.attributes(at: range.location - 1, effectiveRange: nil)
        }
        
        // Create attributed replacement string with preserved attributes
        let replacementAttributed = NSAttributedString(string: replacement, attributes: attributes)
        
        // Replace range
        mutable.replaceCharacters(in: range, with: replacementAttributed)
        
        return NSAttributedString(attributedString: mutable)
    }

    
    func toggleBold(
        in input: NSAttributedString,
        range: NSRange,
        makeBold: Bool
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }
        
        let mutable = NSMutableAttributedString(attributedString: input)
        
        // Enumerate font attributes in the range and replace with bold or regular
        mutable.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let font = value as? NSFont else { return }
            
            var newFont: NSFont
            
            if makeBold {
                // Create bold version of the current font
                let boldDescriptor = font.fontDescriptor.withSymbolicTraits(.bold)
                newFont = NSFont(descriptor: boldDescriptor, size: font.pointSize) ?? font
            } else {
                // Remove bold trait if present, fallback to regular font with same family & size
                var traits = font.fontDescriptor.symbolicTraits
                traits.remove(.bold)
                
                let regularDescriptor = font.fontDescriptor.withSymbolicTraits(traits)
                newFont = NSFont(descriptor: regularDescriptor, size: font.pointSize) ?? NSFont.systemFont(ofSize: font.pointSize)
            }
            
            mutable.addAttribute(.font, value: newFont, range: subRange)
        }
        
        return NSAttributedString(attributedString: mutable)
    }
    /// Toggles bold on the given range, preserving italic, underline, strikethrough, colors, etc.
    func toggleBold2(
        in input: NSAttributedString,
        range: NSRange,
        makeBold: Bool
    ) -> NSAttributedString {
        // Validate range
        guard range.location != NSNotFound, NSMaxRange(range) <= input.length else {
            return input
        }
        
        let m = NSMutableAttributedString(attributedString: input)
        m.beginEditing()
        
        m.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let oldFont = value as? NSFont else { return }
            
            let size = oldFont.pointSize
            var traits = oldFont.fontDescriptor.symbolicTraits
            
            if makeBold {
                traits.insert(.bold)
            } else {
                traits.remove(.bold)
            }
            
            // Build a new descriptor with updated traits
            let newDescriptor = oldFont.fontDescriptor.withSymbolicTraits(traits)
            let newFont = NSFont(descriptor: newDescriptor, size: size) ?? oldFont
            
            // Re-apply the font only (preserves all other attributes in the run)
            m.addAttribute(.font, value: newFont, range: subRange)
        }
        
        m.endEditing()
        return NSAttributedString(attributedString: m)
    }

    

    func toggleItalic(
        in input: NSAttributedString,
        range: NSRange,
        makeItalic: Bool
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }

        let mutable = NSMutableAttributedString(attributedString: input)

        mutable.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let font = value as? NSFont else { return }

            var newFont: NSFont

            if makeItalic {
                // Apply italic trait
                let italicDescriptor = font.fontDescriptor.withSymbolicTraits(.italic)
                newFont = NSFont(descriptor: italicDescriptor, size: font.pointSize) ?? font
            } else {
                // Remove italic trait
                var traits = font.fontDescriptor.symbolicTraits
                traits.remove(.italic)

                let regularDescriptor = font.fontDescriptor.withSymbolicTraits(traits)
                newFont = NSFont(descriptor: regularDescriptor, size: font.pointSize) ?? NSFont.systemFont(ofSize: font.pointSize)
            }

            mutable.addAttribute(.font, value: newFont, range: subRange)
        }

        return NSAttributedString(attributedString: mutable)
    }
    /// Toggles italic on the given range, preserving bold, underline, strikethrough, colors, etc.
    func toggleItalic2(
        in input: NSAttributedString,
        range: NSRange,
        makeItalic: Bool
    ) -> NSAttributedString {
        // Validate range
        guard range.location != NSNotFound, NSMaxRange(range) <= input.length else {
            return input
        }

        let m = NSMutableAttributedString(attributedString: input)
        m.beginEditing()

        m.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let oldFont = value as? NSFont else { return }

            let size = oldFont.pointSize
            var traits = oldFont.fontDescriptor.symbolicTraits

            if makeItalic {
                traits.insert(.italic)
            } else {
                traits.remove(.italic)
            }

            let newDescriptor = oldFont.fontDescriptor.withSymbolicTraits(traits)
            let newFont = NSFont(descriptor: newDescriptor, size: size) ?? oldFont

            // Re-apply font so traits survive
            m.addAttribute(.font, value: newFont, range: subRange)
        }

        m.endEditing()
        return NSAttributedString(attributedString: m)
    }

    
    func toggleUnderlineRed(
        in input: NSAttributedString,
        range: NSRange,
        underline: Bool
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }
        
        let mutable = NSMutableAttributedString(attributedString: input)
        
        if underline {
            // Apply red underline
            mutable.addAttributes([
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: NSColor.red
            ], range: range)
        } else {
            // Remove underline style and color attributes
            mutable.removeAttribute(.underlineStyle, range: range)
            mutable.removeAttribute(.underlineColor, range: range)
        }
        
        return NSAttributedString(attributedString: mutable)
    }
    // Perserve other styles
    /// Toggles a red underline on the given range, preserving existing fonts/traits (bold/italic) and other attributes.
    func toggleUnderlineRed2(
        in input: NSAttributedString,
        range: NSRange,
        underline: Bool
    ) -> NSAttributedString {
        // Validate range
        guard range.location != NSNotFound, NSMaxRange(range) <= input.length else {
            return input
        }

        let m = NSMutableAttributedString(attributedString: input)
        m.beginEditing()

        if underline {
            // Walk existing attribute runs; re-apply underline while re-asserting the current font for each subrange.
            var idx = range.location
            let end = NSMaxRange(range)

            while idx < end {
                var runRange = NSRange(location: 0, length: 0)
                let attrs = m.attributes(at: idx, effectiveRange: &runRange)
                let applyRange = NSIntersectionRange(runRange, range)
                if applyRange.length == 0 {
                    idx = NSMaxRange(runRange)
                    continue
                }

                // Re-assert the current font (NSFont or CTFont) so traits aren't lost by downstream rendering.
                if let font = attrs[.font] {
                    m.addAttribute(.font, value: font, range: applyRange)
                }

                // Add only underline attributes; do not touch anything else.
                m.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: applyRange)
                m.addAttribute(.underlineColor, value: NSColor.red, range: applyRange)

                idx = NSMaxRange(runRange)
            }
        } else {
            // Remove only underline-related attributes; leave the rest intact.
            m.removeAttribute(.underlineStyle, range: range)
            m.removeAttribute(.underlineColor, range: range)
        }

        m.endEditing()
        return NSAttributedString(attributedString: m)
    }

    func toggleStrikethroughRed(
        in input: NSAttributedString,
        range: NSRange,
        applyStrikethrough: Bool
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }

        let mutable = NSMutableAttributedString(attributedString: input)

        if applyStrikethrough {
            mutable.addAttributes([
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: NSColor.red
            ], range: range)
        } else {
            mutable.removeAttribute(.strikethroughStyle, range: range)
            mutable.removeAttribute(.strikethroughColor, range: range)
        }

        return NSAttributedString(attributedString: mutable)
    }
    /// Toggles a red strikethrough on the given range, preserving existing fonts/traits (bold/italic) and all other attributes.
    func toggleStrikethroughRed2(
        in input: NSAttributedString,
        range: NSRange,
        applyStrikethrough: Bool
    ) -> NSAttributedString {
        // Validate range
        guard range.location != NSNotFound, NSMaxRange(range) <= input.length else {
            return input
        }

        let m = NSMutableAttributedString(attributedString: input)
        m.beginEditing()

        if applyStrikethrough {
            // Walk existing attribute runs; re-assert the current font and add only strikethrough keys.
            var idx = range.location
            let end = NSMaxRange(range)

            while idx < end {
                var runRange = NSRange(location: 0, length: 0)
                let attrs = m.attributes(at: idx, effectiveRange: &runRange)
                let applyRange = NSIntersectionRange(runRange, range)
                if applyRange.length == 0 {
                    idx = NSMaxRange(runRange)
                    continue
                }

                // Re-apply the current font (NSFont or CTFont) so traits (bold/italic) are preserved.
                if let font = attrs[.font] {
                    m.addAttribute(.font, value: font, range: applyRange)
                }

                // Add only strikethrough-related attributes.
                m.addAttribute(.strikethroughStyle,
                               value: NSUnderlineStyle.single.rawValue,
                               range: applyRange)
                m.addAttribute(.strikethroughColor,
                               value: NSColor.red,
                               range: applyRange)

                idx = NSMaxRange(runRange)
            }
        } else {
            // Remove only strikethrough keys; leave everything else intact.
            m.removeAttribute(.strikethroughStyle, range: range)
            m.removeAttribute(.strikethroughColor, range: range)
        }

        m.endEditing()
        return NSAttributedString(attributedString: m)
    }

    
    func setFontSize(
        in input: NSAttributedString,
        range: NSRange,
        fontSize: CGFloat
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }

        let mutable = NSMutableAttributedString(attributedString: input)

        mutable.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let font = value as? NSFont else { return }

            // Create a new font descriptor preserving traits but changing size
            let descriptor = font.fontDescriptor
            let newFont = NSFont(descriptor: descriptor, size: fontSize) ?? NSFont.systemFont(ofSize: fontSize)

            mutable.addAttribute(.font, value: newFont, range: subRange)
        }

        return NSAttributedString(attributedString: mutable)
    }
    
    func setFontName(
        in input: NSAttributedString,
        range: NSRange,
        fontName: String
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }

        let mutable = NSMutableAttributedString(attributedString: input)

        mutable.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let font = value as? NSFont else { return }

            // Preserve original font size
            let fontSize = font.pointSize

            // Try to create a font with the given name and original size
            if let newFont = NSFont(name: fontName, size: fontSize) {
                mutable.addAttribute(.font, value: newFont, range: subRange)
            } else {
                // If font name is invalid, keep original font
                mutable.addAttribute(.font, value: font, range: subRange)
            }
        }

        return NSAttributedString(attributedString: mutable)
    }
    func setFontNamePreservingTraits(
        in input: NSAttributedString,
        range: NSRange,
        fontName: String
    ) -> NSAttributedString {
        guard NSMaxRange(range) <= input.length else {
            return input
        }
        
        let mutable = NSMutableAttributedString(attributedString: input)
        
        mutable.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
            guard let oldFont = value as? NSFont else { return }
            
            let fontSize = oldFont.pointSize
            let oldTraits = oldFont.fontDescriptor.symbolicTraits
            
            // Create base descriptor with new family name
            let baseDescriptor = NSFontDescriptor(fontAttributes: [.family: fontName])
            
            // Apply old traits (bold, italic, etc.)
            let newDescriptor = baseDescriptor.withSymbolicTraits(oldTraits)
            
            // Create new font with combined descriptor and size
            let newFont = NSFont(descriptor: newDescriptor, size: fontSize) ?? oldFont
            
            mutable.addAttribute(.font, value: newFont, range: subRange)
        }
        
        return NSAttributedString(attributedString: mutable)
    }
    func setBackgroundColor(
        in input: NSAttributedString,
        range: NSRange,
        color: NSColor
    ) -> NSAttributedString {
        // Validate range
        guard NSMaxRange(range) <= input.length else {
            return input
        }
        
        let mutable = NSMutableAttributedString(attributedString: input)
        
        mutable.addAttribute(.backgroundColor, value: color, range: range)
        
        return NSAttributedString(attributedString: mutable)
    }
}
    


extension ContentView {

    /** ANVÄNDNING:
     
         let example = NSMutableAttributedString(string: "Hello World")
         example.addAttribute(.foregroundColor, value: NSColor.red, range: NSRange(location: 0, length: 5))
         example.addAttribute(.font, value: NSFont.systemFont(ofSize: 18, weight: .bold), range: NSRange(location: 0, length: 5))
         example.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 6, length: 5))
         example.addAttribute(.underlineColor, value: NSColor.blue, range: NSRange(location: 6, length: 5))

         printAttributedStringDetails(example)
     */
    /// Prints detailed text appearance & decoration info for each attribute run in an NSAttributedString.
    func printAttributedStringDetails(_ attributedString: NSAttributedString) {
        let fullRange = NSRange(location: 0, length: attributedString.length)
        
        attributedString.enumerateAttributes(in: fullRange, options: []) { attrs, range, _ in
            print("Range: \(range)")
            
            // 1. Text Appearance
            if let fgColor = attrs[.foregroundColor] as? NSColor {
                print("• Foreground color: \(fgColor)")
            } else {
                print("• Foreground color: nil")
            }
            
            if let bgColor = attrs[.backgroundColor] as? NSColor {
                print("• Background color: \(bgColor)")
            } else {
                print("• Background color: nil")
            }
            
            if let font = attrs[.font] as? NSFont {
                print("• Font: \(font.fontName), size: \(font.pointSize)")
            } else {
                print("• Font: nil")
            }
            
            if let ligature = attrs[.ligature] as? NSNumber {
                print("• Ligatures: \(ligature)")
            } else {
                print("• Ligatures: nil")
            }
            
            if let kern = attrs[.kern] as? NSNumber {
                print("• Kern: \(kern)")
            } else {
                print("• Kern: nil")
            }
            
            if let strokeColor = attrs[.strokeColor] as? NSColor {
                print("• Stroke color: \(strokeColor)")
            } else {
                print("• Stroke color: nil")
            }
            
            if let strokeWidth = attrs[.strokeWidth] as? NSNumber {
                print("• Stroke width: \(strokeWidth)")
            } else {
                print("• Stroke width: nil")
            }
            
            // 2. Text Decoration
            if let underlineStyle = attrs[.underlineStyle] as? NSNumber {
                print("• Underline style: \(underlineStyle)")
            } else {
                print("• Underline style: nil")
            }
            
            if let underlineColor = attrs[.underlineColor] as? NSColor {
                print("• Underline color: \(underlineColor)")
            } else {
                print("• Underline color: nil")
            }
            
            if let strikethroughStyle = attrs[.strikethroughStyle] as? NSNumber {
                print("• Strikethrough style: \(strikethroughStyle)")
            } else {
                print("• Strikethrough style: nil")
            }
            
            if let strikethroughColor = attrs[.strikethroughColor] as? NSColor {
                print("• Strikethrough color: \(strikethroughColor)")
            } else {
                print("• Strikethrough color: nil")
            }
            
            print("— End of range —\n")
        }
    }
    
    /** ANVÄNDNING:
     
         let example = NSMutableAttributedString(string: "Hello World")

         // Add some variety of attributes
         example.addAttribute(.foregroundColor, value: NSColor.red, range: NSRange(location: 0, length: 5))
         example.addAttribute(.font, value: NSFont.systemFont(ofSize: 18, weight: .bold), range: NSRange(location: 0, length: 5))
         example.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 6, length: 5))
         example.addAttribute(.underlineColor, value: NSColor.blue, range: NSRange(location: 6, length: 5))
         example.addAttribute(.shadow, value: {
             let s = NSShadow()
             s.shadowColor = NSColor.black.withAlphaComponent(0.5)
             s.shadowOffset = CGSize(width: 2, height: -2)
             s.shadowBlurRadius = 3
             return s
         }(), range: NSRange(location: 0, length: 11))

         // Print full details
         printFullAttributedStringDetails(example)
     */
    func printFullAttributedStringDetails(_ attributedString: NSAttributedString) {
        let fullRange = NSRange(location: 0, length: attributedString.length)
        
        attributedString.enumerateAttributes(in: fullRange, options: []) { attrs, range, _ in
            print("Range: \(range)")
            
            // 1. TEXT APPEARANCE
            if let fgColor = attrs[.foregroundColor] as? NSColor {
                print("• Foreground color: \(fgColor)")
            } else { print("• Foreground color: nil") }
            
            if let bgColor = attrs[.backgroundColor] as? NSColor {
                print("• Background color: \(bgColor)")
            } else { print("• Background color: nil") }
            
            if let font = attrs[.font] as? NSFont {
                print("• Font: \(font.fontName), size: \(font.pointSize)")
            } else { print("• Font: nil") }
            
            if let ligature = attrs[.ligature] as? NSNumber {
                print("• Ligatures: \(ligature)")
            } else { print("• Ligatures: nil") }
            
            if let kern = attrs[.kern] as? NSNumber {
                print("• Kern: \(kern)")
            } else { print("• Kern: nil") }
            
            if let strokeColor = attrs[.strokeColor] as? NSColor {
                print("• Stroke color: \(strokeColor)")
            } else { print("• Stroke color: nil") }
            
            if let strokeWidth = attrs[.strokeWidth] as? NSNumber {
                print("• Stroke width: \(strokeWidth)")
            } else { print("• Stroke width: nil") }
            
            // 2. TEXT DECORATION
            if let underlineStyle = attrs[.underlineStyle] as? NSNumber {
                print("• Underline style: \(underlineStyle)")
            } else { print("• Underline style: nil") }
            
            if let underlineColor = attrs[.underlineColor] as? NSColor {
                print("• Underline color: \(underlineColor)")
            } else { print("• Underline color: nil") }
            
            if let strikethroughStyle = attrs[.strikethroughStyle] as? NSNumber {
                print("• Strikethrough style: \(strikethroughStyle)")
            } else { print("• Strikethrough style: nil") }
            
            if let strikethroughColor = attrs[.strikethroughColor] as? NSColor {
                print("• Strikethrough color: \(strikethroughColor)")
            } else { print("• Strikethrough color: nil") }
            
            // 3. PARAGRAPH & LAYOUT
            if let paragraphStyle = attrs[.paragraphStyle] as? NSParagraphStyle {
                print("• Paragraph style:")
                print("   – Alignment: \(paragraphStyle.alignment.rawValue)")
                print("   – Line spacing: \(paragraphStyle.lineSpacing)")
                print("   – Paragraph spacing: \(paragraphStyle.paragraphSpacing)")
                print("   – Head indent: \(paragraphStyle.headIndent)")
                print("   – Tail indent: \(paragraphStyle.tailIndent)")
                print("   – First line head indent: \(paragraphStyle.firstLineHeadIndent)")
                print("   – Line break mode: \(paragraphStyle.lineBreakMode.rawValue)")
                print("   – Hyphenation factor: \(paragraphStyle.hyphenationFactor)")
                print("   – Tab stops: \(paragraphStyle.tabStops)")
            } else { print("• Paragraph style: nil") }
            
            // 4. TEXT EFFECTS
            if let shadow = attrs[.shadow] as? NSShadow {
                print("• Shadow:")
                print("   – Color: \(String(describing: shadow.shadowColor))")
                print("   – Offset: \(shadow.shadowOffset)")
                print("   – Blur radius: \(shadow.shadowBlurRadius)")
            } else { print("• Shadow: nil") }
            
            if let baselineOffset = attrs[.baselineOffset] as? NSNumber {
                print("• Baseline offset: \(baselineOffset)")
            } else { print("• Baseline offset: nil") }
            
            if let obliqueness = attrs[.obliqueness] as? NSNumber {
                print("• Obliqueness: \(obliqueness)")
            } else { print("• Obliqueness: nil") }
            
            if let expansion = attrs[.expansion] as? NSNumber {
                print("• Expansion: \(expansion)")
            } else { print("• Expansion: nil") }
            
            if let textEffect = attrs[.textEffect] as? String {
                print("• Text effect: \(textEffect)")
            } else { print("• Text effect: nil") }
            
            // 5. LINKS & ATTACHMENTS
            if let link = attrs[.link] {
                print("• Link: \(link)")
            } else { print("• Link: nil") }
            
            if let attachment = attrs[.attachment] as? NSTextAttachment {
                print("• Attachment: \(attachment)")
            } else { print("• Attachment: nil") }
            
            print("— End of range —\n")
        }
    }



    /// Returns a new NSAttributedString that is displayed as a large outline (stroke) with transparent fill.
    /// - Parameters:
    ///   - input: source NSAttributedString
    ///   - strokeColor: color of the outline
    ///   - strokeWidthPercent: stroke width expressed as percentage of the font point size (positive => stroke only)
    ///   - fontScale: multiplier applied to existing font sizes (default 1.6 to make text "large")
    ///   - targetRange: optional range to apply the effect. If nil, applies to the whole string.
    func outlinedAttributedString(
        from input: NSAttributedString,
        strokeColor: NSColor = .yellow,
        strokeWidthPercent: CGFloat = 8.0,
        fontScale: CGFloat = 1.6,
        targetRange: NSRange? = nil
    ) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: input)
        let fullRange = NSRange(location: 0, length: mutable.length)
        let applyRange = targetRange ?? fullRange
        guard mutable.length > 0 else { return input }

        // Enumerate through attribute runs so we preserve font family, style, etc.
        mutable.enumerateAttributes(in: applyRange, options: []) { attrs, range, _ in
            // Determine the font to use (preserve if present, otherwise use system font)
            let currentFont = (attrs[.font] as? NSFont) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
            let scaledFont = currentFont.withSize(currentFont.pointSize * fontScale)

            // Build new attributes for the range:
            var newAttrs = attrs // start with existing attributes
            // Set transparent fill
            newAttrs[.foregroundColor] = NSColor.clear
            // Set stroke color
            newAttrs[.strokeColor] = strokeColor
            // Set stroke width as percentage of font size (positive => stroke only)
            newAttrs[.strokeWidth] = NSNumber(value: Double(strokeWidthPercent))
            // Apply scaled font
            newAttrs[.font] = scaledFont

            // Optionally you may want to tweak baseline offset so huge fonts align better:
            // newAttrs[.baselineOffset] = NSNumber(value: 0.0)

            // Replace attributes for this run
            mutable.setAttributes(newAttrs, range: range)
        }

        return NSAttributedString(attributedString: mutable)
    }


    /// Returns a new NSAttributedString where the selected range (or whole string) is bold, white, and has a drop shadow.
    /// - Parameters:
    ///   - input: source NSAttributedString
    ///   - shadowColor: color of the drop shadow (default: semi-transparent black)
    ///   - shadowOffset: offset of the shadow (default: (0, -2) — downwards)
    ///   - shadowBlurRadius: blur radius of the shadow (default: 4.0)
    ///   - fontScale: optional multiplier applied to existing font sizes (default 1.0 — keep same size)
    ///   - targetRange: optional range to apply the effect. If nil, applies to the whole string.
    ///
    /** ANVÄNDNING:
     
         let original = NSAttributedString(string: "Important Title",
                                           attributes: [
                                             .font: NSFont.systemFont(ofSize: 28, weight: .regular),
                                             .foregroundColor: NSColor.labelColor
                                           ])

         let styled = boldWhiteWithDropShadow(
             from: original,
             shadowColor: NSColor(calibratedWhite: 0.0, alpha: 0.55),
             shadowOffset: CGSize(width: 0, height: -3),
             shadowBlurRadius: 5.0,
             fontScale: 1.2 // slightly larger
         )

     */
    /// Returns a new NSAttributedString where the selected range (or whole string) is bold, white, and has a drop shadow.
    /// Robustly converts fonts to bold (falls back to descriptor-based creation and finally to system bold).
    func boldWhiteWithDropShadow(
        from input: NSAttributedString,
        shadowColor: NSColor = NSColor(calibratedWhite: 0.0, alpha: 0.6),
        shadowOffset: CGSize = CGSize(width: 0, height: -2),
        shadowBlurRadius: CGFloat = 4.0,
        fontScale: CGFloat = 1.0,
        targetRange: NSRange? = nil
    ) -> NSAttributedString {
        guard input.length > 0 else { return input }

        let mutable = NSMutableAttributedString(attributedString: input)
        let fullRange = NSRange(location: 0, length: mutable.length)
        let applyRange = targetRange ?? fullRange

        // Prepare the shadow once.
        let shadow = NSShadow()
        shadow.shadowColor = shadowColor
        shadow.shadowOffset = NSSize(width: shadowOffset.width, height: shadowOffset.height)
        shadow.shadowBlurRadius = shadowBlurRadius

        let fontManager = NSFontManager.shared

        // Enumerate attribute runs so we preserve other attributes (kern, paragraph style, etc.)
        mutable.enumerateAttributes(in: applyRange, options: []) { attrs, range, _ in
            var newAttrs = attrs

            // Get the current font or fallback to system font
            let currentFont = (attrs[.font] as? NSFont) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
            let targetPointSize = currentFont.pointSize * fontScale

            // 1) First attempt: let NSFontManager produce a bold variant.
            var boldFont = fontManager.convert(currentFont, toHaveTrait: .boldFontMask).withSize(targetPointSize)

            // 2) If you prefer to attempt descriptor-based creation (sometimes necessary for certain families),
            //    create a bold descriptor and try to produce an NSFont from it.
            //    Note: `withSymbolicTraits` returns a non-optional NSFontDescriptor on macOS, so assign it to a let.
            let boldDescriptor = currentFont.fontDescriptor.withSymbolicTraits(.bold)
            if let descriptorBoldFont = NSFont(descriptor: boldDescriptor, size: targetPointSize) {
                boldFont = descriptorBoldFont
            }

            // 3) Final fallback: system bold font
            if boldFont.familyName == nil || boldFont.familyName?.isEmpty == true {
                // In unexpected cases where conversion fails, ensure we have something bold.
                boldFont = NSFont.boldSystemFont(ofSize: targetPointSize)
            }

            // Set attributes: bold font, white fill, and the shadow
            newAttrs[.font] = boldFont
            newAttrs[.foregroundColor] = NSColor.white
            newAttrs[.shadow] = shadow

            mutable.setAttributes(newAttrs, range: range)
        }

        return NSAttributedString(attributedString: mutable)
    }

    /*func boldWhiteWithDropShadow(
        from input: NSAttributedString,
        shadowColor: NSColor = NSColor(calibratedWhite: 0.0, alpha: 0.6),
        shadowOffset: CGSize = CGSize(width: 0, height: -2),
        shadowBlurRadius: CGFloat = 4.0,
        fontScale: CGFloat = 1.0,
        targetRange: NSRange? = nil
    ) -> NSAttributedString {
        // Guard empty
        guard input.length > 0 else { return input }

        let mutable = NSMutableAttributedString(attributedString: input)
        let fullRange = NSRange(location: 0, length: mutable.length)
        let applyRange = targetRange ?? fullRange

        // Create the NSShadow once (we'll reuse it)
        let shadow = NSShadow()
        shadow.shadowColor = shadowColor
        shadow.shadowOffset = NSSize(width: shadowOffset.width, height: shadowOffset.height)
        shadow.shadowBlurRadius = shadowBlurRadius

        // Use NSFontManager to attempt to convert fonts to bold while preserving family/traits
        let fontManager = NSFontManager.shared

        mutable.enumerateAttributes(in: applyRange, options: []) { attrs, range, _ in
            // Preserve existing attributes as starting point
            var newAttrs = attrs

            // Determine current font (or fallback to system font)
            let currentFont = (attrs[.font] as? NSFont) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)
            let targetPointSize = currentFont.pointSize * fontScale

            // Attempt to obtain a bold variant of the current font
            var boldFont: NSFont?
            // First try converting with NSFontManager
            boldFont = fontManager.convert(currentFont, toHaveTrait: .boldFontMask)
            // If conversion didn't change the font family or returned a font with the same traits (no bold available),
            // we attempt to create a descriptor with the bold trait applied.
            if let descriptor = currentFont.fontDescriptor.withSymbolicTraits(.bold) {
                boldFont = NSFont(descriptor: descriptor, size: targetPointSize) ?? boldFont
            }
            // Final fallback: system bold of similar size
            if boldFont == nil {
                boldFont = NSFont.boldSystemFont(ofSize: targetPointSize)
            } else {
                // ensure correct size (convert may keep original size)
                boldFont = boldFont!.withSize(targetPointSize)
            }

            // Set attributes
            newAttrs[.font] = boldFont
            newAttrs[.foregroundColor] = NSColor.white
            newAttrs[.shadow] = shadow

            // Optionally preserve/adjust baselineOffset if fontScale is large (not necessary by default)
            // newAttrs[.baselineOffset] = NSNumber(value: 0.0)

            // Apply attributes to the range
            mutable.setAttributes(newAttrs, range: range)
        }

        return NSAttributedString(attributedString: mutable)
    }*/

}

// MARK: - ❗️FOR DEBUGGING  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*extension ContentView {
    /**
         NSSound. Name ("Basso" )
         NSSound. Name ("Blow")
         NSSound. Name ("Bottle")
         NSSound. Name ("Frog")
         NSSound. Name ("Funk")
         NSSound. Name ("Glass")
         NSSound. Name ("Hero")
         NSSound. Name ("Morse")
         NSSound. Name ("Ping")
         NSSound. Name ("Pop")
         NSSound. Name ("Purr")
         NSSound. Name ("Sosumi")
         NSSound. Name ("Submarine")
         NSSound. Name ("Tink")
     */
    func dropEntered() {
        NSSound(named: "Morse")?.play()
    }
    func dropEntered2() {
        NSSound(named: "Purr")?.play()
    }
    func dropEntered3() {
        NSSound(named: "Tink")?.play()
    }
    
    
    func print_to_debug_window_print_debugging(_ args: Any..., separator: String = " ", terminator: String = "‰\n") {
        if (sharedAppState.app_DEBUG_MODE) {
            let time_now = dateMachine.getCurrentTime()
            let output = args.map(String.init(describing:)).joined(separator: separator)
            if (terminator != "END\n") {
                let nice_terminator = output + "  TIME STAMP {\(time_now)}  " + terminator
                DispatchQueue.main.async {
                    sharedAppState.debug_window_print_debugging.append(contentsOf: nice_terminator)
                }
            } else {
                let nice_terminator = output
                DispatchQueue.main.async {
                    sharedAppState.debug_window_print_debugging.append(contentsOf: nice_terminator)
                }
            }
        }
    }
    func sort_time_stamps_and_print_for_print_debugging() {
        if (sharedAppState.app_DEBUG_MODE) {
            //DispatchQueue.main.async {
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
                let lines_Start = sharedAppState.debug_window_print_debugging
                DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(4)) {
                    
                    let regex = try! NSRegularExpression(pattern: "TIME STAMP \\{(\\d{2}:\\d{2}:\\d{2}\\.\\d{1,9})\\}", options: [])
                    let lines_first = lines_Start.split(separator: ">>").map { String($0) }
                    
                    var final_output = ""
                    
                    for each_timed_action in lines_first {
                        //let lines = lines_first[0].split(separator: "‰\n").map { String($0) }
                        let lines = each_timed_action.split(separator: "‰\n").map { String($0) }
                        
                        var parsed: [(UInt64, String)] = []
                        
                        for line in lines {
                            let nsrange = NSRange(line.startIndex..<line.endIndex, in: line)
                            if let match = regex.firstMatch(in: line, options: [], range: nsrange),
                               let range = Range(match.range(at: 1), in: line) {
                                
                                let ts = String(line[range]) // e.g. "01:33:42.850697994"
                                let parts = ts.split(separator: ":")
                                if parts.count == 3 {
                                    let hour = UInt64(parts[0]) ?? 0
                                    let minute = UInt64(parts[1]) ?? 0
                                    
                                    let secParts = parts[2].split(separator: ".")
                                    if secParts.count == 2,
                                       let second = UInt64(secParts[0]),
                                       let nano = UInt64(secParts[1].padding(toLength: 9, withPad: "0", startingAt: 0)) {
                                        
                                        let totalNanos = hour * 3_600_000_000_000 +
                                        minute * 60_000_000_000 +
                                        second * 1_000_000_000 +
                                        nano
                                        parsed.append((totalNanos, line))
                                    }
                                }
                            }
                        }
                        let sortedLines = parsed.sorted(by: { $0.0 < $1.0 }).map { $0.1 }
                        
                        for line in sortedLines {
                            final_output.append(contentsOf: "\(line)\n")
                        }
                        final_output.append(contentsOf: ">>✅\n\n")
                    }
                    
                    //DispatchQueue.main.asyncAfter(deadline: .now()) {
                    DispatchQueue.main.async {
                        sharedAppState.debug_window_print_debuggingSORTED = ""
                        sharedAppState.debug_window_print_debuggingSORTED.append(contentsOf: final_output)
                    }
                }
            }
        }
    }
    
    /** ANVÄNDNING:
         print_to_debug_window("ContentView", "1")
         print_to_debug_window("ContentView", "2", separator: ", ", terminator: "\n.\n.\n")
         print_to_debug_window("ContentView", "3", separator: "; ")
     */
    func print_to_debug_window_SEQUENTIAL(_ args: Any..., separator: String = " ", terminator: String = "‰\n") {
        if (sharedAppState.app_DEBUG_MODE) {
            let time_now = dateMachine.getCurrentTime()
            let output = args.map(String.init(describing:)).joined(separator: separator)
            let nice_terminator = output + "  TIME STAMP {\(time_now)}  " + terminator
                
            DispatchQueue.main.async {
                sharedAppState.debug_window_attention.append(contentsOf: nice_terminator)
            }
        }
    }
    func print_to_debug_window_ASYNC(_ args: Any..., separator: String = " ", terminator: String = "‰\n") {
        if (sharedAppState.app_DEBUG_MODE) {
            let time_now = dateMachine.getCurrentTime()
            DispatchQueue.global().async {
            //DispatchQueue.global().async {
            //DispatchQueue.main.async {
            //DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                let output = args.map(String.init(describing:)).joined(separator: separator)
                let nice_terminator = output + "  TIME STAMP {\(time_now)}  " + terminator
                DispatchQueue.main.async {
                    sharedAppState.debug_window_attention.append(contentsOf: nice_terminator)
                }
            }
        }
    }
    func sort_time_stamps_and_print() {
        if (sharedAppState.app_DEBUG_MODE) {
            let lines_Start = sharedAppState.debug_window_attention
            DispatchQueue.main.async {
                DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(4)) {
                    
                    let regex = try! NSRegularExpression(pattern: "TIME STAMP \\{(\\d{2}:\\d{2}:\\d{2}\\.\\d{1,9})\\}", options: [])
                    let lines_first = lines_Start.split(separator: ">>").map { String($0) }
                    
                    var final_output = ""
                    
                    for each_timed_action in lines_first {
                        //let lines = lines_first[0].split(separator: "‰\n").map { String($0) }
                        let lines = each_timed_action.split(separator: "‰\n").map { String($0) }
                        
                        var parsed: [(UInt64, String)] = []
                        
                        for line in lines {
                            let nsrange = NSRange(line.startIndex..<line.endIndex, in: line)
                            if let match = regex.firstMatch(in: line, options: [], range: nsrange),
                               let range = Range(match.range(at: 1), in: line) {
                                
                                let ts = String(line[range]) // e.g. "01:33:42.850697994"
                                let parts = ts.split(separator: ":")
                                if parts.count == 3 {
                                    let hour = UInt64(parts[0]) ?? 0
                                    let minute = UInt64(parts[1]) ?? 0
                                    
                                    let secParts = parts[2].split(separator: ".")
                                    if secParts.count == 2,
                                       let second = UInt64(secParts[0]),
                                       let nano = UInt64(secParts[1].padding(toLength: 9, withPad: "0", startingAt: 0)) {
                                        
                                        let totalNanos = hour * 3_600_000_000_000 +
                                        minute * 60_000_000_000 +
                                        second * 1_000_000_000 +
                                        nano
                                        parsed.append((totalNanos, line))
                                    }
                                }
                            }
                        }
                        let sortedLines = parsed.sorted(by: { $0.0 < $1.0 }).map { $0.1 }
                        
                        for line in sortedLines {
                            final_output.append(contentsOf: "\(line)\n")
                        }
                        final_output.append(contentsOf: "\n\t>>✅\n\n")
                    }
                    
                    //DispatchQueue.main.asyncAfter(deadline: .now()) {
                    DispatchQueue.main.async {
                        sharedAppState.debug_window_attentionSORTED = ""
                        sharedAppState.debug_window_attentionSORTED.append(contentsOf: final_output)
                    }
                }
            }
        }
    }
}*/

// MARK: - FOR CONVERSION OF String to NSAttributedString vice versa ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

///Uppgift : att ändra formatet av TaskNote till NSAttributedString så att RichTextKit kan jobba med det och sedan kunna ändra tillbaks till rätt format för att sparas i Realm
extension ContentView {
    
    /**
     func saveAttributedStringToAppStorage() {
         if let data = try? NSKeyedArchiver.archivedData(withRootObject: textt, requiringSecureCoding: false) {
             let base64 = data.base64EncodedString()
             richTextTest = base64
         }
     }

     func loadAttributedStringFromAppStorage() {
         if let data = Data(base64Encoded: richTextTest),
            let attributedString = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSAttributedString {
             textt = attributedString
         }
     }
     */
    
     /**
      func encodeAttributedString(_ attributedString: NSAttributedString) -> String? {
         if let data = try? NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: true) {
             return data.base64EncodedString()
         }
         return nil
     }

     func decodeAttributedString(from base64: String) -> NSAttributedString? {
         guard let data = Data(base64Encoded: base64) else { return nil }

         do {
             let allowedClasses: [AnyClass] = [NSAttributedString.self, NSDictionary.self, NSString.self, NSData.self, NSNumber.self]
             let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
             unarchiver.requiresSecureCoding = true
             unarchiver.setClass(NSAttributedString.self, forClassName: "NSAttributedString")

             let decoded = try unarchiver.decodeTopLevelObject(of: NSAttributedString.self, forKey: NSKeyedArchiveRootObjectKey)
             return decoded
         } catch {
             print("Decoding error: \(error)")
             return nil
         }
     }
    */
    
    /**
    func encodeAttributedString(_ attributedString: NSAttributedString) -> String? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: false)
            return data.base64EncodedString()
        } catch {
            print("Failed to encode attributed string: \(error)")
            return nil
        }
    }
    func decodeAttributedString(from base64: String) -> NSAttributedString? {
        guard let data = Data(base64Encoded: base64) else {
            print("Invalid Base64 string")
            return nil
        }
        do {
            let decoded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSAttributedString
            return decoded
        } catch {
            print("Failed to decode attributed string: \(error)")
            return nil
        }
    }
    */
    func encodeAttributedString(_ attributedString: NSAttributedString) -> String? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: true)
            return data.base64EncodedString()
        } catch {
            //print("Encoding failed: \(error)")
            return nil
        }
    }
    /// Används för att först encode NSAttributedString till base64EncodedString så att man kan göra en "s1.equal(s3)" i miniRedBackButton() eftersom jämförelse av AttributedStrings är lite "svårt" i annat fall
    func encodeAttributedString2(_ attributedString: NSAttributedString) -> String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: true)
            return data.base64EncodedString()
        } catch {
            //print("Encoding failed: \(error)")
            return attributedString.string
        }
    }
    
    func saveTexttToAppStorage() {
        if let encoded = encodeAttributedString(sharedAppState.textt) {
            richTextTest = encoded
        }
    }
    func saveTexttToAppStorage2() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: sharedAppState.textt, requiringSecureCoding: true)
            TaskNameText = data.base64EncodedString()
        } catch {
            //print("Encoding failed: \(error)")
            TaskNameText = sharedAppState.textt.string
        }
        TaskDescriptionText = sharedAppState.textt.string
    }
    func saveTexttToAppStorage3(_ str: NSAttributedString) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: str, requiringSecureCoding: true)
            TaskNameText = data.base64EncodedString()
        } catch {
            //print("Encoding failed: \(error)")
            TaskNameText = str.string
        }
        TaskDescriptionText = str.string
    }
    func saveTexttToAppStorage4(_ str: NSAttributedString) -> String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: str, requiringSecureCoding: true)
            return data.base64EncodedString()
        } catch {
            //print("Encoding failed: \(error)")
            return str.string
        }
    }
    
    
    
    
    
    func decodeAttributedString(from base64: String) -> NSAttributedString? {
        guard let data = Data(base64Encoded: base64) else {
            //print("Base64 decoding failed")
            return nil
        }
        
        do {
            let attributedString = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
            return attributedString
        } catch {
            //print("Decoding failed: \(error)")
            return nil
        }
        // Try decoding a base64 string into AttributedString (if it's a serialized NSAttributedString)
        /*if let decodedData = Data(base64Encoded: base64) {
            do {
                if let nsAttr = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: decodedData) {
                    if let swiftAttr = try? AttributedString(nsAttr, including: \.uiKit) {
                       textt = swiftAttr
                    }
                }
            } catch {
                print("Failed to decode or convert AttributedString: \(error)")
                textt = NSAttributedString(string: originalString)
            }
        }*/
    }
    /*func decodeAttributedString2() -> NSAttributedString? {
        guard let data = Data(base64Encoded: richTextInitialize) else {
            //print("Base64 decoding failed")
            return nil
        }
        
        do {
            let attributedString = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
            //let attributedString = try NSAttributedString(data: data, format: .archivedData)
            return attributedString
        } catch {
            //print("Decoding failed: \(error)")
            return nil
        }
    }*/
    func decodeAttributedString2() -> NSAttributedString? {
        let empty = sharedAppState.darkMode ? sharedAppState.richTextInitializeDarkModeSpaceCharThenNewLineChar : sharedAppState.richTextInitializeLightModeSpaceCharThenNewLineChar
        guard let data = Data(base64Encoded: empty) else {
            //print("Base64 decoding failed")
            return nil
        }
        
        do {
            let attributedString = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
            //let attributedString = try NSAttributedString(data: data, format: .archivedData)
            return attributedString
        } catch {
            //print("Decoding failed: \(error)")
            return nil
        }
    }
    func loadTexttFromAppStorage() {
        if let decoded = decodeAttributedString(from: richTextTest) {
            sharedAppState.textt = decoded
        }
    }
    func loadTexttFromAppStorage2(_ text: String) -> NSAttributedString {
        if let decoded = decodeAttributedString(from: text) {
            return decoded
        } else {
            /*let font = NSFont(name: "Avenir", size: 13)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font as Any,
                //.foregroundColor: UIColor.blue
            ]
             return NSAttributedString(string: text, attributes: attributes)
             attributedQuote.addAttributes(attributes, range: NSRange(location: 0, length: 6))
             
             let attributedQuote = NSMutableAttributedString(string: quote)
             attributedQuote.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 7, length: 5))
             let firstAttributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.green, NSAttributedString.Key.kern: 10]
             */
            return NSAttributedString(string: text)
        }
    }
    // Hämtar lilla texten som saparats i richTextInitialize
    /*func loadTexttFromAppStorage3() -> NSAttributedString {
        if let decoded = decodeAttributedString2() {
            return decoded
        } else {
            return NSAttributedString(string: " ")
        }
    }*/
    func loadTexttFromAppStorage3() -> NSAttributedString {
        if let decoded = decodeAttributedString2() {
            return decoded
        } else {
            return NSAttributedString(string: "  \n")
        }
    }
    func loadTexttFromAppStorage3(_ text: String) -> String {
        if let decoded = decodeAttributedString(from: text) {
            return decoded.string
        } else {
            return text
        }
    }
}

// MARK: -  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

extension ContentView {
    func updateTodaysDate() {
        todaysDate = Date()
        todaysWeekDayName = dateMachine.dayNameOfWeek()
        weekNumberOfYear = dateMachine.weekNumber()
    }
    
    
    /* för rendering vilken lista som ska visas när man är page X popuppen visas */
    func show(pageItemList: Int) {
        //Säkerhetsskull
        shutdownAppButtonIfTrueElseYorN = true
        
        if pageItemList == 0 {
            sharedAppState.currentPopoverPage = 0
            
            sharedAppState.p0StarterPageWith4Buttons = true
            
            sharedAppState.p1showPageIMPandURGPopUp = false
            sharedAppState.p2showPageIMPPopUp = false
            sharedAppState.p3showPageURGPopUp = false
            sharedAppState.p4showPageNOTHINGPopUp = false
            
            sharedAppState.isOnPage = 0
            
        } else if pageItemList == 1 {
            
            sharedAppState.currentPopoverPage = 1
            
            sharedAppState.p0StarterPageWith4Buttons = false
            
            sharedAppState.p1showPageIMPandURGPopUp = true
            sharedAppState.p2showPageIMPPopUp = false
            sharedAppState.p3showPageURGPopUp = false
            sharedAppState.p4showPageNOTHINGPopUp = false
            
            getViewValuesFor(page: 1)
            sharedAppState.isOnPage = 1
        } else if pageItemList == 2 {
            
            sharedAppState.currentPopoverPage = 1
            sharedAppState.p0StarterPageWith4Buttons = false
            
            sharedAppState.p1showPageIMPandURGPopUp = false
            sharedAppState.p2showPageIMPPopUp = true
            sharedAppState.p3showPageURGPopUp = false
            sharedAppState.p4showPageNOTHINGPopUp = false
            
            getViewValuesFor(page: 2)
            sharedAppState.isOnPage = 2
        } else if pageItemList == 3 {
            
            sharedAppState.currentPopoverPage = 1
            sharedAppState.p0StarterPageWith4Buttons = false
            
            sharedAppState.p1showPageIMPandURGPopUp = false
            sharedAppState.p2showPageIMPPopUp = false
            sharedAppState.p3showPageURGPopUp = true
            sharedAppState.p4showPageNOTHINGPopUp = false
            
            getViewValuesFor(page: 3)
            sharedAppState.isOnPage = 3
        } else if pageItemList == 4 {
            
            sharedAppState.currentPopoverPage = 1
            sharedAppState.p0StarterPageWith4Buttons = false
            
            sharedAppState.p1showPageIMPandURGPopUp = false
            sharedAppState.p2showPageIMPPopUp = false
            sharedAppState.p3showPageURGPopUp = false
            sharedAppState.p4showPageNOTHINGPopUp = true
            
            getViewValuesFor(page: 4)
            sharedAppState.isOnPage = 4
        }
    }
    func show2(pageItemList: Int) {
        sharedAppState.currentPopoverPage = 0
        sharedAppState.isOnPage = 0
        
        sharedAppState.p0StarterPageWith4Buttons = true
        sharedAppState.p1showPageIMPandURGPopUp = false
        sharedAppState.p2showPageIMPPopUp = false
        sharedAppState.p3showPageURGPopUp = false
        sharedAppState.p4showPageNOTHINGPopUp = false
    }
    
    func CountIMPandURGTasks() {
        let isThereAny = realmManager.isThereAnyP1Item()
        let isThereMore = realmManager.isThereMoreP1Items()
        sharedAppState.isThereAnyIMPandURGItem = isThereAny
        sharedAppState.isThereMoreThanOneIMPandURGItem = isThereMore
        
        sharedAppState.isThereAnyItem = isThereAny
        sharedAppState.isThereMoreThanOneItem = isThereMore
    }
    func CountIMPTasks() {
        let isThereAny = realmManager.isThereAnyP2Item()
        let isThereMore = realmManager.isThereMoreP2Items()
        sharedAppState.isThereAnyIMPItem = isThereAny
        sharedAppState.isThereMoreThanOneIMPItem = isThereMore
        
        sharedAppState.isThereAnyItem = isThereAny
        sharedAppState.isThereMoreThanOneItem = isThereMore
    }
    func CountURGTasks() {
        let isThereAny = realmManager.isThereAnyP3Item()
        let isThereMore = realmManager.isThereMoreP3Items()
        sharedAppState.isThereAnyURGItem =  isThereAny
        sharedAppState.isThereMoreThanOneURGItem = isThereMore
        
        sharedAppState.isThereAnyItem = isThereAny
        sharedAppState.isThereMoreThanOneItem = isThereMore
    }
    func CountNOTHINGTasks() {
        let isThereAny = realmManager.isThereAnyP4Item()
        let isThereMore = realmManager.isThereMoreP4Items()
        sharedAppState.isThereAnyNOTHINGItem = isThereAny
        sharedAppState.isThereMoreThanOneNOTHINGItem = isThereMore
        
        sharedAppState.isThereAnyItem = isThereAny
        sharedAppState.isThereMoreThanOneItem = isThereMore
    }
    
    
    func getViewValuesFor(page: Int) {
        if page == 1 {
            // för säkerhetsskull
            CountIMPandURGTasks()
            sharedAppState.getViewValuesForP1()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
             callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if sharedAppState.Showing && !sharedAppState.Sorted {
             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
             }*/
        } else if page == 2 {
            // för säkerhetsskull
            CountIMPTasks()
            sharedAppState.getViewValuesForP2()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
             callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if sharedAppState.Showing && !sharedAppState.Sorted {
             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
             }*/
        } else if page == 3 {
            // för säkerhetsskull
            CountURGTasks()
            sharedAppState.getViewValuesForP3()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
             callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if sharedAppState.Showing && !sharedAppState.Sorted {
             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
             }*/
        } else if page == 4 {
            // för säkerhetsskull
            CountNOTHINGTasks()
            sharedAppState.getViewValuesForP4()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
             callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if sharedAppState.Showing && !sharedAppState.Sorted {
             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
             }*/
        }
    }
    
    
    
    /* dessa 2 get ska returnera den Stringen som en Task Item med id == this.CurrentItemID från en sida i RealmManager */
    func getTaskItemWithCurrentIDsTaskNameFor(page: Int) {
        if page == 1 {
            TaskNameText = realmManager.returnP1TaskNameForTaskItemWith(id: CurrentItemID)
        }
        if page == 2 {
            TaskNameText = realmManager.returnP2TaskNameForTaskItemWith(id: CurrentItemID)
        }
        if page == 3 {
            TaskNameText = realmManager.returnP3TaskNameForTaskItemWith(id: CurrentItemID)
        }
        if page == 4 {
            TaskNameText = realmManager.returnP4TaskNameForTaskItemWith(id: CurrentItemID)
        }
    }
    func getTaskItemWithCurrentIDsTaskDescriptionFor(page: Int) {
        if page == 1 {
            TaskDescriptionText = realmManager.returnP1TaskDescriptionForTaskItemWith(id: CurrentItemID)
        }
        if page == 2 {
            TaskDescriptionText = realmManager.returnP2TaskDescriptionForTaskItemWith(id: CurrentItemID)
        }
        if page == 3 {
            TaskDescriptionText = realmManager.returnP3TaskDescriptionForTaskItemWith(id: CurrentItemID)
        }
        if page == 4 {
            TaskDescriptionText = realmManager.returnP4TaskDescriptionForTaskItemWith(id: CurrentItemID)
        }
    }
}

extension ContentView {
    /** Uppgift : att återställa den state/tillsånd som knapparna i HStacken som finns ovanför Listan av task Itemsen ska vara i + ifall man anger TRUE på andra function parametern då så sparar den även tillståndet (SHOW/SORT etc.) som listan blev Renderd för
        Används i :  • RedBackButton
     */
    func resetEditModeValuesAndCountTasksFor(page: Int) {
        if page == 1 {
            CountIMPandURGTasks()
            realmManager.unmarkAllP1ItemisCurrentlyMarkedMarking()
        }
        if page == 2 {
            CountIMPTasks()
            realmManager.unmarkAllP2ItemisCurrentlyMarkedMarking()
        }
        if page == 3 {
            CountURGTasks()
            realmManager.unmarkAllP3ItemisCurrentlyMarkedMarking()
        }
        if page == 4 {
            CountNOTHINGTasks()
            realmManager.unmarkAllP4ItemisCurrentlyMarkedMarking()
        }
        
        sharedAppState.EditMode = false
        
        sharedAppState.AddMode = false
        sharedAppState.AddOneTaskWithTaskName = ""
        
        sharedAppState.MoveMode = false
        sharedAppState.toPage = 0
        sharedAppState.DeleteMode = false
        sharedAppState.rmALLPageMode = false
        
        sharedAppState.SortMode = false
        sharedAppState.SortRequirementOptions = true
        
        sharedAppState.ShowMode = false
        sharedAppState.ShowRequirementOptions = true
        
        sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false // ?? varför
        // för att "resetta" Movemode ifall den var på innan man öppnade tasken
        sharedAppState.showMoveAfterShowFilterAndSortMode = true
    }
    func resetEditModeValuesAndCountTasksFor2(page: Int) {
        if page == 1 {
            realmManager.unmarkAllP1ItemisCurrentlyMarkedMarking()
        }
        if page == 2 {
            realmManager.unmarkAllP2ItemisCurrentlyMarkedMarking()
        }
        if page == 3 {
            realmManager.unmarkAllP3ItemisCurrentlyMarkedMarking()
        }
        if page == 4 {
            realmManager.unmarkAllP4ItemisCurrentlyMarkedMarking()
        }
        
        sharedAppState.EditMode = false
        
        sharedAppState.AddMode = false
        sharedAppState.AddOneTaskWithTaskName = ""
        
        sharedAppState.MoveMode = false
        sharedAppState.toPage = 0
        sharedAppState.DeleteMode = false
        sharedAppState.rmALLPageMode = false
        
        sharedAppState.SortMode = false
        sharedAppState.SortRequirementOptions = true
        
        sharedAppState.ShowMode = false
        sharedAppState.ShowRequirementOptions = true
        
        sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false // ?? varför
        // för att "resetta" Movemode ifall den var på innan man öppnade tasken
        sharedAppState.showMoveAfterShowFilterAndSortMode = true
        
        if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
            sharedAppState.ShowSortRequirementAfterUnshow = true
            sharedAppState.ShowFilterAndSortMode = false
            sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
        }
    }
    
    
    ///Uppgift : att återtälla Views till sitt originella tillstånd när man har EditorMode == true (task name editor och task description editor
    func resetViewValuesFor2EditorPage() {
        rmTaskNameTextChooseOptionIfTrueElseYorN = false
        rmTaskDescriptionTextChooseOptionIfTrueElseYorN = false
        
        restoreTaskNameTextChooseOptionIfTrueElseYorN = false
        restoreTaskDescriptionChooseOptionIfTrueElseYorN = false
        
        txtifTrueElseMarkDownPreviewStyle = true
    }
    
    
    ///Uppgift : att spara TaskName och allt relaterade till current note that is being viewed in 2EditorPage och sedan kalla korrekt sort så att när list of TaskItems visas så visas det rätt
    func exit2EditorPageButtonAction() {
        /*if (sharedAppState.app_DEBUG_MODE) {
            print_to_debug_window_print_debugging(">>\n\n", terminator: "END\n")
            print_to_debug_window_SEQUENTIAL("\n>> Got Out of Note", terminator: "✅\n\n")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                sort_time_stamps_and_print()
                sort_time_stamps_and_print_for_print_debugging()
            }
        }
        */
        
        // För säkerhetsskull
        //sharedAppState.addedOneTask = false   // RÖR ej, ädndra inte värdet av denna i ContentView eftrsom då triggas .onChange(of: addedOneTask) { newValue in } på RichTextEditorn
        sharedAppState.currentNoteIsNew = false
        sharedAppState.added_NEWLINE_CHAR = false
        sharedAppState.wasNoteHavingTextBeforeOpeningTextEditorButIsNowEmptyBeforeExiting = false
        sharedAppState.textt_str_NEWLINE_CHAR = NSAttributedString(string: "")
        
        textEditorIsFocused = false
        sharedAppState.textEditorJustOpenedAndBecameFocused = false
        
        let priority = pickedPriority
        
        if sharedAppState.isOnPage == 1 {
            realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
            if sharedAppState.Sorted && !sharedAppState.Showing {
                callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                if sharedAppState.Showing && !sharedAppState.Sorted {
                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                }
            }
        } else if sharedAppState.isOnPage == 2 {
            realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
            if sharedAppState.Sorted && !sharedAppState.Showing {
                callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                if sharedAppState.Showing && !sharedAppState.Sorted {
                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                }
            }
        } else if sharedAppState.isOnPage == 3 {
            realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
            if sharedAppState.Sorted && !sharedAppState.Showing {
                callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                if sharedAppState.Showing && !sharedAppState.Sorted {
                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                }
            }
        } else if sharedAppState.isOnPage == 4 {
            realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
            if sharedAppState.Sorted && !sharedAppState.Showing {
                callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
            } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                if sharedAppState.Showing && !sharedAppState.Sorted {
                    setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                }
            }
        }
        
        showListofTasksIfTrueElseTwoEditors(true)
        resetViewValuesFor2EditorPage()
        
        sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false // låt Event monitors i AppDelegate.swift veta att inte stänga ner popover som visar ContentView.swift
    }
    
    /**
     Uppgift :
     Används i :
     • if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) {
     ⬇︎
     if !($SortRequirementOptions.wrappedValue) {
     
     • (SAVE-Button) / if !($MDmode.wrappedValue) {
     ⬇︎
     if Sorted {
     */
    func callCorrectRealmSortFor(page: Int, _ byDateIfTrueElsePriority: Bool, _ IncOrDec: Bool) {
        // ifall listan var sorterad innan då ta reda på enligt vilka krav den var sorterad och då sortera tillbaka så att ordningen ej rubbas
        if byDateIfTrueElsePriority {
            if IncOrDec {
                sharedAppState.Sorted = true
                sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = true
                sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing = true
            } else {
                sharedAppState.Sorted = true
                sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = true
                sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing = false
            }
        } else {
            if IncOrDec {
                sharedAppState.Sorted = true
                sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = false
                sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing = true
            } else {
                sharedAppState.Sorted = true
                sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = false
                sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing = false
            }
        }
        
        
        sharedAppState.EditMode = false
        sharedAppState.SortMode = false
        sharedAppState.SortRequirementOptions = true
        
        if page == 1 {
            realmManager.sortP1(sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
        }
        if page == 2 {
            realmManager.sortP2(sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
        }
        if page == 3 {
            realmManager.sortP3(sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
        }
        if page == 4 {
            realmManager.sortP4(sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
        }
    }
    
    func callCorrectRealmShowInShowMode(page: Int) {
        if page == 1 {
            if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                let help = sharedAppState.ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP1ItemsNameContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            } else {
                let help = sharedAppState.ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP1ItemsDescriptionContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountIMPandURGTasks()
        }
        if page == 2 {
            if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                let help = sharedAppState.ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP2ItemsNameContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            } else {
                let help = sharedAppState.ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP2ItemsDescriptionContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountIMPTasks()
        }
        if page == 3 {
            if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                let help = sharedAppState.ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP3ItemsNameContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            } else {
                let help = sharedAppState.ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP3ItemsDescriptionContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountURGTasks()
        }
        if page == 4 {
            if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                let help = sharedAppState.ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP4ItemsNameContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            } else {
                let help = sharedAppState.ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                if !(help.isEmpty) {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP4ItemsDescriptionContaining(name: help)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountNOTHINGTasks()
        }
        
        if sharedAppState.thereIsItemsInCallFromShowButton {
            sharedAppState.Showing = true
            if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                sharedAppState.ShowSortRequirementAfterUnshow = true
                sharedAppState.ShowFilterAndSortMode = false
                sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
            }
            sharedAppState.EditMode = false
            sharedAppState.ShowMode = false
            sharedAppState.ShowRequirementOptions = true
        } else {
            if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                sharedAppState.ShowTextFieldTaskNameFilterResultTextHint = "0 task names                      "
                sharedAppState.ShowCONTAINSTaskName = ""
            } else {
                sharedAppState.ShowTextFieldTaskDescriptionFilterResultTextHint = "0 task descriptions              "
                sharedAppState.ShowCONTAINSTaskDescription = ""
            }
            
            //dropEntered() // Error Sound
        }
    }
    
    
    /**
     Uppgift :
     Används i :
     • (SAVE-Button) / if !($MDmode.wrappedValue) {
     ⬇︎
     if Showing {
     
     •  getViewValuesFor(page: Int) */
    func setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: Int) {
        if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
            sharedAppState.helpWithShowCONTAINS = sharedAppState.ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            sharedAppState.helpWithShowCONTAINS = sharedAppState.ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if page == 1 {
            if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP1ItemsNameContaining(name: sharedAppState.helpWithShowCONTAINS)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP1ItemsDescriptionContaining(name: sharedAppState.helpWithShowCONTAINS)
                }
                
                if sharedAppState.thereIsItemsInCallFromShowButton {
                    sharedAppState.Showing = true
                    
                    if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                        sharedAppState.ShowSortRequirementAfterUnshow = true
                        sharedAppState.ShowFilterAndSortMode = false
                        sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
                    }
                    
                    sharedAppState.EditMode = false
                    sharedAppState.ShowMode = false
                    sharedAppState.ShowRequirementOptions = true
                } else {
                    sharedAppState.Showing = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountIMPandURGTasks()
        }
        if page == 2 {
            if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP2ItemsNameContaining(name: sharedAppState.helpWithShowCONTAINS)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP2ItemsDescriptionContaining(name: sharedAppState.helpWithShowCONTAINS)
                }
                
                if sharedAppState.thereIsItemsInCallFromShowButton {
                    sharedAppState.Showing = true
                    
                    if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                        sharedAppState.ShowSortRequirementAfterUnshow = true
                        sharedAppState.ShowFilterAndSortMode = false
                        sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
                    }
                    
                    sharedAppState.EditMode = false
                    sharedAppState.ShowMode = false
                    sharedAppState.ShowRequirementOptions = true
                } else {
                    sharedAppState.Showing = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountIMPTasks()
        }
        if page == 3 {
            if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP3ItemsNameContaining(name: sharedAppState.helpWithShowCONTAINS)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP3ItemsDescriptionContaining(name: sharedAppState.helpWithShowCONTAINS)
                }
                
                if sharedAppState.thereIsItemsInCallFromShowButton {
                    sharedAppState.Showing = true
                    
                    if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                        sharedAppState.ShowSortRequirementAfterUnshow = true
                        sharedAppState.ShowFilterAndSortMode = false
                        sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
                    }
                    
                    sharedAppState.EditMode = false
                    sharedAppState.ShowMode = false
                    sharedAppState.ShowRequirementOptions = true
                } else {
                    sharedAppState.Showing = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountURGTasks()
        }
        if page == 4 {
            if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
            } else {
                // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                if sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP4ItemsNameContaining(name: sharedAppState.helpWithShowCONTAINS)
                } else {
                    sharedAppState.thereIsItemsInCallFromShowButton = realmManager.showP4ItemsDescriptionContaining(name: sharedAppState.helpWithShowCONTAINS)
                }
                
                if sharedAppState.thereIsItemsInCallFromShowButton {
                    sharedAppState.Showing = true
                    
                    if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                        sharedAppState.ShowSortRequirementAfterUnshow = true
                        sharedAppState.ShowFilterAndSortMode = false
                        sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
                    }
                    
                    sharedAppState.EditMode = false
                    sharedAppState.ShowMode = false
                    sharedAppState.ShowRequirementOptions = true
                } else {
                    sharedAppState.Showing = false
                }
            }
            // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
            CountNOTHINGTasks()
        }
    }
    
    func showListofTasksIfTrueElseTwoEditors(_ show: Bool) {
        if show {
            self.ShowEditor = false
        } else {
            self.ShowEditor = true
        }
    }
}

// MARK: - For Exporting All Notes ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*
extension ContentView {
 
 /*func openDebugWindow() {
     // Get focus from other apps
     NSApplication.shared.activate(ignoringOtherApps: true)
     
     // Create the frame to draw window
     let debugWindow = NSWindow(
         contentRect: NSRect(x: 0, y: 0, width: 500, height: 500),
         styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
         backing: .buffered,
         defer: false
     )
     // Add title
     debugWindow.title = ""
     
     // Keeps window reference active, we need to use this when using NSHostingView
     debugWindow.isReleasedWhenClosed = false // setting this to TRUE shuts down the app if USER closes this window
     
     /* NSHostingView lets us use SwiftUI views with AppKit */
     debugWindow.contentView = NSHostingView(rootView: Debug_Helper().environmentObject(sharedAppState))
     
     debugWindow.hasShadow = true
     
     // Center and bring forward
     debugWindow.center()
     debugWindow.makeKeyAndOrderFront(nil)
 }*/
 /*func openDebugWindow2() {
     
     // If already open and not closed, just bring to front
     if let window = debugWindow, window.isVisible {
         window.makeKeyAndOrderFront(nil)
         return
     }
     
     // Get focus from other apps
     NSApplication.shared.activate(ignoringOtherApps: true)
     
     // Create the frame to draw window
     let window = NSWindow(
         contentRect: NSRect(x: 0, y: 0, width: 500, height: 500),
         styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
         backing: .buffered,
         defer: false
     )
     // Add title
     window.title = "Debug Helper"
     
     // Keeps window reference active, we need to use this when using NSHostingView
     window.isReleasedWhenClosed = false // setting this to TRUE shuts down the app if USER closes this window
     
     /* NSHostingView lets us use SwiftUI views with AppKit */
     window.contentView = NSHostingView(rootView: Debug_Helper().environmentObject(sharedAppState))
     
     window.hasShadow = true
     
     // Center and bring forward
     window.center()
     window.makeKeyAndOrderFront(nil)
     
     // Store the reference
     debugWindow = window

     // Optional: nil the reference when it's closed
     NotificationCenter.default.addObserver(forName: NSWindow.willCloseNotification, object: window, queue: .main) { _ in
         debugWindow = nil
     }
 }*/
    
    func openExportWindow() {
        // Get focus from other apps
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        // Create the frame to draw window
        let exportWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 310, height: 300),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        // Add title
        exportWindow.title = ""
        
        // Keeps window reference active, we need to use this when using NSHostingView
        exportWindow.isReleasedWhenClosed = false
        
        /* NSHostingView lets us use SwiftUI views with AppKit */
        exportWindow.contentView = NSHostingView(rootView: ExportView())
        
        // Center and bring forward
        exportWindow.center()
        exportWindow.makeKeyAndOrderFront(nil)
    }
}
*/

// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

extension ContentView {
    func copyToPasteboard(_ tex: String) {
        do {
            // Write/Copy to pasteboard
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(tex, forType: NSPasteboard.PasteboardType.string)
        } catch {
            print("Error copying to pasteboard:  \(error)")
        }
    }
    func pasteFromPasteboard() -> String {
        var pasted = ""
        do {
            // Read from pasteboard
            let pasteboard = NSPasteboard.general
            pasted = pasteboard.pasteboardItems?.first?.string(forType: .string) ?? ""
            //pasted = pasteboard.pasteboardItems?.first?.string(forType: .rtf) ?? pasteboard.pasteboardItems?.first?.string(forType: .string) ?? ""
        } catch {
            print("Error pasting from pasteboard:  \(error)")
        }
        return pasted
    }
}

 
// MARK: – ContentView_Previews •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
