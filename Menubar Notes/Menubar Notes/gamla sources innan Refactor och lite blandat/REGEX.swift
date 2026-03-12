
/*
 
 //  Created by Shayan Eivaz Khani on 2022-05-22.

 import SwiftUI
 import UniformTypeIdentifiers
 //import LaunchAtLogin
 import AppKit
 //import SafariServices
 //import WeatherKit
 //import CoreLocation

 struct ContentView: View {
 // MARK: – for shutdown button ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @State private var shutdownAppButtonIfTrueElseYorN = true
     
 // MARK: – values of User preferenses/settings ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     //__ för autolaunch
     //@ObservedObject private var launchAtLogin = LaunchAtLogin.observable /* för Launch Package Dependencien */
     //__ cache values för darkmode toggle
     @Environment(\.colorScheme) var colorScheme
     @AppStorage("DarkLight") private var darkMode: Bool = false
     
     //__ för GeneralSettingView
     //@AppStorage("TextView Font") private var fontAvenirIfTrueElseTimes = true
     
 // MARK: – 💧 Connect our RealmManager to View ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @StateObject var realmManager = RealmManager()
     
     //var emo = emojis() // för att öppna EmojiButtonsBoard()
     
 //  MARK: – AppStorage sextion för att behålla page view values/settings i USERDEFAULTS istället för Realm ・・・・・・
     
 //•••• PAGE 1

     @AppStorage("p1ViewSettings_Showing") private var p1ViewSettings_Showing: Bool = false
     @AppStorage("p1ViewSettings_ShowingAndSortedIfTrueElseShowing") private var p1ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
     @AppStorage("p1ViewSettings_Sorted") private var p1ViewSettings_Sorted: Bool = false

     @AppStorage("p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") private var p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
     @AppStorage("p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") private var p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
     @AppStorage("p1ViewSettings_ShowCONTAINSTaskName") private var p1ViewSettings_ShowCONTAINSTaskName: String = ""
     @AppStorage("p1ViewSettings_ShowCONTAINSTaskDescription") private var p1ViewSettings_ShowCONTAINSTaskDescription: String = ""
     @AppStorage("p1ViewSettings_helpWithShowCONTAINS") private var p1ViewSettings_helpWithShowCONTAINS: String = ""

     @AppStorage("p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") private var p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
     @AppStorage("p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask") private var p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
     @AppStorage("p1ViewSettings_thereIsItemsInCallFromShowButton") private var p1ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

     @AppStorage("p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") private var p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
     @AppStorage("p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") private var p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
     @AppStorage("p1ViewSettings_SortByIncreasing") private var p1ViewSettings_SortByIncreasing: Bool = false

     @AppStorage("p1ViewSettings_ShowSortRequirementAfterUnshow") private var p1ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
     @AppStorage("p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") private var p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
     @AppStorage("p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") private var p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false

 //•••• PAGE 2

     @AppStorage("p2ViewSettings_Showing") private var p2ViewSettings_Showing: Bool = false
     @AppStorage("p2ViewSettings_ShowingAndSortedIfTrueElseShowing") private var p2ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
     @AppStorage("p2ViewSettings_Sorted") private var p2ViewSettings_Sorted: Bool = false

     @AppStorage("p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") private var p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
     @AppStorage("p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") private var p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
     @AppStorage("p2ViewSettings_ShowCONTAINSTaskName") private var p2ViewSettings_ShowCONTAINSTaskName: String = ""
     @AppStorage("p2ViewSettings_ShowCONTAINSTaskDescription") private var p2ViewSettings_ShowCONTAINSTaskDescription: String = ""
     @AppStorage("p2ViewSettings_helpWithShowCONTAINS") private var p2ViewSettings_helpWithShowCONTAINS: String = ""

     @AppStorage("p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") private var p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
     @AppStorage("p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask") private var p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
     @AppStorage("p2ViewSettings_thereIsItemsInCallFromShowButton") private var p2ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

     @AppStorage("p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") private var p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
     @AppStorage("p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") private var p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
     @AppStorage("p2ViewSettings_SortByIncreasing") private var p2ViewSettings_SortByIncreasing: Bool = false

     @AppStorage("p2ViewSettings_ShowSortRequirementAfterUnshow") private var p2ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
     @AppStorage("p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") private var p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
     @AppStorage("p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") private var p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false

 //•••• PAGE 3

     @AppStorage("p3ViewSettings_Showing") private var p3ViewSettings_Showing: Bool = false
     @AppStorage("p3ViewSettings_ShowingAndSortedIfTrueElseShowing") private var p3ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
     @AppStorage("p3ViewSettings_Sorted") private var p3ViewSettings_Sorted: Bool = false

     @AppStorage("p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") private var p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
     @AppStorage("p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") private var p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
     @AppStorage("p3ViewSettings_ShowCONTAINSTaskName") private var p3ViewSettings_ShowCONTAINSTaskName: String = ""
     @AppStorage("p3ViewSettings_ShowCONTAINSTaskDescription") private var p3ViewSettings_ShowCONTAINSTaskDescription: String = ""
     @AppStorage("p3ViewSettings_helpWithShowCONTAINS") private var p3ViewSettings_helpWithShowCONTAINS: String = ""

     @AppStorage("p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") private var p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
     @AppStorage("p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask") private var p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
     @AppStorage("p3ViewSettings_thereIsItemsInCallFromShowButton") private var p3ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

     @AppStorage("p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") private var p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
     @AppStorage("p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") private var p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
     @AppStorage("p3ViewSettings_SortByIncreasing") private var p3ViewSettings_SortByIncreasing: Bool = false

     @AppStorage("p3ViewSettings_ShowSortRequirementAfterUnshow") private var p3ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
     @AppStorage("p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") private var p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
     @AppStorage("p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") private var p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false

 //•••• PAGE 4

     @AppStorage("p4ViewSettings_Showing") private var p4ViewSettings_Showing: Bool = false
     @AppStorage("p4ViewSettings_ShowingAndSortedIfTrueElseShowing") private var p4ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
     @AppStorage("p4ViewSettings_Sorted") private var p4ViewSettings_Sorted: Bool = false

     @AppStorage("p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") private var p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
     @AppStorage("p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") private var p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
     @AppStorage("p4ViewSettings_ShowCONTAINSTaskName") private var p4ViewSettings_ShowCONTAINSTaskName: String = ""
     @AppStorage("p4ViewSettings_ShowCONTAINSTaskDescription") private var p4ViewSettings_ShowCONTAINSTaskDescription: String = ""
     @AppStorage("p4ViewSettings_helpWithShowCONTAINS") private var p4ViewSettings_helpWithShowCONTAINS: String = ""

     @AppStorage("p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") private var p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
     @AppStorage("p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask") private var p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
     @AppStorage("p4ViewSettings_thereIsItemsInCallFromShowButton") private var p4ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

     @AppStorage("p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") private var p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
     @AppStorage("p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") private var p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
     @AppStorage("p4ViewSettings_SortByIncreasing") private var p4ViewSettings_SortByIncreasing: Bool = false

     @AppStorage("p4ViewSettings_ShowSortRequirementAfterUnshow") private var p4ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
     @AppStorage("p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") private var p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
     @AppStorage("p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") private var p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false
    
 // MARK: – For FILE EXPORTER skriva ut 4 Listorna i varsin .txt fil varsin  ・・・・・・・・・・・・・・
     
     @AppStorage("PAGE1EXPORT") private var p1FileExportString: String = ""
     @AppStorage("PAGE2EXPORT") private var p2FileExportString: String = ""
     @AppStorage("PAGE3EXPORT") private var p3FileExportString: String = ""
     @AppStorage("PAGE4EXPORT") private var p4FileExportString: String = ""
     
 // MARK: – For rendering different pages when navigating  ・・・・・・・・・・・・・・・・・・・・・・・・・
     
 /*
      Page 0: StartPage (Tasks with their BelongsToPage == 0 is not Tasks for any page)
      Page 1: IMP and URG
      Page 2: IMP
      Page 3: URG
      Page 4: NOTHING
 */
     // används för navigation för PopOverController – currentPopoverPage when app is launched__ currentPopoverPage ska vara == 1
     @State private var currentPopoverPage = 0
     
     // används för att call rätt functions för olika sidor 1–4
     @State private var isOnPage = 0
     
     @AppStorage("p0StarterPageWith4Buttons") private var p0StarterPageWith4Buttons = true
         @AppStorage("p1showPageIMPandURGPopUp")  private var p1showPageIMPandURGPopUp = false
         @AppStorage("p2showPageIMPPopUp") private var p2showPageIMPPopUp = false
         @AppStorage("p3showPageURGPopUp") private var p3showPageURGPopUp = false
         @AppStorage("p4showPageNOTHINGPopUp") private var p4showPageNOTHINGPopUp  = false
     
 // MARK: – For Keeping Count of How Many Items There is on Different Pages ・・・・・・・・・・・・・・・
     
     @AppStorage("isThereAnyIMPandURGItem") var isThereAnyIMPandURGItem = false
     @AppStorage("isThereMoreThanOneIMPandURGItem") var isThereMoreThanOneIMPandURGItem = false
     
     @AppStorage("isThereAnyIMPItem") var isThereAnyIMPItem = false
     @AppStorage("isThereMoreThanOneIMPItem") var isThereMoreThanOneIMPItem = false
     
     @AppStorage("isThereAnyURGItem")  var isThereAnyURGItem = false
     @AppStorage("isThereMoreThanOneURGItem")  var isThereMoreThanOneURGItem =  false
     
     @AppStorage("isThereAnyNOTHINGItem")  var isThereAnyNOTHINGItem = false
     @AppStorage("isThereMoreThanOneNOTHINGItem")  var isThereMoreThanOneNOTHINGItem = false
         
 /* MARK: 💥・・・・・・・・・・・・・・・・・・・・・・・・・・🎾For Enabling Editmode (i.e. delete list items) different pages🎾 ・・・・・・・・・・・・・・・・・・・・・・・・・・💥*/
     
 // MARK: – ❗️⭐️❗️ För EditMode
 /*
      OBS❗️– när EditMode != true -> Sorted och Showing bestämmer vad som ska visas
      OBS❗️– när EditMode == true -> MoveMode, SortMode och ShowMode bestämmer vad som ska visas
 */
     @AppStorage("EditMode")  var EditMode = false
     
     
     
     // MARK: – ⭐️ För AddMode och det som visas för Add Task with a Task Name
     @AppStorage("AddMode") var AddMode = false
     @AppStorage("AddOneTaskWithTaskName") private var AddOneTaskWithTaskName: String = ""
     @AppStorage("AddItemWithTaskNameFilterResultTextHint") private var AddItemWithTaskNameFilterResultTextHint: String = " add with name"
     
     @AppStorage("substitoto") private var substitoto: String = ""
     
     
     
     // MARK: – ⭐️ För det som visas när EditMode == true men (MoveModee == false) && (SortMode == false) && (ShowMode == false) {
     @AppStorage("DeleteMode") var DeleteMode = false
     @AppStorage("rmALLPageMode") var rmALLPageMode = false
     
     // MARK: – ⭐️ För Show Picker
     @AppStorage("MoveMode") var MoveMode = false
     @State private var pages = ["Important", "Useful", "Urgent", "Other"]
     @AppStorage("toPage") private var toPage = 0
     
     
     
     // MARK: – ⭐️ För Show
     @AppStorage("ShowMode") var ShowMode = false
     
     @AppStorage("ShowTextFieldTaskNameFilterResultTextHint") var ShowTextFieldTaskNameFilterResultTextHint: String = ""
     @AppStorage("ShowTextFieldTaskDescriptionFilterResultTextHint") var ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
     @AppStorage("ShowCONTAINSTaskName") var ShowCONTAINSTaskName: String = ""
     @AppStorage("ShowCONTAINSTaskDescription") var ShowCONTAINSTaskDescription: String = ""
     @AppStorage("helpWithShowCONTAINS") var helpWithShowCONTAINS: String = ""
     
     @AppStorage("ShowRequirementOptions") var ShowRequirementOptions = true
     
     // if true då visas TextField("\(ShowTextFieldTaskNameFilterResultTextHint)", text: $ShowCONTAINSTaskName), if false då visas TextField("\(ShowTextFieldTaskDescriptionFilterResultTextHint)", text: $ShowCONTAINSTaskDescription) – i if !($ShowRequirementOptions.wrappedValue) { – i if $ShowMode.wrappedValue && !($MoveMode.wrappedValue) && !($SortMode.wrappedValue) { – i if $isThereMoreThanOneIMPandURGItem.wrappedValue { – i if $EditMode.wrappedValue {
     @AppStorage("ShowShowBarForTaskNameIfTrueElseTaskDescription") var ShowShowBarForTaskNameIfTrueElseTaskDescription = true
     @AppStorage("uselessButUsedinShowItemsAfterSavingTask") var uselessButUsedinShowItemsAfterSavingTask = false
     @AppStorage("thereIsItemsInCallFromShowButton") var thereIsItemsInCallFromShowButton = false // ❗️används i if $ShowMode.wrappedValue && !($SortMode.wrappedValue) { / Button("Show")
     
     
     
     // MARK: – ⭐️ För Sort
     @AppStorage("SortMode") var SortMode = false // if true -> ist för trash och + button så öppnas Sort alternativen
     @AppStorage("SortRequirementOptions") var SortRequirementOptions = true // ska alltid bli assignad till true så att antingen sort By Date knappen / Sort by Priority ska öppnas/visas
     
     @AppStorage("TasksIsSortedbyDateIfTrueElsePriority") var TasksIsSortedbyDateIfTrueElsePriority = true // ❗️
     @AppStorage("TasksIsSortedIncreasingIfTrueElseDecreasing") var TasksIsSortedIncreasingIfTrueElseDecreasing = true // ❗️
     @AppStorage("SortByIncreasing") var SortByIncreasing = false // ❗️if true -> då ska du call the apropiate sort från RealmManager when you edit (add/delete) tasks, och även när du öppnar upp en task item och SAVE den så listan ska vara sorterad på det sättet som det var innan man clicked på¨en item och editor sidan öppnades, ❗️if == false då är listan sorterad dec
     
     
     
     // MARK: – ⭐️ För Sort fast dock efter att vi har använt SHOW på listan
     @AppStorage("ShowFilterAndSortMode") var ShowFilterAndSortMode = false // if true -> då är vi i if !($EditMode.wrappedValue) { ––› if $Showing.wrappedValue && !($Sorted.wrappedValue) {
     @AppStorage("showBackButtonForSortinShowingAndSortedIfTrue") var showBackButtonForSortinShowingAndSortedIfTrue = false // används för att dölja Unshow knappen i översta HStacken på listan av task itemsen för att annars det finns ej så mycket plats för Sort Options att visas
     
     @AppStorage("ShowSortRequirementAfterUnshow") var ShowSortRequirementAfterUnshow = true // if true -> då visas det upp Date/Priority ist för inc/dec i if $Showing.wrappedValue && !($Sorted.wrappedValue) { – i if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) { – i if $isThereMoreThanOneIMPandURGItem.wrappedValue { – i if $ShowFilterAndSortMode.wrappedValue {
     
     
     
     // MARK: – ⭐️ För Move fast dock efter att vi har använt Show&Filter på listan
     @AppStorage("showMoveAfterShowFilterAndSortMode") var showMoveAfterShowFilterAndSortMode = true
     
     
     
 // MARK: – ❗️⭐️❗️ For setting the standard-view-of-items/SHOW/SORT of the list of Items ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @AppStorage("Showing") var Showing = false // ❗️if true -> listan är filtrerad/Showing och visar vissa Items containing a String
         @AppStorage("ShowingAndSortedIfTrueElseShowing") var ShowingAndSortedIfTrueElseShowing = false // ❗️if true -> listan är både filtrerad/Showing och sorterad, if false -> listan är endast Filtrerad/Showing
             @AppStorage("ShowSortByDateAfterUnshowButtonIfTrueElsePriority") var ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true // ❗️if true -> då kommer vi att använda realmManager.FilterAndSort() snart för att sortera det vi Filtrerade/Show baserad på Task Itemens Datum
             @AppStorage("ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") var ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true // ❗️if true -> då har vi använt realmManager.FilterAndSort() och sorterat det vi Filtrerade/Show sedan innan enligt en Increasing
     @AppStorage("Sorted") var Sorted = false  // ❗️if true -> listan är sorterad endast filtrerad/Showing
     
     
     
 // MARK: – For Editing the text inside the 2Editor Page ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @State private var CurrentItemID = 0
     @AppStorage("ShowEditor") private var ShowEditor = false
     
     @State private var text = ""
     
     @State private var TaskNameText: String = ""
     @State private var TaskDescriptionText: String = ""
     
     /* När user trycker på md mode så ska hela Stringen splittas baserad på \n och
        sedan ska markdown() functionen appliceras på elementen av dessa 2 arrayen */
     @State var TaskNameSplitForMarkDownMode: [String] = []
     @State var TaskDescriptionSplitForMarkDownMode: [String] = []
     
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
     @State private var TaskPriority: Int = 0
     
     // MARK: – ⭐️ För Priority Picker
     //@State private var priorities = [ "𝚘", "●", "●●", "●●●", "●●●●", "●●●●●"]
     @State private var priorities = [ "0", "1", "2", "3", "4", "5"]
     @State private var pickedPriority = 0
     
 // MARK: – wordCount ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     //@State private var inputText = ""
     
     //@State private var wordCountTaskName: Int = 0
     //State private var wordCountTaskDescription: Int = 0
     
 // MARK: –  markdown ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @State private var MDmode = false
     @State private var MDname: AttributedString = ""
     @State private var MDtext: AttributedString = ""
     
     @State private var txtifTrueElseMarkDownPreviewStyle = true
     
     @State private var MD_Mode_Text_Size: Double = 15
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
     
     
 // MARK: – some conditional views ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     //__för sidorna med text på
     @State private var isOn: Bool = false
     @State private var isPresented: Bool = false
     //__ för $var som du måste ange som parametern till struct constructorn för SimpleButton
     @State private var dummy1 = true
     
 // MARK: – to show the current date on the first page & välja Task Itemsens Date() ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @State private var currenttimetext = Date()
     @State private var timetext = Date()
     
     @State var selectedDate = Date()
     
 // MARK: – för miniCalculator ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
 /*
      @State private var miniCalculatorNumberLEFT: String = ""
      @State private var miniCalculatorNumberRIGHT: String = ""
      @State private var valdOperator: Int = 0
      @State private var showMathResult: Bool = false
      
      @State private var calculatedResultTextLEFT: String = ""
      @State private var calculatedResultTextRIGHT: String = ""
      
      @State private var showMiniCalculator = false */
     
 // MARK: – to show the current weather information ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
 /*
      @State private var weatherService = WeatherService()
      @State let stockholm = CLLocation(latitude: 59, longitude: 18)
      @State let weather = try! await weatherService.weather(for: stockholm)
      @State let temperature = weather.currentWeather.temperature */
     
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
 /*
      @State private var ifAppisNotPastExpirationDate: Bool = false
      // för setting the Expiration Date for the app
      @State private var expirationDate: Date = Date()
      @State private var forSettingTheExpirationDate: Date = Date()
      
      @State private var forCheckingWhichExpirationDateIsSettInRealm: Date = Date() */
     
     @State private var showDayCounter = false
     @State private var showWeekFinder = false
     
 // MARK: – for using the Date and calender time thingis ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
     
     @AppStorage("engine_name") private var engine_url_name: String = "Google"
     
     @AppStorage("multi_function_button") private var multi_func_button: String = "Day Counter"
     
     @State private var isLoginItemEnabled = UserDefaults.standard.bool(forKey: "isLoginItemEnabled")
     
 // MARK: - 💥Start var body: some View { ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
     
 /* 💥Inne i var body definierar man saker som "popover" när du klickar på menubar iconen. */
     var body: some View {
         
     /*
          pagecount increases if moving further "into" the popover UI layers (further == to left).
          Value on pageCount defines how many pages is "navigatble" from the first page when the popver, pops open. */
 // MARK: - 🚌 Start PopoverPageController・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
         PopoverPageController(pageCount: 2, currentIndex: $currentPopoverPage) {
             
         /*
              currentPopoverPage = 0 ––> the start page (i.e. 4 Big Buttons)
              currentPopoverPage = 1 ––> the page where list of Items are on with their editors */
             
 // MARK: – 🔵 sida nr 1 på PopoverPageController (startsidan)
             VStack {
                 ZStack { // MARK: – ZWorld 1 Start・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
                    
                         VStack (spacing: 5) {
                             
                             // power–Button,Launch at login Toggle &  Dark/Light mode Toggle
                             VStack (alignment: .leading) {
                                 HStack (spacing: 0) {
                                     HStack (spacing: 0) {
                                         Search_Engines()
                                         Spacer()
                                     }.frame(width: 58, alignment: .leading)
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
                                                                         */
                                     
                                     Spacer()
                                         .frame(width: 82)
                                     
                                     Toggle("Dark/Light mode Toggle",isOn: $darkMode)
                                         .toggleStyle(
                                             DarkModeToggle2()
                                         ).preferredColorScheme(darkMode ? .dark : .light) /* .preferredColorScheme(darkMode ? .dark : .light) efter denna Toggeln gör hela toggeln som en switch knapp för darkmode/light mode för appen */
                                    /* Button(action: {
                                                                                 toggleLoginItem()
                                                                             }) {
                                                                                 Text(isLoginItemEnabled ? "Remove Login Item" : "Add Login Item")
                                                                             }
                                                                     */
                                     
                                     HStack (spacing: 2) {
                                         
                                         Spacer()
                                            
                                         /*Text("∙")
                                                                                     .foregroundColor(colorScheme == .dark ? Color.dotDarkMode : Color.dotLightMode)*/
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
                                         Text("∙")
                                             .foregroundColor(colorScheme == .dark ? Color.dotDarkMode : Color.dotLightMode)
                                         Toggle("Shutdown mode Toggle",isOn: $shutdownAppButtonIfTrueElseYorN)
                                             .toggleStyle(
                                                 ShutDownToggle()
                                             )
                                     }.frame(width: 145, alignment: .trailing)
                                 }
                             }.frame(width: 317, alignment: .trailing)
                              .padding(1)
                             
                             HStack (spacing: 0) {
                                 Text(engine_url_name)
                                     .font(.system(size: 9, weight: .light, design: .monospaced))
                                     .frame(alignment: .leading)
                                 HStack {
                                     Spacer()
                                 }.frame(width: 200)
                             }.frame(width: 317)
                              .offset(CGSize(width: 0, height: -9))
                              .shadow(radius: 0.6)
                             
                             
                             /* expiraitondate TEXT som USERN ser
                                                          HStack (spacing: 1) {
                                                              Text(" expiration date: ")
                                                                 .font(.system(size: 8, weight: .light))
                                                              Text(expirationDate, style: .date)
                                                                 .font(.system(size: 9, weight: .light))
                                                                 .foregroundColor(colorScheme == .dark ? Color.gray : Color.ListPageNameLightMode)
                                                              Spacer()
                                                          } */
                             if $showDeveloperSettingsToggleButton.wrappedValue {
                                 HStack {
                                     Text("how many settingsObject is there in Realm?? \(countSettingsObjectsInRealm)")
                                         .font(.system(size: 8, weight: .light))
                                     Spacer()
                                     Button(
                                         action: {
                                             // countSettingsObjectsInRealm – ska visa 5??, vilket ska stå för appens generella inställningar Object som ska finnas rätt i Realm + 4 st Realm Object för Page 1-4 View Settingsen
                                             countSettingsObjectsInRealm = realmManager.countHowManySettingsObjectIsSaved()
                                         },
                                         label: {
                                             Text("recount settings object")
                                                 .font(.system(size: 9, weight: .light))
                                         }
                                     )//.buttonStyle(ClearImageBackground())
                                 }
                             
                                 /*HStack {
                                                                      Text("which expirationdate is currently stored in Realm??")
                                                                         .font(.system(size: 8, weight: .light))
                                                                      Text(forCheckingWhichExpirationDateIsSettInRealm, style: .date)
                                                                         .font(.system(size: 9, weight: .light))
                                                                         .foregroundColor(colorScheme == .dark ? Color.gray : Color.ListPageNameLightMode)
                                                                      Spacer()
                                                                      Button(
                                                                          action: {
                                                                             forCheckingWhichExpirationDateIsSettInRealm = realmManager.getApplicationExpiraitonDate()
                                                                          },
                                                                          label: {
                                                                              Text("check the Date() again")
                                                                                 .font(.system(size: 9, weight: .light))
                                                                          }
                                                                      )//.buttonStyle(ClearImageBackground())
                                                                  } */
                             }
                             
                             Spacer().padding()
                             
                             // 4 Buttons --> List of Items
                             //if $ifAppisNotPastExpirationDate.wrappedValue {
                             if $p0StarterPageWith4Buttons.wrappedValue {
                                 VStack (spacing: 8) {
                                     HStack (spacing: 8) {
                                         Button(
                                             action: {
                                                 show(pageItemList: 1)
                                                 getViewValuesFor(page: 1)
                                                 isOnPage = 1
                                                 currentPopoverPage = 1
                                             },
                                             label: {
                                                 Text("Important")
                                                     .foregroundColor(colorScheme == .dark ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                     //.foregroundColor(colorScheme == .dark ? Color.neuGrayDark : Color.fourButtonTextLightMode)
                                                     //.fontWeight(.light)
                                                     .font(.system(size: 24, weight: .ultraLight, design: .default))
                                                     //.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                     //.frame(alignment: .topTrailing)
                                                     .frame(width: 130, height: 60)
                                                     .shadow(radius: 0.4)
                                             }
                                         ).buttonStyle(neufourButtonStyle())
                                          .offset(CGSize(width: -12.00, height: -34.00))
                                         Button(
                                             action: {
                                                 show(pageItemList: 2)
                                                 getViewValuesFor(page: 2)
                                                 isOnPage = 2
                                                 currentPopoverPage = 1
                                             },
                                             label: {
                                                 Text("Useful")
                                                     .foregroundColor(colorScheme == .dark ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                     //.fontWeight(.light)
                                                     .font(.system(size: 18, weight: .ultraLight, design: .default))
                                                     .frame(width: 87, height: 42, alignment: .center)
                                                     .shadow(radius: 0.4)
                                             }
                                         ).buttonStyle(neufourButtonStyle2())
                                          .offset(CGSize(width: -3.00, height: 13.00))
                                     }
                                     HStack (spacing: 8) {
                                         Button(
                                             action: {
                                                 show(pageItemList: 3)
                                                 getViewValuesFor(page: 3)
                                                 isOnPage = 3
                                                 currentPopoverPage = 1
                                             },
                                             label: {
                                                 Text("Urgent")
                                                     .foregroundColor(colorScheme == .dark ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                     //.fontWeight(.light)
                                                     .font(.system(size: 15, weight: .ultraLight, design: .default))
                                                     .frame(width: 74, height: 30, alignment: .center)
                                                     .shadow(radius: 0.4)
                                             }
                                         ).buttonStyle(neufourButtonStyle2())
                                          .offset(CGSize(width: 3.00, height: -18.00))
                                         Button(
                                             action: {
                                                 show(pageItemList: 4)
                                                 getViewValuesFor(page: 4)
                                                 isOnPage = 4
                                                 currentPopoverPage = 1
                                             },
                                             label: {
                                                 Text("Other")
                                                     .foregroundColor(colorScheme == .dark ? Color.fourButtonTextDarkMode : Color.fourButtonTextLightMode)
                                                     //.fontWeight(.ultraLight)
                                                     .font(.system(size: 14, weight: .ultraLight, design: .default))
                                                     .frame(width: 42, height: 17, alignment: .center)
                                                     .shadow(radius: 0.2)
                                             }
                                         ).buttonStyle(neufourButtonStyle3())
                                          .offset(CGSize(width: 17.00, height: 6.00))
                                     }
                                 }.frame(alignment: .center)
                                  .offset(CGSize(width: 7.00, height: 13.00))
                             }
                             // } // MARK: – för if $ifAppisNotPastExpirationDate.wrappedValue {
                             
                             Spacer().padding()
                             
                             
                             // MARK: – DEVELOPER SETTINGS – välj the expirationdaten, som sedan sparas det i realm Objecte som hela applicationens setting
                             
                             /*
                                                          if $developerSettings.wrappedValue {
                                                              VStack (spacing: 5) {
                                                                  Text("choose applications expiration date:")
                                                                      .font(.custom("Avenir", size: 9))
                                                                      .bold()
                                                                      .foregroundColor(Color.red)
                                                                      .frame(alignment: .leading)
                                                                  HStack {
                                                                     DatePicker("", selection: $forSettingTheExpirationDate, displayedComponents: .date).labelsHidden()
                                                                     Spacer()
                                                                     Button(
                                                                         action: {
                                                                             let tmp = forSettingTheExpirationDate
                                                                             realmManager.setApplicationExpiraitonDate(dat: tmp)
                                                                             expirationDate = realmManager.getApplicationExpiraitonDate()
                                                                         },label: {
                                                                             Text("set date")
                                                                                  .font(.custom("Avenir", size: 9))
                                                                                  .bold()
                                                                                  .foregroundColor(Color.red)
                                                                                  .minimumScaleFactor(0.5)
                                                                         }
                                                                     )
                                                              }
                                                              Divider()
                                                              .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                          }.frame(height: 70) // för VStack (spacing: 5) {
                                                          } // MARK: – för if $developerSettings.wrappedValue {
                                                     */
                             
 // MARK: – HStack med Knapparna längst ner på första sidan
                             VStack (alignment: .leading) {
                                 HStack {
                                     HStack (spacing: 2) {
                                         Text("\(todaysWeekDayName)")
                                             .font(.custom("Avenir", size: 11))
                                             .shadow(radius: 0.6)
                                         Text("∙")
                                             .foregroundColor(colorScheme == .dark ? Color.dotDarkMode : Color.dotLightMode)
                                             .shadow(radius: 0.6)
                                         Text(todaysDate, style: .date)
                                             .font(.custom("Avenir", size: 11))
                                             //.foregroundColor(colorScheme == .dark ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                             .shadow(radius: 0.6)
                                         Text("∙")
                                             .foregroundColor(colorScheme == .dark ? Color.dotDarkMode : Color.dotLightMode)
                                             .shadow(radius: 0.6)
                                         Text("w")
                                             .font(.custom("Avenir", size: 11))
                                             //.foregroundColor(colorScheme == .dark ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                             .shadow(radius: 0.6)
                                         Text("\(weekNumberOfYear)")
                                             .font(.custom("Avenir", size: 13).weight(.bold))
                                             //.foregroundColor(colorScheme == .dark ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                             .shadow(radius: 0.6)
                                     }.frame(alignment: .bottomLeading)
                                      .offset(CGSize(width: 0, height: 2))
                                      .onAppear() {
                                          todaysDate = Date()
                                          todaysWeekDayName = dateMachine.dayNameOfWeek()
                                          weekNumberOfYear = dateMachine.weekNumber()
                                      }
                                     
                                     Spacer()
                                     
                                     HStack (spacing: 1) {
                                         Button(
                                             action: {
                                                 //openWeekFinderWindow() <– behövs inte längre att öppna ett fönster men låter den ligga här ändå
                                                 
                                                 if (self.showDayCounter) {
                                                     self.showDayCounter.toggle()
                                                 }
                                                 self.showWeekFinder.toggle()
                                             },
                                             label: {
                                                 Text("W ")
                                                     .font(.custom("Avenir", size: 11).weight(.bold))
                                                     //.foregroundColor(colorScheme == .dark ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
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
                                                     //.foregroundColor(colorScheme == .dark ? Color.ListPageNameDarkMode : Color.primary)
                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                     .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                             }
                                         ).buttonStyle(ClearImageBackground())
                                          .frame(alignment: .bottomTrailing)
                                         
                                         /*Button(
                                                                                     action: {
                                                                                         emo.openEmojiBoardPage()
                                                                                     },
                                                                                     label: {
                                                                                         Image(systemName: "face.smiling.inverse")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                                                             .font(.system(size: 15))
                                                                                             .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                                                     }
                                                                                 ).buttonStyle(ClearImageBackground())
                                                                                  .frame(alignment: .bottomTrailing) */
                                     }
                                     
                                     if $showDeveloperSettingsToggleButton.wrappedValue {
                                         Button(
                                             action: {
                                                 developerSettings.toggle()
                                             },
                                             label: {
                                                 Image(systemName: "gearshape.fill")
                                                     .renderingMode(.original)//MARK: – 🩸 hur väljer en "tema" av SF Symbol Image
                                                     //.foregroundColor(colorScheme == .dark ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                                                     .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                             }
                                         ).buttonStyle(ClearImageBackground())
                                     } // MARK: – för if $showDeveloperSettingsToggleButton.wrappedValue {
                                 }
                             }.frame(width: 310, height: 35, alignment: .bottom)
                              .padding(3)
                             
                         }.frame(width: 315, height: 500) // MARK: –  VStack INSIDE ZSTACK
                          .padding(1)
                         /*
                                                  .onAppear() {
                                                      realmManager.getApplicationExpiraitonDate()
                                                      // has today passed the  day of expiration
                                                      isDatePastApplicationExpirationDate()
                                                  } */
                         
                         if $showDayCounter.wrappedValue {
                             DayCounter($fromThisDate, $toThisDate, $itIsThisManyYears, $itIsThisManyMonths, $itIsThisManyDays)
                         }
                         if $showWeekFinder.wrappedValue {
                             WeekFinderINNER()
                         }
                         
                 } // MARK: – ZStack för page 1
             } // MARK: – VStack för page 1
             
             
 // MARK: – 💥💥💥💥💥START💥💥💥💥💥 sidan på POPOVERpageController som innehåller Listan med TaskItemsen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
             
             
             VStack {
                 ZStack { // MARK: – ZStacken where the taskItems lists och everthing kommer att visas på・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
                     
                     
 // MARK: –  PAGE 1 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎
                     
                     
                     // MARK: –  PAGE 1 TopMenu🟠🟠🟠🟠🟠🟠🟠
                     if $p1showPageIMPandURGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
                         
                         // MARK: – List of Items in PAGE 1
                         if !($ShowEditor.wrappedValue) {
                             VStack (spacing: 10) { // MARK: – VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                                 VStack (spacing: 8) { // MARK: –  VStack som håller ihop Edit knappen och page name + Elevator
                                      
                                     
 // MARK: –  PAGE 1 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                     Elevator {
                                         ForEach(realmManager.p1Tasks, id: \.id) { p1TaskItem in
                                             
                                             HStack (spacing: 3) {
                                                 
                                                 ZStack {
                                                     RoundedRectangle(cornerRadius: 10)
                                                         .foregroundColor(colorScheme == .dark ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                     
                                                     HStack (spacing: 2) {
                                                         VStack {
                                                             Button(
                                                                 action: {
                                                                     CurrentItemID  = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                     TaskNameText  = p1TaskItem.taskNAME
                                                                     TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                                     TaskDate = p1TaskItem.taskDate
                                                                     let priority = p1TaskItem.taskPriority
                                                                     TaskPriority = priority
                                                                     pickedPriority = priority
                                                                     
                                                                     MDmode = false
                                                                     showListofTasksIfTrueElseTwoEditors(false)
                                                                     
                                                                     resetEditModeValuesAndCountTasksFor(page: 1)
                                                                     
                                                                     //currentPopoverPage = 2
                                                                 },
                                                                 label: {
                                                                     //Text(markdownThis(p1TaskItem.taskNAME))
                                                                     Text("  \(p1TaskItem.taskNAME)")
                                                                         .font(.custom("Avenir", size: 14))
                                                                         .lineLimit(1)
                                                                         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                         .foregroundColor(colorScheme == .dark ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                 }
                                                             ).buttonStyle(InvincibleNothingButton())
                                                              //.buttonStyle(PrimitiveBigTaskItemButton(p1TaskItem.id, p1TaskItem.taskPriority, isOnPage))
                                                             
                                                         }//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25, alignment: .center)
                                                     } // HStack (spacing: 2) {
                                                     
                                                     Button(
                                                         action: {
                                                             CurrentItemID  = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                             TaskNameText  = p1TaskItem.taskNAME
                                                             TaskDescriptionText = p1TaskItem.taskDESCRIPTION
                                                             TaskDate = p1TaskItem.taskDate
                                                             let priority = p1TaskItem.taskPriority
                                                             TaskPriority = priority
                                                             pickedPriority = priority
                                                             
                                                             MDmode = false
                                                             showListofTasksIfTrueElseTwoEditors(false)
                                                             
                                                             resetEditModeValuesAndCountTasksFor(page: 1)
                                                             
                                                             //currentPopoverPage = 2
                                                         },
                                                         label: {
                                                             VStack {
                                                                 Text("                                                                                ")
                                                                     .font(.custom("Avenir", size: 16))
                                                                     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                 /*Text("                                                                                ")
                                                                                                                                      .font(.custom("Avenir", size: 16))
                                                                                                                                      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                                                                                 */
                                                                 
                                                             }.frame(height: 30)
                                                         }
                                                     ).buttonStyle(InvincibleNothingButton())
                                                      .help(Text("\(p1TaskItem.taskNAME)"))
                                                 }.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                  .shadow(radius: 1)
                                                 
                                     
                                                 
                                                 if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p1TaskItem.isCurrentlyMarked == false ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 1, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                    
                                                 } // if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                 if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p1TaskItem.isCurrentlyMarked == false ? realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: true) : realmManager.updateP1ItemisCurrentlyMarkedMarking(id: p1TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 1, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p1TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                     
                                                 } // if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                 
                                             }.padding(1)
                                         } // ForEach
                                     } // Elevator {
                                 } // Avslut för if VStack (spacing: 8) {
                                 
                                 Button(
                                     action: {
                                         show(pageItemList: 0)
                                         isOnPage = 0
                                         updateTodaysDate()
                                         currentPopoverPage = 0 // gå back so start page
                                         
                                         if !(ShowingAndSortedIfTrueElseShowing) {
                                             ShowSortRequirementAfterUnshow = true
                                             ShowFilterAndSortMode = false
                                             showBackButtonForSortinShowingAndSortedIfTrue = false
                                         }
                                         
                                         resetEditModeValuesAndCountTasksFor(page: 1)
                                         SetTheViewingStateOfAPageInRealm(forPage: 1)
                                     },
                                     label: {
                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                             .font(.system(size: 25))
                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                             .frame(width: 272, height: 9) // MARK: –  RedbackButton 🌈 styra storleken direkt med värden för Bilden
                                     }
                                 ).buttonStyle(RedBackButton())
                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 2, x: -1, y: -0.5)
                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown.opacity(0.5) : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1.5, y: 1)
                                                                     */
                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: 1.7, x: 1, y: 1)
                                  .shadow(color: colorScheme == .dark ? Color.neuPurp : Color.neuOrangeLighter2, radius: 2, x: -1, y: -0.5)
                                 
                             }.frame(width: 305, height: 495) // VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                         } // MARK: – Avslut för if !($ShowEditor.wrappedValue) {
                         
 // 💧📺 PAGE 1´s 2Editor Page💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                         if $ShowEditor.wrappedValue {
                             VStack (spacing: 8) { // väljer avståndet mellan  Group{Top Hstack + ZStack { Date, Priority)}  0ch  (Elevator + ForEach)} och Den .bottom HStacken som har SAVE och .md
                                 
                                 if !($MDmode.wrappedValue) {
                                     VStack (spacing: 0) { // bestämmer avståndet mellan allting som visas på TaskName och TaskDescription + Save Hstacken
                                         
                                         //VStack (spacing: 10) { // Håller ihop TaskNameEditor med Zstacken för Date och Priority
                                             VStack (spacing: 0) {
                                                 HStack {
                                                     HStack (spacing: 0) {
                                                         Text("Priority:  ")
                                                             .font(.custom("Avenir", size: 11))
                                                             .bold()
                                                         HStack {
                                                             Picker(selection: $pickedPriority, label: Text("")) {
                                                                 ForEach(0..<priorities.count, id: \.self) {
                                                                     Text(self.priorities[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }.labelsHidden()
                                                         }.frame(width: 60, height: 27)
                                                     }
                                                     Spacer()
                                                     HStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 //copyToPasteboard(TaskNameText.trimmingCharacters(in: .whitespacesAndNewlines))
                                                                 copyToPasteboard(TaskNameText)
                                                             },
                                                             label: {
                                                                 Image(systemName: "doc.on.doc.fill")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         Button(
                                                             action: {
                                                                 let pastedText = pasteFromPasteboard()
                                                                 TaskNameText = TaskNameText + pastedText
                                                             },
                                                             label: {
                                                                 Image(systemName: "text.badge.plus")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         if !($restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     restoreTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("reset")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         getTaskItemWithCurrentIDsTaskNameFor(page: isOnPage)
                                                                         
                                                                         self.restoreTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                         
                                                         Text("∙")
                                                         
                                                         if !($rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     rmTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("rm")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         TaskNameText = ""
                                                                         /*
                                                                          // MARK: – så att när man trycker igen på reset så ska man kunna resetta tillbaka förra originella texten
                                                                          realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                                                          */
                                                                         self.rmTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                     }
                                                 }.offset(CGSize(width: 0, height: -5))
                                                 
                                                 if colorScheme == .dark {
                                                     DarkModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                                                     .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                                                                                                 */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 } else {
                                                     LightModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                                                     .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                                                                                                     */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 }
                                             } // VStack (spacing: 5) {
                                             /*
                                                                                     if colorScheme == .dark {
                                                                                         HStack {
                                                                                             Text("  Date:")
                                                                                                 .font(.custom("Avenir", size: 11))
                                                                                                 .bold()
                                                                                             HStack {
                                                                                                 DatePicker(
                                                                                                     "", selection: $TaskDate,
                                                                                                     in: dateRange,
                                                                                                     displayedComponents: [.date, .hourAndMinute]
                                                                                                 ).labelsHidden()
                                                                                                     .padding()
                                                                                             }.frame(width: 130, height: 27)
                                                                                             Text(" ")
                                                                                             
                                                                                         }.frame(width: 298, height: 27, alignment: .center)
                                                                                          .shadow(radius: 1)
                                                                                          //.background(colorScheme == .dark ? Color.clear : Color.clear, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                                                                                     } else {
                                                                                         HStack {
                                                                                             Text("  Date:")
                                                                                                 .font(.custom("Avenir", size: 11))
                                                                                                 .bold()
                                                                                             HStack {
                                                                                                 DatePicker(
                                                                                                     "", selection: $TaskDate,
                                                                                                     in: dateRange,
                                                                                                     displayedComponents: [.date, .hourAndMinute]
                                                                                                 ).labelsHidden()
                                                                                                  .padding()
                                                                                             }.frame(width: 130, height: 27)
                                                                                             Text(" ")
                                                                                             HStack (spacing: 0) {
                                                                                                 Text("Priority:  ")
                                                                                                     .font(.custom("Avenir", size: 11))
                                                                                                     .bold()
                                                                                                 HStack {
                                                                                                     Picker(selection: $pickedPriority, label: Text("")) {
                                                                                                         ForEach(0..<priorities.count, id: \.self) {
                                                                                                             Text(self.priorities[$0])
                                                                                                                 .font(.custom("Avenir", size: 10))
                                                                                                                 .frame(alignment: .trailing)
                                                                                                         }
                                                                                                     }.labelsHidden()
                                                                                                 }.frame(width: 60, height: 27)
                                                                                             }
                                                                                         }.frame(width: 298, height: 27, alignment: .center)
                                                                                         //.background(colorScheme == .dark ? Color.clear : Color.clear, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                                                                                     }*/
                                                                                     
                                                                                 //} // för VStack (spacing: 10) {
                                                                                 
                                                                                 /*VStack (spacing: 5) {
                                                                                     HStack {
                                                                                         Text(" Description:")
                                                                                             .font(.custom("Avenir", size: 19))
                                                                                             .bold()
                                                                                             .shadow(radius: 20)
                                                                                             .frame(height: 22, alignment: .leading)
                                                                                         Spacer()
                                                                                         HStack (spacing: 0) {
                                                                                             Button(
                                                                                                 action: {
                                                                                                     //copyToPasteboard(TaskDescriptionText.trimmingCharacters(in: .whitespacesAndNewlines))
                                                                                                     copyToPasteboard(TaskDescriptionText)
                                                                                                 },
                                                                                                 label: {
                                                                                                     //Text(" copy")
                                                                                                     Image(systemName: "doc.on.doc.fill")
                                                                                                         .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                                                                 }
                                                                                             ).buttonStyle(CopyAndPaste())
                                                                                             
                                                                                             Text("∙")
                                                                                             
                                                                                             Button(
                                                                                                 action: {
                                                                                                     let pastedText = pasteFromPasteboard()
                                                                                                     TaskDescriptionText = TaskDescriptionText + pastedText
                                                                                                 },
                                                                                                 label: {
                                                                                                     Image(systemName: "text.badge.plus")
                                                                                                         .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                                                                 }
                                                                                             ).buttonStyle(CopyAndPaste())
                                                                                             
                                                                                             Text("∙")
                                                                                             
                                                                                             if !($restoreTaskDescriptionChooseOptionIfTrueElseYorN.wrappedValue) {
                                                                                                 Button(
                                                                                                     action: {
                                                                                                         restoreTaskDescriptionChooseOptionIfTrueElseYorN = true
                                                                                                     },
                                                                                                     label: {
                                                                                                         Text("reset")
                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                     }
                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                             }
                                                                                             if $restoreTaskDescriptionChooseOptionIfTrueElseYorN.wrappedValue {
                                                                                                 HStack (spacing: 2) {
                                                                                                     Button(
                                                                                                         action: {
                                                                                                             getTaskItemWithCurrentIDsTaskDescriptionFor(page: isOnPage)
                                                                                                             
                                                                                                             self.restoreTaskDescriptionChooseOptionIfTrueElseYorN.toggle()
                                                                                                         },
                                                                                                         label: {
                                                                                                             Text("y")
                                                                                                                 .font(.custom("Avenir", size: 15))
                                                                                                                 .foregroundColor(Color.RedTRASHAndRM)
                                                                                                         }
                                                                                                     ).buttonStyle(ClearImageBackground())
                                                                                                     Text(" or ")
                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                     Button(
                                                                                                         action: {
                                                                                                             self.restoreTaskDescriptionChooseOptionIfTrueElseYorN.toggle()
                                                                                                         },
                                                                                                         label: {
                                                                                                             Text("n")
                                                                                                                 .font(.custom("Avenir", size: 15))
                                                                                                                 .foregroundColor(Color.BlueEdit)
                                                                                                         }
                                                                                                     ).buttonStyle(ClearImageBackground())
                                                                                                 }
                                                                                             }
                                                                                             
                                                                                             Text("∙")
                                                                                             
                                                                                             if !($rmTaskDescriptionTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                                                                 Button(
                                                                                                     action: {
                                                                                                         rmTaskDescriptionTextChooseOptionIfTrueElseYorN = true
                                                                                                     },
                                                                                                     label: {
                                                                                                         Text("rm")
                                                                                                             .foregroundColor(Color.RedTRASHAndRM)
                                                                                                     }
                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                             }
                                                                                             if $rmTaskDescriptionTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                                                                 HStack (spacing: 2) {
                                                                                                     Button(
                                                                                                         action: {
                                                                                                             TaskDescriptionText = ""
                                                                                                             /* MARK: – så att när man trycker igen på reset så ska man kunna resetta tillbaka förra originella texten
                                                                                                             realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority) */
                                                                                                             rmTaskDescriptionTextChooseOptionIfTrueElseYorN = false
                                                                                                         },
                                                                                                         label: {
                                                                                                             Text("y")
                                                                                                                 .font(.custom("Avenir", size: 15))
                                                                                                                 .foregroundColor(Color.RedTRASHAndRM)
                                                                                                         }
                                                                                                     ).buttonStyle(ClearImageBackground())
                                                                                                     Text(" or ")
                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                     Button(
                                                                                                         action: {
                                                                                                             rmTaskDescriptionTextChooseOptionIfTrueElseYorN = false
                                                                                                         },
                                                                                                         label: {
                                                                                                             Text("n")
                                                                                                                 .font(.custom("Avenir", size: 15))
                                                                                                                 .foregroundColor(Color.BlueEdit)
                                                                                                         }
                                                                                                     ).buttonStyle(ClearImageBackground())
                                                                                                 }
                                                                                             }
                                                                                         }
                                                                                     }
                                                                                     
                                                                                     if colorScheme == .dark {
                                                                                         DarkModeEditorControllerView(text: $TaskDescriptionText)
                                                                                             .onNSView(
                                                                                                 added: { nsview in
                                                                                                     let root = nsview.subviews[0] as! NSScrollView
                                                                                                     root.hasVerticalScroller = true
                                                                                                     root.hasHorizontalScroller = false
                                                                                                 }
                                                                                             )
                                                                                             .multilineTextAlignment(.leading)
                                                                                             .font(.custom("Avenir", size: 10))
                                                                                             .frame(width: 305, height: 296)
                                                                                             .lineSpacing(2.8)
                                                                                             .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                             .cornerRadius(9)
                                                                                             //.shadow(radius: 4)
                                                                                             /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                             .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1) */
                                                                                             .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                                                     } else {
                                                                                         LightModeEditorControllerView(text: $TaskDescriptionText)
                                                                                             .onNSView(
                                                                                                 added: { nsview in
                                                                                                     let root = nsview.subviews[0] as! NSScrollView
                                                                                                     root.hasVerticalScroller = true
                                                                                                     root.hasHorizontalScroller = false
                                                                                                 }
                                                                                             )
                                                                                             .multilineTextAlignment(.leading)
                                                                                             .font(.custom("Avenir", size: 10))
                                                                                             .frame(width: 305, height: 296)
                                                                                             .lineSpacing(2.8)
                                                                                             .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                             .cornerRadius(9)
                                                                                             //.shadow(radius: 4)
                                                                                             /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                             .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1) */
                                                                                             .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                                                     }
                                                                                 } // för VStack (spacing: 5) { */
                                         
                                     }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 1/2💧 – för VStack Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                 } // MARK: – för if !($MDmode.wrappedValue) {
                                 if $MDmode.wrappedValue {
                                     VStack (spacing: 2) {
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
                                                                                                      .font(.headline) */
                                                                                                 }*/
                                                 
                                                 if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                     Text(TaskNameText)
                                                         .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                         .foregroundColor(.black)
                                                         .lineSpacing(MD_Mode_Text_Space)
                                                         //.fontWidth(Font.Width(MD_Mode_Text_Width))
                                                         //.tracking(MD_Mode_Text_Width)
                                                         .kerning(MD_Mode_Text_Width)
                                                         .frame(maxWidth: .infinity, alignment: .leading)
                                                 } else {
                                                     /*Text(MDname)
                                                                                                                 .font(.custom("Avenir", size: 13))
                                                                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                                                                         */
                                                     LazyVStack {
                                                         ForEach(0..<TaskNameSplitForMarkDownMode.count, id: \.self) { index in
                                                             Text(markdownThis(TaskNameSplitForMarkDownMode[index]))
                                                                 .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                                 .foregroundColor(.black)
                                                                 .lineSpacing(MD_Mode_Text_Space)
                                                                 .kerning(MD_Mode_Text_Width)
                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                             if index != TaskNameSplitForMarkDownMode.count - 1 {
                                                                 Text("                                                                                     ")
                                                             }
                                                         }
                                                     }
                                                 }
                                             }.padding(5)
                                             /*
                                                                                         Divider().background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                         VStack (spacing: 3) {
                                                                                             HStack {
                                                                                                 Text("Description:")
                                                                                                     .font(.custom("Avenir", size: 19))
                                                                                                     .bold()
                                                                                                     .frame(maxWidth: .infinity, alignment: .leading)
                                                                                                 /* Text("  \(wordCountTaskDescription) w")
                                                                                                  .bold()
                                                                                                  .font(.headline) */
                                                                                             }
                                                                                             
                                                                                             if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                                                                 Text(TaskDescriptionText)
                                                                                                     .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                                                                     .lineSpacing(MD_Mode_Text_Space)
                                                                                                     //.fontWidth(Font.Width(MD_Mode_Text_Width))
                                                                                                     //.tracking(MD_Mode_Text_Width)
                                                                                                     .kerning(MD_Mode_Text_Width)
                                                                                                     .frame(maxWidth: .infinity, alignment: .leading)
                                                                                             } else {
                                                                                                 /*Text(MDtext)
                                                                                                     .font(.custom("Avenir", size: 13))
                                                                                                     .frame(maxWidth: .infinity, alignment: .leading) */
                                                                                                 LazyVStack {
                                                                                                     ForEach(0..<TaskDescriptionSplitForMarkDownMode.count, id: \.self) { index in
                                                                                                         Text(markdownThis(TaskDescriptionSplitForMarkDownMode[index]))
                                                                                                             .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                                                                             .lineSpacing(MD_Mode_Text_Space)
                                                                                                             .kerning(MD_Mode_Text_Width)
                                                                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                                                                         if index != TaskDescriptionSplitForMarkDownMode.count - 1 {
                                                                                                             Text("                                                                                     ")
                                                                                                         }
                                                                                                     }
                                                                                                 }
                                                                                             }
                                                                                         }.padding(5)
                                                                                     */
                                         }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 2/2💧 – för ScrollView – Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                     }.background(colorScheme == .dark ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                      .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                      .shadow(radius: 3)
                                 } // för if $MDmode.wrappedValue {
                                 
 // 💧📺 PAGE 1´s 2Editor – Knapperna SAVE och .md💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                                 HStack (spacing: 8) {
                                     
                                     if !($MDmode.wrappedValue) {
                                         VStack (alignment: .leading) {
                                             HStack (spacing: 8) {
                                                 Button(
                                                     action: {
                                                         exit2EditorPageButtonAction()
                                                         //currentPopoverPage = 1
                                                     },
                                                     label: {
                                                         //Text(" Back")
                                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                                             .font(.system(size: 14))
                                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                             .frame(width: 85, height: 18) // MARK: –  miniRedbackButton 🌈 styra storleken direkt med värden för Bilden
                                                     }
                                                 ).buttonStyle(miniRedBackButton())
                                                  .offset(CGSize(width: -4, height: 1))
                                                  .help(Text("Save & Return"))
                                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 1, x: -0.6, y: -0.6)
                                                                                                      .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1, y: 1)
                                                                                                     */
                                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.75), radius: 0.75, x: 0.9, y: 0.8)
                                                  .shadow(color: colorScheme == .dark ? Color.neuPurp.opacity(0.6) : Color.neuOrangeLighter2, radius: 1.5, x: -1.2, y: -1)
                                                 
                                                 Divider()
                                                     .frame(width: 2, height: 31, alignment: .bottom)
                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 
                                                 Button(
                                                     action: {
                                                         let priority = pickedPriority
                                                         
                                                         if isOnPage == 1 {
                                                             realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 2 {
                                                             realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 3 {
                                                             realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 4 {
                                                             realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         }
                                                     },
                                                     label: {
                                                         HStack (spacing: 0) {
                                                             //Text("Save -a")
                                                             Text("Save")
                                                                 .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                         }
                                                     }
                                                 ).buttonStyle(ClearImageBackground())
                                                  .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                 
                                                 Spacer()
                                             } // HStack (spacing: 0) {
                                         } // VStack (alignment: .leading) {
                                     }
                                     
                                     Button(
                                         action: {
                                             // 1 – ❗️
                                             //realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                             // 2
                                             let markdownName = TaskNameText
                                             let markdownDescription = TaskDescriptionText
                                             
                                             /* split returns a list of Substrings, so we have to map (convert) them to Strings. To do that you can just pass the Substring to the Strings init function */
                                             TaskNameSplitForMarkDownMode = markdownName.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             TaskDescriptionSplitForMarkDownMode = markdownDescription.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             /* ––– behövs ej då vi har fixat att markdown visar rätt baserad på \n char
                                                                                         do {
                                                                                             MDname = try AttributedString(markdown: markdownName)
                                                                                             MDtext = try AttributedString(markdown: markdownDescription)
                                                                                         } catch  {
                                                                                             print("Error creating AttributedString:  \(error)")
                                                                                         }
                                                                                         */
                                                                                         
                                             /*
                                                                                              let taskNameWords = TaskNameText.split { $0 == " " || $0.isNewline }
                                                                                              wordCountTaskName = taskNameWords.count
                                                                                              
                                                                                              let taskDescriptionWords = TaskDescriptionText.split { $0 == " " || $0.isNewline }
                                                                                              wordCountTaskDescription = taskDescriptionWords.count
                                                                                          */
                                             
                                             // 3
                                             self.MDmode.toggle()
                                             // ––
                                             resetViewValuesFor2EditorPage()
                                         },
                                         label: {
                                             HStack (spacing: 0) {
                                                 Image(systemName: "paintbrush.fill")
                                                     .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                             }//.shadow(color: colorScheme == .dark ? Color.neuPurp: Color.neuOrange, radius: 2, x: 0, y: 0)
                                         }
                                     ).buttonStyle(ClearImageBackground2())
                                      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                     
                                     if $MDmode.wrappedValue {
                                         
                                         HStack (spacing: 7) {
                                             HStack (spacing: 2) {
                                                 
                                                 /*if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                                                                         HStack (spacing: 0) {
                                                                                                             Text(" Space ")
                                                                                                                 .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                             Stepper {
                                                                                                                 //Text("Size \(formatVal(MD_Mode_Text_Size))")
                                                                                                                 //Text(" Space\n \(formatVal3(MD_Mode_Text_Space))")
                                                                                                                 Text("Space")
                                                                                                                     .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                             } onIncrement: {
                                                                                                                 if MD_Mode_Text_Space < 10 {
                                                                                                                     self.MD_Mode_Text_Space += 0.1
                                                                                                                 }
                                                                                                             } onDecrement: {
                                                                                                                 if MD_Mode_Text_Space > 0.1 {
                                                                                                                     self.MD_Mode_Text_Space -= 0.1
                                                                                                                 }
                                                                                                             } onEditingChanged: {
                                                                                                                 print("\($0)")
                                                                                                             }.labelsHidden()
                                                                                                         }
                                                                                                         HStack (spacing: 0) {
                                                                                                             Text(" Width ")
                                                                                                                 .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                             Stepper(" Width", value: $MD_Mode_Text_Width, in: 0...1.7, step: 0.1, onEditingChanged: {
                                                                                                                 print("\($0)")
                                                                                                             }).labelsHidden()
                                                                                                         }//.padding(.horizontal, 1)
                                                                                                 }*/
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
                                             }.frame(width: 160, alignment: .trailing) // HStack
                                              .padding(.horizontal, 1)
                                             
                                             Divider()
                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 .frame(width: 2, height: 31, alignment: .bottom)
                                                 .padding(.horizontal, 1)
                                             
                                             txtORmd($txtifTrueElseMarkDownPreviewStyle)
                                         }.frame(width: 270, height: 17)
                                     }
                                     
                                 }.frame(width: 295, height: 17) // HStack (spacing: 0) {
                                 
                             }.frame(width: 305, height: 495, alignment: .center) // för VStack (spacing: 8) {
                              .padding(5)
                             
                         } // MARK: – Avslut för if $ShowEditor.wrappedValue {
                         
                     } // MARK: – för if $p1showPageIMPandURGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
                     
 // MARK: – PAGE 2 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎
                     
                     if $p2showPageIMPPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
                         
                         // MARK: – List of Items in PAGE 2
                         if !($ShowEditor.wrappedValue) {
                             VStack (spacing: 10) { // MARK: – VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                                 VStack (spacing: 8) { // MARK: – VStack som håller ihop Edit knappen och page name + Elevator
                                     
                                     
                                     // HStacken som innehåller alla edit och sort buttons
                                     HStack (spacing: 10) {
                                         ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                                             
 // MARK: – PAGE 2 🔅 if !($EditMode.wrappedValue) {
                                             if !($EditMode.wrappedValue) {
                                                 HStack {
                                                     
                                                     //.................
                                                     
                                                     if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                         
                                                         Button(
                                                             action: {
                                                                 CountIMPTasks()
                                                                 EditMode = true
                                                                 
                                                                 AddMode = true
                                                                 MoveMode = false
                                                                 DeleteMode = false
                                                                 rmALLPageMode = false
                                                                 SortMode = false
                                                                 ShowMode = false
                                                             },
                                                             label: {
                                                                 Text(" Add")
                                                                     .foregroundColor(Color.BlueEdit)
                                                                     .bold()
                                                                     .font(.headline)
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                          .keyboardShortcut("a", modifiers: [.command])
                                                          //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                                          //.keyboardShortcut(.defaultAction)
                                                         
                                                         if $isThereAnyIMPItem.wrappedValue {
                                                             Divider()
                                                                 .frame(width: 2, height: 32, alignment: .leading)
                                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                             Button(
                                                                 action: {
                                                                     CountIMPTasks()
                                                                     EditMode = true
                                                                     
                                                                     AddMode = false
                                                                     MoveMode = false
                                                                     DeleteMode = false
                                                                     rmALLPageMode = false
                                                                     SortMode = false
                                                                     ShowMode = false
                                                                 },
                                                                 label: {
                                                                     Text("Edit")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                             if $isThereMoreThanOneIMPItem.wrappedValue {
                                                                 Divider()
                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 //.overlay(.pink)
                                                                 Button(
                                                                     action: {
                                                                         ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                                                         ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                                                         ShowCONTAINSTaskName = ""
                                                                         ShowCONTAINSTaskDescription = ""
                                                                         
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = true
                                                                     },
                                                                     label: {
                                                                         Text("Show")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                                 Divider()
                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 Button(
                                                                     action: {
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = true
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text("Sort")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                             } // MARK: – för if $isThereMoreThanOneIMPItem.wrappedValue {
                                                             
                                                         } // MARK: – för if $isThereAnyIMPItem.wrappedValue {
                                                         
                                                     } // MARK: – if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                     
                                                     //.................
                                                     
                                                     if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                         
                                                         if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                             
                                                             if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                 Button(
                                                                     action: {
                                                                         Showing = false
                                                                         realmManager.updateP2() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                         
                                                                         resetEditModeValuesAndCountTasksFor(page: 2)
                                                                     },
                                                                     label: {
                                                                         Text(" Unshow")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                             }
                                                             /*if $isThereMoreThanOneIMPItem.wrappedValue {
                                                                                                                         if !($ShowFilterAndSortMode.wrappedValue) {
                                                                                                                             
                                                                                                                             if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                                                                                 Divider()
                                                                                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                 Button(
                                                                                                                                     action: {
                                                                                                                                         ShowFilterAndSortMode = true
                                                                                                                                         showBackButtonForSortinShowingAndSortedIfTrue = true
                                                                                                                                         
                                                                                                                                         MoveMode = false
                                                                                                                                         showMoveAfterShowFilterAndSortMode = true
                                                                                                                                     },
                                                                                                                                     label: {
                                                                                                                                         Text("Sort")
                                                                                                                                             .foregroundColor(Color.BlueEdit)
                                                                                                                                             .bold()
                                                                                                                                             .font(.headline)
                                                                                                                                     }
                                                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                                                             } // MARK: – för if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                                                                             
                                                                                                                         } // MARK: – för if !($ShowFilterAndSortMode.wrappedValue) {
                                                                                                                         if $ShowFilterAndSortMode.wrappedValue {
                                                                                                                             
                                                                                                                             if $showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue {
                                                                                                                                 Button(
                                                                                                                                     action: {
                                                                                                                                         if ShowSortRequirementAfterUnshow {
                                                                                                                                             ShowFilterAndSortMode = false
                                                                                                                                         } else {
                                                                                                                                             ShowFilterAndSortMode = false
                                                                                                                                             ShowSortRequirementAfterUnshow = true
                                                                                                                                         }
                                                                                                                                         showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                     },
                                                                                                                                     label: {
                                                                                                                                         // Text(" Back")
                                                                                                                                         Text(" Done")
                                                                                                                                             .foregroundColor(Color.BlueEdit)
                                                                                                                                             .bold()
                                                                                                                                             .font(.headline)
                                                                                                                                     }
                                                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                                                                 
                                                                                                                                 Divider()
                                                                                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                 
                                                                                                                                 if $ShowSortRequirementAfterUnshow.wrappedValue {
                                                                                                                                     Text("by ")
                                                                                                                                         .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                     HStack (spacing: 4) {
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowSortRequirementAfterUnshow = false
                                                                                                                                                 ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("Date")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                     Image(systemName: "alarm.fill")
                                                                                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                         Text("/")
                                                                                                                                             .font(.custom("Avenir", size: 17))
                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowSortRequirementAfterUnshow = false
                                                                                                                                                 ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("Priority")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                     Image(systemName: "exclamationmark.triangle.fill")
                                                                                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                     } // MARK: – för HStack (spacing: 3) {
                                                                                                                                 } // MARK: – för if $ShowSortRequirementAfterUnshow.wrappedValue {
                                                                                                                                 if !($ShowSortRequirementAfterUnshow.wrappedValue) {
                                                                                                                                     HStack (spacing: 4) {
                                                                                                                                         
                                                                                                                                         if $ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue {
                                                                                                                                             Text("by date")
                                                                                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text(" inc")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                             Text("/")
                                                                                                                                                 .font(.custom("Avenir", size: 17))
                                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = false
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                     
                                                                                                                                                     //SetTheViewingStateOfAPageInRealm(forPage: 2)
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text("dec")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                         } // MARK: – för if $ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue {
                                                                                                                                         if !($ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue) {
                                                                                                                                             Text("by priority")
                                                                                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text(" inc")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                             Text("/")
                                                                                                                                                 .font(.custom("Avenir", size: 17))
                                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = false
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                     
                                                                                                                                                     //SetTheViewingStateOfAPageInRealm(forPage: 2)
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text("dec")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                         } // MARK: – för if !($ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue) {
                                                                                                                                         
                                                                                                                                     } // MARK: – för HStack (spacing: 4) {
                                                                                                                                 } // MARK: – för if !($ShowSortRequirementAfterUnshow.wrappedValue) {
                                                                                                                                 
                                                                                                                             } // MARK: – för if $showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue {
                                                                                                                             
                                                                                                                         } // MARK: – för if $ShowAndSortMode.wrappedValue {
                                                                                                                     } // MARK: – för if $isThereMoreThanOneIMPItem.wrappedValue { */
                                                             
                                                         } // MARK: – för if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                         if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                             Button(
                                                                 action: {
                                                                     Showing = false
                                                                     ShowFilterAndSortMode = false
                                                                     ShowingAndSortedIfTrueElseShowing = false
                                                                     
                                                                     realmManager.updateP2() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                     resetEditModeValuesAndCountTasksFor(page: 2)
                                                                 },
                                                                 label: {
                                                                     Text(" reset")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         } // MARK: – för if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                     } // MARK: – för if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                     
                                                     //.................
                                                     
                                                     if $Sorted.wrappedValue && !($Showing.wrappedValue) {
                                                         Button(
                                                             action: {
                                                                 Sorted = false
                                                                 realmManager.updateP2() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                 
                                                                 resetEditModeValuesAndCountTasksFor(page: 2)
                                                             },
                                                             label: {
                                                                 Text(" Unsort")
                                                                     .foregroundColor(Color.BlueEdit)
                                                                     .bold()
                                                                     .font(.headline)
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                     }
                                                     
                                                     //.................
                                                     
                                                     if $Showing.wrappedValue && $Sorted.wrappedValue {
                                                         Button(
                                                             action: {
                                                                 
                                                             },
                                                             label: {
                                                                 VStack {
                                                                     Text(" ❌A possible error related to the showing \n of EDIT/SORT/SHOW buttons has occured, \n please QUIT the app via right-click and open it again")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                         .font(.system(size: 9, weight: .ultraLight, design: .default))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                             .onAppear() {
                                                                 Sorted = false
                                                                 Showing = false
                                                             }
                                                     }
                                                     
                                                 }.frame(width: 230, alignment: .leading) // MARK: – HStack
                                             } // MARK: –  if !($EditMode.wrappedValue) {
 // MARK: – PAGE 2 ⚡️ if $EditMode.wrappedValue {
                                             if $EditMode.wrappedValue {
                                                 HStack (spacing: 2) {
                                                     
                                                     //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                                                     Button(
                                                         action: {
                                                             resetEditModeValuesAndCountTasksFor(page: 2)
                                                         },
                                                         label: {
                                                             Text(" Done  ")
                                                                 .foregroundColor(Color.BlueEdit)
                                                                 .bold()
                                                                 .font(.headline)
                                                                 .frame(alignment: .leading)
                                                         }
                                                     ).buttonStyle(ClearImageBackground())
                                                      .keyboardShortcut("d", modifiers: [.command])
                                                     Divider()
                                                         .frame(width: 2, height: 32, alignment: .leading)
                                                         .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                     //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                                                     
                                                     // 1 ⚡️∙∙∙∙∙
                                                     if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         Text(" ")
                                                         HStack (spacing: 1) {
                                                             Button(
                                                                 action: {
                                                                     realmManager.addToP2()
                                                                     CountIMPTasks()
                                                                 },
                                                                 label: {
                                                                     Image(systemName: "note.text.badge.plus")
                                                                         .renderingMode(.original)
                                                                         .font(.system(size: 18))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .shadow(radius: 0.8)
                                                             /*
                                                                                                                          //Text("・ ")
                                                                                                                          Text(" ⋮")
                                                                                                                              .font(.system(size: 18))
                                                                                                                              .offset(CGSize(width: 0, height: -1))
                                                                                                                              .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                          Text(" ")
                                                                                                                          VStack (spacing: 0) {
                                                                                                                              if colorScheme == .dark {
                                                                                                                                  DarkModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                                                                                                                                      .onNSView(
                                                                                                                                          added: { nsview in
                                                                                                                                              let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                              root.hasVerticalScroller = true
                                                                                                                                              root.hasHorizontalScroller = false
                                                                                                                                          }
                                                                                                                                      )
                                                                                                                                      .multilineTextAlignment(.leading)
                                                                                                                                      .frame(height: 18)
                                                                                                                                      .lineSpacing(2.8)
                                                                                                                                      .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                      .cornerRadius(9)
                                                                                                                                      .shadow(radius: 4)
                                                                                                                              } else {
                                                                                                                                  LightModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                                                                                                                                      .onNSView(
                                                                                                                                          added: { nsview in
                                                                                                                                              let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                              root.hasVerticalScroller = true
                                                                                                                                              root.hasHorizontalScroller = false
                                                                                                                                          }
                                                                                                                                      )
                                                                                                                                      .multilineTextAlignment(.leading)
                                                                                                                                      .frame(height: 18)
                                                                                                                                      .lineSpacing(2.8)
                                                                                                                                      .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                      .cornerRadius(9)
                                                                                                                                      .shadow(radius: 4)
                                                                                                                              }
                                                                                                                          }.frame(width: 100)
                                                                                                                          Button(
                                                                                                                              action: {
                                                                                                                                  substitoto = AddOneTaskWithTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                                                                                                                                  if !(substitoto.isEmpty) {
                                                                                                                                      realmManager.addOneTaskToP2WithTasName(text: substitoto)
                                                                                                                                  } else {
                                                                                                                                      dropEntered()
                                                                                                                                  }
                                                                                                                                  substitoto = ""
                                                                                                                                  AddOneTaskWithTaskName = ""
                                                                                                                              },
                                                                                                                              label: {
                                                                                                                                  Text(" Add")
                                                                                                                                      .foregroundColor(Color.BlueEdit)
                                                                                                                                      .bold()
                                                                                                                                      .font(.headline)
                                                                                                                              }
                                                                                                                          ).buttonStyle(ClearImageBackground())
                                                                                                                           .keyboardShortcut("a", modifiers: [.command])
                                                                                                                           //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                                                                                                           //.keyboardShortcut(.defaultAction)
                                                                                                                         */
                                                         } // MARK: – för HStack (spacing: 1) {
                                                     } // MARK: – if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) &&  !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                     
                                         // 2 ⚡️∙∙∙∙∙
                                                     if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         
                                                         Text(" ")
                                                         if $isThereAnyIMPItem.wrappedValue {
                                                             HStack (spacing: 0) {
                                                                 Button(
                                                                     action: {
                                                                         CountIMPTasks()
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = true
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text("Move  ")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                                 
                                                                 //Text("・")
                                                                 Text("⋮")
                                                                     .font(.system(size: 18))
                                                                     .offset(CGSize(width: 0, height: -1))
                                                                     .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 Text(" ")
                                                                 
                                                                 Button(
                                                                     action: {
                                                                         CountIMPTasks()
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = true
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text(" Remove")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         } // MARK: – if $isThereAnyIMPItem.wrappedValue {
                                                         
                                                     } // MARK: –  if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                     
                                                     if $isThereAnyIMPItem.wrappedValue {
                                             // 3 ⚡️∙∙∙∙∙
                                                         if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Button(
                                                                 action: {
                                                                     realmManager.deleteAllP2ItemisCurrentlyMarkedMarking()
                                                                     CountIMPTasks()
                                                                     if !isThereAnyIMPItem {
                                                                         resetEditModeValuesAndCountTasksFor(page: 2)
                                                                     }
                                                                     
                                                                     if Sorted && !Showing {
                                                                         callCorrectRealmSortFor(page: 2, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                     } else if ShowingAndSortedIfTrueElseShowing {
                                                                         realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                     } else {
                                                                         if Showing && !Sorted {
                                                                             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                         }
                                                                     }
                                                                 },
                                                                 label: {
                                                                     Text("  Remove ")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .help(Text("Remove Marked Tasks"))
                                                             
                                                             //Text("・")
                                                             Text("⋮")
                                                                 .font(.system(size: 18))
                                                                 .offset(CGSize(width: 0, height: -1))
                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                             
                                                             if !($rmALLPageMode.wrappedValue) {
                                                                 Button(
                                                                     action: {
                                                                         rmALLPageMode = true
                                                                     },
                                                                     label: {
                                                                         Text(" rm -a")
                                                                             .foregroundColor(Color.RedTRASHAndRM)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                             if $rmALLPageMode.wrappedValue {
                                                                 HStack (spacing: 2) {
                                                                     Button(
                                                                         action: {
                                                                             realmManager.rmAllP2Tasks()
                                                                             CountIMPTasks()
                                                                             
                                                                             EditMode = false
                                                                             rmALLPageMode = false
                                                                             DeleteMode = false
                                                                         },
                                                                         label: {
                                                                             Text("y")
                                                                                 .font(.custom("Avenir", size: 15))
                                                                                 .foregroundColor(Color.RedTRASHAndRM)
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                     Text(" or ")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                     Button(
                                                                         action: {
                                                                             self.rmALLPageMode.toggle()
                                                                         },
                                                                         label: {
                                                                             Text("n")
                                                                                 .font(.custom("Avenir", size: 15))
                                                                                 .foregroundColor(Color.BlueEdit)
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                 }
                                                             }
                                                         } // MARK: –  if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue)  {
                                             // 4 ⚡️∙∙∙∙∙
                                                         if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Text("  to :")
                                                                 .font(.custom("Avenir", size: 11))
                                                             Picker(selection: $toPage, label: Text("")) {
                                                                 ForEach(0..<pages.count, id: \.self) {
                                                                     Text(self.pages[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                 }
                                                             }.labelsHidden()
                                                             Button(
                                                                 action: {
                                                                     let addTasksToPage = toPage
                                                                     realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 2, andAddToPage: addTasksToPage)
                                                                     
                                                                     CountIMPTasks()
                                                                     if !isThereAnyIMPItem {
                                                                         resetEditModeValuesAndCountTasksFor(page: 2)
                                                                     }
                                                                 },
                                                                 label: {
                                                                     Text(" Move")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .help(Text("Move Marked Tasks"))
                                                             
                                                         } // MARK: – if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         
                                                     } // MARK: – if $isThereAnyIMPItem.wrappedValue {
                                                     
                                                     if $isThereMoreThanOneIMPItem.wrappedValue {
                                             // 5 ⚡️∙∙∙∙∙
                                                         if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Text(" ")
                                                             if $ShowRequirementOptions.wrappedValue {
                                                                 Text("show ")
                                                                     .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                 HStack (spacing: 3) {
                                                                     Button(
                                                                         action: {
                                                                             ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                                             ShowRequirementOptions = false
                                                                         },
                                                                         label: {
                                                                             HStack (spacing: 0) {
                                                                                 Text(" if ")
                                                                                     .foregroundColor(Color.RedTRASHAndRM)
                                                                                 Text("Name")
                                                                                     .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                             }
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                     //.buttonStyle(ClearImageBackground())
                                                                     
                                                                     /*Text("/")
                                                                                                                                             .font(.custom("Avenir", size: 17))
                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                         
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowShowBarForTaskNameIfTrueElseTaskDescription = false
                                                                                                                                                 ShowRequirementOptions = false
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("if ")
                                                                                                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                                                                                                     Text("Description")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                                                                                          */
                                                                     
                                                                 } // MARK: – för HStack (spacing: 3) {
                                                             } // MARK: – för if $SortRequirementOptions.wrappedValue {
                                                             if !($ShowRequirementOptions.wrappedValue) {
                                                                 /*
                                                                                                                                  if $ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue {
                                                                                                                                      if colorScheme == .dark {
                                                                                                                                          DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      } else {
                                                                                                                                          LightModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      }
                                                                                                                                  }
                                                                                                                                  if !($ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue) {
                                                                                                                                      if colorScheme == .dark {
                                                                                                                                          DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskDescription)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      } else {
                                                                                                                                          LightModeHStackEditorControllerView(text: $ShowCONTAINSTaskDescription)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      }
                                                                                                                                  }
                                                                                                                                  Button(
                                                                                                                                      action: {
                                                                                                                                          callCorrectRealmShowInShowMode(page: 2)
                                                                                                                                      },
                                                                                                                                      label: {
                                                                                                                                          Text("  Show")
                                                                                                                                              .foregroundColor(Color.BlueEdit)
                                                                                                                                              .bold()
                                                                                                                                              .font(.headline)
                                                                                                                                      }
                                                                                                                                  ).buttonStyle(ClearImageBackground())
                                                                                                                                 */
                                                             } // MARK: – för if !($ShowRequirementOptions.wrappedValue) {
                                                             
                                                         } // MARK: – för if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                             // 6 ⚡️∙∙∙∙∙
                                                         if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                             HStack (spacing: 3) {
                                                                 Text(" ")
                                                                 
                                                                 if $SortRequirementOptions.wrappedValue {
                                                                     Text("by ")
                                                                         .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                     HStack (spacing: 4) {
                                                                         Button(
                                                                             action: {
                                                                                 TasksIsSortedbyDateIfTrueElsePriority = true
                                                                                 SortRequirementOptions = false
                                                                             },
                                                                             label: {
                                                                                 HStack (spacing: 0) {
                                                                                     Text("Date")
                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                     Image(systemName: "alarm.fill")
                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                 }
                                                                             }
                                                                         ).buttonStyle(ClearImageBackground())
                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                         Text("/")
                                                                             .font(.custom("Avenir", size: 17))
                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                         Button(
                                                                             action: {
                                                                                 TasksIsSortedbyDateIfTrueElsePriority = false
                                                                                 SortRequirementOptions = false
                                                                             },
                                                                             label: {
                                                                                 HStack (spacing: 0) {
                                                                                     Text("Priority")
                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                     Image(systemName: "exclamationmark.triangle.fill")
                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                 }
                                                                             }
                                                                         ).buttonStyle(ClearImageBackground())
                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                     } //.frame(maxWidth: .infinity) // MARK: – för HStack (spacing: 2) {
                                                                 } // MARK: – för if $SortRequirementOptions.wrappedValue {
                                                                 if !($SortRequirementOptions.wrappedValue) {
                                                                     HStack (spacing: 4) {
                                                                         
                                                                         if $TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                                             Text("by date")
                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 2, true, true)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text(" inc")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                             Text("/")
                                                                                 .font(.custom("Avenir", size: 17))
                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 2, true, false)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text("dec")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.down.right.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                         } // MARK: – för if $TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                                         if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                                             Text("by priority")
                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 2, false, true)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text(" inc")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                             Text("/")
                                                                                 .font(.custom("Avenir", size: 17))
                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 2, false, false)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text("dec")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.down.right.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                         } // MARK: – för if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                                         
                                                                     } // MARK: – för HStack (spacing: 4) {
                                                                 } // MARK: – för if !($SortRequirementOptions.wrappedValue) {
                                                                 
                                                             } // MARK: – för HStack (spacing: 1) {
                                                         } // MARK: –  if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                         
                                                     } // MARK: – if $isThereMoreThanOneIMPItem.wrappedValue {
                                                     
                                                 }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $EditMode.wrappedValue {
                                             } // MARK: – if $EditMode.wrappedValue {
                                             
                                         } // MARK: – ZStack inside HStack
                                         
                                         ListPageName(2)
                                             .offset(CGSize(width: 18.00, height: 0.00))
                                     }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
                                     
 // MARK: –  PAGE 2 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                     Elevator {
                                         ForEach(realmManager.p2Tasks, id: \.id) { p2TaskItem in
                                             
                                             HStack (spacing: 3) {
                                                 
                                                 ZStack {
                                                     RoundedRectangle(cornerRadius: 10)
                                                         .foregroundColor(colorScheme == .dark ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                     HStack (spacing: 2) {
                                                         VStack {
                                                             Button(
                                                                 action: {
                                                                     CurrentItemID  = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                     TaskNameText  = p2TaskItem.taskNAME
                                                                     TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                                     TaskDate = p2TaskItem.taskDate
                                                                     let priority = p2TaskItem.taskPriority
                                                                     TaskPriority = priority
                                                                     pickedPriority = priority
                                                                     
                                                                     MDmode = false
                                                                     showListofTasksIfTrueElseTwoEditors(false)
                                                                     
                                                                     resetEditModeValuesAndCountTasksFor(page: 2)
                                                                     
                                                                     //currentPopoverPage = 2
                                                                 },
                                                                 label: {
                                                                     //Text(markdownThis(p2TaskItem.taskNAME))
                                                                     Text("  \(p2TaskItem.taskNAME)")
                                                                         .font(.custom("Avenir", size: 14))
                                                                         .lineLimit(1)
                                                                         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                         .foregroundColor(colorScheme == .dark ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                 }
                                                             ).buttonStyle(InvincibleNothingButton())
                                                              //.buttonStyle(PrimitiveBigTaskItemButton(p2TaskItem.id, p2TaskItem.taskPriority, isOnPage))
                                                             
                                                         }//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25, alignment: .center)
                                                     } // HStack (spacing: 2) {
                                                     Button(
                                                         action: {
                                                             CurrentItemID  = p2TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                             TaskNameText  = p2TaskItem.taskNAME
                                                             TaskDescriptionText = p2TaskItem.taskDESCRIPTION
                                                             TaskDate = p2TaskItem.taskDate
                                                             let priority = p2TaskItem.taskPriority
                                                             TaskPriority = priority
                                                             pickedPriority = priority
                                                             
                                                             MDmode = false
                                                             showListofTasksIfTrueElseTwoEditors(false)
                                                             
                                                             resetEditModeValuesAndCountTasksFor(page: 2)
                                                             
                                                             //currentPopoverPage = 2
                                                         },
                                                         label: {
                                                             VStack {
                                                                 Text("                                                                                ")
                                                                     .font(.custom("Avenir", size: 16))
                                                                     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                 /*Text("                                                                                ")
                                                                                                                                      .font(.custom("Avenir", size: 16))
                                                                                                                                      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                                                                                 */
                                                             }.frame(height: 30)
                                                         }
                                                     ).buttonStyle(InvincibleNothingButton())
                                                         .help(Text("\(p2TaskItem.taskNAME)"))
                                                 }.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                  .shadow(radius: 1)
                                                 
                                                 
                                                 
                                                 if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p2TaskItem.isCurrentlyMarked == false ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 2, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                    
                                                 } // if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                 if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p2TaskItem.isCurrentlyMarked == false ? realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: true) : realmManager.updateP2ItemisCurrentlyMarkedMarking(id: p2TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 2, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p2TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                     
                                                 } // if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                 
                                             }.padding(1)
                                         } // ForEach
                                     } // Elevator {
                                 } // Avslut för if VStack (spacing: 8) {
                                 
                                 Button(
                                     action: {
                                         show(pageItemList: 0)
                                         isOnPage = 0
                                         updateTodaysDate()
                                         currentPopoverPage = 0 // gå back so start page
                                         
                                         if !(ShowingAndSortedIfTrueElseShowing) {
                                             ShowSortRequirementAfterUnshow = true
                                             ShowFilterAndSortMode = false
                                             showBackButtonForSortinShowingAndSortedIfTrue = false
                                         }
                                         
                                         resetEditModeValuesAndCountTasksFor(page: 2)
                                         SetTheViewingStateOfAPageInRealm(forPage: 2)
                                     },
                                     label: {
                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                             .font(.system(size: 25))
                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                             .frame(width: 272, height: 9) // MARK: –  RedbackButton 🌈 styra storleken direkt med värden för Bilden
                                     }
                                 ).buttonStyle(RedBackButton())
                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 2, x: -1, y: -0.5)
                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown.opacity(0.5) : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1.5, y: 1)
                                                                     */
                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: 1.7, x: 1, y: 1)
                                  .shadow(color: colorScheme == .dark ? Color.neuPurp : Color.neuOrangeLighter2, radius: 2, x: -1, y: -0.5)
                                 
                             }.frame(width: 305, height: 495) // VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                         } // MARK: – Avslut för if !($ShowEditor.wrappedValue) {
                         
 // 💧📺 PAGE 2´s 2Editor Page💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                         if $ShowEditor.wrappedValue {
                             VStack (spacing: 8) { // väljer avståndet mellan  Group{Top Hstack + ZStack { Date, Priority)}  0ch  (Elevator + ForEach)} och Den .bottom HStacken som har SAVE och .md
                                 
                                 if !($MDmode.wrappedValue) {
                                     VStack (spacing: 0) { // bestämmer avståndet mellan allting som visas på TaskName och TaskDescription + Save Hstacken
                                         
                                         //VStack (spacing: 10) { // Håller ihop TaskNameEditor med Zstacken för Date och Priority
                                             VStack (spacing: 0) {
                                                 HStack {
                                                     HStack (spacing: 0) {
                                                         Text("Priority:  ")
                                                             .font(.custom("Avenir", size: 11))
                                                             .bold()
                                                         HStack {
                                                             Picker(selection: $pickedPriority, label: Text("")) {
                                                                 ForEach(0..<priorities.count, id: \.self) {
                                                                     Text(self.priorities[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }.labelsHidden()
                                                         }.frame(width: 60, height: 27)
                                                     }
                                                     Spacer()
                                                     HStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 //copyToPasteboard(TaskNameText.trimmingCharacters(in: .whitespacesAndNewlines))
                                                                 copyToPasteboard(TaskNameText)
                                                             },
                                                             label: {
                                                                 Image(systemName: "doc.on.doc.fill")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         Button(
                                                             action: {
                                                                 let pastedText = pasteFromPasteboard()
                                                                 TaskNameText = TaskNameText + pastedText
                                                             },
                                                             label: {
                                                                 Image(systemName: "text.badge.plus")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         if !($restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     restoreTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("reset")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         getTaskItemWithCurrentIDsTaskNameFor(page: isOnPage)
                                                                         
                                                                         self.restoreTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                         
                                                         Text("∙")
                                                         
                                                         if !($rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     rmTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("rm")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         TaskNameText = ""
                                                                         /*
                                                                                                                                                  // MARK: – så att när man trycker igen på reset så ska man kunna resetta tillbaka förra originella texten
                                                                                                                                                  realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                                                                                                                                  */
                                                                         self.rmTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                     }
                                                 }.offset(CGSize(width: 0, height: -5))
                                                 
                                                 if colorScheme == .dark {
                                                     DarkModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                                                     .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                                                                                                 */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 } else {
                                                     LightModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                                                   .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                                                                                                 */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 }
                                             } // VStack (spacing: 5) {
                                             
                                     }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 1/2💧 – för VStack Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                 } // MARK: – för if !($MDmode.wrappedValue) {
                                 if $MDmode.wrappedValue {
                                     VStack (spacing: 2) {
                                         ScrollView(.vertical) {
                                             VStack (spacing: 0) {
                                                 if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                     Text(TaskNameText)
                                                         .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                         .foregroundColor(.black)
                                                         .lineSpacing(MD_Mode_Text_Space)
                                                         //.fontWidth(Font.Width(MD_Mode_Text_Width))
                                                         //.tracking(MD_Mode_Text_Width)
                                                         .kerning(MD_Mode_Text_Width)
                                                         .frame(maxWidth: .infinity, alignment: .leading)
                                                 } else {
                                                     /*Text(MDname)
                                                                                                                 .font(.custom("Avenir", size: 13))
                                                                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                                                                         */
                                                     LazyVStack {
                                                         ForEach(0..<TaskNameSplitForMarkDownMode.count, id: \.self) { index in
                                                             Text(markdownThis(TaskNameSplitForMarkDownMode[index]))
                                                                 .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                                 .foregroundColor(.black)
                                                                 .lineSpacing(MD_Mode_Text_Space)
                                                                 .kerning(MD_Mode_Text_Width)
                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                             if index != TaskNameSplitForMarkDownMode.count - 1 {
                                                                 Text("                                                                                     ")
                                                             }
                                                         }
                                                     }
                                                 }
                                             }.padding(5)
                                         }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 2/2💧 – för ScrollView – Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                     }.background(colorScheme == .dark ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                      .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                      .shadow(radius: 4)
                                 } // för if $MDmode.wrappedValue {
                                 
 // 💧📺 PAGE 2´s 2Editor – Knapperna SAVE och .md💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                                 HStack (spacing: 8) {
                                     
                                     if !($MDmode.wrappedValue) {
                                         VStack (alignment: .leading) {
                                             HStack (spacing: 8) {
                                                 Button(
                                                     action: {
                                                         exit2EditorPageButtonAction()
                                                         //currentPopoverPage = 1
                                                     },
                                                     label: {
                                                         //Text(" Back")
                                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                                             .font(.system(size: 14))
                                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                             .frame(width: 85, height: 18) // MARK: –  miniRedbackButton 🌈 styra storleken direkt med värden för Bilden
                                                     }
                                                 ).buttonStyle(miniRedBackButton())
                                                  .offset(CGSize(width: -4, height: 1))
                                                  .help(Text("Save & Return"))
                                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 1, x: -0.6, y: -0.6)
                                                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1, y: 1)
                                                                                                     */
                                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.75), radius: 0.75, x: 0.9, y: 0.8)
                                                  .shadow(color: colorScheme == .dark ? Color.neuPurp.opacity(0.6) : Color.neuOrangeLighter2, radius: 1.5, x: -1.2, y: -1)
                                                 
                                                 Divider()
                                                     .frame(width: 2, height: 31, alignment: .bottom)
                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 
                                                 Button(
                                                     action: {
                                                         let priority = pickedPriority
                                                         
                                                         if isOnPage == 1 {
                                                             realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 2 {
                                                             realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 3 {
                                                             realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 4 {
                                                             realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         }
                                                     },
                                                     label: {
                                                         HStack (spacing: 0) {
                                                             //Text("Save -a")
                                                             Text("Save")
                                                                 .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                         }
                                                     }
                                                 ).buttonStyle(ClearImageBackground())
                                                  .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                 
                                                 Spacer()
                                             } // HStack (spacing: 0) {
                                     } // VStack (alignment: .leading) {
                                 }
                                     
                                     Button(
                                         action: {
                                             // 1 – ❗️
                                             //realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                             // 2
                                             let markdownName = TaskNameText
                                             let markdownDescription = TaskDescriptionText
                                             
                                             /* split returns a list of Substrings, so we have to map (convert) them to Strings. To do that you can just pass the Substring to the Strings init function */
                                             TaskNameSplitForMarkDownMode = markdownName.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             TaskDescriptionSplitForMarkDownMode = markdownDescription.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             /* ––– behövs ej då vi har fixat att markdown visar rätt baserad på \n char
                                                                                                 do {
                                                                                                     MDname = try AttributedString(markdown: markdownName)
                                                                                                     MDtext = try AttributedString(markdown: markdownDescription)
                                                                                                 } catch  {
                                                                                                     print("Error creating AttributedString:  \(error)")
                                                                                                 }
                                                                                         */
                                                                                                 
                                             /*
                                                                                              let taskNameWords = TaskNameText.split { $0 == " " || $0.isNewline }
                                                                                              wordCountTaskName = taskNameWords.count
                                                                                              
                                                                                              let taskDescriptionWords = TaskDescriptionText.split { $0 == " " || $0.isNewline }
                                                                                              wordCountTaskDescription = taskDescriptionWords.count
                                                                                          */
                                             
                                             // 3
                                             self.MDmode.toggle()
                                             // ––
                                             resetViewValuesFor2EditorPage()
                                         },
                                         label: {
                                             HStack (spacing: 0) {
                                                 Image(systemName: "paintbrush.fill")
                                                     .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                             }//.shadow(color: colorScheme == .dark ? Color.neuPurp: Color.neuOrange, radius: 2, x: 0, y: 0)
                                         }
                                     ).buttonStyle(ClearImageBackground2())
                                      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                     
                                     if $MDmode.wrappedValue {
                                         
                                         HStack (spacing: 7) {
                                             HStack (spacing: 2) {
                                                 
                                                 /*if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                                                                         HStack (spacing: 0) {
                                                                                                             Text(" Space ")
                                                                                                                 .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                             Stepper {
                                                                                                                 //Text("Size \(formatVal(MD_Mode_Text_Size))")
                                                                                                                 //Text(" Space\n \(formatVal3(MD_Mode_Text_Space))")
                                                                                                                 Text("Space")
                                                                                                                     .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                             } onIncrement: {
                                                                                                                 if MD_Mode_Text_Space < 10 {
                                                                                                                     self.MD_Mode_Text_Space += 0.1
                                                                                                                 }
                                                                                                             } onDecrement: {
                                                                                                                 if MD_Mode_Text_Space > 0.1 {
                                                                                                                     self.MD_Mode_Text_Space -= 0.1
                                                                                                                 }
                                                                                                             } onEditingChanged: {
                                                                                                                 print("\($0)")
                                                                                                             }.labelsHidden()
                                                                                                         }
                                                                                                         HStack (spacing: 0) {
                                                                                                             Text(" Width ")
                                                                                                                 .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                             Stepper(" Width", value: $MD_Mode_Text_Width, in: 0...1.7, step: 0.1, onEditingChanged: {
                                                                                                                 print("\($0)")
                                                                                                             }).labelsHidden()
                                                                                                         }//.padding(.horizontal, 1)
                                                                                                     }*/
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
                                             }.frame(width: 160, alignment: .trailing) // HStack
                                              .padding(.horizontal, 1)
                                             
                                             Divider()
                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 .frame(width: 2, height: 31, alignment: .bottom)
                                                 .padding(.horizontal, 1)
                                             
                                             txtORmd($txtifTrueElseMarkDownPreviewStyle)
                                         }.frame(width: 270, height: 17)
                                     }
                                     
                                 }.frame(width: 295, height: 17) // HStack (spacing: 0) {
                                 
                             }.frame(width: 305, height: 495, alignment: .center) // för VStack (spacing: 8) {
                              .padding(5)
                             
                         } // MARK: – Avslut för if $ShowEditor.wrappedValue {
                         
                     } // MARK: – för if $p2showPageIMPPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
                     
 // MARK: – PAGE 3 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎
                     
                     if $p3showPageURGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p2showPageIMPPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
                         
 // MARK: – List of Items in PAGE 3
                         if !($ShowEditor.wrappedValue) {
                             VStack (spacing: 10) { // MARK: – VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                                 VStack (spacing: 8) { // MARK: –  VStack som håller ihop Edit knappen och page name + Elevator
                                     
                                     // HStacken som innehåller alla edit och sort buttons
                                     HStack (spacing: 10) {
                                         ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                                             
 // MARK: – PAGE 3 🔅 if !($EditMode.wrappedValue) {
                                             if !($EditMode.wrappedValue) {
                                                 HStack {
                                                     
                                                     //.................
                                                     
                                                     if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                         
                                                         Button(
                                                             action: {
                                                                 CountURGTasks()
                                                                 EditMode = true
                                                                 
                                                                 AddMode = true
                                                                 MoveMode = false
                                                                 DeleteMode = false
                                                                 rmALLPageMode = false
                                                                 SortMode = false
                                                                 ShowMode = false
                                                             },
                                                             label: {
                                                                 Text(" Add")
                                                                     .foregroundColor(Color.BlueEdit)
                                                                     .bold()
                                                                     .font(.headline)
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                          .keyboardShortcut("a", modifiers: [.command])
                                                          //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                                          //.keyboardShortcut(.defaultAction)
                                                         
                                                         if $isThereAnyURGItem.wrappedValue {
                                                             Divider()
                                                                 .frame(width: 2, height: 32, alignment: .leading)
                                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                             Button(
                                                                 action: {
                                                                     CountURGTasks()
                                                                     EditMode = true
                                                                     
                                                                     AddMode = false
                                                                     MoveMode = false
                                                                     DeleteMode = false
                                                                     rmALLPageMode = false
                                                                     SortMode = false
                                                                     ShowMode = false
                                                                 },
                                                                 label: {
                                                                     Text("Edit")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                             if $isThereMoreThanOneURGItem.wrappedValue {
                                                                 Divider()
                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 //.overlay(.pink)
                                                                 Button(
                                                                     action: {
                                                                         ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                                                         ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                                                         ShowCONTAINSTaskName = ""
                                                                         ShowCONTAINSTaskDescription = ""
                                                                         
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = true
                                                                     },
                                                                     label: {
                                                                         Text("Show")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                                 Divider()
                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 Button(
                                                                     action: {
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = true
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text("Sort")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                             } // MARK: – för if $isThereMoreThanOneURGItem.wrappedValue {
                                                             
                                                         } // MARK: – för if $isThereAnyURGItem.wrappedValue {
                                                         
                                                     } // MARK: – if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                     
                                                     //.................
                                                     
                                                     if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                         
                                                         if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                             
                                                             if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                 Button(
                                                                     action: {
                                                                         Showing = false
                                                                         realmManager.updateP3() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                         
                                                                         resetEditModeValuesAndCountTasksFor(page: 3)
                                                                     },
                                                                     label: {
                                                                         Text(" Unshow")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                             }
                                                             /*if $isThereMoreThanOneURGItem.wrappedValue {
                                                                                                                         if !($ShowFilterAndSortMode.wrappedValue) {
                                                                                                                             
                                                                                                                             if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                                                                                 Divider()
                                                                                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                 Button(
                                                                                                                                     action: {
                                                                                                                                         ShowFilterAndSortMode = true
                                                                                                                                         showBackButtonForSortinShowingAndSortedIfTrue = true
                                                                                                                                         
                                                                                                                                         MoveMode = false
                                                                                                                                         showMoveAfterShowFilterAndSortMode = true
                                                                                                                                     },
                                                                                                                                     label: {
                                                                                                                                         Text("Sort")
                                                                                                                                             .foregroundColor(Color.BlueEdit)
                                                                                                                                             .bold()
                                                                                                                                             .font(.headline)
                                                                                                                                     }
                                                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                                                             } // MARK: – för if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                                                                             
                                                                                                                         } // MARK: – för if !($ShowFilterAndSortMode.wrappedValue) {
                                                                                                                         if $ShowFilterAndSortMode.wrappedValue {
                                                                                                                             
                                                                                                                             if $showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue {
                                                                                                                                 Button(
                                                                                                                                     action: {
                                                                                                                                         if ShowSortRequirementAfterUnshow {
                                                                                                                                             ShowFilterAndSortMode = false
                                                                                                                                         } else {
                                                                                                                                             ShowFilterAndSortMode = false
                                                                                                                                             ShowSortRequirementAfterUnshow = true
                                                                                                                                         }
                                                                                                                                         showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                     },
                                                                                                                                     label: {
                                                                                                                                         // Text(" Back")
                                                                                                                                         Text(" Done")
                                                                                                                                             .foregroundColor(Color.BlueEdit)
                                                                                                                                             .bold()
                                                                                                                                             .font(.headline)
                                                                                                                                     }
                                                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                                                                 
                                                                                                                                 Divider()
                                                                                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                 
                                                                                                                                 if $ShowSortRequirementAfterUnshow.wrappedValue {
                                                                                                                                     Text("by ")
                                                                                                                                         .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                     HStack (spacing: 4) {
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowSortRequirementAfterUnshow = false
                                                                                                                                                 ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("Date")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                     Image(systemName: "alarm.fill")
                                                                                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                         Text("/")
                                                                                                                                             .font(.custom("Avenir", size: 17))
                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowSortRequirementAfterUnshow = false
                                                                                                                                                 ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("Priority")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                     Image(systemName: "exclamationmark.triangle.fill")
                                                                                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                     } // MARK: – för HStack (spacing: 3) {
                                                                                                                                 } // MARK: – för if $ShowSortRequirementAfterUnshow.wrappedValue {
                                                                                                                                 if !($ShowSortRequirementAfterUnshow.wrappedValue) {
                                                                                                                                     HStack (spacing: 4) {
                                                                                                                                         
                                                                                                                                         if $ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue {
                                                                                                                                             Text("by date")
                                                                                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text(" inc")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                             Text("/")
                                                                                                                                                 .font(.custom("Avenir", size: 17))
                                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = false
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                     
                                                                                                                                                     //SetTheViewingStateOfAPageInRealm(forPage: 3)
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text("dec")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                         } // MARK: – för if $ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue {
                                                                                                                                         if !($ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue) {
                                                                                                                                             Text("by priority")
                                                                                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text(" inc")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                             Text("/")
                                                                                                                                                 .font(.custom("Avenir", size: 17))
                                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = false
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                     
                                                                                                                                                     //SetTheViewingStateOfAPageInRealm(forPage: 3)
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text("dec")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                         } // MARK: – för if !($ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue) {
                                                                                                                                         
                                                                                                                                     } // MARK: – för HStack (spacing: 4) {
                                                                                                                                 } // MARK: – för if !($ShowSortRequirementAfterUnshow.wrappedValue) {
                                                                                                                                 
                                                                                                                             } // MARK: – för if $showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue {
                                                                                                                             
                                                                                                                         } // MARK: – för if $ShowAndSortMode.wrappedValue {
                                                                                                                     } // MARK: – för if $isThereMoreThanOneURGItem.wrappedValue { */
                                                             
                                                         } // MARK: – för if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                         if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                             Button(
                                                                 action: {
                                                                     Showing = false
                                                                     ShowFilterAndSortMode = false
                                                                     ShowingAndSortedIfTrueElseShowing = false
                                                                     
                                                                     realmManager.updateP3() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                     resetEditModeValuesAndCountTasksFor(page: 3)
                                                                 },
                                                                 label: {
                                                                     Text(" reset")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         } // MARK: – för if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                         
                                                     } // MARK: – för if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                     
                                                     //.................
                                                     
                                                     if $Sorted.wrappedValue && !($Showing.wrappedValue) {
                                                         Button(
                                                             action: {
                                                                 Sorted = false
                                                                 realmManager.updateP3() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                 
                                                                 resetEditModeValuesAndCountTasksFor(page: 3)
                                                             },
                                                             label: {
                                                                 Text(" Unsort")
                                                                     .foregroundColor(Color.BlueEdit)
                                                                     .bold()
                                                                     .font(.headline)
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                     }
                                                     
                                                     //.................
                                                     
                                                     if $Showing.wrappedValue && $Sorted.wrappedValue {
                                                         Button(
                                                             action: {
                                                                 
                                                             },
                                                             label: {
                                                                 VStack {
                                                                     Text(" ❌A possible error related to the showing \n of EDIT/SORT/SHOW buttons has occured, \n please QUIT the app via right-click and open it again")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                         .font(.system(size: 9, weight: .ultraLight, design: .default))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                          .onAppear() {
                                                              Sorted = false
                                                              Showing = false
                                                          }
                                                     }
                                                     
                                                 }.frame(width: 230, alignment: .leading) // MARK: – HStack
                                             } // MARK: –  if !($EditMode.wrappedValue) {
 // MARK: – PAGE 3 ⚡️ if $EditMode.wrappedValue {
                                             if $EditMode.wrappedValue {
                                                 HStack (spacing: 2) {
                                                     
                                                     //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                                                     Button(
                                                         action: {
                                                             resetEditModeValuesAndCountTasksFor(page: 3)
                                                         },
                                                         label: {
                                                             Text(" Done  ")
                                                                 .foregroundColor(Color.BlueEdit)
                                                                 .bold()
                                                                 .font(.headline)
                                                                 .frame(alignment: .leading)
                                                         }
                                                     ).buttonStyle(ClearImageBackground())
                                                      .keyboardShortcut("d", modifiers: [.command])
                                                     Divider()
                                                         .frame(width: 2, height: 32, alignment: .leading)
                                                         .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                     //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                                                     
                                         // 1 ⚡️∙∙∙∙∙
                                                     if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         Text(" ")
                                                         HStack (spacing: 1) {
                                                             Button(
                                                                 action: {
                                                                     realmManager.addToP3()
                                                                     CountURGTasks()
                                                                 },
                                                                 label: {
                                                                     Image(systemName: "note.text.badge.plus")
                                                                         .renderingMode(.original)
                                                                         .font(.system(size: 18))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .shadow(radius: 0.8)
                                                            /*
                                                                                                                         //Text("・ ")
                                                                                                                         Text(" ⋮")
                                                                                                                             .font(.system(size: 18))
                                                                                                                             .offset(CGSize(width: 0, height: -1))
                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                         Text(" ")
                                                                                                                         VStack (spacing: 0) {
                                                                                                                             if colorScheme == .dark {
                                                                                                                                 DarkModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                                                                                                                                     .onNSView(
                                                                                                                                         added: { nsview in
                                                                                                                                             let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                             root.hasVerticalScroller = true
                                                                                                                                             root.hasHorizontalScroller = false
                                                                                                                                         }
                                                                                                                                     )
                                                                                                                                     .multilineTextAlignment(.leading)
                                                                                                                                     .frame(height: 18)
                                                                                                                                     .lineSpacing(2.8)
                                                                                                                                     .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                     .cornerRadius(9)
                                                                                                                                     .shadow(radius: 4)
                                                                                                                             } else {
                                                                                                                                 LightModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                                                                                                                                     .onNSView(
                                                                                                                                         added: { nsview in
                                                                                                                                             let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                             root.hasVerticalScroller = true
                                                                                                                                             root.hasHorizontalScroller = false
                                                                                                                                         }
                                                                                                                                     )
                                                                                                                                     .multilineTextAlignment(.leading)
                                                                                                                                     .frame(height: 18)
                                                                                                                                     .lineSpacing(2.8)
                                                                                                                                     .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                     .cornerRadius(9)
                                                                                                                                     .shadow(radius: 4)
                                                                                                                             }
                                                                                                                         }.frame(width: 100)
                                                                                                                         Button(
                                                                                                                             action: {
                                                                                                                                 substitoto = AddOneTaskWithTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                                                                                                                                 if !(substitoto.isEmpty) {
                                                                                                                                     realmManager.addOneTaskToP3WithTasName(text: substitoto)
                                                                                                                                 } else {
                                                                                                                                     dropEntered()
                                                                                                                                 }
                                                                                                                                 substitoto = ""
                                                                                                                                 AddOneTaskWithTaskName = ""
                                                                                                                             },
                                                                                                                             label: {
                                                                                                                                 Text(" Add")
                                                                                                                                     .foregroundColor(Color.BlueEdit)
                                                                                                                                     .bold()
                                                                                                                                     .font(.headline)
                                                                                                                             }
                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                          .keyboardShortcut("a", modifiers: [.command])
                                                                                                                          //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                                                                                                          //.keyboardShortcut(.defaultAction)
                                                                                                                         */
                                                         } // MARK: – för  HStack (spacing: 1) {
                                                     } // MARK: – if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) &&  !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                     
                                         // 2 ⚡️∙∙∙∙∙
                                                     if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         
                                                         Text(" ")
                                                         if $isThereAnyURGItem.wrappedValue {
                                                             HStack (spacing: 0) {
                                                                 Button(
                                                                     action: {
                                                                         CountURGTasks()
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = true
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text("Move  ")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                                 
                                                                 //Text("・")
                                                                 Text("⋮")
                                                                     .font(.system(size: 18))
                                                                     .offset(CGSize(width: 0, height: -1))
                                                                     .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 Text(" ")
                                                                 
                                                                 Button(
                                                                     action: {
                                                                         CountURGTasks()
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = true
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text(" Remove")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         } // MARK: – if $isThereAnyURGItem.wrappedValue {
                                                         
                                                     } // MARK: –  if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                     
                                                     if $isThereAnyURGItem.wrappedValue {
                                             // 3 ⚡️∙∙∙∙∙
                                                         if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Button(
                                                                 action: {
                                                                     realmManager.deleteAllP3ItemisCurrentlyMarkedMarking()
                                                                     CountURGTasks()
                                                                     if !isThereAnyURGItem {
                                                                         resetEditModeValuesAndCountTasksFor(page: 3)
                                                                     }
                                                                     
                                                                     if Sorted && !Showing {
                                                                         callCorrectRealmSortFor(page: 3, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                     } else if ShowingAndSortedIfTrueElseShowing {
                                                                         realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                     } else {
                                                                         if Showing && !Sorted {
                                                                             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                         }
                                                                     }
                                                                 },
                                                                 label: {
                                                                     Text("  Remove ")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .help(Text("Remove Marked Tasks"))
                                                             
                                                             //Text("・")
                                                             Text("⋮")
                                                                 .font(.system(size: 18))
                                                                 .offset(CGSize(width: 0, height: -1))
                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                             
                                                             if !($rmALLPageMode.wrappedValue) {
                                                                 Button(
                                                                     action: {
                                                                         rmALLPageMode = true
                                                                     },
                                                                     label: {
                                                                         Text(" rm -a")
                                                                             .foregroundColor(Color.RedTRASHAndRM)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                             if $rmALLPageMode.wrappedValue {
                                                                 HStack (spacing: 2) {
                                                                     Button(
                                                                         action: {
                                                                             realmManager.rmAllP3Tasks()
                                                                             CountURGTasks()
                                                                             
                                                                             EditMode = false
                                                                             rmALLPageMode = false
                                                                             DeleteMode = false
                                                                         },
                                                                         label: {
                                                                             Text("y")
                                                                                 .font(.custom("Avenir", size: 15))
                                                                                 .foregroundColor(Color.RedTRASHAndRM)
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                     Text(" or ")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                     Button(
                                                                         action: {
                                                                             self.rmALLPageMode.toggle()
                                                                         },
                                                                         label: {
                                                                             Text("n")
                                                                                 .font(.custom("Avenir", size: 15))
                                                                                 .foregroundColor(Color.BlueEdit)
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                 }
                                                             }
                                                         } // MARK: –  if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue)  {
                                             // 4 ⚡️∙∙∙∙∙
                                                         if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Text("  to :")
                                                                 .font(.custom("Avenir", size: 11))
                                                             Picker(selection: $toPage, label: Text("")) {
                                                                 ForEach(0..<pages.count, id: \.self) {
                                                                     Text(self.pages[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                 }
                                                             }.labelsHidden()
                                                             Button(
                                                                 action: {
                                                                     let addTasksToPage = toPage
                                                                     realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 3, andAddToPage: addTasksToPage)
                                                                     
                                                                     CountURGTasks()
                                                                     if !isThereAnyURGItem {
                                                                         resetEditModeValuesAndCountTasksFor(page: 3)
                                                                     }
                                                                 },
                                                                 label: {
                                                                     Text(" Move")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .help(Text("Move Marked Tasks"))
                                                             
                                                         } // MARK: – if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         
                                                     } // MARK: – if $isThereAnyURGItem.wrappedValue {
                                                     
                                                     if $isThereMoreThanOneURGItem.wrappedValue {
                                             // 5 ⚡️∙∙∙∙∙
                                                         if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Text(" ")
                                                             if $ShowRequirementOptions.wrappedValue {
                                                                 Text("show ")
                                                                     .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                 HStack (spacing: 3) {
                                                                     Button(
                                                                         action: {
                                                                             ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                                             ShowRequirementOptions = false
                                                                         },
                                                                         label: {
                                                                             HStack (spacing: 0) {
                                                                                 Text(" if ")
                                                                                     .foregroundColor(Color.RedTRASHAndRM)
                                                                                 Text("Name")
                                                                                     .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                             }
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                     //.buttonStyle(ClearImageBackground())
                                                                     
                                                                     /*Text("/")
                                                                                                                                             .font(.custom("Avenir", size: 17))
                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                         
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowShowBarForTaskNameIfTrueElseTaskDescription = false
                                                                                                                                                 ShowRequirementOptions = false
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("if ")
                                                                                                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                                                                                                     Text("Description")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                                                                                          */
                                                                 } // MARK: – för HStack (spacing: 3) {
                                                             } // MARK: – för if $SortRequirementOptions.wrappedValue {
                                                             if !($ShowRequirementOptions.wrappedValue) {
                                                                 /*
                                                                                                                                  if $ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue {
                                                                                                                                      if colorScheme == .dark {
                                                                                                                                          DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      } else {
                                                                                                                                          LightModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      }
                                                                                                                                  }
                                                                                                                                  if !($ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue) {
                                                                                                                                      if colorScheme == .dark {
                                                                                                                                          DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskDescription)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      } else {
                                                                                                                                          LightModeHStackEditorControllerView(text: $ShowCONTAINSTaskDescription)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      }
                                                                                                                                  }
                                                                                                                                  Button(
                                                                                                                                      action: {
                                                                                                                                          callCorrectRealmShowInShowMode(page: 3)
                                                                                                                                      },
                                                                                                                                      label: {
                                                                                                                                          Text("  Show")
                                                                                                                                              .foregroundColor(Color.BlueEdit)
                                                                                                                                              .bold()
                                                                                                                                              .font(.headline)
                                                                                                                                      }
                                                                                                                                  ).buttonStyle(ClearImageBackground())
                                                                                                                                 */
                                                             } // MARK: – för if !($ShowRequirementOptions.wrappedValue) {
                                                             
                                                         } // MARK: – för if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                             // 6 ⚡️∙∙∙∙∙
                                                         if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                             HStack (spacing: 3) {
                                                                 Text(" ")
                                                                 
                                                                 if $SortRequirementOptions.wrappedValue {
                                                                     Text("by ")
                                                                         .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                     HStack (spacing: 4) {
                                                                         Button(
                                                                             action: {
                                                                                 TasksIsSortedbyDateIfTrueElsePriority = true
                                                                                 SortRequirementOptions = false
                                                                             },
                                                                             label: {
                                                                                 HStack (spacing: 0) {
                                                                                     Text("Date")
                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                     Image(systemName: "alarm.fill")
                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                 }
                                                                             }
                                                                         ).buttonStyle(ClearImageBackground())
                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                         Text("/")
                                                                             .font(.custom("Avenir", size: 17))
                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                         Button(
                                                                             action: {
                                                                                 TasksIsSortedbyDateIfTrueElsePriority = false
                                                                                 SortRequirementOptions = false
                                                                             },
                                                                             label: {
                                                                                 HStack (spacing: 0) {
                                                                                     Text("Priority")
                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                     Image(systemName: "exclamationmark.triangle.fill")
                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                 }
                                                                             }
                                                                         ).buttonStyle(ClearImageBackground())
                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                     } //.frame(maxWidth: .infinity) // MARK: – för HStack (spacing: 2) {
                                                                 } // MARK: – för if $SortRequirementOptions.wrappedValue {
                                                                 if !($SortRequirementOptions.wrappedValue) {
                                                                     HStack (spacing: 4) {
                                                                         
                                                                         if $TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                                             Text("by date")
                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 3, true, true)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text(" inc")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                             Text("/")
                                                                                 .font(.custom("Avenir", size: 17))
                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 3, true, false)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text("dec")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.down.right.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                         } // MARK: – för if $TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                                         if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                                             Text("by priority")
                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 3, false, true)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text(" inc")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                             Text("/")
                                                                                 .font(.custom("Avenir", size: 17))
                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 3, false, false)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text("dec")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.down.right.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                         } // MARK: – för if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                                         
                                                                     } // MARK: – för HStack (spacing: 4) {
                                                                 } // MARK: – för if !($SortRequirementOptions.wrappedValue) {
                                                                 
                                                             } // MARK: – för HStack (spacing: 1) {
                                                         } // MARK: –  if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                         
                                                     } // MARK: – if $isThereMoreThanOneURGItem.wrappedValue {
                                                     
                                                 }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $EditMode.wrappedValue {
                                             } // MARK: – if $EditMode.wrappedValue {
                                             
                                         } // MARK: – ZStack inside HStack
                                         
                                         ListPageName(3)
                                             .offset(CGSize(width: 18.00, height: 0.00))
                                     }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {

 // MARK: –  PAGE 3 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                     Elevator {
                                         ForEach(realmManager.p3Tasks, id: \.id) { p3TaskItem in
                                             
                                             HStack (spacing: 3) {
                                                 
                                                 ZStack {
                                                     RoundedRectangle(cornerRadius: 10)
                                                         .foregroundColor(colorScheme == .dark ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                     HStack (spacing: 2) {
                                                         VStack {
                                                             Button(
                                                                 action: {
                                                                     CurrentItemID  = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                     TaskNameText  = p3TaskItem.taskNAME
                                                                     TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                                     TaskDate = p3TaskItem.taskDate
                                                                     let priority = p3TaskItem.taskPriority
                                                                     TaskPriority = priority
                                                                     pickedPriority = priority
                                                                     
                                                                     MDmode = false
                                                                     showListofTasksIfTrueElseTwoEditors(false)
                                                                     
                                                                     resetEditModeValuesAndCountTasksFor(page: 3)
                                                                     
                                                                     //currentPopoverPage = 2
                                                                 },
                                                                 label: {
                                                                     //Text(markdownThis(p3TaskItem.taskNAME))
                                                                     Text("  \(p3TaskItem.taskNAME)")
                                                                         .font(.custom("Avenir", size: 14))
                                                                         .lineLimit(1)
                                                                         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                         .foregroundColor(colorScheme == .dark ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                 }
                                                             ).buttonStyle(InvincibleNothingButton())
                                                              //.buttonStyle(PrimitiveBigTaskItemButton(p3TaskItem.id, p3TaskItem.taskPriority, isOnPage))
                                                             
                                                         }//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25, alignment: .center)
                                                     } // HStack (spacing: 2) {
                                                     Button(
                                                         action: {
                                                             CurrentItemID  = p3TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                             TaskNameText  = p3TaskItem.taskNAME
                                                             TaskDescriptionText = p3TaskItem.taskDESCRIPTION
                                                             TaskDate = p3TaskItem.taskDate
                                                             let priority = p3TaskItem.taskPriority
                                                             TaskPriority = priority
                                                             pickedPriority = priority
                                                             
                                                             MDmode = false
                                                             showListofTasksIfTrueElseTwoEditors(false)
                                                             
                                                             resetEditModeValuesAndCountTasksFor(page: 3)
                                                             
                                                             //currentPopoverPage = 2
                                                         },
                                                         label: {
                                                             VStack {
                                                                 Text("                                                                                ")
                                                                     .font(.custom("Avenir", size: 16))
                                                                     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                 /*Text("                                                                                ")
                                                                                                                                      .font(.custom("Avenir", size: 16))
                                                                                                                                      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                                                                                 */
                                                                 
                                                             }.frame(height: 30)
                                                         }
                                                     ).buttonStyle(InvincibleNothingButton())
                                                         .help(Text("\(p3TaskItem.taskNAME)"))
                                                 }.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                  .shadow(radius: 1)
                                                 
                                                 
                                                 
                                                 if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p3TaskItem.isCurrentlyMarked == false ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 3, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                    
                                                 } // if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                 if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p3TaskItem.isCurrentlyMarked == false ? realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: true) : realmManager.updateP3ItemisCurrentlyMarkedMarking(id: p3TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 3, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p3TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                     
                                                 } // if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                 
                                             }.padding(1)
                                         } // ForEach
                                     } // Elevator {
                                 } // Avslut för if VStack (spacing: 8) {
                                 
                                 Button(
                                     action: {
                                         show(pageItemList: 0)
                                         isOnPage = 0
                                         updateTodaysDate()
                                         currentPopoverPage = 0 // gå back so start page
                                         
                                         if !(ShowingAndSortedIfTrueElseShowing) {
                                             ShowSortRequirementAfterUnshow = true
                                             ShowFilterAndSortMode = false
                                             showBackButtonForSortinShowingAndSortedIfTrue = false
                                         }
                                         
                                         resetEditModeValuesAndCountTasksFor(page: 3)
                                         SetTheViewingStateOfAPageInRealm(forPage: 3)
                                     },
                                     label: {
                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                             .font(.system(size: 25))
                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                             .frame(width: 272, height: 9) // MARK: –  RedbackButton 🌈 styra storleken direkt med värden för Bilden
                                     }
                                 ).buttonStyle(RedBackButton())
                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 2, x: -1, y: -0.5)
                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown.opacity(0.5) : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1.5, y: 1)
                                                                     */
                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: 1.7, x: 1, y: 1)
                                  .shadow(color: colorScheme == .dark ? Color.neuPurp : Color.neuOrangeLighter2, radius: 2, x: -1, y: -0.5)
                                 
                             }.frame(width: 305, height: 495) // VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                         } // MARK: – Avslut för if !($ShowEditor.wrappedValue) {
                         
 // 💧📺 PAGE 3´s 2Editor Page💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                         if $ShowEditor.wrappedValue {
                             VStack (spacing: 8) { // väljer avståndet mellan  Group{Top Hstack + ZStack { Date, Priority)}  0ch  (Elevator + ForEach)} och Den .bottom HStacken som har SAVE och .md
                                 
                                 if !($MDmode.wrappedValue) {
                                     VStack (spacing: 0) { // bestämmer avståndet mellan allting som visas på TaskName och TaskDescription + Save Hstacken
                                         
                                         //VStack (spacing: 10) { // Håller ihop TaskNameEditor med Zstacken för Date och Priority
                                             VStack (spacing: 0) {
                                                 HStack {
                                                     HStack (spacing: 0) {
                                                         Text("Priority:  ")
                                                             .font(.custom("Avenir", size: 11))
                                                             .bold()
                                                         HStack {
                                                             Picker(selection: $pickedPriority, label: Text("")) {
                                                                 ForEach(0..<priorities.count, id: \.self) {
                                                                     Text(self.priorities[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }.labelsHidden()
                                                         }.frame(width: 60, height: 27)
                                                     }
                                                     Spacer()
                                                     HStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 //copyToPasteboard(TaskNameText.trimmingCharacters(in: .whitespacesAndNewlines))
                                                                 copyToPasteboard(TaskNameText)
                                                             },
                                                             label: {
                                                                 Image(systemName: "doc.on.doc.fill")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         Button(
                                                             action: {
                                                                 let pastedText = pasteFromPasteboard()
                                                                 TaskNameText = TaskNameText + pastedText
                                                             },
                                                             label: {
                                                                 Image(systemName: "text.badge.plus")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         if !($restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     restoreTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("reset")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         getTaskItemWithCurrentIDsTaskNameFor(page: isOnPage)
                                                                         
                                                                         self.restoreTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                         
                                                         Text("∙")
                                                         
                                                         if !($rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     rmTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("rm")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         TaskNameText = ""
                                                                         /*
                                                                                                                                                  // MARK: – så att när man trycker igen på reset så ska man kunna resetta tillbaka förra originella texten
                                                                                                                                                  realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                                                                                                                                  */
                                                                         self.rmTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                     }
                                                 }.offset(CGSize(width: 0, height: -5))
                                                 
                                                 if colorScheme == .dark {
                                                     DarkModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1) */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 } else {
                                                     LightModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1) */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 }
                                             } // VStack (spacing: 5) {
                                             
                                     }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 1/2💧 – för VStack Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                 } // MARK: – för if !($MDmode.wrappedValue) {
                                 if $MDmode.wrappedValue {
                                     VStack (spacing: 2) {
                                         ScrollView(.vertical) {
                                             VStack (spacing: 0) {
                                                 if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                     Text(TaskNameText)
                                                         .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                         .foregroundColor(.black)
                                                         .lineSpacing(MD_Mode_Text_Space)
                                                         //.fontWidth(Font.Width(MD_Mode_Text_Width))
                                                         //.tracking(MD_Mode_Text_Width)
                                                         .kerning(MD_Mode_Text_Width)
                                                         .frame(maxWidth: .infinity, alignment: .leading)
                                                 } else {
                                                     /*Text(MDname)
                                                                                                             .font(.custom("Avenir", size: 13))
                                                                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                                                                         */
                                                     LazyVStack {
                                                         ForEach(0..<TaskNameSplitForMarkDownMode.count, id: \.self) { index in
                                                             Text(markdownThis(TaskNameSplitForMarkDownMode[index]))
                                                                 .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                                 .foregroundColor(.black)
                                                                 .lineSpacing(MD_Mode_Text_Space)
                                                                 .kerning(MD_Mode_Text_Width)
                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                             if index != TaskNameSplitForMarkDownMode.count - 1 {
                                                                 Text("                                                                                     ")
                                                             }
                                                         }
                                                     }
                                                 }
                                             }.padding(5)
                                         }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 2/2💧 – för ScrollView – Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                     }.background(colorScheme == .dark ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                      .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                      .shadow(radius: 4)
                                 } // för if $MDmode.wrappedValue {
                                 
 // 💧📺 PAGE 3´s 2Editor – Knapperna SAVE och .md💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                                 HStack (spacing: 8) {
                                     
                                     if !($MDmode.wrappedValue) {
                                         VStack (alignment: .leading) {
                                             HStack (spacing: 8) {
                                                 Button(
                                                     action: {
                                                         exit2EditorPageButtonAction()
                                                         //currentPopoverPage = 1
                                                     },
                                                     label: {
                                                         //Text(" Back")
                                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                                             .font(.system(size: 14))
                                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                             .frame(width: 85, height: 18) // MARK: –  miniRedbackButton 🌈 styra storleken direkt med värden för Bilden
                                                     }
                                                 ).buttonStyle(miniRedBackButton())
                                                  .offset(CGSize(width: -4, height: 1))
                                                  .help(Text("Save & Return"))
                                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 1, x: -0.6, y: -0.6)
                                                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1, y: 1)
                                                                                                     */
                                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.75), radius: 0.75, x: 0.9, y: 0.8)
                                                  .shadow(color: colorScheme == .dark ? Color.neuPurp.opacity(0.6) : Color.neuOrangeLighter2, radius: 1.5, x: -1.2, y: -1)
                                                 
                                                 Divider()
                                                     .frame(width: 2, height: 31, alignment: .bottom)
                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 
                                                 Button(
                                                     action: {
                                                         let priority = pickedPriority
                                                         
                                                         if isOnPage == 1 {
                                                             realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 2 {
                                                             realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 3 {
                                                             realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 4 {
                                                             realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         }
                                                     },
                                                     label: {
                                                         HStack (spacing: 0) {
                                                             //Text("Save -a")
                                                             Text("Save")
                                                                 .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                         }
                                                     }
                                                 ).buttonStyle(ClearImageBackground())
                                                  .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                 Spacer()
                                             } // HStack (spacing: 0) {
                                         } // VStack (alignment: .leading) {
                                     }
                                     
                                     Button(
                                         action: {
                                             // 1 – ❗️
                                             //realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                             // 2
                                             let markdownName = TaskNameText
                                             let markdownDescription = TaskDescriptionText
                                             
                                             /* split returns a list of Substrings, so we have to map (convert) them to Strings. To do that you can just pass the Substring to the Strings init function */
                                             TaskNameSplitForMarkDownMode = markdownName.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             TaskDescriptionSplitForMarkDownMode = markdownDescription.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             /* ––– behövs ej då vi har fixat att markdown visar rätt baserad på \n char
                                                                                         do {
                                                                                             MDname = try AttributedString(markdown: markdownName)
                                                                                             MDtext = try AttributedString(markdown: markdownDescription)
                                                                                         } catch  {
                                                                                             print("Error creating AttributedString:  \(error)")
                                                                                         }
                                                                                         */
                                                                                         
                                             /*
                                                                                              let taskNameWords = TaskNameText.split { $0 == " " || $0.isNewline }
                                                                                              wordCountTaskName = taskNameWords.count
                                                                                              
                                                                                              let taskDescriptionWords = TaskDescriptionText.split { $0 == " " || $0.isNewline }
                                                                                              wordCountTaskDescription = taskDescriptionWords.count
                                                                                          */
                                             
                                             // 3
                                             self.MDmode.toggle()
                                             // ––
                                             resetViewValuesFor2EditorPage()
                                         },
                                         label: {
                                             HStack (spacing: 0) {
                                                 Image(systemName: "paintbrush.fill")
                                                     .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                             }//.shadow(color: colorScheme == .dark ? Color.neuPurp: Color.neuOrange, radius: 2, x: 0, y: 0)
                                         }
                                     ).buttonStyle(ClearImageBackground2())
                                      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                     
                                     if $MDmode.wrappedValue {
                                         
                                         HStack (spacing: 7) {
                                             HStack (spacing: 2) {
                                                 
                                                 /*if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                                                                     HStack (spacing: 0) {
                                                                                                         Text(" Space ")
                                                                                                             .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                         Stepper {
                                                                                                             //Text("Size \(formatVal(MD_Mode_Text_Size))")
                                                                                                             //Text(" Space\n \(formatVal3(MD_Mode_Text_Space))")
                                                                                                             Text("Space")
                                                                                                                 .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                         } onIncrement: {
                                                                                                             if MD_Mode_Text_Space < 10 {
                                                                                                                 self.MD_Mode_Text_Space += 0.1
                                                                                                             }
                                                                                                         } onDecrement: {
                                                                                                             if MD_Mode_Text_Space > 0.1 {
                                                                                                                 self.MD_Mode_Text_Space -= 0.1
                                                                                                             }
                                                                                                         } onEditingChanged: {
                                                                                                             print("\($0)")
                                                                                                         }.labelsHidden()
                                                                                                     }
                                                                                                     HStack (spacing: 0) {
                                                                                                         Text(" Width ")
                                                                                                             .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                         Stepper(" Width", value: $MD_Mode_Text_Width, in: 0...1.7, step: 0.1, onEditingChanged: {
                                                                                                             print("\($0)")
                                                                                                         }).labelsHidden()
                                                                                                     }//.padding(.horizontal, 1)
                                                                                                 }*/
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
                                             }.frame(width: 160, alignment: .trailing) // HStack
                                              .padding(.horizontal, 1)
                                             
                                             Divider()
                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 .frame(width: 2, height: 31, alignment: .bottom)
                                                 .padding(.horizontal, 1)
                                             
                                             txtORmd($txtifTrueElseMarkDownPreviewStyle)
                                         }.frame(width: 270, height: 17)
                                     }
                                     
                                 }.frame(width: 295, height: 17) // HStack (spacing: 0) {
                                 
                             }.frame(width: 305, height: 495, alignment: .center) // för VStack (spacing: 8) {
                              .padding(5)
                             
                         } // MARK: – Avslut för if $ShowEditor.wrappedValue {
                         
                     } // MARK: – för if $p3showPageURGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p2showPageIMPPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
                     
 // MARK: –  PAGE 4 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎
                     
                     if $p4showPageNOTHINGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) {
                         
 // MARK: – List of Items in PAGE 4
                         if !($ShowEditor.wrappedValue) {
                             VStack (spacing: 10) { // MARK: – VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                                 VStack (spacing: 8) { // MARK: –  VStack som håller ihop Edit knappen och page name + Elevator
                                     
                                     
                                     // HStacken som innehåller alla edit och sort buttons
                                     HStack (spacing: 10) {
                                         ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                                             
 // MARK: – PAGE 4 🔅 if !($EditMode.wrappedValue) {
                                             if !($EditMode.wrappedValue) {
                                                 HStack {
                                                     
                                                     //.................
                                                     
                                                     if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                         
                                                         Button(
                                                             action: {
                                                                 CountNOTHINGTasks()
                                                                 EditMode = true
                                                                 
                                                                 AddMode = true
                                                                 MoveMode = false
                                                                 DeleteMode = false
                                                                 rmALLPageMode = false
                                                                 SortMode = false
                                                                 ShowMode = false
                                                             },
                                                             label: {
                                                                 Text(" Add")
                                                                     .foregroundColor(Color.BlueEdit)
                                                                     .bold()
                                                                     .font(.headline)
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                          .keyboardShortcut("a", modifiers: [.command])
                                                          //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                                          //.keyboardShortcut(.defaultAction)
                                                         
                                                         if $isThereAnyNOTHINGItem.wrappedValue {
                                                             Divider()
                                                                 .frame(width: 2, height: 32, alignment: .leading)
                                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                             Button(
                                                                 action: {
                                                                     CountNOTHINGTasks()
                                                                     EditMode = true
                                                                     
                                                                     AddMode = false
                                                                     MoveMode = false
                                                                     DeleteMode = false
                                                                     rmALLPageMode = false
                                                                     SortMode = false
                                                                     ShowMode = false
                                                                 },
                                                                 label: {
                                                                     Text("Edit")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                             if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                                                                 Divider()
                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 //.overlay(.pink)
                                                                 Button(
                                                                     action: {
                                                                         ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                                                         ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                                                         ShowCONTAINSTaskName = ""
                                                                         ShowCONTAINSTaskDescription = ""
                                                                         
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = true
                                                                     },
                                                                     label: {
                                                                         Text("Show")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                                 Divider()
                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 Button(
                                                                     action: {
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = true
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text("Sort")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                             } // MARK: – för if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                                                             
                                                         } // MARK: – för if $isThereAnyNOTHINGItem.wrappedValue {
                                                         
                                                     } // MARK: – if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                     
                                                     //.................
                                                     
                                                     if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                         
                                                         if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                             
                                                             if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                 Button(
                                                                     action: {
                                                                         Showing = false
                                                                         realmManager.updateP4() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                         
                                                                         resetEditModeValuesAndCountTasksFor(page: 4)
                                                                     },
                                                                     label: {
                                                                         Text(" Unshow")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground2())
                                                             }
                                                             /*if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                                                                                                                         if !($ShowFilterAndSortMode.wrappedValue) {
                                                                                                                             
                                                                                                                             if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                                                                                 Divider()
                                                                                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                 Button(
                                                                                                                                     action: {
                                                                                                                                         ShowFilterAndSortMode = true
                                                                                                                                         showBackButtonForSortinShowingAndSortedIfTrue = true
                                                                                                                                         
                                                                                                                                         MoveMode = false
                                                                                                                                         showMoveAfterShowFilterAndSortMode = true
                                                                                                                                     },
                                                                                                                                     label: {
                                                                                                                                         Text("Sort")
                                                                                                                                             .foregroundColor(Color.BlueEdit)
                                                                                                                                             .bold()
                                                                                                                                             .font(.headline)
                                                                                                                                     }
                                                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                                                             } // MARK: – för if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                                                                             
                                                                                                                         } // MARK: – för if !($ShowFilterAndSortMode.wrappedValue) {
                                                                                                                         if $ShowFilterAndSortMode.wrappedValue {
                                                                                                                             
                                                                                                                             if $showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue {
                                                                                                                                 Button(
                                                                                                                                     action: {
                                                                                                                                         if ShowSortRequirementAfterUnshow {
                                                                                                                                             ShowFilterAndSortMode = false
                                                                                                                                         } else {
                                                                                                                                             ShowFilterAndSortMode = false
                                                                                                                                             ShowSortRequirementAfterUnshow = true
                                                                                                                                         }
                                                                                                                                         showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                     },
                                                                                                                                     label: {
                                                                                                                                         // Text(" Back")
                                                                                                                                         Text(" Done")
                                                                                                                                             .foregroundColor(Color.BlueEdit)
                                                                                                                                             .bold()
                                                                                                                                             .font(.headline)
                                                                                                                                     }
                                                                                                                                 ).buttonStyle(ClearImageBackground2())
                                                                                                                                 
                                                                                                                                 Divider()
                                                                                                                                     .frame(width: 2, height: 32, alignment: .leading)
                                                                                                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                 
                                                                                                                                 if $ShowSortRequirementAfterUnshow.wrappedValue {
                                                                                                                                     Text("by ")
                                                                                                                                         .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                     HStack (spacing: 4) {
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowSortRequirementAfterUnshow = false
                                                                                                                                                 ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("Date")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                     Image(systemName: "alarm.fill")
                                                                                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                         Text("/")
                                                                                                                                             .font(.custom("Avenir", size: 17))
                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowSortRequirementAfterUnshow = false
                                                                                                                                                 ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("Priority")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                     Image(systemName: "exclamationmark.triangle.fill")
                                                                                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                     } // MARK: – för HStack (spacing: 3) {
                                                                                                                                 } // MARK: – för if $ShowSortRequirementAfterUnshow.wrappedValue {
                                                                                                                                 if !($ShowSortRequirementAfterUnshow.wrappedValue) {
                                                                                                                                     HStack (spacing: 4) {
                                                                                                                                         
                                                                                                                                         if $ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue {
                                                                                                                                             Text("by date")
                                                                                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text(" inc")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                             Text("/")
                                                                                                                                                 .font(.custom("Avenir", size: 17))
                                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = false
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                     
                                                                                                                                                     //SetTheViewingStateOfAPageInRealm(forPage: 4)
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text("dec")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                         } // MARK: – för if $ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue {
                                                                                                                                         if !($ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue) {
                                                                                                                                             Text("by priority")
                                                                                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text(" inc")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                             Text("/")
                                                                                                                                                 .font(.custom("Avenir", size: 17))
                                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                             Button(
                                                                                                                                                 action: {
                                                                                                                                                     ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = false
                                                                                                                                                     
                                                                                                                                                     ShowSortRequirementAfterUnshow = true
                                                                                                                                                     showBackButtonForSortinShowingAndSortedIfTrue = false
                                                                                                                                                     
                                                                                                                                                     realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                                                                                                     ShowingAndSortedIfTrueElseShowing = true
                                                                                                                                                     
                                                                                                                                                     //SetTheViewingStateOfAPageInRealm(forPage: 4)
                                                                                                                                                 },
                                                                                                                                                 label: {
                                                                                                                                                     HStack (spacing: 0) {
                                                                                                                                                         Text("dec")
                                                                                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                                                                                     }
                                                                                                                                                 }
                                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                                         } // MARK: – för if !($ShowSortByDateAfterUnshowButtonIfTrueElsePriority.wrappedValue) {
                                                                                                                                         
                                                                                                                                     } // MARK: – för HStack (spacing: 4) {
                                                                                                                                 } // MARK: – för if !($ShowSortRequirementAfterUnshow.wrappedValue) {
                                                                                                                                 
                                                                                                                             } // MARK: – för if $showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue {
                                                                                                                             
                                                                                                                         } // MARK: – för if $ShowAndSortMode.wrappedValue {
                                                                                                                     } // MARK: – för if $isThereMoreThanOneNOTHINGItem.wrappedValue { */
                                                             
                                                         } // MARK: – för if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                         if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                             Button(
                                                                 action: {
                                                                     Showing = false
                                                                     ShowFilterAndSortMode = false
                                                                     ShowingAndSortedIfTrueElseShowing = false
                                                                     
                                                                     realmManager.updateP4() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                     resetEditModeValuesAndCountTasksFor(page: 4)
                                                                 },
                                                                 label: {
                                                                     Text(" reset")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         } // MARK: – för if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                         
                                                     } // MARK: – för if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                     
                                                     //.................
                                                     
                                                     if $Sorted.wrappedValue && !($Showing.wrappedValue) {
                                                         Button(
                                                             action: {
                                                                 Sorted = false
                                                                 realmManager.updateP4() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                                 
                                                                 resetEditModeValuesAndCountTasksFor(page: 4)
                                                             },
                                                             label: {
                                                                 Text(" Unsort")
                                                                     .foregroundColor(Color.BlueEdit)
                                                                     .bold()
                                                                     .font(.headline)
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                     }
                                                     
                                                     //.................
                                                     
                                                     if $Showing.wrappedValue && $Sorted.wrappedValue {
                                                         Button(
                                                             action: {
                                                                 
                                                             },
                                                             label: {
                                                                 VStack {
                                                                     Text(" ❌A possible error related to the showing \n of EDIT/SORT/SHOW buttons has occured, \n please QUIT the app via right-click and open it again")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                         .font(.system(size: 9, weight: .ultraLight, design: .default))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }
                                                         ).buttonStyle(ClearImageBackground2())
                                                          .onAppear() {
                                                              Sorted = false
                                                              Showing = false
                                                          }
                                                     }
                                                     
                                                 }.frame(width: 230, alignment: .leading) // MARK: – HStack
                                             } // MARK: –  if !($EditMode.wrappedValue) {
 // MARK: – PAGE 4 ⚡️ if $EditMode.wrappedValue {
                                             if $EditMode.wrappedValue {
                                                 HStack (spacing: 2) {
                                                     
                                                     //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                                                     Button(
                                                         action: {
                                                             resetEditModeValuesAndCountTasksFor(page: 4)
                                                         },
                                                         label: {
                                                             Text(" Done  ")
                                                                 .foregroundColor(Color.BlueEdit)
                                                                 .bold()
                                                                 .font(.headline)
                                                                 .frame(alignment: .leading)
                                                         }
                                                     ).buttonStyle(ClearImageBackground())
                                                      .keyboardShortcut("d", modifiers: [.command])
                                                     Divider()
                                                         .frame(width: 2, height: 32, alignment: .leading)
                                                         .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                     //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                                                     
                                         // 1 ⚡️∙∙∙∙∙
                                                     if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         Text(" ")
                                                         HStack (spacing: 1) {
                                                             Button(
                                                                 action: {
                                                                     realmManager.addToP4()
                                                                     CountNOTHINGTasks()
                                                                     
                                                                     // self.p6EditMode.toggle() MARK: – 🩸 hur man fixar en toggle binding action till en @State bool var
                                                                 },
                                                                 label: {
                                                                     Image(systemName: "note.text.badge.plus")
                                                                         .renderingMode(.original)
                                                                         .font(.system(size: 18))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .shadow(radius: 0.8)
                                                            /*
                                                                                                                             //Text("・ ")
                                                                                                                             Text(" ⋮")
                                                                                                                                 .font(.system(size: 18))
                                                                                                                                 .offset(CGSize(width: 0, height: -1))
                                                                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                             Text(" ")
                                                                                                                             VStack (spacing: 0) {
                                                                                                                                 if colorScheme == .dark {
                                                                                                                                     DarkModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                                                                                                                                         .onNSView(
                                                                                                                                             added: { nsview in
                                                                                                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                 root.hasVerticalScroller = true
                                                                                                                                                 root.hasHorizontalScroller = false
                                                                                                                                             }
                                                                                                                                         )
                                                                                                                                         .multilineTextAlignment(.leading)
                                                                                                                                         .frame(height: 18)
                                                                                                                                         .lineSpacing(2.8)
                                                                                                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                         .cornerRadius(9)
                                                                                                                                         .shadow(radius: 4)
                                                                                                                                 } else {
                                                                                                                                     LightModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                                                                                                                                         .onNSView(
                                                                                                                                             added: { nsview in
                                                                                                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                 root.hasVerticalScroller = true
                                                                                                                                                 root.hasHorizontalScroller = false
                                                                                                                                             }
                                                                                                                                         )
                                                                                                                                         .multilineTextAlignment(.leading)
                                                                                                                                         .frame(height: 18)
                                                                                                                                         .lineSpacing(2.8)
                                                                                                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                         .cornerRadius(9)
                                                                                                                                         .shadow(radius: 4)
                                                                                                                                 }
                                                                                                                             }.frame(width: 100)
                                                                                                                             Button(
                                                                                                                                 action: {
                                                                                                                                     substitoto = AddOneTaskWithTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                                                                                                                                     if !(substitoto.isEmpty) {
                                                                                                                                         realmManager.addOneTaskToP4WithTasName(text: substitoto)
                                                                                                                                     } else {
                                                                                                                                         dropEntered()
                                                                                                                                     }
                                                                                                                                     substitoto = ""
                                                                                                                                     AddOneTaskWithTaskName = ""
                                                                                                                                 },
                                                                                                                                 label: {
                                                                                                                                     Text(" Add")
                                                                                                                                         .foregroundColor(Color.BlueEdit)
                                                                                                                                         .bold()
                                                                                                                                         .font(.headline)
                                                                                                                                 }
                                                                                                                             ).buttonStyle(ClearImageBackground())
                                                                                                                              .keyboardShortcut("a", modifiers: [.command])
                                                                                                                              //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                                                                                                              //.keyboardShortcut(.defaultAction)
                                                                                                                         */
                                                         } // MARK: – för  HStack (spacing: 1) {
                                                     } // MARK: – if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) &&  !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                     
                                         // 2 ⚡️∙∙∙∙∙
                                                     if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         
                                                         Text(" ")
                                                         if $isThereAnyNOTHINGItem.wrappedValue {
                                                             HStack (spacing: 0) {
                                                                 Button(
                                                                     action: {
                                                                         CountNOTHINGTasks()
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = true
                                                                         DeleteMode = false
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text("Move  ")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                                 
                                                                 //Text("・")
                                                                 Text("⋮")
                                                                     .font(.system(size: 18))
                                                                     .offset(CGSize(width: 0, height: -1))
                                                                     .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                 Text(" ")
                                                                 
                                                                 Button(
                                                                     action: {
                                                                         CountNOTHINGTasks()
                                                                         EditMode = true
                                                                         
                                                                         AddMode = false
                                                                         MoveMode = false
                                                                         DeleteMode = true
                                                                         rmALLPageMode = false
                                                                         SortMode = false
                                                                         ShowMode = false
                                                                     },
                                                                     label: {
                                                                         Text(" Remove")
                                                                             .foregroundColor(Color.BlueEdit)
                                                                             .bold()
                                                                             .font(.headline)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         } // MARK: – if $isThereAnyNOTHINGItem.wrappedValue {
                                                         
                                                     } // MARK: –  if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                     
                                                     if $isThereAnyNOTHINGItem.wrappedValue {
                                             // 3 ⚡️∙∙∙∙∙
                                                         if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Button(
                                                                 action: {
                                                                     realmManager.deleteAllP4ItemisCurrentlyMarkedMarking()
                                                                     CountNOTHINGTasks()
                                                                     if !isThereAnyNOTHINGItem {
                                                                         resetEditModeValuesAndCountTasksFor(page: 4)
                                                                     }
                                                                     
                                                                     if Sorted && !Showing {
                                                                         callCorrectRealmSortFor(page: 4, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                     } else if ShowingAndSortedIfTrueElseShowing {
                                                                         realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                     } else {
                                                                         if Showing && !Sorted {
                                                                             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                         }
                                                                     }
                                                                 },
                                                                 label: {
                                                                     Text("  Remove ")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .help(Text("Remove Marked Tasks"))
                                                             
                                                             //Text("・")
                                                             Text("⋮")
                                                                 .font(.system(size: 18))
                                                                 .offset(CGSize(width: 0, height: -1))
                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                             
                                                             if !($rmALLPageMode.wrappedValue) {
                                                                 Button(
                                                                     action: {
                                                                         rmALLPageMode = true
                                                                     },
                                                                     label: {
                                                                         Text(" rm -a")
                                                                             .foregroundColor(Color.RedTRASHAndRM)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                             if $rmALLPageMode.wrappedValue {
                                                                 HStack (spacing: 2) {
                                                                     Button(
                                                                         action: {
                                                                             realmManager.rmAllP4Tasks()
                                                                             CountNOTHINGTasks()
                                                                             
                                                                             EditMode = false
                                                                             rmALLPageMode = false
                                                                             DeleteMode = false
                                                                         },
                                                                         label: {
                                                                             Text("y")
                                                                                 .font(.custom("Avenir", size: 15))
                                                                                 .foregroundColor(Color.RedTRASHAndRM)
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                     Text(" or ")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                     Button(
                                                                         action: {
                                                                             self.rmALLPageMode.toggle()
                                                                         },
                                                                         label: {
                                                                             Text("n")
                                                                                 .font(.custom("Avenir", size: 15))
                                                                                 .foregroundColor(Color.BlueEdit)
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                 }
                                                             }
                                                         } // MARK: –  if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue)  {
                                             // 4 ⚡️∙∙∙∙∙
                                                         if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Text("  to :")
                                                                 .font(.custom("Avenir", size: 11))
                                                             Picker(selection: $toPage, label: Text("")) {
                                                                 ForEach(0..<pages.count, id: \.self) {
                                                                     Text(self.pages[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                 }
                                                             }.labelsHidden()
                                                             Button(
                                                                 action: {
                                                                     let addTasksToPage = toPage
                                                                     realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 4, andAddToPage: addTasksToPage)
                                                                     
                                                                     CountNOTHINGTasks()
                                                                     if !isThereAnyNOTHINGItem {
                                                                         resetEditModeValuesAndCountTasksFor(page: 4)
                                                                     }
                                                                 },
                                                                 label: {
                                                                     Text(" Move")
                                                                         .foregroundColor(Color.BlueEdit)
                                                                         .bold()
                                                                         .font(.headline)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground())
                                                              .help(Text("Move Marked Tasks"))
                                                             
                                                         } // MARK: – if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                         
                                                     } // MARK: – if $isThereAnyNOTHINGItem.wrappedValue {
                                                     
                                                     if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                                             // 5 ⚡️∙∙∙∙∙
                                                         if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                             
                                                             Text(" ")
                                                             if $ShowRequirementOptions.wrappedValue {
                                                                 Text("show ")
                                                                     .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                 HStack (spacing: 3) {
                                                                     Button(
                                                                         action: {
                                                                             ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                                             ShowRequirementOptions = false
                                                                         },
                                                                         label: {
                                                                             HStack (spacing: 0) {
                                                                                 Text(" if ")
                                                                                     .foregroundColor(Color.RedTRASHAndRM)
                                                                                 Text("Name")
                                                                                     .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                             }
                                                                         }
                                                                     ).buttonStyle(ClearImageBackground())
                                                                     //.buttonStyle(ClearImageBackground())
                                                                     
                                                                     /*Text("/")
                                                                                                                                             .font(.custom("Avenir", size: 17))
                                                                                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                                                                                         
                                                                                                                                         Button(
                                                                                                                                             action: {
                                                                                                                                                 ShowShowBarForTaskNameIfTrueElseTaskDescription = false
                                                                                                                                                 ShowRequirementOptions = false
                                                                                                                                             },
                                                                                                                                             label: {
                                                                                                                                                 HStack (spacing: 0) {
                                                                                                                                                     Text("if ")
                                                                                                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                                                                                                     Text("Description")
                                                                                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                                                                                 }
                                                                                                                                             }
                                                                                                                                         ).buttonStyle(ClearImageBackground())
                                                                                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                                                                                          */
                                                                 } // MARK: – för HStack (spacing: 3) {
                                                             } // MARK: – för if $SortRequirementOptions.wrappedValue {
                                                             if !($ShowRequirementOptions.wrappedValue) {
                                                                 /*
                                                                                                                                  if $ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue {
                                                                                                                                      if colorScheme == .dark {
                                                                                                                                          DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      } else {
                                                                                                                                          LightModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      }
                                                                                                                                  }
                                                                                                                                  if !($ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue) {
                                                                                                                                      if colorScheme == .dark {
                                                                                                                                          DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskDescription)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      } else {
                                                                                                                                          LightModeHStackEditorControllerView(text: $ShowCONTAINSTaskDescription)
                                                                                                                                              .onNSView(
                                                                                                                                                  added: { nsview in
                                                                                                                                                      let root = nsview.subviews[0] as! NSScrollView
                                                                                                                                                      root.hasVerticalScroller = true
                                                                                                                                                      root.hasHorizontalScroller = false
                                                                                                                                                  }
                                                                                                                                              )
                                                                                                                                              .multilineTextAlignment(.leading)
                                                                                                                                              .frame(height: 18)
                                                                                                                                              .lineSpacing(2.8)
                                                                                                                                              .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                                                                                                              .cornerRadius(9)
                                                                                                                                              .shadow(radius: 4)
                                                                                                                                      }
                                                                                                                                  }
                                                                                                                                  Button(
                                                                                                                                      action: {
                                                                                                                                          callCorrectRealmShowInShowMode(page: 4)
                                                                                                                                      },
                                                                                                                                      label: {
                                                                                                                                          Text("  Show")
                                                                                                                                              .foregroundColor(Color.BlueEdit)
                                                                                                                                              .bold()
                                                                                                                                              .font(.headline)
                                                                                                                                      }
                                                                                                                                  ).buttonStyle(ClearImageBackground())
                                                                                                                                 */
                                                             } // MARK: – för if !($ShowRequirementOptions.wrappedValue) {
                                                             
                                                         } // MARK: – för if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                             // 6 ⚡️∙∙∙∙∙
                                                         if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                             HStack (spacing: 3) {
                                                                 Text(" ")
                                                                 
                                                                 if $SortRequirementOptions.wrappedValue {
                                                                     Text("by ")
                                                                         .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                     HStack (spacing: 4) {
                                                                         Button(
                                                                             action: {
                                                                                 TasksIsSortedbyDateIfTrueElsePriority = true
                                                                                 SortRequirementOptions = false
                                                                             },
                                                                             label: {
                                                                                 HStack (spacing: 0) {
                                                                                     Text("Date")
                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                     Image(systemName: "alarm.fill")
                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                 }
                                                                             }
                                                                         ).buttonStyle(ClearImageBackground())
                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                         Text("/")
                                                                             .font(.custom("Avenir", size: 17))
                                                                             .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                         Button(
                                                                             action: {
                                                                                 TasksIsSortedbyDateIfTrueElsePriority = false
                                                                                 SortRequirementOptions = false
                                                                             },
                                                                             label: {
                                                                                 HStack (spacing: 0) {
                                                                                     Text("Priority")
                                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                     Image(systemName: "exclamationmark.triangle.fill")
                                                                                         .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                 }
                                                                             }
                                                                         ).buttonStyle(ClearImageBackground())
                                                                         //.buttonStyle(TopHStackShowSortOptions())
                                                                     } //.frame(maxWidth: .infinity) // MARK: – för HStack (spacing: 2) {
                                                                 } // MARK: – för if $SortRequirementOptions.wrappedValue {
                                                                 if !($SortRequirementOptions.wrappedValue) {
                                                                     HStack (spacing: 4) {
                                                                         
                                                                         if $TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                                             Text("by date")
                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 4, true, true)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text(" inc")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                             Text("/")
                                                                                 .font(.custom("Avenir", size: 17))
                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 4, true, false)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text("dec")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.down.right.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                         } // MARK: – för if $TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                                         if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                                             Text("by priority")
                                                                                 .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 4, false, true)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text(" inc")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.up.forward.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                             Text("/")
                                                                                 .font(.custom("Avenir", size: 17))
                                                                                 .foregroundColor(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                                             Button(
                                                                                 action: {
                                                                                     callCorrectRealmSortFor(page: 4, false, false)
                                                                                 },
                                                                                 label: {
                                                                                     HStack (spacing: 0) {
                                                                                         Text("dec")
                                                                                             .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                                         Image(systemName: "arrow.down.right.circle.fill")
                                                                                             .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                                                                     }
                                                                                 }
                                                                             ).buttonStyle(ClearImageBackground())
                                                                             //.buttonStyle(TopHStackShowSortOptions())
                                                                         } // MARK: – för if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                                         
                                                                     } // MARK: – för HStack (spacing: 4) {
                                                                 } // MARK: – för if !($SortRequirementOptions.wrappedValue) {
                                                                 
                                                             } // MARK: – för HStack (spacing: 1) {
                                                         } // MARK: –  if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                         
                                                     } // MARK: – if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                                                     
                                                 }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $EditMode.wrappedValue {
                                             } // MARK: – if $EditMode.wrappedValue {
                                             
                                         } // MARK: – ZStack inside HStack
                                         
                                         ListPageName(4)
                                             .offset(CGSize(width: 18.00, height: 0.00))
                                     }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
                                     
 // MARK: –  PAGE 4 List of Notes🟠🟠🟠🟠🟠🟠🟠
                                     Elevator {
                                         ForEach(realmManager.p4Tasks, id: \.id) { p4TaskItem in
                                             
                                             HStack (spacing: 3) {
                                                 
                                                 ZStack {
                                                     RoundedRectangle(cornerRadius: 10)
                                                         .foregroundColor(colorScheme == .dark ? Color.DatePriorityBackgroundDarkMode : Color.DatePriorityBackgroundLightMode)
                                                     HStack (spacing: 2) {
                                                         VStack {
                                                             Button(
                                                                 action: {
                                                                     CurrentItemID  = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                                     TaskNameText  = p4TaskItem.taskNAME
                                                                     TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                                     TaskDate = p4TaskItem.taskDate
                                                                     let priority = p4TaskItem.taskPriority
                                                                     TaskPriority = priority
                                                                     pickedPriority = priority
                                                                     
                                                                     MDmode = false
                                                                     showListofTasksIfTrueElseTwoEditors(false)
                                                                     
                                                                     resetEditModeValuesAndCountTasksFor(page: 4)
                                                                     
                                                                     //currentPopoverPage = 2
                                                                 },
                                                                 label: {
                                                                     //Text(markdownThis(p4TaskItem.taskNAME))
                                                                     Text("  \(p4TaskItem.taskNAME)")
                                                                         .font(.custom("Avenir", size: 14))
                                                                         .lineLimit(1)
                                                                         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                                         .foregroundColor(colorScheme == .dark ? Color.ItemTextDarkMode : Color.ItemTextLightMode)
                                                                 }
                                                             ).buttonStyle(InvincibleNothingButton())
                                                              //.buttonStyle(PrimitiveBigTaskItemButton(p4TaskItem.id, p4TaskItem.taskPriority, isOnPage))
                                                             
                                                         }//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25, alignment: .center)
                                                     } // HStack (spacing: 2) {
                                                     Button(
                                                         action: {
                                                             CurrentItemID  = p4TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
                                                             TaskNameText  = p4TaskItem.taskNAME
                                                             TaskDescriptionText = p4TaskItem.taskDESCRIPTION
                                                             TaskDate = p4TaskItem.taskDate
                                                             let priority = p4TaskItem.taskPriority
                                                             TaskPriority = priority
                                                             pickedPriority = priority
                                                             
                                                             MDmode = false
                                                             showListofTasksIfTrueElseTwoEditors(false)
                                                             
                                                             resetEditModeValuesAndCountTasksFor(page: 4)
                                                             
                                                             //currentPopoverPage = 2
                                                         },
                                                         label: {
                                                             VStack {
                                                                 Text("                                                                                ")
                                                                     .font(.custom("Avenir", size: 16))
                                                                     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                 /*Text("                                                                                ")
                                                                                                                                      .font(.custom("Avenir", size: 16))
                                                                                                                                      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                                                                                 */
                                                                 
                                                             }.frame(height: 30)
                                                         }
                                                     ).buttonStyle(InvincibleNothingButton())
                                                         .help(Text("\(p4TaskItem.taskNAME)"))
                                                 }.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                  .shadow(radius: 1)
                                                 
                                                 
                                                 
                                                 if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p4TaskItem.isCurrentlyMarked == false ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 4, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                    
                                                 } // if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) {
                                                 if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                     VStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 p4TaskItem.isCurrentlyMarked == false ? realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: true) : realmManager.updateP4ItemisCurrentlyMarkedMarking(id: p4TaskItem.id, isMarked: false)
                                                                 
                                                                 if Sorted && !Showing {
                                                                     callCorrectRealmSortFor(page: 4, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
                                                                 } else if ShowingAndSortedIfTrueElseShowing {
                                                                     realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                                                 } else {
                                                                     if Showing && !Sorted {
                                                                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                                                                     }
                                                                 }
                                                             },
                                                             label: {
                                                                 Text("    ")
                                                             }
                                                         ).buttonStyle(MarkDoneCheckButton2(p4TaskItem.isCurrentlyMarked))
                                                         Spacer()
                                                     }.frame(width: 17)
                                                     
                                                 } // if $MoveMode.wrappedValue && !($DeleteMode.wrappedValue) {
                                                 
                                             }.padding(1)
                                         } // ForEach
                                     } // Elevator {
                                 } // Avslut för if VStack (spacing: 8) {
                                 
                                 Button(
                                     action: {
                                         show(pageItemList: 0)
                                         isOnPage = 0
                                         updateTodaysDate()
                                         currentPopoverPage = 0 // gå back so start page
                                         
                                         if !(ShowingAndSortedIfTrueElseShowing) {
                                             ShowSortRequirementAfterUnshow = true
                                             ShowFilterAndSortMode = false
                                             showBackButtonForSortinShowingAndSortedIfTrue = false
                                         }
                                         
                                         resetEditModeValuesAndCountTasksFor(page: 4)
                                         SetTheViewingStateOfAPageInRealm(forPage: 4)
                                     },
                                     label: {
                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                             .font(.system(size: 25))
                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                             .frame(width: 272, height: 9) // MARK: –  RedbackButton 🌈 styra storleken direkt med värden för Bilden
                                     }
                                 ).buttonStyle(RedBackButton())
                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 2, x: -1, y: -0.5)
                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown.opacity(0.5) : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1.5, y: 1)
                                                                     */
                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.9), radius: 1.7, x: 1, y: 1)
                                  .shadow(color: colorScheme == .dark ? Color.neuPurp : Color.neuOrangeLighter2, radius: 2, x: -1, y: -0.5)
                                 
                             }.frame(width: 305, height: 495) // VStack (spacing: 10) { // VStack som innehåller allting som ska visas på sidan som visar upp listan med tasken
                         } // MARK: – Avslut för if !($ShowEditor.wrappedValue) {
                         
 // 💧📺 PAGE 4´s 2Editor Page💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                         if $ShowEditor.wrappedValue {
                             VStack (spacing: 8) { // väljer avståndet mellan  Group{Top Hstack + ZStack { Date, Priority)}  0ch  (Elevator + ForEach)} och Den .bottom HStacken som har SAVE och .md
                                 
                                 if !($MDmode.wrappedValue) {
                                     VStack (spacing: 0) { // bestämmer avståndet mellan allting som visas på TaskName och TaskDescription + Save Hstacken
                                         
                                         //VStack (spacing: 10) { // Håller ihop TaskNameEditor med Zstacken för Date och Priority
                                             VStack (spacing: 0) {
                                                 HStack {
                                                     HStack (spacing: 0) {
                                                         Text("Priority:  ")
                                                             .font(.custom("Avenir", size: 11))
                                                             .bold()
                                                         HStack {
                                                             Picker(selection: $pickedPriority, label: Text("")) {
                                                                 ForEach(0..<priorities.count, id: \.self) {
                                                                     Text(self.priorities[$0])
                                                                         .font(.custom("Avenir", size: 10))
                                                                         .frame(alignment: .trailing)
                                                                 }
                                                             }.labelsHidden()
                                                         }.frame(width: 60, height: 27)
                                                     }
                                                     Spacer()
                                                     HStack (spacing: 0) {
                                                         Button(
                                                             action: {
                                                                 //copyToPasteboard(TaskNameText.trimmingCharacters(in: .whitespacesAndNewlines))
                                                                 copyToPasteboard(TaskNameText)
                                                             },
                                                             label: {
                                                                 Image(systemName: "doc.on.doc.fill")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         Button(
                                                             action: {
                                                                 let pastedText = pasteFromPasteboard()
                                                                 TaskNameText = TaskNameText + pastedText
                                                             },
                                                             label: {
                                                                 Image(systemName: "text.badge.plus")
                                                                     .foregroundColor(colorScheme == .dark ? Color.CopyPasteImageColorDarkMode : Color.CopyPasteImageColorLightMode)
                                                             }
                                                         ).buttonStyle(CopyAndPaste())
                                                         
                                                         Text("∙")
                                                         
                                                         if !($restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     restoreTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("reset")
                                                                         .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $restoreTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         getTaskItemWithCurrentIDsTaskNameFor(page: isOnPage)
                                                                         
                                                                         self.restoreTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                         
                                                         Text("∙")
                                                         
                                                         if !($rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue) {
                                                             Button(
                                                                 action: {
                                                                     rmTaskNameTextChooseOptionIfTrueElseYorN = true
                                                                 },
                                                                 label: {
                                                                     Text("rm")
                                                                         .foregroundColor(Color.RedTRASHAndRM)
                                                                 }
                                                             ).buttonStyle(ClearImageBackground2())
                                                         }
                                                         if $rmTaskNameTextChooseOptionIfTrueElseYorN.wrappedValue {
                                                             HStack (spacing: 2) {
                                                                 Button(
                                                                     action: {
                                                                         TaskNameText = ""
                                                                         /*
                                                                                                                                                  // MARK: – så att när man trycker igen på reset så ska man kunna resetta tillbaka förra originella texten
                                                                                                                                                  realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                                                                                                                                  */
                                                                         self.rmTaskNameTextChooseOptionIfTrueElseYorN.toggle()
                                                                     },
                                                                     label: {
                                                                         Text("y")
                                                                             .font(.custom("Avenir", size: 15))
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
                                                                         Text("n")
                                                                             .font(.custom("Avenir", size: 15))
                                                                             .foregroundColor(Color.BlueEdit)
                                                                     }
                                                                 ).buttonStyle(ClearImageBackground())
                                                             }
                                                         }
                                                     }
                                                 }.offset(CGSize(width: 0, height: -5))
                                                 
                                                 if colorScheme == .dark {
                                                     DarkModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                                                     .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                                                                                                 */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 } else {
                                                     LightModeEditorControllerView(text: $TaskNameText)
                                                         .onNSView(
                                                             added: { nsview in
                                                                 let root = nsview.subviews[0] as! NSScrollView
                                                                 root.hasVerticalScroller = true
                                                                 root.hasHorizontalScroller = false
                                                             }
                                                         )
                                                         .multilineTextAlignment(.leading)
                                                         .font(.custom("Avenir", size: 10))
                                                         .frame(width: 305, height: 432)
                                                         .lineSpacing(2.8)
                                                         .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                                         .cornerRadius(9)
                                                         //.shadow(radius: 4)
                                                         /*.shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeUP: Color.TextViewShadowLightModeUP, radius: 1, x: -1, y: -1)
                                                                                                                     .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN : Color.TextViewShadowLightModeDOWN, radius: 1, x: 1, y: 1)
                                                                                                                 */
                                                         .shadow(color: colorScheme == .dark ? Color.TextViewShadowDarkModeDOWN: Color.TextViewShadowLightModeUP, radius: 4, x: 0, y: 0)
                                                 }
                                             } // VStack (spacing: 5) {
                                             
                                     }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 1/2💧 – för VStack Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                 } // MARK: – för if !($MDmode.wrappedValue) {
                                 if $MDmode.wrappedValue {
                                     VStack (spacing: 2) {
                                         ScrollView(.vertical) {
                                             VStack (spacing: 0) {
                                                 if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                     Text(TaskNameText)
                                                         .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                         .foregroundColor(.black)
                                                         .lineSpacing(MD_Mode_Text_Space)
                                                         //.fontWidth(Font.Width(MD_Mode_Text_Width))
                                                         //.tracking(MD_Mode_Text_Width)
                                                         .kerning(MD_Mode_Text_Width)
                                                         .frame(maxWidth: .infinity, alignment: .leading)
                                                 } else {
                                                     /*Text(MDname)
                                                                                                             .font(.custom("Avenir", size: 13))
                                                                                                             .frame(maxWidth: .infinity, alignment: .leading)
                                                                                                         */
                                                     LazyVStack {
                                                         ForEach(0..<TaskNameSplitForMarkDownMode.count, id: \.self) { index in
                                                             Text(markdownThis(TaskNameSplitForMarkDownMode[index]))
                                                                 .font(.custom("Avenir", size: MD_Mode_Text_Size))
                                                                 .foregroundColor(.black)
                                                                 .lineSpacing(MD_Mode_Text_Space)
                                                                 .kerning(MD_Mode_Text_Width)
                                                                 .frame(maxWidth: .infinity, alignment: .leading)
                                                             if index != TaskNameSplitForMarkDownMode.count - 1 {
                                                                 Text("                                                                                     ")
                                                             }
                                                         }
                                                     }
                                                 }
                                             }.padding(5)
                                         }.frame(width: 305, height: 458) // MARK: 💧💥❗️💥 Del 2/2💧 – för ScrollView – Dessa ska vara lika långa för att ej fucka upp placementet av SAVE och .md Hstacken
                                     }.background(colorScheme == .dark ? Color.MarkdowPageBackgroundDarkMode : Color.MarkdowPageBackgroundLightMode)
                                      .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                                      .shadow(radius: 4)
                                 } // för if $MDmode.wrappedValue {
                                 
 // 💧📺 PAGE 4´s 2Editor – Knapperna SAVE och .md💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
                                 HStack (spacing: 8) {
                                     
                                     if !($MDmode.wrappedValue) {
                                         VStack (alignment: .leading) {
                                             HStack (spacing: 8) {
                                                 Button(
                                                     action: {
                                                         exit2EditorPageButtonAction()
                                                         //currentPopoverPage = 1
                                                     },
                                                     label: {
                                                         //Text(" Back")
                                                         Image(systemName: "arrowshape.turn.up.backward.fill")
                                                             .font(.system(size: 14))
                                                             .foregroundColor(colorScheme == .dark ? Color.neuPurpLight: Color.neuOrangeLight)
                                                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                             .frame(width: 85, height: 18) // MARK: –  miniRedbackButton 🌈 styra storleken direkt med värden för Bilden
                                                     }
                                                 ).buttonStyle(miniRedBackButton())
                                                  .offset(CGSize(width: -4, height: 1))
                                                  .help(Text("Save & Return"))
                                                  /*.shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowUP : Color.RedBackButtonLightModeShadowUP, radius: 1, x: -0.6, y: -0.6)
                                                                                                     .shadow(color: colorScheme == .dark ? Color.RedBackButtonDarkModeShadowDown : Color.RedBackButtonLightModeShadowDOWN, radius: 2, x: 1, y: 1)
                                                                                                     */
                                                  .shadow(color: colorScheme == .dark ? Color.neuBlueNeon : Color.neuOrange.opacity(0.75), radius: 0.75, x: 0.9, y: 0.8)
                                                  .shadow(color: colorScheme == .dark ? Color.neuPurp.opacity(0.6) : Color.neuOrangeLighter2, radius: 1.5, x: -1.2, y: -1)
                                                 
                                                 Divider()
                                                     .frame(width: 2, height: 31, alignment: .bottom)
                                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 
                                                 Button(
                                                     action: {
                                                         let priority = pickedPriority
                                                         
                                                         if isOnPage == 1 {
                                                             realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 2 {
                                                             realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 3 {
                                                             realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         } else if isOnPage == 4 {
                                                             realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
                                                         }
                                                     },
                                                     label: {
                                                         HStack (spacing: 0) {
                                                             //Text("Save -a")
                                                             Text("Save")
                                                                 .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                         }
                                                     }
                                                 ).buttonStyle(ClearImageBackground())
                                                  .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                                 
                                                 Spacer()
                                             } // HStack (spacing: 0) {
                                         } // VStack (alignment: .leading) {
                                     }
                                     
                                     Button(
                                         action: {
                                             // 1 – ❗️
                                             //realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: TaskPriority)
                                             // 2
                                             let markdownName = TaskNameText
                                             let markdownDescription = TaskDescriptionText
                                             
                                             /* split returns a list of Substrings, so we have to map (convert) them to Strings. To do that you can just pass the Substring to the Strings init function */
                                             TaskNameSplitForMarkDownMode = markdownName.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             TaskDescriptionSplitForMarkDownMode = markdownDescription.split{ $0.isNewline }.map({ (substring) in
                                                 return String(substring)
                                             })
                                             /* ––– behövs ej då vi har fixat att markdown visar rätt baserad på \n char
                                                                                             do {
                                                                                                 MDname = try AttributedString(markdown: markdownName)
                                                                                                 MDtext = try AttributedString(markdown: markdownDescription)
                                                                                             } catch  {
                                                                                                 print("Error creating AttributedString:  \(error)")
                                                                                             }
                                                                                     */
                                                                                     
                                             /*
                                                                                          let taskNameWords = TaskNameText.split { $0 == " " || $0.isNewline }
                                                                                          wordCountTaskName = taskNameWords.count
                                                                                          
                                                                                          let taskDescriptionWords = TaskDescriptionText.split { $0 == " " || $0.isNewline }
                                                                                          wordCountTaskDescription = taskDescriptionWords.count
                                                                                      */
                                             
                                             // 3
                                             self.MDmode.toggle()
                                             // ––
                                             resetViewValuesFor2EditorPage()
                                         },
                                         label: {
                                             HStack (spacing: 0) {
                                                 Image(systemName: "paintbrush.fill")
                                                     .foregroundColor(colorScheme == .dark ? Color.miniGeneralButtonsColorDarkMode : Color.miniGeneralButtonsColorLightMode)
                                             }//.shadow(color: colorScheme == .dark ? Color.neuPurp: Color.neuOrange, radius: 2, x: 0, y: 0)
                                         }
                                     ).buttonStyle(ClearImageBackground2())
                                      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                     
                                     if $MDmode.wrappedValue {
                                         
                                         HStack (spacing: 7) {
                                             HStack (spacing: 2) {
                                                 
                                                 /*if $txtifTrueElseMarkDownPreviewStyle.wrappedValue {
                                                                                                     HStack (spacing: 0) {
                                                                                                         Text(" Space ")
                                                                                                             .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                         Stepper {
                                                                                                             //Text("Size \(formatVal(MD_Mode_Text_Size))")
                                                                                                             //Text(" Space\n \(formatVal3(MD_Mode_Text_Space))")
                                                                                                             Text("Space")
                                                                                                                 .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                         } onIncrement: {
                                                                                                             if MD_Mode_Text_Space < 10 {
                                                                                                                 self.MD_Mode_Text_Space += 0.1
                                                                                                             }
                                                                                                         } onDecrement: {
                                                                                                             if MD_Mode_Text_Space > 0.1 {
                                                                                                                 self.MD_Mode_Text_Space -= 0.1
                                                                                                             }
                                                                                                         } onEditingChanged: {
                                                                                                             print("\($0)")
                                                                                                         }.labelsHidden()
                                                                                                     }
                                                                                                     HStack (spacing: 0) {
                                                                                                         Text(" Width ")
                                                                                                             .font(.system(size: 9, weight: .light, design: .monospaced))
                                                                                                         Stepper(" Width", value: $MD_Mode_Text_Width, in: 0...1.7, step: 0.1, onEditingChanged: {
                                                                                                             print("\($0)")
                                                                                                         }).labelsHidden()
                                                                                                     }//.padding(.horizontal, 1)
                                                                                                 }*/
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
                                             }.frame(width: 160, alignment: .trailing) // HStack
                                              .padding(.horizontal, 1)
                                             
                                             Divider()
                                                 .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                 .frame(width: 2, height: 31, alignment: .bottom)
                                                 .padding(.horizontal, 1)
                                             
                                             txtORmd($txtifTrueElseMarkDownPreviewStyle)
                                         }.frame(width: 270, height: 17)
                                     }
                                     
                                 }.frame(width: 295, height: 17) // HStack (spacing: 0) {
                                 
                             }.frame(width: 305, height: 495, alignment: .center) // för VStack (spacing: 8) {
                              .padding(5)
                             
                         } // MARK: – Avslut för if $ShowEditor.wrappedValue {
                         
                         
                     } // MARK: – för if $p4showPageNOTHINGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) {
                     
                     
 // MARK: – 💥💥💥💥💥AVSLUT💥💥💥💥💥 sidan på POPOVERpageController som innehåller Listan med TaskItemsen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
                     
                     
                 } // MARK: – ZWorld End・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・🌐
             }.padding(8) // MARK: – VStacken som alla page kommer appear on på ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・⭐️
                 
             
         }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center) // MARK: - 🚌 Avslut PopoverPageController・・・・・・・・・・・・
         //.frame(width: 320, height: 500, alignment: .center)
     } // MARK: - 💥Avslut var body: some View { •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
 } // MARK: – Avslut struct ContentView



 extension ContentView {
     
     /* för rendering vilken lista som ska visas när man är page X popuppen visas */
     func show(pageItemList: Int) {
         //Säkerhetsskull
         shutdownAppButtonIfTrueElseYorN = true
         
         if pageItemList == 0 {
             p0StarterPageWith4Buttons = true
             
             p1showPageIMPandURGPopUp = false
             p2showPageIMPPopUp = false
             p3showPageURGPopUp = false
             p4showPageNOTHINGPopUp = false
         }
         if pageItemList == 1 {
             p0StarterPageWith4Buttons = false
             
             p1showPageIMPandURGPopUp = true
             p2showPageIMPPopUp = false
             p3showPageURGPopUp = false
             p4showPageNOTHINGPopUp = false
         }
         if pageItemList == 2 {
             p0StarterPageWith4Buttons = false
             
             p1showPageIMPandURGPopUp = false
             p2showPageIMPPopUp = true
             p3showPageURGPopUp = false
             p4showPageNOTHINGPopUp = false
         }
         if pageItemList == 3 {
             p0StarterPageWith4Buttons = false
             
             p1showPageIMPandURGPopUp = false
             p2showPageIMPPopUp = false
             p3showPageURGPopUp = true
             p4showPageNOTHINGPopUp = false
         }
         if pageItemList == 4 {
             p0StarterPageWith4Buttons = false
             
             p1showPageIMPandURGPopUp = false
             p2showPageIMPPopUp = false
             p3showPageURGPopUp = false
             p4showPageNOTHINGPopUp = true
         }
     }
     
 /* – checka ifall today är/förbi den expiration datument som appen har. Ifall den är/förbi då gör så att knapparna som navigerar till listorna förvinner
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
     
     /* för rendering att alla tasknames ska visas som .MD mode på listan */
     func markdownThis(_ text: String) -> AttributedString {
         var markdownTaskName: AttributedString = ""
         do {
             markdownTaskName  = try AttributedString(markdown: text)
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
     
     
 /*
     private func toggleLoginItem() {
         let service = SMAppService.loginItem(identifier: "com.4Time.Menubar-Notes") // Replace with your app's launcher app identifier
         
         if isLoginItemEnabled {
             do {
                 try service.register()
             } catch {
                 print("Unable to register \(error)")
             }
         } else {
             do {
                 try service.unregister()
             } catch {
                 print("Unable to register \(error)")
             }
         }
         
         isLoginItemEnabled.toggle()
         UserDefaults.standard.set(isLoginItemEnabled, forKey: "isLoginItemEnabled")
     }*/
 }



 extension ContentView {
     func updateTodaysDate() {
         todaysDate = Date()
         todaysWeekDayName = dateMachine.dayNameOfWeek()
         weekNumberOfYear = dateMachine.weekNumber()
     }
     
     func CountIMPandURGTasks() {
         isThereAnyIMPandURGItem = realmManager.isThereAnyP1Item()
         isThereMoreThanOneIMPandURGItem = realmManager.isThereMoreP1Items()
     }
     func CountIMPTasks() {
         isThereAnyIMPItem = realmManager.isThereAnyP2Item()
         isThereMoreThanOneIMPItem = realmManager.isThereMoreP2Items()
     }
     func CountURGTasks() {
         isThereAnyURGItem = realmManager.isThereAnyP3Item()
         isThereMoreThanOneURGItem = realmManager.isThereMoreP3Items()
     }
     func CountNOTHINGTasks() {
         isThereAnyNOTHINGItem = realmManager.isThereAnyP4Item()
         isThereMoreThanOneNOTHINGItem = realmManager.isThereMoreP4Items()
     }
     
     
     func getViewValuesFor(page: Int) {
         if page == 1 {
             // för säkerhetsskull
             CountIMPandURGTasks()
             getViewValuesForP1()
             
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 1, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if Showing && !Sorted {
                 setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
             }
         }
         if page == 2 {
             // för säkerhetsskull
             CountIMPTasks()
             getViewValuesForP2()
             
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 2, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if Showing && !Sorted {
                 setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
             }
         }
         if page == 3 {
             // för säkerhetsskull
             CountURGTasks()
             getViewValuesForP3()
             
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 3, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if Showing && !Sorted {
                 setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
             }
         }
         if page == 4 {
             // för säkerhetsskull
             CountNOTHINGTasks()
             getViewValuesForP4()
             
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 4, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             }
             if Showing && !Sorted {
                 setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
             }
         }
     }
     func getViewValuesForP1() {
         Showing = p1ViewSettings_Showing
         ShowingAndSortedIfTrueElseShowing = p1ViewSettings_ShowingAndSortedIfTrueElseShowing
         Sorted = p1ViewSettings_Sorted
         
         ShowTextFieldTaskNameFilterResultTextHint = p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint
         ShowTextFieldTaskDescriptionFilterResultTextHint = p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint
         ShowCONTAINSTaskName = p1ViewSettings_ShowCONTAINSTaskName
         ShowCONTAINSTaskDescription = p1ViewSettings_ShowCONTAINSTaskDescription
         helpWithShowCONTAINS = p1ViewSettings_helpWithShowCONTAINS
         
         ShowShowBarForTaskNameIfTrueElseTaskDescription = p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription
         uselessButUsedinShowItemsAfterSavingTask = p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask
         thereIsItemsInCallFromShowButton = p1ViewSettings_thereIsItemsInCallFromShowButton
         
         TasksIsSortedbyDateIfTrueElsePriority = p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority
         TasksIsSortedIncreasingIfTrueElseDecreasing = p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing
         SortByIncreasing = p1ViewSettings_SortByIncreasing
         
         ShowSortRequirementAfterUnshow = p1ViewSettings_ShowSortRequirementAfterUnshow
         ShowSortByDateAfterUnshowButtonIfTrueElsePriority = p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority
         ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
     }
     func getViewValuesForP2() {
         Showing = p2ViewSettings_Showing
         ShowingAndSortedIfTrueElseShowing = p2ViewSettings_ShowingAndSortedIfTrueElseShowing
         Sorted = p2ViewSettings_Sorted

         ShowTextFieldTaskNameFilterResultTextHint = p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint
         ShowTextFieldTaskDescriptionFilterResultTextHint = p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint
         ShowCONTAINSTaskName = p2ViewSettings_ShowCONTAINSTaskName
         ShowCONTAINSTaskDescription = p2ViewSettings_ShowCONTAINSTaskDescription
         helpWithShowCONTAINS = p2ViewSettings_helpWithShowCONTAINS

         ShowShowBarForTaskNameIfTrueElseTaskDescription = p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription
         uselessButUsedinShowItemsAfterSavingTask = p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask
         thereIsItemsInCallFromShowButton = p2ViewSettings_thereIsItemsInCallFromShowButton

         TasksIsSortedbyDateIfTrueElsePriority = p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority
         TasksIsSortedIncreasingIfTrueElseDecreasing = p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing
         SortByIncreasing = p2ViewSettings_SortByIncreasing

         ShowSortRequirementAfterUnshow = p2ViewSettings_ShowSortRequirementAfterUnshow
         ShowSortByDateAfterUnshowButtonIfTrueElsePriority = p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority
         ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
     }
     func getViewValuesForP3() {
         Showing = p3ViewSettings_Showing
         ShowingAndSortedIfTrueElseShowing = p3ViewSettings_ShowingAndSortedIfTrueElseShowing
         Sorted = p3ViewSettings_Sorted

         ShowTextFieldTaskNameFilterResultTextHint = p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint
         ShowTextFieldTaskDescriptionFilterResultTextHint = p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint
         ShowCONTAINSTaskName = p3ViewSettings_ShowCONTAINSTaskName
         ShowCONTAINSTaskDescription = p3ViewSettings_ShowCONTAINSTaskDescription
         helpWithShowCONTAINS = p3ViewSettings_helpWithShowCONTAINS

         ShowShowBarForTaskNameIfTrueElseTaskDescription = p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription
         uselessButUsedinShowItemsAfterSavingTask = p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask
         thereIsItemsInCallFromShowButton = p3ViewSettings_thereIsItemsInCallFromShowButton

         TasksIsSortedbyDateIfTrueElsePriority = p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority
         TasksIsSortedIncreasingIfTrueElseDecreasing = p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing
         SortByIncreasing = p3ViewSettings_SortByIncreasing

         ShowSortRequirementAfterUnshow = p3ViewSettings_ShowSortRequirementAfterUnshow
         ShowSortByDateAfterUnshowButtonIfTrueElsePriority = p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority
         ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
     }
     func getViewValuesForP4() {
         Showing = p4ViewSettings_Showing
         ShowingAndSortedIfTrueElseShowing = p4ViewSettings_ShowingAndSortedIfTrueElseShowing
         Sorted = p4ViewSettings_Sorted

         ShowTextFieldTaskNameFilterResultTextHint = p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint
         ShowTextFieldTaskDescriptionFilterResultTextHint = p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint
         ShowCONTAINSTaskName = p4ViewSettings_ShowCONTAINSTaskName
         ShowCONTAINSTaskDescription = p4ViewSettings_ShowCONTAINSTaskDescription
         helpWithShowCONTAINS = p4ViewSettings_helpWithShowCONTAINS

         ShowShowBarForTaskNameIfTrueElseTaskDescription = p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription
         uselessButUsedinShowItemsAfterSavingTask = p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask
         thereIsItemsInCallFromShowButton = p4ViewSettings_thereIsItemsInCallFromShowButton

         TasksIsSortedbyDateIfTrueElsePriority = p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority
         TasksIsSortedIncreasingIfTrueElseDecreasing = p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing
         SortByIncreasing = p4ViewSettings_SortByIncreasing

         ShowSortRequirementAfterUnshow = p4ViewSettings_ShowSortRequirementAfterUnshow
         ShowSortByDateAfterUnshowButtonIfTrueElsePriority = p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority
         ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
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
     func SetTheViewingStateOfAPageInRealm(forPage: Int) {
         if forPage == 1 {
             p1ViewSettings_Showing = Showing
                 UserDefaults.standard.set(p1ViewSettings_Showing, forKey: "p1ViewSettings_Showing")
             p1ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
                 UserDefaults.standard.set(p1ViewSettings_ShowingAndSortedIfTrueElseShowing, forKey: "p1ViewSettings_ShowingAndSortedIfTrueElseShowing")
             p1ViewSettings_Sorted = Sorted
                 UserDefaults.standard.set(p1ViewSettings_Sorted, forKey: "p1ViewSettings_Sorted")

             
             p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                 UserDefaults.standard.set(p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint, forKey: "p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint")
             p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                 UserDefaults.standard.set(p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint, forKey: "p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint")
             p1ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                 UserDefaults.standard.set(p1ViewSettings_ShowCONTAINSTaskName, forKey: "p1ViewSettings_ShowCONTAINSTaskName")
             p1ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                 UserDefaults.standard.set(p1ViewSettings_ShowCONTAINSTaskDescription, forKey: "p1ViewSettings_ShowCONTAINSTaskDescription")
             p1ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS
                 UserDefaults.standard.set(p1ViewSettings_helpWithShowCONTAINS, forKey: "p1ViewSettings_helpWithShowCONTAINS")
             
             
             p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                 UserDefaults.standard.set(p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription, forKey: "p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription")
             p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                 UserDefaults.standard.set(p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask, forKey: "p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask")
             p1ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton
                 UserDefaults.standard.set(p1ViewSettings_thereIsItemsInCallFromShowButton, forKey: "p1ViewSettings_thereIsItemsInCallFromShowButton")
             
             
             p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                 UserDefaults.standard.set(p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority, forKey: "p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority")
             p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                 UserDefaults.standard.set(p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing, forKey: "p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing")
             p1ViewSettings_SortByIncreasing = SortByIncreasing
                 UserDefaults.standard.set(p1ViewSettings_SortByIncreasing, forKey: "p1ViewSettings_SortByIncreasing")
             
             
             p1ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                 UserDefaults.standard.set(p1ViewSettings_ShowSortRequirementAfterUnshow, forKey: "p1ViewSettings_ShowSortRequirementAfterUnshow")
             p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                 UserDefaults.standard.set(p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority, forKey: "p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority")
             p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
                 UserDefaults.standard.set(p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing, forKey: "p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing")

         } else if forPage == 2 {
             p2ViewSettings_Showing = Showing
             UserDefaults.standard.set(p2ViewSettings_Showing, forKey: "p2ViewSettings_Showing")
             p2ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
             UserDefaults.standard.set(p2ViewSettings_ShowingAndSortedIfTrueElseShowing, forKey: "p2ViewSettings_ShowingAndSortedIfTrueElseShowing")
             p2ViewSettings_Sorted = Sorted
             UserDefaults.standard.set(p2ViewSettings_Sorted, forKey: "p2ViewSettings_Sorted")

             
             p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                 UserDefaults.standard.set(p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint, forKey: "p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint")
             p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                 UserDefaults.standard.set(p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint, forKey: "p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint")
             p2ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                 UserDefaults.standard.set(p2ViewSettings_ShowCONTAINSTaskName, forKey: "p2ViewSettings_ShowCONTAINSTaskName")
             p2ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                 UserDefaults.standard.set(p2ViewSettings_ShowCONTAINSTaskDescription, forKey: "p2ViewSettings_ShowCONTAINSTaskDescription")
             p2ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS
                 UserDefaults.standard.set(p2ViewSettings_helpWithShowCONTAINS, forKey: "p2ViewSettings_helpWithShowCONTAINS")
             
             p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                 UserDefaults.standard.set(p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription, forKey: "p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription")
             p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                 UserDefaults.standard.set(p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask, forKey: "p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask")
             p2ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton
                 UserDefaults.standard.set(p2ViewSettings_thereIsItemsInCallFromShowButton, forKey: "p2ViewSettings_thereIsItemsInCallFromShowButton")
             
             
             p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                 UserDefaults.standard.set(p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority, forKey: "p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority")
             p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                 UserDefaults.standard.set(p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing, forKey: "p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing")
             p2ViewSettings_SortByIncreasing = SortByIncreasing
                 UserDefaults.standard.set(p2ViewSettings_SortByIncreasing, forKey: "p2ViewSettings_SortByIncreasing")
             
             
             p2ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                 UserDefaults.standard.set(p2ViewSettings_ShowSortRequirementAfterUnshow, forKey: "p2ViewSettings_ShowSortRequirementAfterUnshow")
             p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                 UserDefaults.standard.set(p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority, forKey: "p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority")
             p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
                 UserDefaults.standard.set(p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing, forKey: "p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing")
             
         } else if forPage == 3 {
             p3ViewSettings_Showing = Showing
                 UserDefaults.standard.set(p3ViewSettings_Showing, forKey: "p3ViewSettings_Showing")
             p3ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
                 UserDefaults.standard.set(p3ViewSettings_ShowingAndSortedIfTrueElseShowing, forKey: "p3ViewSettings_ShowingAndSortedIfTrueElseShowing")
             p3ViewSettings_Sorted = Sorted
                 UserDefaults.standard.set(p3ViewSettings_Sorted, forKey: "p3ViewSettings_Sorted")

             
             p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                 UserDefaults.standard.set(p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint, forKey: "p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint")
             p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                 UserDefaults.standard.set(p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint, forKey: "p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint")
             p3ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                 UserDefaults.standard.set(p3ViewSettings_ShowCONTAINSTaskName, forKey: "p3ViewSettings_ShowCONTAINSTaskName")
             p3ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                 UserDefaults.standard.set(p3ViewSettings_ShowCONTAINSTaskDescription, forKey: "p3ViewSettings_ShowCONTAINSTaskDescription")
             p3ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS
                 UserDefaults.standard.set(p3ViewSettings_helpWithShowCONTAINS, forKey: "p3ViewSettings_helpWithShowCONTAINS")
             
             
             p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                 UserDefaults.standard.set(p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription, forKey: "p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription")
             p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                 UserDefaults.standard.set(p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask, forKey: "p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask")
             p3ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton
                 UserDefaults.standard.set(p3ViewSettings_thereIsItemsInCallFromShowButton, forKey: "p3ViewSettings_thereIsItemsInCallFromShowButton")
             
             
             p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                 UserDefaults.standard.set(p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority, forKey: "p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority")
             p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                 UserDefaults.standard.set(p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing, forKey: "p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing")
             p3ViewSettings_SortByIncreasing = SortByIncreasing
                 UserDefaults.standard.set(p3ViewSettings_SortByIncreasing, forKey: "p3ViewSettings_SortByIncreasing")
             
             
             p3ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                 UserDefaults.standard.set(p3ViewSettings_ShowSortRequirementAfterUnshow, forKey: "p3ViewSettings_ShowSortRequirementAfterUnshow")
             p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                 UserDefaults.standard.set(p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority, forKey: "p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority")
             p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
                 UserDefaults.standard.set(p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing, forKey: "p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing")
             
         } else if forPage == 4 {
             p4ViewSettings_Showing = Showing
             UserDefaults.standard.set(p4ViewSettings_Showing, forKey: "p4ViewSettings_Showing")
             p4ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
             UserDefaults.standard.set(p4ViewSettings_ShowingAndSortedIfTrueElseShowing, forKey: "p4ViewSettings_ShowingAndSortedIfTrueElseShowing")
             p4ViewSettings_Sorted = Sorted
             UserDefaults.standard.set(p4ViewSettings_Sorted, forKey: "p4ViewSettings_Sorted")

             
             p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
             UserDefaults.standard.set(p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint, forKey: "p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint")
             p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
             UserDefaults.standard.set(p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint, forKey: "p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint")
             p4ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
             UserDefaults.standard.set(p4ViewSettings_ShowCONTAINSTaskName, forKey: "p4ViewSettings_ShowCONTAINSTaskName")
             p4ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
             UserDefaults.standard.set(p4ViewSettings_ShowCONTAINSTaskDescription, forKey: "p4ViewSettings_ShowCONTAINSTaskDescription")
             p4ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS
             UserDefaults.standard.set(p4ViewSettings_helpWithShowCONTAINS, forKey: "p4ViewSettings_helpWithShowCONTAINS")
             
             
             p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
             UserDefaults.standard.set(p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription, forKey: "p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription")
             p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
             UserDefaults.standard.set(p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask, forKey: "p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask")
             p4ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton
             UserDefaults.standard.set(p4ViewSettings_thereIsItemsInCallFromShowButton, forKey: "p4ViewSettings_thereIsItemsInCallFromShowButton")
             
             
             p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
             UserDefaults.standard.set(p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority, forKey: "p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority")
             p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
             UserDefaults.standard.set(p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing, forKey: "p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing")
             p4ViewSettings_SortByIncreasing = SortByIncreasing
             UserDefaults.standard.set(p4ViewSettings_SortByIncreasing, forKey: "p4ViewSettings_SortByIncreasing")
             
             p4ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
             UserDefaults.standard.set(p4ViewSettings_ShowSortRequirementAfterUnshow, forKey: "p4ViewSettings_ShowSortRequirementAfterUnshow")
             p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
             UserDefaults.standard.set(p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority, forKey: "p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority")
             p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
             UserDefaults.standard.set(p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing, forKey: "p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing")
         }
     }
     
     
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
         
         EditMode = false
         
         AddMode = false
         AddOneTaskWithTaskName = ""
         
         MoveMode = false
         toPage = 0
         DeleteMode = false
         rmALLPageMode = false
         
         SortMode = false
         SortRequirementOptions = true
         
         ShowMode = false
         ShowRequirementOptions = true
         
         showBackButtonForSortinShowingAndSortedIfTrue = false // ?? varför
         // för att "resetta" Movemode ifall den var på innan man öppnade tasken
         showMoveAfterShowFilterAndSortMode = true
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
         
         if isOnPage == 1 {
             realmManager.updateP1ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 1, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             } else if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 if Showing && !Sorted {
                     setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                 }
             }
         } else if isOnPage == 2 {
             realmManager.updateP2ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 2, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             } else if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 if Showing && !Sorted {
                     setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                 }
             }
         } else if isOnPage == 3 {
             realmManager.updateP3ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 3, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             } else if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 if Showing && !Sorted {
                     setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                 }
             }
         } else if isOnPage == 4 {
             realmManager.updateP4ItemTextDatePriority(id: CurrentItemID, name: TaskNameText, tex: TaskDescriptionText, dat: TaskDate, prio: priority)
             if Sorted && !Showing {
                 callCorrectRealmSortFor(page: 4, TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
             } else if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 if Showing && !Sorted {
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
          • if $SortMode.wrappedValue && !($ShowMode.wrappedValue) && !($MoveMode.wrappedValue) {
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
                 Sorted = true
                 TasksIsSortedbyDateIfTrueElsePriority = true
                 TasksIsSortedIncreasingIfTrueElseDecreasing = true
             } else {
                 Sorted = true
                 TasksIsSortedbyDateIfTrueElsePriority = true
                 TasksIsSortedIncreasingIfTrueElseDecreasing = false
             }
         } else {
             if IncOrDec {
                 Sorted = true
                 TasksIsSortedbyDateIfTrueElsePriority = false
                 TasksIsSortedIncreasingIfTrueElseDecreasing = true
             } else {
                 Sorted = true
                 TasksIsSortedbyDateIfTrueElsePriority = false
                 TasksIsSortedIncreasingIfTrueElseDecreasing = false
             }
         }
         
         UserDefaults.standard.set(Sorted, forKey: "Sorted")
         UserDefaults.standard.set(TasksIsSortedbyDateIfTrueElsePriority, forKey: "TasksIsSortedbyDateIfTrueElsePriority")
         UserDefaults.standard.set(TasksIsSortedIncreasingIfTrueElseDecreasing, forKey: "TasksIsSortedIncreasingIfTrueElseDecreasing")
         
         EditMode = false
         UserDefaults.standard.set(EditMode, forKey: "EditMode")
         SortMode = false
         UserDefaults.standard.set(SortMode, forKey: "SortMode")
         SortRequirementOptions = true
         UserDefaults.standard.set(Sorted, forKey: "SortMode")
         
         if page == 1 {
             realmManager.sortP1(TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
         }
         if page == 2 {
             realmManager.sortP2(TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
         }
         if page == 3 {
             realmManager.sortP3(TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
         }
         if page == 4 {
             realmManager.sortP4(TasksIsSortedbyDateIfTrueElsePriority, TasksIsSortedIncreasingIfTrueElseDecreasing)
         }
     }
     
     func callCorrectRealmShowInShowMode(page: Int) {
         if page == 1 {
             if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                 let help = ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP1ItemsNameContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             } else {
                 let help = ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP1ItemsDescriptionContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountIMPandURGTasks()
         }
         if page == 2 {
             if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                 let help = ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP2ItemsNameContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             } else {
                 let help = ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP2ItemsDescriptionContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountIMPTasks()
         }
         if page == 3 {
             if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                 let help = ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP3ItemsNameContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             } else {
                 let help = ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP3ItemsDescriptionContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountURGTasks()
         }
         if page == 4 {
             if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                 let help = ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP4ItemsNameContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             } else {
                 let help = ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                 if !(help.isEmpty) {
                     thereIsItemsInCallFromShowButton = realmManager.showP4ItemsDescriptionContaining(name: help)
                 } else {
                     thereIsItemsInCallFromShowButton = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountNOTHINGTasks()
         }
         
         if thereIsItemsInCallFromShowButton {
             Showing = true
             if !(ShowingAndSortedIfTrueElseShowing) {
                 ShowSortRequirementAfterUnshow = true
                 ShowFilterAndSortMode = false
                 showBackButtonForSortinShowingAndSortedIfTrue = false
             }
             EditMode = false
             ShowMode = false
             ShowRequirementOptions = true
         } else {
             if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                 ShowTextFieldTaskNameFilterResultTextHint = "0 task names                      "
                 ShowCONTAINSTaskName = ""
             } else {
                 ShowTextFieldTaskDescriptionFilterResultTextHint = "0 task descriptions              "
                 ShowCONTAINSTaskDescription = ""
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
         if ShowShowBarForTaskNameIfTrueElseTaskDescription {
             helpWithShowCONTAINS = ShowCONTAINSTaskName.trimmingCharacters(in: .whitespacesAndNewlines)
         } else {
             helpWithShowCONTAINS = ShowCONTAINSTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
         }
         
         if page == 1 {
             if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                 if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                     thereIsItemsInCallFromShowButton = realmManager.showP1ItemsNameContaining(name: helpWithShowCONTAINS)
                 } else {
                     thereIsItemsInCallFromShowButton = realmManager.showP1ItemsDescriptionContaining(name: helpWithShowCONTAINS)
                 }
                 
                 if thereIsItemsInCallFromShowButton {
                     Showing = true
                     
                     if !(ShowingAndSortedIfTrueElseShowing) {
                         ShowSortRequirementAfterUnshow = true
                         ShowFilterAndSortMode = false
                         showBackButtonForSortinShowingAndSortedIfTrue = false
                     }
                     
                     EditMode = false
                     ShowMode = false
                     ShowRequirementOptions = true
                 } else {
                     Showing = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountIMPandURGTasks()
         }
         if page == 2 {
             if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP2(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                 if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                     thereIsItemsInCallFromShowButton = realmManager.showP2ItemsNameContaining(name: helpWithShowCONTAINS)
                 } else {
                     thereIsItemsInCallFromShowButton = realmManager.showP2ItemsDescriptionContaining(name: helpWithShowCONTAINS)
                 }
                 
                 if thereIsItemsInCallFromShowButton {
                     Showing = true
                     
                     if !(ShowingAndSortedIfTrueElseShowing) {
                         ShowSortRequirementAfterUnshow = true
                         ShowFilterAndSortMode = false
                         showBackButtonForSortinShowingAndSortedIfTrue = false
                     }
                     
                     EditMode = false
                     ShowMode = false
                     ShowRequirementOptions = true
                 } else {
                     Showing = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountIMPTasks()
         }
         if page == 3 {
             if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP3(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                 if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                     thereIsItemsInCallFromShowButton = realmManager.showP3ItemsNameContaining(name: helpWithShowCONTAINS)
                 } else {
                     thereIsItemsInCallFromShowButton = realmManager.showP3ItemsDescriptionContaining(name: helpWithShowCONTAINS)
                 }
                 
                 if thereIsItemsInCallFromShowButton {
                     Showing = true
                     
                     if !(ShowingAndSortedIfTrueElseShowing) {
                         ShowSortRequirementAfterUnshow = true
                         ShowFilterAndSortMode = false
                         showBackButtonForSortinShowingAndSortedIfTrue = false
                     }
                     
                     EditMode = false
                     ShowMode = false
                     ShowRequirementOptions = true
                 } else {
                     Showing = false
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountURGTasks()
         }
         if page == 4 {
             if ShowingAndSortedIfTrueElseShowing {
                 realmManager.FilterAndSortP4(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
             } else {
                 // ifall listan var ordered/showing enligt if task.Name CONTAINS some String som är sparad i @State var ShowCONTAINSTaskName, då återställ den ordningen
                 if ShowShowBarForTaskNameIfTrueElseTaskDescription {
                     thereIsItemsInCallFromShowButton = realmManager.showP4ItemsNameContaining(name: helpWithShowCONTAINS)
                 } else {
                     thereIsItemsInCallFromShowButton = realmManager.showP4ItemsDescriptionContaining(name: helpWithShowCONTAINS)
                 }
                 
                 if thereIsItemsInCallFromShowButton {
                     Showing = true
                     UserDefaults.standard.set(Showing, forKey: "Showing")
                     
                     if !(ShowingAndSortedIfTrueElseShowing) {
                         ShowSortRequirementAfterUnshow = true
                         UserDefaults.standard.set(ShowSortRequirementAfterUnshow, forKey: "ShowSortRequirementAfterUnshow")
                         ShowFilterAndSortMode = false
                         UserDefaults.standard.set(ShowFilterAndSortMode, forKey: "ShowFilterAndSortMode")
                         showBackButtonForSortinShowingAndSortedIfTrue = false
                         UserDefaults.standard.set(showBackButtonForSortinShowingAndSortedIfTrue, forKey: "showBackButtonForSortinShowingAndSortedIfTrue")
                     }
                     
                     EditMode = false
                     UserDefaults.standard.set(EditMode, forKey: "EditMode")
                     ShowMode = false
                     UserDefaults.standard.set(ShowMode, forKey: "ShowMode")
                     ShowRequirementOptions = true
                     UserDefaults.standard.set(ShowRequirementOptions, forKey: "ShowRequirementOptions")
                 } else {
                     Showing = false
                     UserDefaults.standard.set(Showing, forKey: "Showing")
                 }
             }
             // för säkehetsskull – Ha med för att annars det har blivit buggar i correct uppdateringen av Showing Bool @State som messar upp SHOW/UNSHOW knapparna
             CountNOTHINGTasks()
         }
     }
     
     func showListofTasksIfTrueElseTwoEditors(_ show: Bool) {
         if show {
             ShowEditor = false
         } else {
             ShowEditor = true
         }
     }
 }



 // MARK: – för att kunna adda Conditional modifiers på Views (Text() och etc.)

 /*
      if you only want to apply a modifier if a condition is true,
      the View extension is a good method. For example, you only want
      to add a shadow to your Text if the value of shouldAddShadow is true.
      If it's false, you don't want to add any shadow.
      
      Let's start by creating the View extension. This extension lets us add the .if modifier to our Views and will only apply the modifiers we add if the condition is met. */
 /*
     extension View {
          @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
              if condition {
                  transform(self)
              } else {
                  self
              }
          }
      }
  */
 /*
     With this extension, we can add the .if modifier to our View!
     This is also better for your application's performance, because
     you can let users disable the shadows and all other CPU-expensive
     modifiers, like blur views, if they have an old device. */
 /* struct ContentView: View {
         @State private var shouldAddShadow: Bool = true
         
         var body: some View {
             Text("Hello, world!")
                 .if(shouldAddShadow) { view in
                     view.shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                 }
         }
     } */


 /*
 extension View {
     @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
         if condition {
             transform(self)
         } else {
             self
         }
     }
 } */



 // MARK: – För making gradient colored text

 extension Text {
     public func foregroundLinearGradient(
         colors: [Color],
         startPoint: UnitPoint,
         endPoint: UnitPoint) -> some View {
             self.overlay {
                 LinearGradient(
                     colors: colors,
                     startPoint: startPoint,
                     endPoint: endPoint
                 ).mask(self)
             }
         }
 }


 // MARK: – För How to remove SwiftUI TextField focus border
 /*
 extension NSTextField {
     open override var focusRingType: NSFocusRingType {
         get { .none }
         set { }
     }
 } */



 // MARK: – ⚪️För att Wrap NSTextView in SwiftUI – Hur man kan använda sig av en TextView i macOS⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️

 /* 1. Create a ViewController that presents the NSTextView */
 class EditorController: NSViewController {
     var textView = NSTextView()
 /*
      An RGB color value represents RED, GREEN, and BLUE light sources.
      An RGBA color value is an extension of RGB with an Alpha channel (opacity).
 */
     //var cDarkMode: NSColor = NSColor.init(red: 206, green: 203, blue: 203, alpha: 1.00)
     //var cLightMode: NSColor = NSColor.init(red: 0, green: 245, blue: 234, alpha: 0.75)
     //var cTextDarkMode: NSColor = NSColor.init(red: 163, green: 161, blue: 161, alpha: 0.75)
     //var cTextLightMode: NSColor = NSColor.init(red: 56, green: 52, blue: 52, alpha: 0.75)
     
     override func loadView() {
         let scrollView = NSScrollView()
         scrollView.hasVerticalScroller = true
         
         textView.autoresizingMask = [.width]
         textView.allowsUndo = true
         
         textView.textColor = NSColor.darkGray
         textView.font = NSFont(name: "Avenir", size: 14.0)
         //textView.backgroundColor = NSColor.init(red: 56, green: 52, blue: 52, alpha: 0.75)
         textView.backgroundColor = NSColor.init(red:0.87059, green:0.84706, blue:0.84706, alpha:1.00000)
         
         scrollView.documentView = textView
         self.view = scrollView
     }
     
     override func viewDidAppear() {
         //self.view.window?.makeFirstResponder(self.view) // vill inte att den ska focus på textViewen så fort den visas upp på en sida
     }
 }
 /* 2. Create a Representable */
 struct EditorControllerView: NSViewControllerRepresentable {
     @Binding var text: String
     
     func makeCoordinator() -> Coordinator {
         return Coordinator(self)
     }
     
     class Coordinator: NSObject, NSTextStorageDelegate
     {
         private var parent: EditorControllerView
         var shouldUpdateText = true
         
         init(_ parent: EditorControllerView) {
             self.parent = parent
         }
         
         func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
             guard shouldUpdateText else {
                 return
             }
             let edited = textStorage.attributedSubstring(from: editedRange).string
             let insertIndex = parent.text.utf16.index(parent.text.utf16.startIndex, offsetBy: editedRange.lowerBound)
             
             func numberOfCharactersToDelete() -> Int {
                 editedRange.length - delta
             }
             
             let endIndex = parent.text.utf16.index(insertIndex, offsetBy: numberOfCharactersToDelete())
             self.parent.text.replaceSubrange(insertIndex..<endIndex, with: edited)
         }
     }
     
     func makeNSViewController(context: Context) -> EditorController {
         let vc = EditorController()
         vc.textView.textStorage?.delegate = context.coordinator
         return vc
     }
     
     func updateNSViewController(_ nsViewController: EditorController, context: Context) {
         if text != nsViewController.textView.string {
             context.coordinator.shouldUpdateText = false
             nsViewController.textView.string = text
             context.coordinator.shouldUpdateText = true
         }
     }
 }


 /* 1 a DARKMODE ViewController */
 class DarkModeEditorController: NSViewController
 {
     var textView = NSTextView()
     
     override func loadView() {
         let scrollView = NSScrollView()
         scrollView.hasVerticalScroller = true
         
         textView.autoresizingMask = [.width]
         textView.allowsUndo = true
         
         //textView.textColor = NSColor.lightGray
         //textView.textColor = NSColor.init(red:0.67843, green:0.68627, blue:0.74902, alpha:1.00000)
         //textView.textColor = NSColor.init(red: 0.80392, green: 0.81176, blue: 0.84706, alpha: 1.00000)
         //textView.textColor = NSColor.init(red: 0.09804, green: 0.09804, blue: 0.09804, alpha: 1.00000)
         textView.textColor = NSColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00000)
         textView.font = NSFont(name: "Avenir", size: 15.0)
         //textView.backgroundColor = NSColor.init(red: 0.21176, green: 0.20784, blue: 0.20392, alpha: 1.00000)
         textView.backgroundColor = NSColor.init(red: 0.60784, green: 0.59216, blue: 0.59216, alpha: 1.00000)
         
         scrollView.documentView = textView
         self.view = scrollView
     }
     
     override func viewDidAppear() {
         //self.view.window?.makeFirstResponder(self.view) // vill inte att den ska focus på textViewen så fort den visas upp på en sida
     }
 }
 /* 2 a DARKMODE Representable */
 struct DarkModeEditorControllerView: NSViewControllerRepresentable {
     @Binding var text: String
     
     func makeCoordinator() -> Coordinator {
         return Coordinator(self)
     }
     
     class Coordinator: NSObject, NSTextStorageDelegate
     {
         private var parent: DarkModeEditorControllerView
         var shouldUpdateText = true
         
         init(_ parent: DarkModeEditorControllerView) {
             self.parent = parent
         }
         
         func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
             guard shouldUpdateText else {
                 return
             }
             let edited = textStorage.attributedSubstring(from: editedRange).string
             let insertIndex = parent.text.utf16.index(parent.text.utf16.startIndex, offsetBy: editedRange.lowerBound)
             
             func numberOfCharactersToDelete() -> Int {
                 editedRange.length - delta
             }
             
             let endIndex = parent.text.utf16.index(insertIndex, offsetBy: numberOfCharactersToDelete())
             self.parent.text.replaceSubrange(insertIndex..<endIndex, with: edited)
         }
     }
     
     func makeNSViewController(context: Context) -> DarkModeEditorController {
         let vc = DarkModeEditorController()
         vc.textView.textStorage?.delegate = context.coordinator
         return vc
     }
     
     func updateNSViewController(_ nsViewController: DarkModeEditorController, context: Context) {
         if text != nsViewController.textView.string {
             context.coordinator.shouldUpdateText = false
             nsViewController.textView.string = text
             context.coordinator.shouldUpdateText = true
         }
     }
 }


 /* 1. a LIGHTMODE ViewController */
 class LightModeEditorController: NSViewController
 {
     var textView = NSTextView()
     
     override func loadView() {
         let scrollView = NSScrollView()
         scrollView.hasVerticalScroller = true
         
         textView.autoresizingMask = [.width]
         textView.allowsUndo = true
         
         textView.textColor = NSColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00000)
         textView.font = NSFont(name: "Avenir", size: 15.0)
         textView.backgroundColor = NSColor.init(red: 1.00000, green: 1.00000, blue: 1.00000, alpha: 1.00000)
         
         scrollView.documentView = textView
         self.view = scrollView
     }
     
     override func viewDidAppear() {
         //self.view.window?.makeFirstResponder(self.view) // vill inte att den ska focus på textViewen så fort den visas upp på en sida
     }
 }
 /* 2. a LIGHTMODE Representable */
 struct LightModeEditorControllerView: NSViewControllerRepresentable {
     @Binding var text: String
     
     func makeCoordinator() -> Coordinator {
         return Coordinator(self)
     }
     
     class Coordinator: NSObject, NSTextStorageDelegate
     {
         private var parent: LightModeEditorControllerView
         var shouldUpdateText = true
         
         init(_ parent: LightModeEditorControllerView) {
             self.parent = parent
         }
         
         func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
             guard shouldUpdateText else {
                 return
             }
             let edited = textStorage.attributedSubstring(from: editedRange).string
             let insertIndex = parent.text.utf16.index(parent.text.utf16.startIndex, offsetBy: editedRange.lowerBound)
             
             func numberOfCharactersToDelete() -> Int {
                 editedRange.length - delta
             }
             
             let endIndex = parent.text.utf16.index(insertIndex, offsetBy: numberOfCharactersToDelete())
             self.parent.text.replaceSubrange(insertIndex..<endIndex, with: edited)
         }
     }
     
     func makeNSViewController(context: Context) -> LightModeEditorController {
         let vc = LightModeEditorController()
         vc.textView.textStorage?.delegate = context.coordinator
         return vc
     }
     
     func updateNSViewController(_ nsViewController: LightModeEditorController, context: Context) {
         if text != nsViewController.textView.string {
             context.coordinator.shouldUpdateText = false
             nsViewController.textView.string = text
             context.coordinator.shouldUpdateText = true
         }
     }
 }

 // MARK: – TEXT VIEW FÖR TOP HSTACK ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️

 /* 1. a DARKMODE ViewController FÖR TOP HSTACK */
 /*class DarkModeHStackEditorController: NSViewController {
     var textView = NSTextView()
     
     override func loadView() {
         let scrollView = NSScrollView()
         scrollView.hasVerticalScroller = false
         
         textView.autoresizingMask = [.width]
         textView.allowsUndo = true
         
         
         /*textView.textColor = NSColor.darkGray
         textView.font = NSFont(name: "Avenir", size: 12.0)
         //textView.backgroundColor = NSColor.init(red: 0.87059, green: 0.84706, blue: 0.84706, alpha: 1.00000)
         //textView.backgroundColor = NSColor.init(red: 0.21176, green: 0.20784, blue: 0.20392, alpha: 1.00000)
         textView.backgroundColor = NSColor.init(red: 0.94902, green: 0.92157, blue: 0.92157, alpha: 1.00000) */
         
         //textView.textColor = NSColor.lightGray
         //textView.textColor = NSColor.init(red:0.67843, green:0.68627, blue:0.74902, alpha:1.00000)
         textView.textColor = NSColor.init(red: 0.80392, green: 0.81176, blue: 0.84706, alpha: 1.00000)
         textView.font = NSFont(name: "Avenir", size: 12.0)
         textView.backgroundColor = NSColor.init(red: 0.21176, green: 0.20784, blue: 0.20392, alpha: 1.00000)
         
         scrollView.documentView = textView
         self.view = scrollView
     }
     
     override func viewDidAppear() {
         self.view.window?.makeFirstResponder(self.view) // vill inte att den ska focus på textViewen så fort den visas upp på en sida
     }
 }
  */
 /* 2. a DARKMODE Representable */
 /*struct DarkModeHStackEditorControllerView: NSViewControllerRepresentable {
     @Binding var text: String
     
     func makeCoordinator() -> Coordinator {
         return Coordinator(self)
     }
     
     class Coordinator: NSObject, NSTextStorageDelegate
     {
         private var parent: DarkModeHStackEditorControllerView
         var shouldUpdateText = true
         
         init(_ parent: DarkModeHStackEditorControllerView) {
             self.parent = parent
         }
         
         func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
             guard shouldUpdateText else {
                 return
             }
             let edited = textStorage.attributedSubstring(from: editedRange).string
             let insertIndex = parent.text.utf16.index(parent.text.utf16.startIndex, offsetBy: editedRange.lowerBound)
             
             func numberOfCharactersToDelete() -> Int {
                 editedRange.length - delta
             }
             
             let endIndex = parent.text.utf16.index(insertIndex, offsetBy: numberOfCharactersToDelete())
             self.parent.text.replaceSubrange(insertIndex..<endIndex, with: edited)
         }
     }
     
     func makeNSViewController(context: Context) -> DarkModeHStackEditorController {
         let vc = DarkModeHStackEditorController()
         vc.textView.textStorage?.delegate = context.coordinator
         return vc
     }
     
     func updateNSViewController(_ nsViewController: DarkModeHStackEditorController, context: Context) {
         if text != nsViewController.textView.string {
             context.coordinator.shouldUpdateText = false
             nsViewController.textView.string = text
             context.coordinator.shouldUpdateText = true
         }
     }
 }
 */


 /* 1. a LIGHTMODE ViewController FÖR TOP HSTACK *//*
 class LightModeHStackEditorController: NSViewController {
     var textView = NSTextView()
     
     override func loadView() {
         let scrollView = NSScrollView()
         scrollView.hasVerticalScroller = false
         
         textView.autoresizingMask = [.width]
         textView.allowsUndo = true
         
         textView.textColor = NSColor.darkGray
         textView.font = NSFont(name: "Avenir", size: 12.0)
         textView.backgroundColor = NSColor.init(red: 1.00000, green: 1.00000, blue: 1.00000, alpha: 1.00000)
         
         scrollView.documentView = textView
         self.view = scrollView
     }
     
     override func viewDidAppear() {
         self.view.window?.makeFirstResponder(self.view) // vill inte att den ska focus på textViewen så fort den visas upp på en sida
     }
 }
                                                    */
 /* 2. a LIGHTMODE Representable */
 /*struct LightModeHStackEditorControllerView: NSViewControllerRepresentable {
     @Binding var text: String
     
     func makeCoordinator() -> Coordinator {
         return Coordinator(self)
     }
     
     class Coordinator: NSObject, NSTextStorageDelegate
     {
         private var parent: LightModeHStackEditorControllerView
         var shouldUpdateText = true
         
         init(_ parent: LightModeHStackEditorControllerView) {
             self.parent = parent
         }
         
         func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
             guard shouldUpdateText else {
                 return
             }
             let edited = textStorage.attributedSubstring(from: editedRange).string
             let insertIndex = parent.text.utf16.index(parent.text.utf16.startIndex, offsetBy: editedRange.lowerBound)
             
             func numberOfCharactersToDelete() -> Int {
                 editedRange.length - delta
             }
             
             let endIndex = parent.text.utf16.index(insertIndex, offsetBy: numberOfCharactersToDelete())
             self.parent.text.replaceSubrange(insertIndex..<endIndex, with: edited)
         }
     }
     
     func makeNSViewController(context: Context) -> LightModeHStackEditorController {
         let vc = LightModeHStackEditorController()
         vc.textView.textStorage?.delegate = context.coordinator
         return vc
     }
     
     func updateNSViewController(_ nsViewController: LightModeHStackEditorController, context: Context) {
         if text != nsViewController.textView.string {
             context.coordinator.shouldUpdateText = false
             nsViewController.textView.string = text
             context.coordinator.shouldUpdateText = true
         }
     }
 }
  */


 // MARK: – Hide scroller of NSScrollView (i.e. hide the scrollen för TextEditorn)

 /** Användsning:
              LightModeHStackEditorControllerView(text: $AddOneTaskWithTaskName)
                 .onNSView(
                     added: { nsview in
                         let root = nsview.subviews[0] as! NSScrollView
                         root.hasVerticalScroller = true
                         root.hasHorizontalScroller = false
                     }
                 )
  */

 extension View {
     func onNSView(added: @escaping (NSView) -> Void) -> some View {
         NSViewAccessor(onNSViewAdded: added) { self }
     }
 }

 struct NSViewAccessor<Content>: NSViewRepresentable where Content: View {
     var onNSView: (NSView) -> Void
     var viewBuilder: () -> Content
     
     init(onNSViewAdded: @escaping (NSView) -> Void, @ViewBuilder viewBuilder: @escaping () -> Content) {
         self.onNSView = onNSViewAdded
         self.viewBuilder = viewBuilder
     }
     
     func makeNSView(context: Context) -> NSViewAccessorHosting<Content> {
         return NSViewAccessorHosting(onNSView: onNSView, rootView: self.viewBuilder())
     }
     
     func updateNSView(_ nsView: NSViewAccessorHosting<Content>, context: Context) {
         nsView.rootView = self.viewBuilder()
     }
 }

 class NSViewAccessorHosting<Content>: NSHostingView<Content> where Content : View
 {
     var onNSView: ((NSView) -> Void)
     
     init(onNSView: @escaping (NSView) -> Void, rootView: Content) {
         self.onNSView = onNSView
         super.init(rootView: rootView)
     }
     
     @objc required dynamic init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     required init(rootView: Content) {
         fatalError("init(rootView:) has not been implemented")
     }
     
     override func didAddSubview(_ subview: NSView) {
         super.didAddSubview(subview)
         onNSView(subview)
     }
 }

 // MARK: – ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️

 // MARK: – ContentView_Previews

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }

 
 
 */
