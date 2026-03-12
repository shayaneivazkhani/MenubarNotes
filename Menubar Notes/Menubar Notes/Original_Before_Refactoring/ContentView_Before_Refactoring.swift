//
//  ContentView_Before_Refactoring.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-02.
//

import SwiftUI
import AppKit
import UniformTypeIdentifiers
import LaunchAtLogin
import RichTextKit

/*
struct ContentView: View {
    
    // MARK: – för alerting/showing messege to user ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var showToast = false
    //@State private var isShowAlert: Bool = false
    
    //@State private var isShowPopover = false
    
    // MARK: – för hantera focusstate på RichTextEditor ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
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
    
    @StateObject private var sharedAppState = AppState()
    
    // MARK: – For Editing the text inside RichTextKit in the 2Editor Page ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @AppStorage("richTextTest") var richTextTest: String = "" // Används inte längre men när skulle implementera richtexten den användes därför referar några exempel-funktioner på denna
    
    @AppStorage("richTextInitialize") var richTextInitialize: String = "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGuCwwVGSAqKyw0Nz9AQ0ZVJG51bGzUDQ4PEBESExRYTlNTdHJpbmdaTlNEZWxlZ2F0ZVxOU0F0dHJpYnV0ZXNWJGNsYXNzgAKAAIAEgA3SEBYXGFlOUy5zdHJpbmeAA1Eg0hobHB1aJGNsYXNzbmFtZVgkY2xhc3Nlc18QD05TTXV0YWJsZVN0cmluZ6McHh9YTlNTdHJpbmdYTlNPYmplY3TTISIQIyYpV05TLmtleXNaTlMub2JqZWN0c6IkJYAFgAaiJyiAB4AJgAxfEBBOU1BhcmFncmFwaFN0eWxlVk5TRm9udNQtLi8QEjEyM1pOU1RhYlN0b3BzW05TQWxpZ25tZW50XxAfTlNBbGxvd3NUaWdodGVuaW5nRm9yVHJ1bmNhdGlvboAAEAQQAYAI0hobNTZfEBBOU1BhcmFncmFwaFN0eWxlojUf1Dg5OhA7PD0+Vk5TU2l6ZVhOU2ZGbGFnc1ZOU05hbWUjQCoAAAAAAAAQEIAKgAtbQXZlbmlyLUJvb2vSGhtBQlZOU0ZvbnSiQR/SGhtERVxOU0RpY3Rpb25hcnmiRB/SGhtHSF1OU1RleHRTdG9yYWdlpElKSx9dTlNUZXh0U3RvcmFnZV8QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmdfEBJOU0F0dHJpYnV0ZWRTdHJpbmcACAARABoAJAApADIANwBJAEwAUQBTAGIAaABxAHoAhQCSAJkAmwCdAJ8AoQCmALAAsgC0ALkAxADNAN8A4wDsAPUA/AEEAQ8BEgEUARYBGQEbAR0BHwEyATkBQgFNAVkBewF9AX8BgQGDAYgBmwGeAacBrgG3Ab4BxwHJAcsBzQHZAd4B5QHoAe0B+gH9AgICEAIVAiMCPwAAAAAAAAIBAAAAAAAAAEwAAAAAAAAAAAAAAAAAAAJU"
    
    @State private var wordCount: Int = 0 // conts words of textt.string
    
    @State var textt = NSAttributedString(string: " ") // Själva RichTexten som visas i 2Editor pagen
    @StateObject var context = RichTextContext() // varför inte @ObservedObject??
    
    @State var textt_str = NSAttributedString(string: " ") // Gets set when a USER presses a note on ListOfNOtes page, then gets used in comparing with the context.attributedtext so that if user have made any changes then the USER shall have the option to choose if he/she wants to save recent changes made to the note before returning

    /*
    // välj från https://danielsaidi.github.io/RichTextKit/documentation/richtextkit/richtextformat/toolbarconfig
    let toolbarConfig = RichTextFormat.ToolbarConfig(
        alignments: [],
        //alignments: .defaultPickerValues,
        //alignments: [.left, .center, .right], // optional: customize alignment buttons
        //colorPickers: [.underline],
        colorPickers: [], // Show text color inline
        colorPickersDisclosed: [], // Show background color in disclosure menu
        indentButtons: false,
        superscriptButtons: false
    )
    let toolbarConfig2 = RichTextFormat.ToolbarConfig(
        alignments: [],
        //alignments: .defaultPickerValues,
        //alignments: [.left, .center, .right], // optional: customize alignment buttons
        //colorPickers: [.underline],
        colorPickers: [], // Show text color inline
        colorPickersDisclosed: [], // Show background color in disclosure menu
        fontPicker: false,
        fontSizePicker: true,
        indentButtons: false,
        superscriptButtons: false
    )
    let toolbarConfig3 = RichTextFormat.ToolbarConfig(
        alignments: [],
        //alignments: .defaultPickerValues,
        //alignments: [.left, .center, .right], // optional: customize alignment buttons
        //colorPickers: [.underline],
        colorPickers: [.foreground], // Show text color inline
        colorPickersDisclosed: [], // Show background color in disclosure menu
        fontPicker: false,
        fontSizePicker: false,
        indentButtons: false,
        styles: [],
        superscriptButtons: false
    )
    let toolbarConfig4 = RichTextFormat.ToolbarConfig(
        alignments: [],
        //alignments: .defaultPickerValues,
        //alignments: [.left, .center, .right], // optional: customize alignment buttons
        //colorPickers: [.underline],
        colorPickers: [], // Show text color inline
        colorPickersDisclosed: [], // Show background color in disclosure menu
        fontPicker: false,
        fontSizePicker: false,
        indentButtons: false,
        styles: [.bold, .italic, .underlined, .strikethrough],
        superscriptButtons: false
    )
    let toolbarConfig5 = RichTextFormat.ToolbarConfig(
        alignments: [],
        //alignments: .defaultPickerValues,
        //alignments: [.left, .center, .right], // optional: customize alignment buttons
        //colorPickers: [.underline],
        colorPickers: [], // Show text color inline
        colorPickersDisclosed: [], // Show background color in disclosure menu
        fontPicker: false,
        fontSizePicker: true,
        indentButtons: false,
        styles: [],
        superscriptButtons: false
    )
    let toolbarStyle = RichTextFormat.ToolbarStyle(
        padding: 2.0,
        spacing: 0
    )
    let toolbarStyle2 = RichTextFormat.ToolbarStyle(
        padding: 0.0,
        spacing: 0
    )
    */
    
    //let editorConf = RichTextView.Configuration(
    let editorConf = RichTextEditorConfig(
        isScrollingEnabled: true,
        isScrollBarsVisible: true,
        isContinuousSpellCheckingEnabled: false
    )
    
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
    /*let fontSizeOptions = [
        FontSizeOption(name: "Title 36", size: 36),
        FontSizeOption(name: "Title 28", size: 28),
        FontSizeOption(name: "Heading 22", size: 22),
        FontSizeOption(name: "Heading 20", size: 18),
        FontSizeOption(name: "Subheading 18", size: 18),
        FontSizeOption(name: "Subheading 16", size: 16),
        FontSizeOption(name: "Body 14", size: 14),
        FontSizeOption(name: "Body 13", size: 13),
        FontSizeOption(name: "Body 12", size: 12),
    ]*/
    let fontSizeOptions: [FontSizeOption] = [
        FontSizeOption(name: "Title 30",     size: 30, name_bold: true,  name_size: 18),
        FontSizeOption(name: "Title 28",     size: 28, name_bold: true,  name_size: 16.5),
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
        "Didot",
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
    /*let textStyleOptions: [textStyleOption] = [
        textStyleOption(name: "Title",      size: 28, name_bold: true,  name_underline: false, name_size: 15.5),
        textStyleOption(name: "Heading",    size: 22, name_bold: false,  name_underline: false,  name_size: 13),
        textStyleOption(name: "Subheading", size: 18, name_bold: true, name_underline: true, name_size: 11),
        textStyleOption(name: "Body",       size: 14, name_bold: false, name_underline: false, name_size: 10.5),
    ]*/
    let textStyleOptions: [textStyleOption] = [
        textStyleOption(name: "Title",      size: 28, name_bold: true,  name_underline: false, name_size: 15.5),
        textStyleOption(name: "Heading",    size: 22, name_bold: false,  name_underline: true,  name_size: 13),
        textStyleOption(name: "Subheading", size: 18, name_bold: true, name_underline: false, name_size: 11),
        textStyleOption(name: "Body",       size: 14, name_bold: false, name_underline: false, name_size: 10.5),
    ]
    
    // MARK: – För miniRadBackButton Dialog (save & Exit or just exit) inside the 2Editor Page ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@State private var isShow = false
    //@State private var selectMenu = "None"
    
    @State private var anyNewChanges: Bool = false
    @State private var anyNewChangesInOnlyTextColor: Bool = false
    @State private var showingConfirmationDialog: Bool = false
    private var confirmationDialogTitle: String = "Do you want to save the recent changes made to this note?"
    private var confirmationDialogMessage: String = "" //"If you choose option 2 ’Exit’ no changes will be saved"
    
    // MARK: – För multi windowed app ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
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
    
    // MARK: – ⭐️ För Priority Picker
    //@State private var priorities = [ "𝚘", "●", "●●", "●●●", "●●●●", "●●●●●"]
    //@State private var priorities = [ "0", "1", "2", "3", "4", "5"]
    @State private var priorities = [ "0", "1", "2"]
    @State private var pickedPriority = 0
    
    // Array of colors for dark mode and light mode
    let darkModeColors: [Color] = [
        .gray.opacity(0.4),
        Color.neuOrangePriority2.opacity(0.5),
        Color.neuOrangePriority4.opacity(0.7),
    ]
    
    let lightModeColors: [Color] = [
        .gray.opacity(0.6),
        Color.neuOrangePriority1,
        Color.neuOrangePriority4,
    ]
    
    // MARK: – For FILE EXPORTER skriva ut 4 Listorna i varsin .txt fil varsin  ・・・・・・・・・・・・・・
    /**
                WTF se till att nulla dessa så att du inte exporterar din egna värde till folk
     */
    @AppStorage("PAGE1EXPORT") private var p1FileExportString: String = ""
    @AppStorage("PAGE2EXPORT") private var p2FileExportString: String = ""
    @AppStorage("PAGE3EXPORT") private var p3FileExportString: String = ""
    @AppStorage("PAGE4EXPORT") private var p4FileExportString: String = ""
    
    // MARK: –  markdown ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
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
    
    // MARK: – to show the current date on the first page & välja Task Itemsens Date() ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @State private var currenttimetext = Date()
    @State private var timetext = Date()
    
    @State var selectedDate = Date()
    
    // MARK: – ⚠️ Developer Settings (ghost set everything behind the scenes) & expiration Date + SET week number・・・・・・・・・・・・・・・・・・・
    
    @State private var showDeveloperSettingsToggleButton: Bool = false
    @State private var developerSettings: Bool = false
    
    @State private var countSettingsObjectsInRealm = 0
    
    // MARK: – for using the Date and calender time thingis ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
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
    
    // MARK: – for using the Date and calender time thingis ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @AppStorage("engine_name") private var engine_url_name: String = "Google"
    @AppStorage("showAddEngineOverlay") var showAddEngineOverlay: Bool = false
    @AppStorage("newEngineName") var newEngineName: String = ""
    @AppStorage("newEngineURL") var newEngineURL: String = ""
    
    @AppStorage("multi_function_button") private var multi_func_button: String = "Day Counter"
    
//・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    public init() {
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
                        
// power–Button,Launch at login Toggle &  Dark/Light mode Toggle
                        VStack (alignment: .leading) {
                            HStack (spacing: 0) {
                                HStack (spacing: 0) {
                                    //Search_Engines()
                                    LaunchAtLogin.Toggle()
                                        .toggleStyle(AutoLaunchToggle())
                                        .help(Text("When computer starts this app will start and appear in menubar automatically"))
                                    Spacer()
                                }.frame(width: 98, alignment: .leading)
                                 .offset(CGSize(width: 1.00, height: -6.00))
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
                                        AboutApplicationView_SheetView_Dismiss()
                                        
                                        /*Text("∙")
                                            .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
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
                                         */
                                         
                                        Text("∙")
                                            .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        Button(
                                            action: {
                                                self.shutdownAppButtonIfTrueElseYorN = false
                                            },
                                            label: {
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
                                            Text("Shutdown? ")
                                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                                .shadow(radius: 0.6)
                                            Button(
                                                action: {
                                                    self.shutdownAppButtonIfTrueElseYorN = true
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
                                                    self.shutdownAppButtonIfTrueElseYorN = true
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
                                }.frame(width: 145, alignment: .trailing)
                                 .offset(CGSize(width: 0.00, height: -12.00))
                            }
                        }.frame(width: 407, alignment: .trailing) //.frame(width: 317, alignment: .trailing)
                         .offset(CGSize(width: 0.00, height: -6.00))
                         .padding(1)
                        
                        /*HStack (spacing: 0) {
                            Text(engine_url_name)
                                .font(.system(size: 9, weight: .light, design: .monospaced))
                                .frame(alignment: .leading)
                            HStack {
                                Spacer()
                            }.frame(width: 200)
                        }.frame(width: 317)
                         .offset(CGSize(width: 0, height: -9))
                         .shadow(radius: 0.6)
                         */
                        
                        Spacer().padding()
                        
                        // 4 Buttons --> List of Items
                        //if $ifAppisNotPastExpirationDate.wrappedValue {
                        if $sharedAppState.p0StarterPageWith4Buttons.wrappedValue {
                            VStack (spacing: 8) {
                                HStack (spacing: 8) {
                                    Button(
                                        action: {
                                            show(pageItemList: 1)
                                        },
                                        label: {
                                            Text("Important")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.foregroundColor(sharedAppState.darkMode ? Color.neuGrayDark : Color.fourButtonTextLightMode)
                                                //.fontWeight(.light)
                                                .font(.system(size: 29, weight: .light, design: .default))
                                                //.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                //.frame(alignment: .topTrailing)
                                                .frame(width: 170, height: 80)
                                                //.shadow(radius: 0.4)
                                        }
                                    ).buttonStyle(neufourButtonStyle())
                                     .offset(CGSize(width: -16.00, height: -50.00))
                                    Button(
                                        action: {
                                            show(pageItemList: 2)
                                        },
                                        label: {
                                            Text("Useful")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.fontWeight(.light)
                                                .font(.system(size: 25, weight: .light, design: .default))
                                                .frame(width: 120, height: 65, alignment: .center)
                                                //.shadow(radius: 0.4)
                                        }
                                    ).buttonStyle(neufourButtonStyle2())
                                     .offset(CGSize(width: -6.00, height: 17.00))
                                }
                                HStack (spacing: 8) {
                                    Button(
                                        action: {
                                            show(pageItemList: 3)
                                        },
                                        label: {
                                            Text("Urgent")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.fontWeight(.light)
                                                .font(.system(size: 22, weight: .light, design: .default))
                                                .frame(width: 110, height: 55, alignment: .center)
                                                //.shadow(radius: 0.4)
                                        }
                                    ).buttonStyle(neufourButtonStyle2())
                                     .offset(CGSize(width: 6.00, height: -22.00))
                                    Button(
                                        action: {
                                            show(pageItemList: 4)
                                        },
                                        label: {
                                            Text("Other")
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                //.fontWeight(.ultraLight)
                                                .font(.system(size: 19, weight: .light, design: .default))
                                                .frame(width: 70, height: 35, alignment: .center)
                                                //.shadow(radius: 0.2)
                                        }
                                    ).buttonStyle(neufourButtonStyle3())
                                     .offset(CGSize(width: 19.00, height: 12.00))
                                }
                            }.frame(alignment: .center)
                             .offset(CGSize(width: 7.00, height: 13.00))
                        }
                        // } // MARK: – för if $ifAppisNotPastExpirationDate.wrappedValue {
                        
                        Spacer().padding()
                        
                        // MARK: – HStack med Knapparna längst ner på första sidan
                        VStack (alignment: .leading) {
                            HStack {
                                HStack (spacing: 2) {
                                    Text("\(todaysWeekDayName)")
                                        //.font(.custom("Avenir", size: 12))
                                        .font(.custom("Avenir", size: 14).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        .shadow(radius: 0.6)
                                    Text("∙")
                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        .shadow(radius: 0.6)
                                    Text(todaysDate, style: .date)
                                        //.font(.custom("Avenir", size: 12))
                                        .font(.custom("Avenir", size: 14).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                        .shadow(radius: 0.6)
                                    Text("∙")
                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        .shadow(radius: 0.6)
                                    //Text("w")
                                    Text("week")
                                        //.font(.custom("Avenir", size: 12))
                                        .font(.custom("Avenir", size: 14).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                        .shadow(radius: 0.6)
                                    Text("\(weekNumberOfYear)")
                                        .font(.custom("Avenir", size: 14).weight(.regular))
                                        //.foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                        .shadow(radius: 0.6)
                                }.frame(alignment: .bottomLeading)
                                 .offset(CGSize(width: 0, height: 2))
                                
                                Spacer()
                                
                                /*HStack (spacing: 1) {
                                    Button(
                                        action: {
                                            
                                            if (self.showDayCounter) {
                                                self.showDayCounter.toggle()
                                            }
                                            self.showWeekFinder.toggle()
                                        },
                                        label: {
                                            Text("W ")
                                                .font(.custom("Avenir", size: 11).weight(.bold))
                                            //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                                .shadow(radius: 0.6)
                                        }
                                    ).buttonStyle(ClearImageBackground())
                                        .frame(alignment: .bottomTrailing)
                                        .offset(CGSize(width: 0, height: 2))
                                    Button(
                                        action: {
                                            if (self.showWeekFinder) {
                                                self.showWeekFinder.toggle()
                                            }
                                            
                                            if (!self.showDayCounter) {
                                                fromThisDate = Date()
                                                toThisDate = Date()
                                            }
                                            self.showDayCounter.toggle()
                                        },
                                        label: {
                                            Image(systemName: "stopwatch.fill")
                                                //.renderingMode(.template) //MARK: – 🩸 hur väljer en "tema" av SF Symbol Image
                                                //.renderingMode(.original)
                                                //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.primary)
                                                .foregroundColor(sharedAppState.darkMode ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                        }
                                    ).buttonStyle(ClearImageBackground())
                                     .frame(alignment: .bottomTrailing)
                                    
                                }*/
                            }
                        }.frame(width: 395, height: 35, alignment: .bottom) //.frame(width: 310, height: 35, alignment: .bottom)
                         .padding(3)
                        
                    }.frame(width: 400, height: 630) //.frame(width: 315, height: 500) // MARK: –  VStack INSIDE ZSTACK
                     .padding(1)
                     .background(
                        Toggle("Dark/Light mode Toggle",isOn: $sharedAppState.darkMode)
                            .toggleStyle(DarkModeToggle2())
                     )
                     .onAppear() {
                         //dropEntered()
                         
                         /*if (sharedAppState.darkMode) {
                             sharedAppState.darkMode = false
                         }*/
                         
                         /*todaysDate = Date()
                         todaysWeekDayName = dateMachine.dayNameOfWeek()
                         weekNumberOfYear = dateMachine.weekNumber()*/
                         if (todaysWeekDayName != dateMachine.dayNameOfWeek()) {
                             todaysDate = Date()
                             todaysWeekDayName = dateMachine.dayNameOfWeek()
                             weekNumberOfYear = dateMachine.weekNumber()
                         }
                     }
                     .onHover() { r in
                         //dropEntered()
                         
                         /*if (sharedAppState.darkMode) {
                             sharedAppState.darkMode = false
                         }*/
                         
                         /*todaysDate = Date()
                         todaysWeekDayName = dateMachine.dayNameOfWeek()
                         weekNumberOfYear = dateMachine.weekNumber()
                         */
                         
                         if (todaysWeekDayName != dateMachine.dayNameOfWeek()) {
                             todaysDate = Date()
                             todaysWeekDayName = dateMachine.dayNameOfWeek()
                             weekNumberOfYear = dateMachine.weekNumber()
                         }
                     }
            /*#if os(iOS)
                     .onAppear() {
                         todaysDate = Date()
                         todaysWeekDayName = dateMachine.dayNameOfWeek()
                         weekNumberOfYear = dateMachine.weekNumber()
                     }
            #endif
             */
                    
                    /*if $showDayCounter.wrappedValue {
                        DayCounter($fromThisDate, $toThisDate, $itIsThisManyYears, $itIsThisManyMonths, $itIsThisManyDays)
                    }
                    if $showWeekFinder.wrappedValue {
                        WeekFinderINNER()
                    }*/
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

                                    ListPage_TopMenu() // HStacken ovanpå listofNotes som innehåller alla edit och sort buttons
                                    
                                    if $sharedAppState.p1showPageIMPandURGPopUp.wrappedValue {
// MARK: –  PAGE 1 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                        Elevator {
                                            ForEach(realmManager.p1Tasks, id: \.id) { p1TaskItem in
                                                
                                                HStack (spacing: 3) {
                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                        VStack (spacing: 0) {
                                                            Button(
                                                                action: {
                                                                    p1TaskItem.isCurrentlyMarked == false ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                    
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
                                                                    p1TaskItem.isCurrentlyMarked == false ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                    
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
                                                                self.textt = str
                                                                self.textt_str = str
                                                                anyNewChanges = false
                                                                anyNewChangesInOnlyTextColor = false
                                                                
                                                                textEditorIsFocused = true
                                                                
                                                                MDmode = false
                                                                showListofTasksIfTrueElseTwoEditors(false)

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
                                    } else if $sharedAppState.p2showPageIMPPopUp.wrappedValue {
// MARK: –  PAGE 2 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                        Elevator {
                                            ForEach(realmManager.p2Tasks, id: \.id) { p2TaskItem in
                                                HStack (spacing: 3) {
                                                    
                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                        VStack (spacing: 0) {
                                                            Button(
                                                                action: {
                                                                    p2TaskItem.isCurrentlyMarked == false ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                    
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
                                                                    p2TaskItem.isCurrentlyMarked == false ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                    
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
                                                                self.textt = str
                                                                self.textt_str = str
                                                                anyNewChanges = false
                                                                anyNewChangesInOnlyTextColor = false
                                                                
                                                                textEditorIsFocused = true
                                                                
                                                                MDmode = false
                                                                showListofTasksIfTrueElseTwoEditors(false)

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
                                    } else if $sharedAppState.p3showPageURGPopUp.wrappedValue {
// MARK: –  PAGE 3 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                        Elevator {
                                            ForEach(realmManager.p3Tasks, id: \.id) { p3TaskItem in
                                                HStack (spacing: 3) {
                                                    
                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                        VStack (spacing: 0) {
                                                            Button(
                                                                action: {
                                                                    p3TaskItem.isCurrentlyMarked == false ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                    
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
                                                                    p3TaskItem.isCurrentlyMarked == false ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                    
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
                                                                self.textt = str
                                                                self.textt_str = str
                                                                anyNewChanges = false
                                                                anyNewChangesInOnlyTextColor = false
                                                                
                                                                textEditorIsFocused = true
                                                                
                                                                MDmode = false
                                                                showListofTasksIfTrueElseTwoEditors(false)
                                                                
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
                                    } else if $sharedAppState.p4showPageNOTHINGPopUp.wrappedValue {
// MARK: –  PAGE 4 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                        Elevator {
                                            ForEach(realmManager.p4Tasks, id: \.id) { p4TaskItem in
                                                HStack (spacing: 3) {
                                                    
                                                    if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) {
                                                        VStack (spacing: 0) {
                                                            Button(
                                                                action: {
                                                                    p4TaskItem.isCurrentlyMarked == false ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                    
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
                                                                    p4TaskItem.isCurrentlyMarked == false ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                    
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
                                                                
                                                                //loadTexttFromAppStorage()
                                                                
                                                               /*let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                textt = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                */
                                                                
                                                                //fixRichTextColor() Funkar inte
                                                                
                                                                
                                                                /*//textt = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                //textt = str
                                                                context.handle(.setAttributedString(str))
                                                                //context.trigger(.setAttributedString(str))
                                                                */
                                                                
                                                                let name = p4TaskItem.taskNAME // make sure taskname inte är en ""
                                                                let richtext = loadTexttFromAppStorage2(name)
                                                                let str = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                self.textt = str
                                                                self.textt_str = str
                                                                //context.isEditingText = true
                                                                //context.handle(.setAttributedString(str))
                                                                //context.trigger(.setAttributedString(str))
                                                                anyNewChanges = false
                                                                anyNewChangesInOnlyTextColor = false
                                                                
                                                                textEditorIsFocused = true
                                                                
                                                                MDmode = false
                                                                showListofTasksIfTrueElseTwoEditors(false)

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
                                    } // MARK: – för if $p4showPageNOTHINGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) {
                                    
                                    Button(
                                        action: {
                                            let onThepage = sharedAppState.isOnPage
                                            show2(pageItemList: 0)
                                            updateTodaysDate()
                                            if !(sharedAppState.ShowingAndSortedIfTrueElseShowing) {
                                                sharedAppState.ShowSortRequirementAfterUnshow = true
                                                sharedAppState.ShowFilterAndSortMode = false
                                                sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue = false
                                            }
                                            resetEditModeValuesAndCountTasksFor2(page: onThepage)
                                            sharedAppState.SetTheViewingStateOfAPageInRealm(forPage: onThepage)
                                        },
                                        label: {
                                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                                .font(.system(size: 25))
                                                .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode : Color.neuOrangeLight)
                                                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                .frame(width: 362, height: 9) //.frame(width: 272, height: 9) // MARK: –  RedbackButton 🌈 styra storleken direkt med värden för Bilden
                                        }
                                    ).buttonStyle(RedBackButton())
                                }
                            }
                        }.frame(width: 390, height: 625) //.frame(width: 305, height: 495) // VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                    } // Avslut för if !($ShowEditor.wrappedValue) {
                    
// MARK: – 💧📺  2Editor Page💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                    if $ShowEditor.wrappedValue {
                        VStack (spacing: 2) { // väljer avståndet mellan (Elevator + ForEach)} och Den .bottom HStacken som har SAVE och .md
                            
                            if !($MDmode.wrappedValue) {
                                
                                VStack (spacing: 0) {
                                    VStack {
                                        ZStack {
// MARK: – Top RichText Edit attributes Buttons
                                            VStack (spacing: 1) {
                                                /*HStack (spacing: 0) {
                                                     Spacer().frame(width: 235)
                                                     RichTextFormat.Toolbar(context: context)
                                                     .richTextFormatToolbarConfig(toolbarConfig5)
                                                     .richTextFormatToolbarStyle(toolbarStyle)
                                                     .frame(width: 45)
                                                 }//.frame(width: 45)
                                                 */
                                                
                                                /*ScrollView(.horizontal) {
                                                     RichTextFormat.Toolbar(context: context)
                                                     .richTextFormatToolbarConfig(toolbarConfig)
                                                     .richTextFormatToolbarStyle(toolbarStyle)
                                                 }*/
                                                //.frame(width: 395, height: 130)
                                                
                                                /*ScrollView(.horizontal) {
                                                     RichTextFormat.Toolbar(context: context)
                                                     .richTextFormatToolbarConfig(toolbarConfig2)
                                                     .richTextFormatToolbarStyle(toolbarStyle)
                                                 }*/
                                                
                                                /*HStack (spacing: 15) {
                                                     HStack  {
                                                     Spacer()
                                                     }.frame(width: 235)
                                                     RichTextFormat.Toolbar(context: context)
                                                     .richTextFormatToolbarConfig(toolbarConfig2)
                                                     .richTextFormatToolbarStyle(toolbarStyle)
                                                 }.frame(width: 395)
                                                 */
                                                    
                                                HStack (spacing: 10) {
                                                    /*ScrollView(.horizontal) {
                                                         RichTextFormat.Toolbar(context: context)
                                                         .richTextFormatToolbarConfig(toolbarConfig3)
                                                         .richTextFormatToolbarStyle(toolbarStyle2)
                                                         //.offset(CGSize(width: 0.00, height: -5.00))
                                                         //.frame(height: 44)
                                                     }
                                                     */
                                                    /*RichTextFormat.Sidebar(context: context)
                                                     .richTextFormatSidebarConfig(
                                                         .init(
                                                             alignments: [],
                                                             //alignments: .defaultPickerValues,
                                                             //alignments: [.left, .center, .right], // optional: customize alignment buttons
                                                             //colorPickers: [.underline],
                                                             colorPickers: [], // Show text color inline
                                                             colorPickersDisclosed: [], // Show background color in disclosure menu
                                                             fontPicker: true,
                                                             fontSizePicker: false,
                                                             indentButtons: false,
                                                             styles: [],
                                                             superscriptButtons: false
                                                         )
                                                     )
                                                     .richTextFormatToolbarStyle(toolbarStyle)
                                                     .frame(width: 130, height: 64)
                                                     .offset(CGSize(width: 0.00, height: 10.00))
                                                     */
                                                    /*RichTextFormat.Sidebar(context: context)
                                                        .richTextFormatSidebarConfig(
                                                            .init(
                                                                alignments: [],
                                                                //alignments: .defaultPickerValues,
                                                                //alignments: [.left, .center, .right], // optional: customize alignment buttons
                                                                //colorPickers: [.underline],
                                                                colorPickers: [], // Show text color inline
                                                                colorPickersDisclosed: [], // Show background color in disclosure menu
                                                                fontPicker: false,
                                                                fontSizePicker: false,
                                                                indentButtons: false,
                                                                styles: [.bold, .italic, .underlined, .strikethrough],
                                                                superscriptButtons: false
                                                            )
                                                        )
                                                        .richTextFormatToolbarStyle(toolbarStyle2)
                                                        //.controlSize(.small)
                                                        .controlSize(.regular)
                                                        //.hoverMod()
                                                        .frame(width: 155, height: 64)
                                                        //.offset(CGSize(width: 3.00, height: 10.00))
                                                        .offset(CGSize(width: 3.00, height: 10.00))
                                                     */
                                                    
                                                    /*RichTextFormat.Sidebar(context: context)
                                                        .richTextFormatSidebarConfig(
                                                            .init(
                                                                alignments: [],
                                                                //alignments: .defaultPickerValues,
                                                                //alignments: [.left, .center, .right], // optional: customize alignment buttons
                                                                //colorPickers: [.underline],
                                                                colorPickers: [], // Show text color inline
                                                                colorPickersDisclosed: [], // Show background color in disclosure menu
                                                                fontPicker: false,
                                                                fontSizePicker: true,
                                                                indentButtons: false,
                                                                styles: [],
                                                                superscriptButtons: false
                                                            )
                                                        )
                                                        .richTextFormatToolbarStyle(toolbarStyle2)
                                                        //.controlSize(.small)
                                                        .controlSize(.regular)
                                                        .frame(width: 90, height: 64)
                                                        .offset(CGSize(width: -17.00, height: 10.00))*/
                                                    VStack {
                                                        HStack (spacing: 0) {
                                                            /*RoundToggleButton(isOn: context.binding(for: .bold), changedStyle: $anyNewChanges)
                                                            RoundToggleButton(isOn: context.binding(for: .italic), changedStyle: $anyNewChanges)
                                                            RoundToggleButton(isOn: context.binding(for: .underlined), changedStyle: $anyNewChanges)
                                                            RoundToggleButton(isOn: context.binding(for: .strikethrough), changedStyle: $anyNewChanges)
                                                            */
                                                            
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        let cursor_position = context.selectedRange.upperBound
                                                                        let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                        
                                                                        if (context.binding(for: .bold).wrappedValue) {
                                                                            context.handle(.setStyle(.bold, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.bold, true))
                                                                        }
                                                                        /*context.styles.hasStyle(.bold)
                                                                         context.handle(.setStyle(.bold, true))*/
                                                                        
                                                                        context.handle(.selectRange(emptyRange))
                                                                        context.resetSelectedRange()
                                                                        
                                                                        anyNewChanges = true
                                                                    } else {
                                                                        //context.fontName = name
                                                                        withAnimation {
                                                                            showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Image(systemName: "bold")
                                                                        .font(.system(size: 14))
                                                                        .frame(width: 28, height: 15.5)
                                                                        .foregroundColor(.black)
                                                                        .padding(2)
                                                                        .background(context.binding(for: .bold).wrappedValue ?
                                                                                    Color.accentColor.opacity(0.91) : Color.generalButtonsBackgroundColorLightMode)
                                                                        //.clipShape(Circle())
                                                                        .clipShape(Rectangle())
                                                                        /*.onTapGesture {
                                                                            withAnimation {
                                                                                showToast = true
                                                                            }
                                                                        }*/
                                                                }
                                                            ).buttonStyle(ClearImageBackground3())
                                                             .keyboardShortcut("b", modifiers: [.command])
                                                            
                                                            Divider()
                                                                .frame(width: 1, height: 19)
                                                                .background(Color.neuGray2)
                                                            
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        let cursor_position = context.selectedRange.upperBound
                                                                        let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                        
                                                                        if (context.binding(for: .italic).wrappedValue) {
                                                                            context.handle(.setStyle(.italic, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.italic, true))
                                                                        }
                                                                        
                                                                        context.handle(.selectRange(emptyRange))
                                                                        context.resetSelectedRange()
                                                                        
                                                                        anyNewChanges = true
                                                                    } else {
                                                                        withAnimation {
                                                                            showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Image(systemName: "italic")
                                                                        .font(.system(size: 14))
                                                                        .frame(width: 28, height: 15.5)
                                                                        .foregroundColor(.black)
                                                                        .padding(2)
                                                                        .background(context.binding(for: .italic).wrappedValue ?
                                                                                    Color.accentColor.opacity(0.91) : Color.generalButtonsBackgroundColorLightMode)
                                                                        //.clipShape(Circle())
                                                                        .clipShape(Rectangle())
                                                                }
                                                            ).buttonStyle(ClearImageBackground3())
                                                                .keyboardShortcut("i", modifiers: [.command])
                                                            
                                                            Divider()
                                                                .frame(width: 1, height: 19)
                                                                .background(Color.neuGray2)
                                                            
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        let cursor_position = context.selectedRange.upperBound
                                                                        let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                        
                                                                        if (context.binding(for: .underlined).wrappedValue) {
                                                                            context.handle(.setStyle(.underlined, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.underlined, true))
                                                                        }
                                                                        
                                                                        context.handle(.selectRange(emptyRange))
                                                                        context.resetSelectedRange()
                                                                        
                                                                        anyNewChanges = true
                                                                    } else {
                                                                        withAnimation {
                                                                            showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Image(systemName: "underline")
                                                                        .font(.system(size: 13))
                                                                        .frame(width: 28, height: 15.5)
                                                                        .foregroundColor(.black)
                                                                        .padding(2)
                                                                        .background(context.binding(for: .underlined).wrappedValue ?
                                                                                    Color.accentColor.opacity(0.91) : Color.generalButtonsBackgroundColorLightMode)
                                                                        .clipShape(Rectangle())
                                                                }
                                                            ).buttonStyle(ClearImageBackground3())
                                                             .keyboardShortcut("u", modifiers: [.command])
                                                            
                                                            Divider()
                                                                .frame(width: 1, height: 19)
                                                                .background(Color.neuGray2)
                                                                //.frame(width: 1, height: 12, alignment: .bottom)
                                                                //.padding(.horizontal, 1)
                                                            
                                                            Button(
                                                                action: {
                                                                    if (context.hasSelectedRange) {
                                                                        let cursor_position = context.selectedRange.upperBound
                                                                        let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                        
                                                                        if (context.binding(for: .strikethrough).wrappedValue) {
                                                                            context.handle(.setStyle(.strikethrough, false))
                                                                        } else {
                                                                            context.handle(.setStyle(.strikethrough, true))
                                                                        }
                                                                        
                                                                        context.handle(.selectRange(emptyRange))
                                                                        context.resetSelectedRange()
                                                                        
                                                                        anyNewChanges = true
                                                                    } else {
                                                                        withAnimation {
                                                                            showToast = true
                                                                        }
                                                                    }
                                                                },
                                                                label: {
                                                                    Image(systemName: "strikethrough")
                                                                        .font(.system(size: 16))
                                                                        //.resizable()
                                                                        //.scaledToFit()
                                                                        .frame(width: 28, height: 15.5)
                                                                        .foregroundColor(.black)
                                                                        .padding(2)
                                                                        .background(context.binding(for: .strikethrough).wrappedValue ?
                                                                                    Color.accentColor.opacity(0.91) : Color.generalButtonsBackgroundColorLightMode)
                                                                        //.clipShape(Circle())
                                                                        .clipShape(Rectangle())
                                                                }
                                                            ).buttonStyle(ClearImageBackground3())
                                                             .keyboardShortcut("s", modifiers: [.command])
                                                             //.buttonStyle(.borderless)
                                                             //.buttonStyle(.borderedProminent)
                                                             //.clipShape(Circle())
                                                            //.clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                                                            //.clipShape(Rectangle())
                                                        }.background(Color.generalButtonsBackgroundColorLightMode)
                                                         .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                                                         //RoundToggleButton(isOn: $context.hasStyle(RichTextStyle.bold))
                                                         //.controlSize(.small)
                                                         .controlSize(.regular)
                                                        Spacer()
                                                    }.frame(width: 110, height: 50)
                                                     //.offset(CGSize(width: 5.00, height: 0.00))
                                                     //.offset(CGSize(width: -10.00, height: 0.00))
                                                     //.offset(CGSize(width: -6.00, height: 0.00))
                                                    
                                                    VStack {
                                                        Menu {
                                                            //ForEach(fontNames.indices, id: \.self) { index in
                                                            ForEach(fontSizeOptions, id: \.self) { option in
                                                                
                                                                Button(
                                                                    action: {
                                                                        if (context.hasSelectedRange) {
                                                                            let cursor_position = context.selectedRange.upperBound
                                                                            let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                            context.fontSize = option.size
                                                                            
                                                                            context.handle(.selectRange(emptyRange))
                                                                            context.resetSelectedRange()
                                                                            
                                                                            anyNewChanges = true
                                                                        } else {
                                                                            withAnimation {
                                                                                showToast = true
                                                                            }
                                                                        }
                                                                    },
                                                                    label: {
                                                                        Text(option.name)
                                                                            .font(.system(size: option.name_size))
                                                                            .bold(option.name_bold)
                                                                    }
                                                                )
                                                            }
                                                        } label: {
                                                            //Text("Font Size: \(Int(context.fontSize))")
                                                            Text("\(Int(context.fontSize))")
                                                        }
                                                        //.controlSize(.small)
                                                        .controlSize(.regular)
                                                        Spacer()
                                                    }.frame(width: 45, height: 50)
                                                     //.offset(CGSize(width: -10.00, height: 0.00))
                                                    .offset(CGSize(width: 10.00, height: 0.00))
                                                    
                                                    VStack {
                                                        Menu {
                                                            //ForEach(fontNames.indices, id: \.self) { index in
                                                            ForEach(fontNames, id: \.self) { name in
                                                                Button(
                                                                    action: {
                                                                        if (context.hasSelectedRange) {
                                                                            let cursor_position = context.selectedRange.upperBound
                                                                            let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                            context.fontName = name
                                                                            
                                                                            context.handle(.selectRange(emptyRange))
                                                                            context.resetSelectedRange()
                                                                            
                                                                            anyNewChanges = true
                                                                        } else {
                                                                            withAnimation {
                                                                                showToast = true
                                                                            }
                                                                        }
                                                                    },
                                                                    label: {
                                                                        Text(name)
                                                                            .font(.custom(name, size: 11))
                                                                    }
                                                                )
                                                            }
                                                        } label: {
                                                            //Text("Font")
                                                            Text(context.fontName)
                                                        }
                                                        //.controlSize(.small)
                                                        .controlSize(.regular)
                                                        Spacer()
                                                    }.frame(width: 100, height: 50)
                                                     //.offset(CGSize(width: 5.00, height: 0.00))
                                                     //.offset(CGSize(width: -10.00, height: 0.00))
                                                     .offset(CGSize(width: 10.00, height: 0.00))
                                                    
                                                    VStack {
                                                        /*
                                                        //Button("Show Popover", action: {
                                                        Button("Style", action: {
                                                            self.isShowPopover = true
                                                            
                                                        }).padding(10)
                                                          .popover(isPresented: $isShowPopover) {
                                                              ForEach(textStyleOptions, id: \.self) { option in
                                                                  Button(
                                                                      action: {
                                                                          if (context.hasSelectedRange) {
                                                                              let cursor_position = context.selectedRange.upperBound
                                                                              let cursor_position_low = context.selectedRange.lowerBound
                                                                              let len = cursor_position - cursor_position_low
                                                                              let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                              let initialRange = NSRange(location: cursor_position_low, length: len)
                                                                              
                                                                              context.isEditingText = false
                                                                              
                                                                              //Text("Is bold: \(context.styles.hasStyle(.bold))")
                                                                              context.fontSize = option.size
                                                                              if (option.name_bold) {
                                                                                  context.handle(.setStyle(RichTextStyle.bold, true))
                                                                              } else {
                                                                                  context.handle(.setStyle(RichTextStyle.bold, false))
                                                                              }
                                                                              if (option.name_underline) {
                                                                                  context.handle(.setStyle(RichTextStyle.underlined, true))
                                                                              } else {
                                                                                  context.handle(.setStyle(RichTextStyle.underlined, false))
                                                                              }
                                                                              context.handle(.setStyle(RichTextStyle.italic, false))
                                                                              context.handle(.setStyle(RichTextStyle.strikethrough, false))
                                                                          
                                                                              context.handle(.selectRange(emptyRange))
                                                                              context.resetSelectedRange()
                                                                              
                                                                              context.isEditingText = true
                                                                              context.handle(.selectRange(initialRange))
                                                                              
                                                                              anyNewChanges = true
                                                                          } else {
                                                                          }
                                                                      },
                                                                      label: {
                                                                          Text(option.name)
                                                                              .font(.system(size: option.name_size))
                                                                              .bold(option.name_bold)
                                                                              .underline(option.name_underline, color: .red)
                                                                              //.strikethrough(true, color: Color.blue)
                                                                      }
                                                                  )
                                                              }
                                                          }
                                                        */
                                                        Menu {
                                                            ForEach(textStyleOptions, id: \.self) { option in
                                                                Button(
                                                                    action: {
                                                                        if (context.hasSelectedRange) {
                                                                            let cursor_position = context.selectedRange.upperBound
                                                                            let cursor_position_low = context.selectedRange.lowerBound
                                                                            let len = cursor_position - cursor_position_low
                                                                            let emptyRange = NSRange(location: cursor_position, length: 0)
                                                                            let initialRange = NSRange(location: cursor_position_low, length: len)
                                                                            
                                                                            context.isEditingText = false
                                                                            
                                                                            //Text("Is bold: \(context.styles.hasStyle(.bold))")
                                                                            context.fontSize = option.size
                                                                            if (option.name_bold) {
                                                                                context.handle(.setStyle(RichTextStyle.bold, true))
                                                                            } else {
                                                                                context.handle(.setStyle(RichTextStyle.bold, false))
                                                                            }
                                                                            if (option.name_underline) {
                                                                                context.handle(.setStyle(RichTextStyle.underlined, true))
                                                                            } else {
                                                                                context.handle(.setStyle(RichTextStyle.underlined, false))
                                                                            }
                                                                            context.handle(.setStyle(RichTextStyle.italic, false))
                                                                            context.handle(.setStyle(RichTextStyle.strikethrough, false))
                                                                        
                                                                            context.handle(.selectRange(emptyRange))
                                                                            context.resetSelectedRange()
                                                                            
                                                                            context.isEditingText = true
                                                                            context.handle(.selectRange(initialRange))
                                                                            
                                                                            anyNewChanges = true
                                                                        } else {
                                                                            withAnimation {
                                                                                showToast = true
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
                                                                )
                                                            }
                                                        } label: {
                                                            //Text("Font Size: \(Int(context.fontSize))")
                                                            Text("Style")
                                                        }
                                                        //.controlSize(.small)
                                                        .controlSize(.regular)
                                                        Spacer()
                                                    }.frame(width: 65, height: 50)
                                                     //.offset(CGSize(width: -10.00, height: 0.00))
                                                     .offset(CGSize(width: 10.00, height: 0.00))
                                                }.frame(width: 395)
                                                
                                                Spacer()
                                                    //.frame(height: 490)
                                                    .frame(height: 520)
                                            }.frame(width: 395, height: 584)//.frame(width: 395, height: 554)
                                                    
                                            /*VStack (spacing: 1) {
                                                HStack (spacing: 0) {
                                                    Spacer()
                                                        .frame(height: 205)
                                                }
                                                TextEditor(text: textt)
                                                    .onChange(of: textt) { value in
                                                            //let words = textt.string
                                                            let str = value.string
                                                            let words = str.split { $0 == " " || $0.isNewline }
                                                            let count = words.count
                                                            self.wordCount = count
                                                            if (count = 0) {
                                                        }
                                                    }
                                            }*/
// MARK: – RichText Editor
                                            VStack (spacing: 1) {
                                                HStack (spacing: 0) {
                                                    Spacer()
                                                        //.frame(height: 25)
                                                        .frame(height: 30)
                                                }
                                                RichTextEditor(text: $textt, context: context, format: .archivedData) {
                                                    //$0.textContentInset = CGSize(width: 10, height: 10)
                                                    $0.textContentInset = CGSize(width: 0, height: 10)
                                                    //$0.setRichTextColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: textt.length))
                                                    /*$0.setRichTextColor(RichTextColor.foreground, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: textt.length))*/
                                                    $0.setRichTextColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: textt.length))
                                                    //$0.setRichTextColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: 0))
                                                    $0.setRichTextColor(RichTextColor.background, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), at: NSRange(location: 0, length: textt.length))
                                                    $0.setRichTextColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: textt.length))
                                                    $0.setRichTextColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0), at: NSRange(location: 0, length: textt.length))
                                                }.richTextEditorConfig(editorConf)
                                                 .focused($textEditorIsFocused)
                                                 //.focusedValue(\.noteValue, textt) // whenever this becomes focused, write value of "textt" to .noteValue
                                                 .onChange(of: textEditorIsFocused) { newValue in
                                                     // Handle focus change
                                                     //dropEntered()
                                                     
                                                     if (!textEditorIsFocused) {
                                                         context.resetSelectedRange()
                                                     }
                                                 }
                                                 /*.onChange(of: sharedAppState.darkMode) { newValue in
                                                   
                                                     //let emptyRange = NSRange(location: 0, length: 0)
                                                     //let fullRange = NSRange(location: 0, length: context.attributedString.richText.length)
                                                     
                                                     //context.isEditingText = false
                                                     
                                                     //context.handle(.selectRange(fullRange))
                                                     
                                                     //context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                     
                                                     //context.handle(.selectRange(emptyRange))
                                                     //context.resetSelectedRange()
                                                     
                                                     //context.isEditingText = true
                                                     //context.handle(.selectRange(initialRange))
                                                 }*/
                                                 .onChange(of: context.fontName) { value in
                                                    let t = (context.fontSize == 16) && (context.fontName == ".AppleSystemUIFont")
                                                    if t {
                                                        //if textt.string.isEmpty {
                                                        //if context.attributedString.string.isEmpty {
                                                        if context.attributedString.richText.string.isEmpty {
                                                            //dropEntered() // make a sound så i know this block was executed
                                                            
                                                            
                                                            
                                                            /*context.handle(.setAttributedString(loadTexttFromAppStorage3()))
                                                            context.handle(.selectRange(NSRange(location: 0, length: 1)))
                                                            
                                                            context.handle(.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)))
                                                            
                                                            context.handle(.selectRange(NSRange(location: 1, length: 0)))
                                                            context.resetSelectedRange()*/
                                                            
                                                            //context.handle(.setAttributedString(loadTexttFromAppStorage3()))
                                                            
                                                            //fixRichTextColor() // funkar inte
                                                            
                                                            
                                                            textEditorIsFocused = false
                                                            context.isEditingText = false
                                                            
                                                            context.handle(.setAttributedString(NSAttributedString(string: " ")))
                                                            
                                                            //let fullRange = NSRange(location: 0, length: textt.length)
                                                            let fullRange = NSRange(location: 0, length: context.attributedString.length)
                                                            //let emptyRange = NSRange(location: textt.length, length: textt.length)
                                                            let emptyRange = NSRange(location: 1, length: 0)
                                                            
                                                            context.handle(.selectRange(fullRange))
                                                            
                                                            context.fontSize = CGFloat(13)
                                                            context.fontName = "Avenir"
                                                            context.setColor(RichTextColor.foreground, to: !sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                            
                                                            //Text("Is bold: \(context.styles.hasStyle(.bold))")
                                                            context.handle(.setStyle(RichTextStyle.bold, false))
                                                            context.handle(.setStyle(RichTextStyle.underlined, false))
                                                            context.handle(.setStyle(RichTextStyle.italic, false))
                                                            context.handle(.setStyle(RichTextStyle.strikethrough, false))
                                                            context.setColor(RichTextColor.foreground, to: sharedAppState.darkMode ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                                                            
                                                            context.setColor(RichTextColor.background, to:  NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
                                                            
                                                            //context.trigger(.selectRange(emptyRange))
                                                            context.handle(.selectRange(emptyRange))
                                                            context.resetSelectedRange()
                                                            
                                                            //textEditorIsFocused = true
                                                            textEditorIsFocused = false
                                                            context.isEditingText = true
                                                            
                                                            anyNewChanges = true
                                                        }
                                                    }
                                                 }/*.onTapGesture(count: 1, perform: {
                                                     dropEntered()
                                                 })
                                                if #available(macOS 15.0, *) {
                                                    .pointerStyle(.horizontalText)
                                                }*/
                                                .onAppear() {
                                                     if (!anyNewChangesInOnlyTextColor) {
                                                         //if ((textt_str != textt) && (textt_str.string == context.attributedString.richText.string))  {
                                                        //if ((textt_str != context.attributedString) && (textt_str.string == textt.string))  {
                                                            //if ((textt_str == textt) && (textt_str.string == context.attributedString.richText.string))  {
                                                            
                                                         //if ((textt_str != context.attributedString.richText) && !anyNewChanges && (textt_str.string == context.attributedString.richText.string)) {
                                                        //if (textt_str != context.attributedString.richText  && !anyNewChanges && (textt_str.string == context.attributedString.richText.string)) {
                                                        if (textt_str != context.attributedString.richText) {
                                                            //dropEntered()
                                                                 
                                                            anyNewChangesInOnlyTextColor = true
                                                        }
                                                     }
                                                }
                                                /*.richTextEditorStyle(
                                                    .init(
                                                        font: NSFont(name: "Avenir", size: 13)!,
                                                        fontColor: .red,
                                                        backgroundColor: .red
                                                    )
                                                )*/
                                                //.frame(width: 395, height: 554)
                                                //.background(Color.MarkdowPageBackgroundLightMode)
                                            
                                            }.frame(width: 395, height: 584)//.frame(width: 395, height: 554)
                                             .offset(CGSize(width: 4.00, height: 0.00))
                                        
                                            RoundedRectangle(cornerRadius: 9, style: .continuous)
                                                .stroke(lineWidth: CGFloat(pickedPriority + pickedPriority + 1))
                                                .foregroundColor(lightModeColors[pickedPriority % 3])
                                        }.frame(width: 395, height: 584)//.frame(width: 395, height: 554)
                                         //.background(sharedAppState.darkMode ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                    }.frame(width: 395, height: 584)//.frame(width: 395, height: 554)
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
                                }.frame(width: 395, height: 588, alignment: .top)//.frame(width: 395, height: 581, alignment: .top) //.frame(width: 305, height: 458)  // MARK: 💧💥❗️💥 Del 1/2💧 – för VStack Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                 //.preferredColorScheme(colorScheme == .dark ? .dark : .light)
                                 //.preferredColorScheme(.light)
                                
                            } // MARK: – för if !($MDmode.wrappedValue) {
                            
                            /*if $MDmode.wrappedValue {
                                VStack (spacing: 0) {
                                    ScrollView(.vertical) {
                                        VStack (spacing: 0) {
                                            /*
                                             HStack {
                                                 Text("Task:")
                                                     .font(.custom("Avenir", size: 22))
                                                     .bold()
                                                     .frame(maxWidth: .infinity, alignment: .leading)
                                                 /* Text("  \(wordCountTaskName) w")
                                                      .bold()
                                                      .font(.headline)
                                                  */
                                             }
                                             */
                                                                  
                                            if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                Text(TaskNameText)
                                                    .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                    .foregroundColor(sharedAppState.darkMode ? Color.MarkdowPageTextDarkMode: Color.MarkdowPageTextLightMode)
                                                    .lineSpacing(MD_Mode_Text_Space)
                                                    //.fontWidth(Font.Width(MD_Mode_Text_Width))
                                                    //.tracking(MD_Mode_Text_Width)
                                                    .kerning(MD_Mode_Text_Width)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } else {
                                                LazyVStack {
                                                    ForEach(0..<TaskNameSplitForMarkDownMode.count, id: \.self) { index in
                                                        Text(markdownThis(TaskNameSplitForMarkDownMode[index]))
                                                            .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                            .foregroundColor(sharedAppState.darkMode ? Color.MarkdowPageTextDarkMode: Color.MarkdowPageTextLightMode)
                                                            .lineSpacing(MD_Mode_Text_Space)
                                                            .kerning(MD_Mode_Text_Width)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        if index != TaskNameSplitForMarkDownMode.count - 1 {
                                                            //Text("                                                                                     ")
                                                        }
                                                    }
                                                }
                                            }
                                        }.padding(5)
                                    }//.frame(width: 395, height: 578, alignment: .top)//.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 2/2💧 – för ScrollView – Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                }.frame(width: 395, height: 581, alignment: .top)
                                 .background(sharedAppState.darkMode ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                 .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                 .shadow(color: sharedAppState.darkMode ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 2, x: 0, y: 0)
                                 //.shadow(radius: 2)
                            } // för if $MDmode.wrappedValue {
                            */
                            
                            /*Spacer()
                                .frame(width: 395, height: 4)*/
                            
// 💧📺 2Editor – Knapperna  .md💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                            HStack (spacing: 8) {
                                
                                if !($MDmode.wrappedValue) {
                                    //VStack (alignment: .leading) {
                                        HStack (spacing: 3) {
                                            /*Button(
                                                action: {
                                                    // TODO – spara textt i correct string format i AppStorage
                                                    //saveTexttToAppStorage()
                                                    
                                                    //saveTexttToAppStorage2() // save richText
                                                    //saveTexttToAppStorage3(context.attributedString)
                                                    saveTexttToAppStorage3(context.attributedString.richText)
                                                    
                                                    exit2EditorPageButtonAction()
                                                    //currentPopoverPage = 1
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
                                             //.offset(CGSize(width: -4, height: 1))
                                             .help(Text("Save current & return to notes"))*/

                                            
                                                
                                            /*Button("Show Dialog") {
                                                isShow = true
                                            }.confirmationDialog("Select a menu", isPresented: $isShow, titleVisibility: .visible) {
                                                Button("Menu 1") {
                                                    selectMenu = "Menu 1"
                                                }
                                                
                                                Button("Menu 2") {
                                                    selectMenu = "Menu 2"
                                                }
                                                
                                                Button("Menu 3") {
                                                    selectMenu = "Menu 3"
                                                }
                                            }.buttonStyle(miniRedBackButton())*/
                                            Button(
                                                action: {
                                                    textEditorIsFocused = false
                                                    
                                                    if (anyNewChangesInOnlyTextColor) {
                                                        //if ((anyNewChanges) || (textt_str.string != textt.string)) {
                                                        if ((anyNewChanges) || (textt_str.string != context.attributedString.richText.string)) {
                                                            showingConfirmationDialog = true
                                                        } else {
                                                            saveTexttToAppStorage3(context.attributedString.richText) // Only the textColor has changed, dont need to ask USER for confirmation
                                                            
                                                            exit2EditorPageButtonAction()
                                                            context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                        }
                                                    } else {
                                                        if ((textt_str != context.attributedString.richText) || (anyNewChanges) || (textt_str.string != context.attributedString.richText.string)) {
                                                            showingConfirmationDialog = true
                                                        } else {
                                                            exit2EditorPageButtonAction()
                                                            context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                        }
                                                    }
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
                                            ).confirmationDialog(Text(confirmationDialogTitle), isPresented: $showingConfirmationDialog, titleVisibility: .automatic,
                                                                  actions: {
                                                                      //Button("Delete", role: .destructive) { }
                                                                      Button("Save recent changes") {
                                                                          saveTexttToAppStorage3(context.attributedString.richText)
                                                                          
                                                                          exit2EditorPageButtonAction()
                                                                          context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                      }
                                                                      Button("Revert Changes") {
                                                                          exit2EditorPageButtonAction()
                                                                          context.handle(.setAttributedString(NSAttributedString(string: "")))
                                                                      }
                                                                      Button("Cancel", role: .cancel) {
                                                                          textEditorIsFocused = true
                                                                      }
                                                                  },
                                                                  message: {
                                                                      confirmationDialogMessage == "" ? nil : Text(confirmationDialogMessage)
                                                              }
                                             ).buttonStyle(miniRedBackButton())
                                             //.offset(CGSize(width: -4, height: 1))
                                            
                                            Spacer()
                                            //NotePreview()
                                            
                                            /*Text(textEditorIsFocused ? "TextField is focused" : "TextField is not focused")
                                                .onTapGesture {
                                                    textEditorIsFocused = false
                                                }*/
                                            
                                            HStack {
                                                HStack (spacing: 0) {
                                                    Text("Note Priority:  ")
                                                        .font(.custom("Avenir", size: 11))
                                                        .bold()
                                                        .onTapGesture {
                                                           textEditorIsFocused = false
                                                       }
                                                    HStack {
                                                        Picker(selection: $pickedPriority, label: Text("")) {
                                                            ForEach(0..<priorities.count, id: \.self) {
                                                                Text(self.priorities[$0])
                                                                    .font(.custom("Avenir", size: 10))
                                                                    .bold()
                                                                    .frame(alignment: .trailing)
                                                                    .onHover { Bool in
                                                                       textEditorIsFocused = false
                                                                    }
                                                            }
                                                        }.labelsHidden()
                                                         .onTapGesture {
                                                            textEditorIsFocused = false
                                                         }
                                                    }.frame(width: 60, height: 27)
                                                }.controlSize(.large)
                                                
            
                                                /*HStack (spacing: 0) {
                                                    
                                                    Button(
                                                        action: {
                                                            //saveTexttToAppStorage2()
                                                            
                                                            let priority = pickedPriority
                                                            
                                                            if sharedAppState.isOnPage == 1 {
                                                                realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                            } else if sharedAppState.isOnPage == 2 {
                                                                realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                            } else if sharedAppState.isOnPage == 3 {
                                                                realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                            } else if sharedAppState.isOnPage == 4 {
                                                                realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                            }
                                                        },
                                                        label: {
                                                            HStack (spacing: 0) {
                                                                Text("save")
                                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                            }
                                                        }
                                                    ).buttonStyle(ClearImageBackground())
                                                        .help(Text("Save recent changes"))
                                                    
                                                    Text("∙")
                                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                                    
                                                    Button(
                                                        action: {
                                                            //copyToPasteboard(TaskNameText.trimmingCharacters(in: .whitespacesAndNewlines))
                                                            copyToPasteboard(TaskNameText)
                                                        },
                                                        label: {
                                                            /*Image(systemName: "doc.on.doc.fill")
                                                                .foregroundColor(sharedAppState.darkMode ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             */
                                                            Text("copy")
                                                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                        }
                                                    ).buttonStyle(CopyAndPaste())
                                                     .help(Text("Copy text to pasteboard"))
                                                    
                                                    Text("∙")
                                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                                    
                                                    if !($restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                        Button(
                                                            action: {
                                                                restoreTaskNameTextChooseOptionIfTrueElseYorN = true
                                                            },
                                                            label: {
                                                                Text("reset")
                                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                            }
                                                        ).buttonStyle(ClearImageBackground2())
                                                         .help(Text("Restore text to same state when opened"))
                                                    }
                                                    if $restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                        HStack (spacing: 2) {
                                                            Button(
                                                                action: {
                                                                    getTaskItemWithCurrentIDsTaskNameFor(page: sharedAppState.isOnPage)
                                                                    
                                                                    /*let name = TaskNameText // make sure taskname inte är en ""
                                                                    let richtext = loadTexttFromAppStorage2(name)
                                                                    self.textt = richtext.string.isEmpty ? loadTexttFromAppStorage3() : richtext
                                                                    */
                                                                    
                                                                    self.restoreTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                },
                                                                label: {
                                                                    Text("yes")
                                                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                                        //.font(.custom("Avenir", size: 15))
                                                                        .foregroundColor(Color.RedTRASHAndRM)
                                                                }
                                                            ).buttonStyle(ClearImageBackground())
                                                            Text(" or ")
                                                                .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                            Button(
                                                                action: {
                                                                    self.restoreTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                },
                                                                label: {
                                                                    Text("no")
                                                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                                        //.font(.custom("Avenir", size: 15))
                                                                        .foregroundColor(Color.BlueEdit)
                                                                }
                                                            ).buttonStyle(ClearImageBackground())
                                                        }
                                                    }
                                                    
                                                    Text("∙")
                                                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                        .foregroundColor(sharedAppState.darkMode ? Color.dotDarkMode : Color.dotLightMode)
                                                    
                                                    if !($rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                        Button(
                                                            action: {
                                                                rmTaskNameTextChooseOptionIfTrueElseYorN = true
                                                            },
                                                            label: {
                                                                Text("clear")
                                                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                                    .foregroundColor(Color.RedTRASHAndRM)
                                                            }
                                                        ).buttonStyle(ClearImageBackground2())
                                                         .help(Text("Clears this text but does not save it – you can restore the last saved text"))
                                                    }
                                                    if $rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                        HStack (spacing: 2) {
                                                            Button(
                                                                action: {
                                                                    TaskNameText = ""
                                                                    //textt = loadTexttFromAppStorage3()
                                                                    
                                                                    // så att när man trycker igen på reset så ska man kunna resetta tillbaka förra originella texten
                                                                    //realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                                                    
                                                                    self.rmTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                },
                                                                label: {
                                                                    Text("yes")
                                                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                                    //.font(.custom("Avenir", size: 15))
                                                                        .foregroundColor(Color.RedTRASHAndRM)
                                                                }
                                                            ).buttonStyle(ClearImageBackground())
                                                            Text(" or ")
                                                                .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                            Button(
                                                                action: {
                                                                    self.rmTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                },
                                                                label: {
                                                                    Text("no")
                                                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                                        //.font(.custom("Avenir", size: 15))
                                                                        .foregroundColor(Color.BlueEdit)
                                                                }
                                                            ).buttonStyle(ClearImageBackground())
                                                        }
                                                    }
                                                }
                                                */
                                                
                                                //ShareLink(item: TaskNameText) {
                                                //ShareLink(item: textt.string) {
                                                ShareLink(item: context.attributedString.richText.string) {
                                                    //Label("share", systemImage:  "square.and.arrow.up")
                                                    Image(systemName: "square.and.arrow.up")
                                                    Text("Share")
                                                        //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                                        .font(.custom("Avenir", size: 11))
                                                        .bold()
                                                        //.shadow(radius: 0.3)
                                                        //.foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                        .frame(width: 30, height: 18)
                                                }.controlSize(.large)
                                                 .onTapGesture {
                                                    textEditorIsFocused = false
                                                }
                                                /*ShareLink(item: TaskNameText) {
                                                     //Label("share", systemImage:  "square.and.arrow.up")
                                                     Text("Share")
                                                     .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                     .shadow(radius: 0.3)
                                                     .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                     .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                     .frame(width: 85, height: 18)
                                                 }.buttonStyle(miniRedBackButton())
                                                 //.offset(CGSize(width: -4, height: 1))
                                                 */
                                                /*ShareLink(item: TaskNameText) {
                                                     Label("share", systemImage:  "square.and.arrow.up")
                                                     }.labelsHidden()
                                                 */
                                                /*ShareLink(item: TaskNameText) {
                                                     Text("share")
                                                     //.font(.system(size: 11, weight: .bold, design: .monospaced))
                                                     .font(.custom("Avenir", size: 11))
                                                     .bold()
                                                     //.foregroundColor(.primary) // Use system color to respect light/dark mode
                                                     //.background(Color.clear)   // Ensure no background
                                                 }//.labelsHidden()*/
                                                //Spacer()
                                                /*ShareLink(item: url, subject: Text("Check out this link"), message: Text("If you want to learn Swift, take a look at this website.")) {
                                                    Image(systemName: "square.and.arrow.up")
                                                 }
                                                 ShareLink(item: url) {
                                                    Label("Tap me to share", systemImage:  "square.and.arrow.up")
                                                 }*/
                                                /*ShareLink(item: TaskNameText) {
                                                     /*Image(systemName: "doc.on.doc.fill")
                                                      .foregroundColor(sharedAppState.darkMode ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                      */
                                                     Text("share")
                                                     .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                 
                                                     /*HStack (spacing: 0) {
                                                          Text("save")
                                                          .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                          }
                                                      }*/
                                                 }.labelsHidden()
                                                 */
                                                /*ShareLink(item: TaskNameText) {
                                                     Text("share")
                                                     .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                     //.foregroundColor(.primary) // Use system color to respect light/dark mode
                                                     //.background(Color.clear)   // Ensure no background
                                                 }.buttonStyle(ClearImageBackground())
                                                 */
                                            }
                                            /*Button(
                                                action: {
                                                    // 1 – ❗️
                                                    //realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                                    // 2
                                                    let markdownName = TaskNameText
                                                    //let markdownDescription = TaskDescriptionText
                                                    
                                                    /* split returns a list of Substrings, so we have to map (convert) them to Strings. To do that you can just pass the Substring to the Strings init function */
                                                    TaskNameSplitForMarkDownMode = markdownName.split(whereSeparator: \.isNewline).map { String($0) }
                                                    
                                                    /*TaskDescriptionSplitForMarkDownMode = markdownDescription.split{ $0.isNewline }.map({ (substring) in
                                                        return String(substring)
                                                     })*/
                                                    // 3
                                                    self.MDmode = true
                                                    // ––
                                                    resetViewValuesFor2EditorPage()
                                                },
                                                label: {
                                                    HStack (spacing: 0) {
                                                        Text("Preview")
                                                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                            .shadow(radius: 0.3)
                                                        //Image(systemName: "paintbrush.fill")
                                                            //.foregroundColor(sharedAppState.darkMode ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                            //.font(.system(size: 14))
                                                            //.foregroundColor(sharedAppState.darkMode ? Color.neuPurpLight: Color.neuOrangeLight)
                                                            //.foregroundColor(sharedAppState.darkMode ? Color.neuPurpLight : Color.miniGeneralButtonsColorLightMode)
                                                            //.foregroundColor(sharedAppState.darkMode ? Color.neuPurpLight: Color.neuOrangeLight)
                                                            .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                            .frame(width: 85, height: 18)
                                                    }//.shadow(color: sharedAppState.darkMode ? Color.neuPurp: Color.neuOrange, radius: 2, x: 0, y: 0)
                                                }
                                            ).buttonStyle(miniRedBackButton())
                                                //.offset(CGSize(width: 4, height: 1))
                                                .help(Text("Open preview text/markdown mode"))
                                            */
                                        }//.frame(width: 382, height: 18) //.frame(width: 292, height: 18) // HStack (spacing: 0) {
                                    //} // VStack (alignment: .leading) {
                                }
                                
                                /*if $MDmode.wrappedValue {
                                    HStack  {
                                        Button(
                                            action: {
                                                self.MDmode = false
                                                resetViewValuesFor2EditorPage()
                                            },
                                            label: {
                                                //Text(" Back")
                                                Image(systemName: "arrowshape.turn.up.backward.fill")
                                                    .font(.system(size: 14))
                                                    //.foregroundColor(sharedAppState.darkMode ? Color.neuPurpLight: Color.neuOrangeLight)
                                                    .foregroundColor(sharedAppState.darkMode ? Color.fourButtonTextDarkMode: Color.neuOrangeLight)
                                                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                    .frame(width: 85, height: 18)
                                            }
                                        ).buttonStyle(miniRedBackButton())
                                         //.offset(CGSize(width: -4, height: 1))
                                         .help(Text("Return to editing note"))
                                        
                                        Spacer()
                                        
                                        HStack (spacing: 2) {
                                            HStack (spacing: 0) {
                                                Text(" Size ")
                                                    .font(.system(size: 9, weight: .light, design: .monospaced))
                                                Stepper {
                                                    //Text("Size \(formatVal(MD_Mode_Text_Size))")
                                                    //Text("Size\n \(formatVal2(MD_Mode_Text_Size))")
                                                    Text(" Size")
                                                        .font(.system(size: 9, weight: .light, design: .monospaced))
                                                } onIncrement: {
                                                    if MD_Mode_Text_Size < 25 {
                                                        self.MD_Mode_Text_Size += 1
                                                    }
                                                } onDecrement: {
                                                    if MD_Mode_Text_Size > 7 {
                                                        self.MD_Mode_Text_Size -= 1
                                                    }
                                                } onEditingChanged: {
                                                    print("\($0)")
                                                }.labelsHidden()
                                            }
                                        }.frame(width: 70, alignment: .trailing) // HStack
                                         .padding(.horizontal, 1)
                                        
                                        Divider()
                                            .background(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                            .frame(width: 2, height: 35, alignment: .bottom)
                                            .padding(.horizontal, 1)
                                        
                                        Text_OR_Markdown($txtifTrueElseMarkDownPreviewStyle)
                                    }
                                }
                                */
                                
                            }.frame(width: 393, height: 28) //.frame(width: 290, height: 18) // HStack (spacing: 0) {
                             //.padding(5)
                        }.frame(width: 395, height: 625, alignment: .center) //.frame(width: 305, height: 495, alignment: .center) // för VStack (spacing: 8) {
                         //.padding(5)
                         .preferredColorScheme(.dark)
                        //.preferredColorScheme(colorScheme == .dark ? .dark : .light)
                        
                    } // Avslut för if $ShowEditor.wrappedValue {
                    
// MARK: – 💥💥💥💥💥AVSLUT💥💥💥💥💥 sidan på POPOVERpageController som innehåller Listan med TaskItemsen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
                    
                } // ZWorld End・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
                .showToast(showToast: $showToast.animation(), content: FabulaToast(showToast: $showToast.animation(), toastData: FabulaToast.ToastData(title: "Attention❗️", message: "Operation available only if you have made a selection", backgroundColor: Color.white), position: .top))
                /*.alert(isPresented: $isShowAlert) {
                    Alert(title: Text("Title"), message: Text("This is a alert message"), dismissButton: .default(Text("Dismiss")))
                }*/
            }.padding(8)  // MARK: – VStack för page 1 – VStacken som alla page kommer appear on på ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・⭐️
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center) // MARK: - 🚌 Avslut PopoverPageController・・・・・・・・・・・・
         //.frame(width: 320, height: 500, alignment: .center)
         .environmentObject(sharedAppState) // Injecting sharedSettings as environment object for all children i.e by declaring the property  @EnvironmentObject var sharedAppState: AppState  in these children viewes, then those children will have the same reference to same AppState property here in Contentview
         .preferredColorScheme(sharedAppState.darkMode ? .dark : .light) // In SwiftUI, preferredColorScheme(_:) is a view modifier that allows you to override the system’s color scheme (light or dark mode) for a specific view.
        //.preferredColorScheme(.dark)
    } // MARK: - 💥Avslut var body: some View {
} // MARK: – Avslut struct ContentView



// MARK: -  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
/**
 Uppgift : att ändra formatet av TaskNote till NSAttributedString så att RichTextKit kan jobba med det och sedan kunna ändra tillbaks till rätt format för att sparas i Realm
 */
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
    
    
    func saveTexttToAppStorage() {
        if let encoded = encodeAttributedString(textt) {
            richTextTest = encoded
        }
    }
    func saveTexttToAppStorage2() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: textt, requiringSecureCoding: true)
            TaskNameText = data.base64EncodedString()
        } catch {
            //print("Encoding failed: \(error)")
            TaskNameText = textt.string
        }
        TaskDescriptionText = textt.string
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
    func decodeAttributedString2() -> NSAttributedString? {
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
    }
    func loadTexttFromAppStorage() {
        if let decoded = decodeAttributedString(from: richTextTest) {
            textt = decoded
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
    func loadTexttFromAppStorage3() -> NSAttributedString {
        if let decoded = decodeAttributedString2() {
            return decoded
        } else {
            return NSAttributedString(string: " ")
        }
    }
    func loadTexttFromAppStorage3(_ text: String) -> String {
        if let decoded = decodeAttributedString(from: text) {
            return decoded.string
        } else {
            return text
        }
    }
    
    
    
    
    
    func fixRichTextColor() {
        //let fullRange = NSRange(location: 0, length: textt.length)
        let fullRange = NSRange(location: 0, length: context.attributedString.length)
        //let emptyRange = NSRange(location: textt.length, length: textt.length)
        let emptyRange = NSRange(location: 0, length: 0)
        //context.trigger(.selectRange(fullRange))
        context.handle(.selectRange(fullRange))
        //context.setColor(.foreground, to: (sharedAppState.darkMode ? Color.ItemTextDarkMode : Color.ItemTextLightMode))
        //context.setColor(.foreground, to: ((sharedAppState.darkMode) ? NSColor(red: 0.87843, green: 0.87059, blue: 0.83922, alpha: 0.80) : NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        context.setColor(RichTextColor.foreground, to: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
        context.setColor(RichTextColor.strikethrough, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        context.setColor(RichTextColor.underline, to: NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        context.setColor(RichTextColor.background, to:  NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
        //context.trigger(.selectRange(emptyRange))
        context.handle(.selectRange(emptyRange))
    }
}



extension ContentView {
    func dropEntered() {
        NSSound(named: "Morse")?.play()
    }
    
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
    /**
     Uppgift : att återställa den state/tillsånd som knapparna i HStacken som finns ovanför Listan av task Itemsen ska vara i + ifall man anger TRUE på andra function parametern då så sparar den även tillståndet (SHOW/SORT etc.) som listan blev Renderd för
     Används i :
     • RedBackButton */
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
    
    
    /**
     Uppgift : att återtälla Views till sitt originella tillstånd när man har EditorMode == true (task name editor och task description editor)
     */
    func resetViewValuesFor2EditorPage() {
        rmTaskNameTextChooseOptionIfTrueElseYorN = false
        rmTaskDescriptionTextChooseOptionIfTrueElseYorN = false
        
        restoreTaskNameTextChooseOptionIfTrueElseYorN = false
        restoreTaskDescriptionChooseOptionIfTrueElseYorN = false
        
        txtifTrueElseMarkDownPreviewStyle = true
    }
    
    
    /**
     Uppgift : att spara TaskName och allt relaterade till current note that is being viewed in 2EditorPage och sedan kalla korrekt sort så att när list of TaskItems visas så visas det rätt
     */
    func exit2EditorPageButtonAction() {
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
            
            dropEntered() // Error Sound
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


// MARK: – ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

// MARK: - Not Used ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*
extension ContentView {
    
    /* för rendering att alla tasknames ska visas som .MD mode på listan */
    func markdownThis(_ text: String) -> AttributedString {
        var markdownTaskName: AttributedString = ""
        do {
            markdownTaskName = try AttributedString(markdown: text)
        } catch {
            print("Error creating AttributedString:  \(error)")
        }
        return markdownTaskName
    }
    
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
        } catch {
            print("Error pasting from pasteboard:  \(error)")
        }
        return pasted
    }
/*func openWeekFinderWindow() {
         // Get focus from other apps
         NSApplication.shared.activate(ignoringOtherApps: true)
         
         // Create the frame to draw window
         let exportWindow = NSWindow(
         contentRect: NSRect(x: 0, y: 0, width: 500, height: 130),
         styleMask: [.titled, .closable, .fullSizeContentView],
         backing: .buffered,
         defer: false
         )
         // Add title
         exportWindow.title = ""
         
         // Keeps window reference active, we need to use this when using NSHostingView
         exportWindow.isReleasedWhenClosed = false
         
         /* NSHostingView lets us use SwiftUI views with AppKit */
         exportWindow.contentView = NSHostingView(rootView: WeekFinderOUTER())
         
         // Center and bring forward
         exportWindow.center()
         exportWindow.makeKeyAndOrderFront(nil)
    }*/
}
*/
