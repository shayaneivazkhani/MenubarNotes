//
//  AppState.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import SwiftUI

/** Handels Global State of the app */
class AppState: ObservableObject {
// MARK: – Att ha Koll på vilken ACTIVE Nuvarande/CURRENT Version/build av menubar Notes USERS har laddat ner ・・・・・・・・・
    
    /// Current Active Build That uploaded to App Store
    @AppStorage("menubarNotesCurrent_AppStore_Versions_Build_NUMBER") var menubarNotesCurrent_AppStore_Versions_Build_NUMBER: Int = 0
    
   // Semantic versioning:  CATEGORY.SUBCATEGORY.PATCH  i.e.  Major.Minor.Patch
   /// Text("Version \(menubarNotesCurrent_Versions_Build_CATEGORY).\(menubarNotesCurrent_Versions_Build_SUBCATEGORY).\(menubarNotesCurrent_Versions_Build_PATCH)")
    @AppStorage("menubarNotesCurrent_Versions_Build_CATEGORY") var menubarNotesCurrent_Versions_Build_CATEGORY: Int = 0
    @AppStorage("menubarNotesCurrent_Versions_Build_SUBCATEGORY") var menubarNotesCurrent_Versions_Build_SUBCATEGORY: Int = 0
    @AppStorage("menubarNotesCurrent_Versions_Build_PATCH") var menubarNotesCurrent_Versions_Build_PATCH: Int = 0

    // Date-based versioning: YYYY-MM-DD
    /// Text("Version \(menubarNotesCurrent_Versions_Build_YEAR)-\(menubarNotesCurrent_Versions_Build_MONTH)-\(menubarNotesCurrent_Versions_Build_DAY)")
    @AppStorage("menubarNotesCurrent_Versions_Build_YEAR") var menubarNotesCurrent_Versions_Build_YEAR: Int = 0
    @AppStorage("menubarNotesCurrent_Versions_Build_MONTH") var menubarNotesCurrent_Versions_Build_MONTH: Int = 0
    @AppStorage("menubarNotesCurrent_Versions_Build_DAY") var menubarNotesCurrent_Versions_Build_DAY: Int = 0
    
// MARK: – för din egna debugging av appen ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    /*@Published var app_DEBUG_MODE: Bool = false  // ❗️SET to true if Debugging
    
    @Published var debug_window_print_debugging: String = ""
    @Published var debug_window_print_debuggingSORTED: String = ""
    @Published var debug_window_attention: String = ""
    @Published var debug_window_attentionSORTED: String = ""
    */
    
     func popoverDidDetach(_ popover: NSPopover) {
         
     }
    
// MARK: – För att meddela i ContentView() att USER har detached the popovern och därför har functionen Appdelegate om att ifall USER klickar utanför Popover() då ska man vänta med att stänga Popovern
            
    @Published var popOverHasBeenDetachedByUser: Bool = false
    
// MARK: – För att meddela i Appdelegate om att ifall USER klickar utanför Popover() då ska man vänta med att stänga Popovern
        
    @Published var someSheetIsActiveWaitingForUserActionToCloseSheet: Bool = false
    
// MARK: – Justera RichTextEditorns FocusState ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Published var textEditorJustOpenedAndBecameFocused: Bool = false
    
// MARK: – Texten som används av RichTextEditorn ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Published var textt = NSAttributedString(string: "") // Själva RichTexten som visas i 2Editor pagen
    @Published var textt_str = NSAttributedString(string: "")
    
    /*
     var shareText: String {
             get { textt.string }
             set { textt.string = newValue }
         }
     */
    
    @Published var userHasMadeSelectionPrepareEditorForSelectResett: Bool = false
    
    @Published var anyNewChanges: Bool = false
    @Published var anyNewChangesInOnlyTextColor: Bool = false
    
    @Published var currentNoteIsNew: Bool = false
    @Published var wasNoteHavingTextBeforeOpeningTextEditorButIsNowEmptyBeforeExiting: Bool = false
    
// MARK: – För att ha koll på att ifall någon av knapparna CUT,COPY & PASTE körs så att .onChange {} på ändring av fontName inte gör något
    
    //@Published var cutOrCopyButtonIsCurrentlyActive: Bool = false //sharedAppState.cutOrCopyButtonIsCurrentlyActive = true
    @Published var someActionInChangingRichTextEditorsTextIsActive: Bool = false // whenever this is active then wait and dont do shit
    //sharedAppState.someActionInChangingRichTextEditorsTextIsActive = true
    
// MARK: – För att trigga igång RichTextEditorns check av foregroundColor, underlineColor och strikethroughColor är korrekt・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    //@Published var triggerColorCheckuppInRichTextEditor: Bool = false
    
// MARK: – För att trigga igång RichTextEditorns check av textt.string.hasSuffix(" \n")・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Published var triggerTextHasSuffixCheckuppInRichTextEditor: Bool = false

// MARK: – För att trigga igång RichTextEditorns check av textt .foregroundColor ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
    //@Published var triggerTextForegroundColorCheckuppInRichTextEditor: Bool = false
    
// MARK: – För att meddela ContentView add man har addat en task så att .onChange {} listener automatiskt öppnar EditorPagen med den texten som precis hade addats
    
    @Published var addedOneTask: Bool = false
    
// MARK: – För att meddela ContentView add man har addat en "\n" till sharedAppState.textt i .onChange {} listener på RichTextEditorn ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Published var added_NEWLINE_CHAR: Bool = false
    @Published var textt_str_NEWLINE_CHAR = NSAttributedString(string: "")
    
    
// MARK: – Texten som används av RichTextEditorn ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Published var preview_textt = NSAttributedString(string: "") 
    @Published var preview_noteID = 0
    @Published var preview_noteBelongsToPage = 0
    
//  MARK: – Global Bool for giving USER a NOTIFICATION if he or she does something wrong ・・・・・・・・・
    
    @AppStorage("showToast") var showToast = false
    
//  MARK: – For dark/light mode ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @AppStorage("DarkLight") var darkMode: Bool = false
    var dummy_darkMode: Bool = false
    
//  MARK: – Global Text variable for editing RichText notes ・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
    @AppStorage("richTextInitialize") var richTextInitialize: String = "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGuCwwVGSAqKyw0Nz9AQ0ZVJG51bGzUDQ4PEBESExRYTlNTdHJpbmdaTlNEZWxlZ2F0ZVxOU0F0dHJpYnV0ZXNWJGNsYXNzgAKAAIAEgA3SEBYXGFlOUy5zdHJpbmeAA1Eg0hobHB1aJGNsYXNzbmFtZVgkY2xhc3Nlc18QD05TTXV0YWJsZVN0cmluZ6McHh9YTlNTdHJpbmdYTlNPYmplY3TTISIQIyYpV05TLmtleXNaTlMub2JqZWN0c6IkJYAFgAaiJyiAB4AJgAxfEBBOU1BhcmFncmFwaFN0eWxlVk5TRm9udNQtLi8QEjEyM1pOU1RhYlN0b3BzW05TQWxpZ25tZW50XxAfTlNBbGxvd3NUaWdodGVuaW5nRm9yVHJ1bmNhdGlvboAAEAQQAYAI0hobNTZfEBBOU1BhcmFncmFwaFN0eWxlojUf1Dg5OhA7PD0+Vk5TU2l6ZVhOU2ZGbGFnc1ZOU05hbWUjQCoAAAAAAAAQEIAKgAtbQXZlbmlyLUJvb2vSGhtBQlZOU0ZvbnSiQR/SGhtERVxOU0RpY3Rpb25hcnmiRB/SGhtHSF1OU1RleHRTdG9yYWdlpElKSx9dTlNUZXh0U3RvcmFnZV8QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmdfEBJOU0F0dHJpYnV0ZWRTdHJpbmcACAARABoAJAApADIANwBJAEwAUQBTAGIAaABxAHoAhQCSAJkAmwCdAJ8AoQCmALAAsgC0ALkAxADNAN8A4wDsAPUA/AEEAQ8BEgEUARYBGQEbAR0BHwEyATkBQgFNAVkBewF9AX8BgQGDAYgBmwGeAacBrgG3Ab4BxwHJAcsBzQHZAd4B5QHoAe0B+gH9AgICEAIVAiMCPwAAAAAAAAIBAAAAAAAAAEwAAAAAAAAAAAAAAAAAAAJU"
    
    /*
    // Darkmode Avenir size 12
    @AppStorage("richTextInitializeDarkModeSpaceCharThenNewLineChar") var richTextInitializeDarkModeSpaceCharThenNewLineChar: String = "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"
    
    // Lightmode Avenir size 12
    @AppStorage("richTextInitializeLightModeSpaceCharThenNewLineChar") var richTextInitializeLightModeSpaceCharThenNewLineChar: String = "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"
    */
    @AppStorage("richTextInitializeDarkModeSpaceCharThenNewLineChar") var richTextInitializeDarkModeSpaceCharThenNewLineChar: String = ""
    @AppStorage("richTextInitializeLightModeSpaceCharThenNewLineChar") var richTextInitializeLightModeSpaceCharThenNewLineChar: String = ""
    
//  MARK: – TODO : kanske flytta hit alla Global Text variable for editing notes・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
/***
     CurrentItemID = p1TaskItem.id  //  MARK: – 🩸 WTF har du 2 st
     TaskNameText = p1TaskItem.taskNAME
     TaskDescriptionText = p1TaskItem.taskDESCRIPTION
     TaskDate = p1TaskItem.taskDate
     let priority = p1TaskItem.taskPriority
     TaskPriority = priority
     pickedPriority = priority
     
     MDmode = false
     showListofTasksIfTrueElseTwoEditors(false)
     
     resetEditModeValuesAndCountTasksFor(page: 1)
*/
    
//  MARK: – Editmode USER have choosen at least one note so that REMOVE and MOVE buttons should be activated・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @AppStorage("choosenAtleastOneNote") var choosenAtleastOneNote: Int = 0
    
//  MARK: – AppStorage section för att behålla page view values/settings i USERDEFAULTS istället för Realm・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
        
    //•••• PAGE 1

        @AppStorage("p1ViewSettings_Showing") var p1ViewSettings_Showing: Bool = false
        @AppStorage("p1ViewSettings_ShowingAndSortedIfTrueElseShowing") var p1ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
        @AppStorage("p1ViewSettings_Sorted") var p1ViewSettings_Sorted: Bool = false

        @AppStorage("p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") var p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
        @AppStorage("p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") var p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
        @AppStorage("p1ViewSettings_ShowCONTAINSTaskName") var p1ViewSettings_ShowCONTAINSTaskName: String = ""
        @AppStorage("p1ViewSettings_ShowCONTAINSTaskDescription") var p1ViewSettings_ShowCONTAINSTaskDescription: String = ""
        @AppStorage("p1ViewSettings_helpWithShowCONTAINS") var p1ViewSettings_helpWithShowCONTAINS: String = ""

        @AppStorage("p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") var p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
        @AppStorage("p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask") var p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
        @AppStorage("p1ViewSettings_thereIsItemsInCallFromShowButton") var p1ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

        @AppStorage("p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") var p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
        @AppStorage("p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") var p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
        @AppStorage("p1ViewSettings_SortByIncreasing") var p1ViewSettings_SortByIncreasing: Bool = false

        @AppStorage("p1ViewSettings_ShowSortRequirementAfterUnshow") var p1ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
        @AppStorage("p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") var p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
        @AppStorage("p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") var p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false

    //•••• PAGE 2

        @AppStorage("p2ViewSettings_Showing") var p2ViewSettings_Showing: Bool = false
        @AppStorage("p2ViewSettings_ShowingAndSortedIfTrueElseShowing") var p2ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
        @AppStorage("p2ViewSettings_Sorted") var p2ViewSettings_Sorted: Bool = false

        @AppStorage("p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") var p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
        @AppStorage("p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") var p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
        @AppStorage("p2ViewSettings_ShowCONTAINSTaskName") var p2ViewSettings_ShowCONTAINSTaskName: String = ""
        @AppStorage("p2ViewSettings_ShowCONTAINSTaskDescription") var p2ViewSettings_ShowCONTAINSTaskDescription: String = ""
        @AppStorage("p2ViewSettings_helpWithShowCONTAINS") var p2ViewSettings_helpWithShowCONTAINS: String = ""

        @AppStorage("p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") var p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
        @AppStorage("p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask") var p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
        @AppStorage("p2ViewSettings_thereIsItemsInCallFromShowButton") var p2ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

        @AppStorage("p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") var p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
        @AppStorage("p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") var p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
        @AppStorage("p2ViewSettings_SortByIncreasing") var p2ViewSettings_SortByIncreasing: Bool = false

        @AppStorage("p2ViewSettings_ShowSortRequirementAfterUnshow") var p2ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
        @AppStorage("p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") var p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
        @AppStorage("p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") var p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false

    //•••• PAGE 3

        @AppStorage("p3ViewSettings_Showing") var p3ViewSettings_Showing: Bool = false
        @AppStorage("p3ViewSettings_ShowingAndSortedIfTrueElseShowing") var p3ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
        @AppStorage("p3ViewSettings_Sorted") var p3ViewSettings_Sorted: Bool = false

        @AppStorage("p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") var p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
        @AppStorage("p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") var p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
        @AppStorage("p3ViewSettings_ShowCONTAINSTaskName") var p3ViewSettings_ShowCONTAINSTaskName: String = ""
        @AppStorage("p3ViewSettings_ShowCONTAINSTaskDescription") var p3ViewSettings_ShowCONTAINSTaskDescription: String = ""
        @AppStorage("p3ViewSettings_helpWithShowCONTAINS") var p3ViewSettings_helpWithShowCONTAINS: String = ""

        @AppStorage("p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") var p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
        @AppStorage("p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask") var p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
        @AppStorage("p3ViewSettings_thereIsItemsInCallFromShowButton") var p3ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

        @AppStorage("p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") var p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
        @AppStorage("p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") var p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
        @AppStorage("p3ViewSettings_SortByIncreasing") var p3ViewSettings_SortByIncreasing: Bool = false

        @AppStorage("p3ViewSettings_ShowSortRequirementAfterUnshow") var p3ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
        @AppStorage("p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") var p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
        @AppStorage("p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") var p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false

    //•••• PAGE 4

        @AppStorage("p4ViewSettings_Showing") var p4ViewSettings_Showing: Bool = false
        @AppStorage("p4ViewSettings_ShowingAndSortedIfTrueElseShowing") var p4ViewSettings_ShowingAndSortedIfTrueElseShowing: Bool = false
        @AppStorage("p4ViewSettings_Sorted") var p4ViewSettings_Sorted: Bool = false

        @AppStorage("p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint") var p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint: String = ""
        @AppStorage("p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint") var p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
        @AppStorage("p4ViewSettings_ShowCONTAINSTaskName") var p4ViewSettings_ShowCONTAINSTaskName: String = ""
        @AppStorage("p4ViewSettings_ShowCONTAINSTaskDescription") var p4ViewSettings_ShowCONTAINSTaskDescription: String = ""
        @AppStorage("p4ViewSettings_helpWithShowCONTAINS") var p4ViewSettings_helpWithShowCONTAINS: String = ""

        @AppStorage("p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription") var p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = false
        @AppStorage("p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask") var p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask: Bool = false
        @AppStorage("p4ViewSettings_thereIsItemsInCallFromShowButton") var p4ViewSettings_thereIsItemsInCallFromShowButton: Bool = false

        @AppStorage("p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority") var p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority: Bool = false
        @AppStorage("p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing") var p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = false
        @AppStorage("p4ViewSettings_SortByIncreasing") var p4ViewSettings_SortByIncreasing: Bool = false

        @AppStorage("p4ViewSettings_ShowSortRequirementAfterUnshow") var p4ViewSettings_ShowSortRequirementAfterUnshow: Bool = false
        @AppStorage("p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority") var p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = false
        @AppStorage("p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") var p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = false
       

        
// MARK: – For rendering different pages when navigating  ・・・・・・・・・・・・・・・・・・・・・・・・・
    
    /*
         Page 0: StartPage (Tasks with their BelongsToPage == 0 is not Tasks for any page)
         Page 1: IMP and URG
         Page 2: IMP
         Page 3: URG
         Page 4: NOTHING
    */
        // används för navigation för PopOverController – currentPopoverPage when app is launched__ currentPopoverPage ska vara == 1 
    @AppStorage("currentPopoverPage") var currentPopoverPage: Int = 0
        
        // används för att call rätt functions för olika sidor 1–4
    @AppStorage("isOnPage") var isOnPage: Int = 0
        
        @AppStorage("p0StarterPageWith4Buttons") var p0StarterPageWith4Buttons: Bool = true
            @AppStorage("p1showPageIMPandURGPopUp")  var p1showPageIMPandURGPopUp: Bool = false
            @AppStorage("p2showPageIMPPopUp") var p2showPageIMPPopUp: Bool = false
            @AppStorage("p3showPageURGPopUp") var p3showPageURGPopUp: Bool = false
            @AppStorage("p4showPageNOTHINGPopUp") var p4showPageNOTHINGPopUp: Bool = false
    
// MARK: – For Keeping Count of How Many Items There is on Different Pages ・・・・・・・・・・・・・・・
    
    @AppStorage("isThereAnyItem") var isThereAnyItem: Bool = false
    @AppStorage("isThereMoreThanOneItem") var isThereMoreThanOneItem: Bool = false
        
        @AppStorage("isThereAnyIMPandURGItem") var isThereAnyIMPandURGItem: Bool = false
        @AppStorage("isThereMoreThanOneIMPandURGItem") var isThereMoreThanOneIMPandURGItem: Bool = false
        
        @AppStorage("isThereAnyIMPItem") var isThereAnyIMPItem: Bool = false
        @AppStorage("isThereMoreThanOneIMPItem") var isThereMoreThanOneIMPItem: Bool = false
        
        @AppStorage("isThereAnyURGItem")  var isThereAnyURGItem: Bool = false
        @AppStorage("isThereMoreThanOneURGItem")  var isThereMoreThanOneURGItem: Bool =  false
        
        @AppStorage("isThereAnyNOTHINGItem")  var isThereAnyNOTHINGItem: Bool = false
        @AppStorage("isThereMoreThanOneNOTHINGItem")  var isThereMoreThanOneNOTHINGItem: Bool = false
            
/* MARK: 💥・・・・・・・・・・・・・・・・・・・・・・・・・・🎾For Enabling Editmode (i.e. delete list items) different pages🎾 ・・・・・・・・・・・・・・・・・・・・・・・・・・💥*/
        
// MARK: – ❗️⭐️❗️ För EditMode
/*
         OBS❗️– när EditMode != true -> Sorted och Showing bestämmer vad som ska visas
         OBS❗️– när EditMode == true -> MoveMode, SortMode och ShowMode bestämmer vad som ska visas
    */
        @AppStorage("EditMode")  var EditMode: Bool = false
        
        
        
// MARK: – ⭐️ För AddMode och det som visas för Add Task with a Task Name
        @AppStorage("AddMode") var AddMode: Bool = false
        @AppStorage("AddOneTaskWithTaskName") var AddOneTaskWithTaskName: String = ""
        @AppStorage("AddItemWithTaskNameFilterResultTextHint") var AddItemWithTaskNameFilterResultTextHint: String = " add with name"
        
        @AppStorage("substitoto") var substitoto: String = ""
        
        
        
// MARK: – ⭐️ För det som visas när EditMode == true men (MoveModee == false) && (SortMode == false) && (ShowMode == false) {
        @AppStorage("DeleteMode") var DeleteMode: Bool = false
        @AppStorage("rmALLPageMode") var rmALLPageMode: Bool = false
        
// MARK: – ⭐️ För Show Picker
        @AppStorage("MoveMode") var MoveMode: Bool = false
        @Published var pages = ["Important", "Useful", "Urgent", "Other"]
        @AppStorage("toPage") var toPage: Int = 0
        
        
        
// MARK: – ⭐️ För Show
        @AppStorage("ShowMode") var ShowMode: Bool = false
        
        @AppStorage("ShowTextFieldTaskNameFilterResultTextHint") var ShowTextFieldTaskNameFilterResultTextHint: String = ""
        @AppStorage("ShowTextFieldTaskDescriptionFilterResultTextHint") var ShowTextFieldTaskDescriptionFilterResultTextHint: String = ""
        @AppStorage("ShowCONTAINSTaskName") var ShowCONTAINSTaskName: String = ""
        @AppStorage("ShowCONTAINSTaskDescription") var ShowCONTAINSTaskDescription: String = ""
        @AppStorage("helpWithShowCONTAINS") var helpWithShowCONTAINS: String = ""
        
        @AppStorage("ShowRequirementOptions") var ShowRequirementOptions: Bool = true
        
        // if true då visas TextField("\(ShowTextFieldTaskNameFilterResultTextHint)", text: $ShowCONTAINSTaskName), if false då visas TextField("\(ShowTextFieldTaskDescriptionFilterResultTextHint)", text: $ShowCONTAINSTaskDescription) – i if !($ShowRequirementOptions.wrappedValue) { – i if $ShowMode.wrappedValue && !($MoveMode.wrappedValue) && !($SortMode.wrappedValue) { – i if $isThereMoreThanOneIMPandURGItem.wrappedValue { – i if $EditMode.wrappedValue {
        @AppStorage("ShowShowBarForTaskNameIfTrueElseTaskDescription") var ShowShowBarForTaskNameIfTrueElseTaskDescription: Bool = true
        @AppStorage("uselessButUsedinShowItemsAfterSavingTask") var uselessButUsedinShowItemsAfterSavingTask: Bool = false
        @AppStorage("thereIsItemsInCallFromShowButton") var thereIsItemsInCallFromShowButton: Bool = false // ❗️används i if $ShowMode.wrappedValue && !($SortMode.wrappedValue) { / Button("Show")
        
        
        
// MARK: – ⭐️ För Sort
        @AppStorage("SortMode") var SortMode: Bool = false // if true -> ist för trash och + button så öppnas Sort alternativen
        @AppStorage("SortRequirementOptions") var SortRequirementOptions: Bool = true // ska alltid bli assignad till true så att antingen sort By Date knappen / Sort by Priority ska öppnas/visas
        
        @AppStorage("TasksIsSortedbyDateIfTrueElsePriority") var TasksIsSortedbyDateIfTrueElsePriority: Bool = true // ❗️
        @AppStorage("TasksIsSortedIncreasingIfTrueElseDecreasing") var TasksIsSortedIncreasingIfTrueElseDecreasing: Bool = true // ❗️
        @AppStorage("SortByIncreasing") var SortByIncreasing: Bool = false // ❗️if true -> då ska du call the apropiate sort från RealmManager when you edit (add/delete) tasks, och även när du öppnar upp en task item och SAVE den så listan ska vara sorterad på det sättet som det var innan man clicked på¨en item och editor sidan öppnades, ❗️if == false då är listan sorterad dec
        
        
        
// MARK: – ⭐️ För Sort fast dock efter att vi har använt SHOW på listan
        @AppStorage("ShowFilterAndSortMode") var ShowFilterAndSortMode: Bool = false // if true -> då är vi i if !($EditMode.wrappedValue) { ––› if $Showing.wrappedValue && !($Sorted.wrappedValue) {
        @AppStorage("showBackButtonForSortinShowingAndSortedIfTrue") var showBackButtonForSortinShowingAndSortedIfTrue: Bool = false // används för att dölja Unshow knappen i översta HStacken på listan av task itemsen för att annars det finns ej så mycket plats för Sort Options att visas
        
        @AppStorage("ShowSortRequirementAfterUnshow") var ShowSortRequirementAfterUnshow: Bool = true // if true -> då visas det upp Date/Priority ist för inc/dec i if $Showing.wrappedValue && !($Sorted.wrappedValue) { – i if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) { – i if $isThereMoreThanOneIMPandURGItem.wrappedValue { – i if $ShowFilterAndSortMode.wrappedValue {
        
        
        
// MARK: – ⭐️ För Move fast dock efter att vi har använt Show&Filter på listan
        @AppStorage("showMoveAfterShowFilterAndSortMode") var showMoveAfterShowFilterAndSortMode: Bool = true
        
        
        
// MARK: – ❗️⭐️❗️ For setting the standard-view-of-items/SHOW/SORT of the list of Items ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        @AppStorage("Showing") var Showing: Bool = false // ❗️if true -> listan är filtrerad/Showing och visar vissa Items containing a String
            @AppStorage("ShowingAndSortedIfTrueElseShowing") var ShowingAndSortedIfTrueElseShowing: Bool = false // ❗️if true -> listan är både filtrerad/Showing och sorterad, if false -> listan är endast Filtrerad/Showing
                @AppStorage("ShowSortByDateAfterUnshowButtonIfTrueElsePriority") var ShowSortByDateAfterUnshowButtonIfTrueElsePriority: Bool = true // ❗️if true -> då kommer vi att använda realmManager.FilterAndSort() snart för att sortera det vi Filtrerade/Show baserad på Task Itemens Datum
                @AppStorage("ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing") var ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing: Bool = true // ❗️if true -> då har vi använt realmManager.FilterAndSort() och sorterat det vi Filtrerade/Show sedan innan enligt en Increasing
        @AppStorage("Sorted") var Sorted: Bool = false  // ❗️if true -> listan är sorterad endast filtrerad/Showing
    
    
// MARK: – some conditional views ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        //__för sidorna med text på
    @AppStorage("isOn") var isOn: Bool = false
    @AppStorage("isPresented") var isPresented: Bool = false
        //__ för $var som du måste ange som parametern till struct constructorn för SimpleButton
    @AppStorage("dummy1") var dummy1: Bool = true
    
// MARK:  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    init() {
        menubarNotesCurrent_AppStore_Versions_Build_NUMBER = 44
        
        menubarNotesCurrent_Versions_Build_CATEGORY = 5
        menubarNotesCurrent_Versions_Build_SUBCATEGORY = 0
        menubarNotesCurrent_Versions_Build_PATCH = 2

        menubarNotesCurrent_Versions_Build_YEAR = 2025
        menubarNotesCurrent_Versions_Build_MONTH = 8
        menubarNotesCurrent_Versions_Build_DAY = 8
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        showToast = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        darkMode = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        richTextInitialize = "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGuCwwVGSAqKyw0Nz9AQ0ZVJG51bGzUDQ4PEBESExRYTlNTdHJpbmdaTlNEZWxlZ2F0ZVxOU0F0dHJpYnV0ZXNWJGNsYXNzgAKAAIAEgA3SEBYXGFlOUy5zdHJpbmeAA1Eg0hobHB1aJGNsYXNzbmFtZVgkY2xhc3Nlc18QD05TTXV0YWJsZVN0cmluZ6McHh9YTlNTdHJpbmdYTlNPYmplY3TTISIQIyYpV05TLmtleXNaTlMub2JqZWN0c6IkJYAFgAaiJyiAB4AJgAxfEBBOU1BhcmFncmFwaFN0eWxlVk5TRm9udNQtLi8QEjEyM1pOU1RhYlN0b3BzW05TQWxpZ25tZW50XxAfTlNBbGxvd3NUaWdodGVuaW5nRm9yVHJ1bmNhdGlvboAAEAQQAYAI0hobNTZfEBBOU1BhcmFncmFwaFN0eWxlojUf1Dg5OhA7PD0+Vk5TU2l6ZVhOU2ZGbGFnc1ZOU05hbWUjQCoAAAAAAAAQEIAKgAtbQXZlbmlyLUJvb2vSGhtBQlZOU0ZvbnSiQR/SGhtERVxOU0RpY3Rpb25hcnmiRB/SGhtHSF1OU1RleHRTdG9yYWdlpElKSx9dTlNUZXh0U3RvcmFnZV8QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmdfEBJOU0F0dHJpYnV0ZWRTdHJpbmcACAARABoAJAApADIANwBJAEwAUQBTAGIAaABxAHoAhQCSAJkAmwCdAJ8AoQCmALAAsgC0ALkAxADNAN8A4wDsAPUA/AEEAQ8BEgEUARYBGQEbAR0BHwEyATkBQgFNAVkBewF9AX8BgQGDAYgBmwGeAacBrgG3Ab4BxwHJAcsBzQHZAd4B5QHoAe0B+gH9AgICEAIVAiMCPwAAAAAAAAIBAAAAAAAAAEwAAAAAAAAAAAAAAAAAAAJU"
        
        /*richTextInitializeDarkModeSpaceCharThenNewLineChar = "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"
        
        richTextInitializeLightModeSpaceCharThenNewLineChar = "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvEBcLDBUZIDAxMjM0NT9FRkpNVVZZYGNoa1UkbnVsbNQNDg8QERITFFhOU1N0cmluZ1pOU0RlbGVnYXRlXE5TQXR0cmlidXRlc1YkY2xhc3OAAoAAgASAFtIQFhcYWU5TLnN0cmluZ4ADVCAgCiDSGhscHVokY2xhc3NuYW1lWCRjbGFzc2VzXxAPTlNNdXRhYmxlU3RyaW5noxweH1hOU1N0cmluZ1hOU09iamVjdNMhIhAjKS9XTlMua2V5c1pOUy5vYmplY3RzpSQlJicogAWABoAHgAiACaUqKyotLoAKgA+ACoASgBSAFV8QFE5TU3RyaWtldGhyb3VnaENvbG9yVk5TRm9udF8QEE5TVW5kZXJsaW5lQ29sb3JfEBBOU1BhcmFncmFwaFN0eWxlV05TQ29sb3LVNjc4ORA6Ozw9PlxOU0NvbXBvbmVudHNVTlNSR0JcTlNDb2xvclNwYWNlXxASTlNDdXN0b21Db2xvclNwYWNlRzEgMCAwIDFPEB0wLjk4NTk1NDE2NTUgMCAwLjAyNjk0MDAwODYzABABgAuADtNAQRBCQ0RUTlNJRFVOU0lDQxAHgAyADU8RDEgAAAxITGlubwIQAABtbnRyUkdCIFhZWiAHzgACAAkABgAxAABhY3NwTVNGVAAAAABJRUMgc1JHQgAAAAAAAAAAAAAAAAAA9tYAAQAAAADTLUhQICAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFjcHJ0AAABUAAAADNkZXNjAAABhAAAAGx3dHB0AAAB8AAAABRia3B0AAACBAAAABRyWFlaAAACGAAAABRnWFlaAAACLAAAABRiWFlaAAACQAAAABRkbW5kAAACVAAAAHBkbWRkAAACxAAAAIh2dWVkAAADTAAAAIZ2aWV3AAAD1AAAACRsdW1pAAAD+AAAABRtZWFzAAAEDAAAACR0ZWNoAAAEMAAAAAxyVFJDAAAEPAAACAxnVFJDAAAEPAAACAxiVFJDAAAEPAAACAx0ZXh0AAAAAENvcHlyaWdodCAoYykgMTk5OCBIZXdsZXR0LVBhY2thcmQgQ29tcGFueQAAZGVzYwAAAAAAAAASc1JHQiBJRUM2MTk2Ni0yLjEAAAAAAAAAAAAAABJzUkdCIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWFlaIAAAAAAAAPNRAAEAAAABFsxYWVogAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z2Rlc2MAAAAAAAAAFklFQyBodHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAFklFQyBodHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZXNjAAAAAAAAAC5JRUMgNjE5NjYtMi4xIERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAtIHNSR0IAAAAAAAAAAAAAAC5JRUMgNjE5NjYtMi4xIERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAtIHNSR0IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZGVzYwAAAAAAAAAsUmVmZXJlbmNlIFZpZXdpbmcgQ29uZGl0aW9uIGluIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAALFJlZmVyZW5jZSBWaWV3aW5nIENvbmRpdGlvbiBpbiBJRUM2MTk2Ni0yLjEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHZpZXcAAAAAABOk/gAUXy4AEM8UAAPtzAAEEwsAA1yeAAAAAVhZWiAAAAAAAEwJVgBQAAAAVx/nbWVhcwAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAo8AAAACc2lnIAAAAABDUlQgY3VydgAAAAAAAAQAAAAABQAKAA8AFAAZAB4AIwAoAC0AMgA3ADsAQABFAEoATwBUAFkAXgBjAGgAbQByAHcAfACBAIYAiwCQAJUAmgCfAKQAqQCuALIAtwC8AMEAxgDLANAA1QDbAOAA5QDrAPAA9gD7AQEBBwENARMBGQEfASUBKwEyATgBPgFFAUwBUgFZAWABZwFuAXUBfAGDAYsBkgGaAaEBqQGxAbkBwQHJAdEB2QHhAekB8gH6AgMCDAIUAh0CJgIvAjgCQQJLAlQCXQJnAnECegKEAo4CmAKiAqwCtgLBAssC1QLgAusC9QMAAwsDFgMhAy0DOANDA08DWgNmA3IDfgOKA5YDogOuA7oDxwPTA+AD7AP5BAYEEwQgBC0EOwRIBFUEYwRxBH4EjASaBKgEtgTEBNME4QTwBP4FDQUcBSsFOgVJBVgFZwV3BYYFlgWmBbUFxQXVBeUF9gYGBhYGJwY3BkgGWQZqBnsGjAadBq8GwAbRBuMG9QcHBxkHKwc9B08HYQd0B4YHmQesB78H0gflB/gICwgfCDIIRghaCG4IggiWCKoIvgjSCOcI+wkQCSUJOglPCWQJeQmPCaQJugnPCeUJ+woRCicKPQpUCmoKgQqYCq4KxQrcCvMLCwsiCzkLUQtpC4ALmAuwC8gL4Qv5DBIMKgxDDFwMdQyODKcMwAzZDPMNDQ0mDUANWg10DY4NqQ3DDd4N+A4TDi4OSQ5kDn8Omw62DtIO7g8JDyUPQQ9eD3oPlg+zD88P7BAJECYQQxBhEH4QmxC5ENcQ9RETETERTxFtEYwRqhHJEegSBxImEkUSZBKEEqMSwxLjEwMTIxNDE2MTgxOkE8UT5RQGFCcUSRRqFIsUrRTOFPAVEhU0FVYVeBWbFb0V4BYDFiYWSRZsFo8WshbWFvoXHRdBF2UXiReuF9IX9xgbGEAYZRiKGK8Y1Rj6GSAZRRlrGZEZtxndGgQaKhpRGncanhrFGuwbFBs7G2MbihuyG9ocAhwqHFIcexyjHMwc9R0eHUcdcB2ZHcMd7B4WHkAeah6UHr4e6R8THz4faR+UH78f6iAVIEEgbCCYIMQg8CEcIUghdSGhIc4h+yInIlUigiKvIt0jCiM4I2YjlCPCI/AkHyRNJHwkqyTaJQklOCVoJZclxyX3JicmVyaHJrcm6CcYJ0kneierJ9woDSg/KHEooijUKQYpOClrKZ0p0CoCKjUqaCqbKs8rAis2K2krnSvRLAUsOSxuLKIs1y0MLUEtdi2rLeEuFi5MLoIuty7uLyQvWi+RL8cv/jA1MGwwpDDbMRIxSjGCMbox8jIqMmMymzLUMw0zRjN/M7gz8TQrNGU0njTYNRM1TTWHNcI1/TY3NnI2rjbpNyQ3YDecN9c4FDhQOIw4yDkFOUI5fzm8Ofk6Njp0OrI67zstO2s7qjvoPCc8ZTykPOM9Ij1hPaE94D4gPmA+oD7gPyE/YT+iP+JAI0BkQKZA50EpQWpBrEHuQjBCckK1QvdDOkN9Q8BEA0RHRIpEzkUSRVVFmkXeRiJGZ0arRvBHNUd7R8BIBUhLSJFI10kdSWNJqUnwSjdKfUrESwxLU0uaS+JMKkxyTLpNAk1KTZNN3E4lTm5Ot08AT0lPk0/dUCdQcVC7UQZRUFGbUeZSMVJ8UsdTE1NfU6pT9lRCVI9U21UoVXVVwlYPVlxWqVb3V0RXklfgWC9YfVjLWRpZaVm4WgdaVlqmWvVbRVuVW+VcNVyGXNZdJ114XcleGl5sXr1fD19hX7NgBWBXYKpg/GFPYaJh9WJJYpxi8GNDY5dj62RAZJRk6WU9ZZJl52Y9ZpJm6Gc9Z5Nn6Wg/aJZo7GlDaZpp8WpIap9q92tPa6dr/2xXbK9tCG1gbbluEm5rbsRvHm94b9FwK3CGcOBxOnGVcfByS3KmcwFzXXO4dBR0cHTMdSh1hXXhdj52m3b4d1Z3s3gReG54zHkqeYl553pGeqV7BHtje8J8IXyBfOF9QX2hfgF+Yn7CfyN/hH/lgEeAqIEKgWuBzYIwgpKC9INXg7qEHYSAhOOFR4Wrhg6GcobXhzuHn4gEiGmIzokziZmJ/opkisqLMIuWi/yMY4zKjTGNmI3/jmaOzo82j56QBpBukNaRP5GokhGSepLjk02TtpQglIqU9JVflcmWNJaflwqXdZfgmEyYuJkkmZCZ/JpomtWbQpuvnByciZz3nWSd0p5Anq6fHZ+Ln/qgaaDYoUehtqImopajBqN2o+akVqTHpTilqaYapoum/adup+CoUqjEqTepqaocqo+rAqt1q+msXKzQrUStuK4trqGvFq+LsACwdbDqsWCx1rJLssKzOLOutCW0nLUTtYq2AbZ5tvC3aLfguFm40blKucK6O7q1uy67p7whvJu9Fb2Pvgq+hL7/v3q/9cBwwOzBZ8Hjwl/C28NYw9TEUcTOxUvFyMZGxsPHQce/yD3IvMk6ybnKOMq3yzbLtsw1zLXNNc21zjbOts83z7jQOdC60TzRvtI/0sHTRNPG1EnUy9VO1dHWVdbY11zX4Nhk2OjZbNnx2nba+9uA3AXcit0Q3ZbeHN6i3ynfr+A24L3hROHM4lPi2+Nj4+vkc+T85YTmDeaW5x/nqegy6LzpRunQ6lvq5etw6/vshu0R7ZzuKO6070DvzPBY8OXxcvH/8ozzGfOn9DT0wvVQ9d72bfb794r4Gfio+Tj5x/pX+uf7d/wH/Jj9Kf26/kv+3P9t///SGhtHSFxOU0NvbG9yU3BhY2WiSR9cTlNDb2xvclNwYWNl0hobS0xXTlNDb2xvcqJLH9ROT1AQUVJTVFZOU1NpemVYTlNmRmxhZ3NWTlNOYW1lI0AoAAAAAAAAEBCAEIARW0F2ZW5pci1Cb29r0hobV1hWTlNGb250olcf1FpbXBASXjxfWk5TVGFiU3RvcHNbTlNBbGlnbm1lbnRfEB9OU0FsbG93c1RpZ2h0ZW5pbmdGb3JUcnVuY2F0aW9ugAAQBIAT0hobYWJfEBBOU1BhcmFncmFwaFN0eWxlomEf1TY3ODkQZGU8PT5HMCAwIDAgMUYwIDAgMACAC4AO0hobaWpcTlNEaWN0aW9uYXJ5omkf0hobbG1dTlNUZXh0U3RvcmFnZaRub3AfXU5TVGV4dFN0b3JhZ2VfEBlOU011dGFibGVBdHRyaWJ1dGVkU3RyaW5nXxASTlNBdHRyaWJ1dGVkU3RyaW5nAAgAEQAaACQAKQAyADcASQBMAFEAUwBtAHMAfACFAJAAnQCkAKYAqACqAKwAsQC7AL0AwgDHANIA2wDtAPEA+gEDAQoBEgEdASMBJQEnASkBKwEtATMBNQE3ATkBOwE9AT8BVgFdAXABgwGLAZYBowGpAbYBywHTAfMB9QH3AfkCAAIFAgsCDQIPAhEOXQ5iDm8Ocg5/DoQOjA6PDpgOnw6oDq8OuA66DrwOvg7KDs8O1g7ZDuIO7Q75DxsPHQ8fDyEPJg85DzwPRw9PD1YPWA9aD18PbA9vD3QPgg+HD5UPsQAAAAAAAAIBAAAAAAAAAHEAAAAAAAAAAAAAAAAAAA/G"
        */
        
        richTextInitializeDarkModeSpaceCharThenNewLineChar = "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvEBcLDBUZIDAxMjM0NT9FRkpNVVZZYGNoa1UkbnVsbNQNDg8QERITFFhOU1N0cmluZ1pOU0RlbGVnYXRlXE5TQXR0cmlidXRlc1YkY2xhc3OAAoAAgASAFtIQFhcYWU5TLnN0cmluZ4ADUyAgCtIaGxwdWiRjbGFzc25hbWVYJGNsYXNzZXNfEA9OU011dGFibGVTdHJpbmejHB4fWE5TU3RyaW5nWE5TT2JqZWN00yEiECMpL1dOUy5rZXlzWk5TLm9iamVjdHOlJCUmJyiABYAGgAeACIAJpSorKi0ugAqAD4AKgBKAFIAVXxAUTlNTdHJpa2V0aHJvdWdoQ29sb3JWTlNGb250XxAQTlNVbmRlcmxpbmVDb2xvcl8QEE5TUGFyYWdyYXBoU3R5bGVXTlNDb2xvctU2Nzg5EDo7PD0+XE5TQ29tcG9uZW50c1VOU1JHQlxOU0NvbG9yU3BhY2VfEBJOU0N1c3RvbUNvbG9yU3BhY2VHMSAwIDAgMU8QHTAuOTg1OTU0MTY1NSAwIDAuMDI2OTQwMDA4NjMAEAGAC4AO00BBEEJDRFROU0lEVU5TSUNDEAeADIANTxEMSAAADEhMaW5vAhAAAG1udHJSR0IgWFlaIAfOAAIACQAGADEAAGFjc3BNU0ZUAAAAAElFQyBzUkdCAAAAAAAAAAAAAAAAAAD21gABAAAAANMtSFAgIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEWNwcnQAAAFQAAAAM2Rlc2MAAAGEAAAAbHd0cHQAAAHwAAAAFGJrcHQAAAIEAAAAFHJYWVoAAAIYAAAAFGdYWVoAAAIsAAAAFGJYWVoAAAJAAAAAFGRtbmQAAAJUAAAAcGRtZGQAAALEAAAAiHZ1ZWQAAANMAAAAhnZpZXcAAAPUAAAAJGx1bWkAAAP4AAAAFG1lYXMAAAQMAAAAJHRlY2gAAAQwAAAADHJUUkMAAAQ8AAAIDGdUUkMAAAQ8AAAIDGJUUkMAAAQ8AAAIDHRleHQAAAAAQ29weXJpZ2h0IChjKSAxOTk4IEhld2xldHQtUGFja2FyZCBDb21wYW55AABkZXNjAAAAAAAAABJzUkdCIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAAEnNSR0IgSUVDNjE5NjYtMi4xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABYWVogAAAAAAAA81EAAQAAAAEWzFhZWiAAAAAAAAAAAAAAAAAAAAAAWFlaIAAAAAAAAG+iAAA49QAAA5BYWVogAAAAAAAAYpkAALeFAAAY2lhZWiAAAAAAAAAkoAAAD4QAALbPZGVzYwAAAAAAAAAWSUVDIGh0dHA6Ly93d3cuaWVjLmNoAAAAAAAAAAAAAAAWSUVDIGh0dHA6Ly93d3cuaWVjLmNoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGRlc2MAAAAAAAAALklFQyA2MTk2Ni0yLjEgRGVmYXVsdCBSR0IgY29sb3VyIHNwYWNlIC0gc1JHQgAAAAAAAAAAAAAALklFQyA2MTk2Ni0yLjEgRGVmYXVsdCBSR0IgY29sb3VyIHNwYWNlIC0gc1JHQgAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZXNjAAAAAAAAACxSZWZlcmVuY2UgVmlld2luZyBDb25kaXRpb24gaW4gSUVDNjE5NjYtMi4xAAAAAAAAAAAAAAAsUmVmZXJlbmNlIFZpZXdpbmcgQ29uZGl0aW9uIGluIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdmlldwAAAAAAE6T+ABRfLgAQzxQAA+3MAAQTCwADXJ4AAAABWFlaIAAAAAAATAlWAFAAAABXH+dtZWFzAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAACjwAAAAJzaWcgAAAAAENSVCBjdXJ2AAAAAAAABAAAAAAFAAoADwAUABkAHgAjACgALQAyADcAOwBAAEUASgBPAFQAWQBeAGMAaABtAHIAdwB8AIEAhgCLAJAAlQCaAJ8ApACpAK4AsgC3ALwAwQDGAMsA0ADVANsA4ADlAOsA8AD2APsBAQEHAQ0BEwEZAR8BJQErATIBOAE+AUUBTAFSAVkBYAFnAW4BdQF8AYMBiwGSAZoBoQGpAbEBuQHBAckB0QHZAeEB6QHyAfoCAwIMAhQCHQImAi8COAJBAksCVAJdAmcCcQJ6AoQCjgKYAqICrAK2AsECywLVAuAC6wL1AwADCwMWAyEDLQM4A0MDTwNaA2YDcgN+A4oDlgOiA64DugPHA9MD4APsA/kEBgQTBCAELQQ7BEgEVQRjBHEEfgSMBJoEqAS2BMQE0wThBPAE/gUNBRwFKwU6BUkFWAVnBXcFhgWWBaYFtQXFBdUF5QX2BgYGFgYnBjcGSAZZBmoGewaMBp0GrwbABtEG4wb1BwcHGQcrBz0HTwdhB3QHhgeZB6wHvwfSB+UH+AgLCB8IMghGCFoIbgiCCJYIqgi+CNII5wj7CRAJJQk6CU8JZAl5CY8JpAm6Cc8J5Qn7ChEKJwo9ClQKagqBCpgKrgrFCtwK8wsLCyILOQtRC2kLgAuYC7ALyAvhC/kMEgwqDEMMXAx1DI4MpwzADNkM8w0NDSYNQA1aDXQNjg2pDcMN3g34DhMOLg5JDmQOfw6bDrYO0g7uDwkPJQ9BD14Peg+WD7MPzw/sEAkQJhBDEGEQfhCbELkQ1xD1ERMRMRFPEW0RjBGqEckR6BIHEiYSRRJkEoQSoxLDEuMTAxMjE0MTYxODE6QTxRPlFAYUJxRJFGoUixStFM4U8BUSFTQVVhV4FZsVvRXgFgMWJhZJFmwWjxayFtYW+hcdF0EXZReJF64X0hf3GBsYQBhlGIoYrxjVGPoZIBlFGWsZkRm3Gd0aBBoqGlEadxqeGsUa7BsUGzsbYxuKG7Ib2hwCHCocUhx7HKMczBz1HR4dRx1wHZkdwx3sHhYeQB5qHpQevh7pHxMfPh9pH5Qfvx/qIBUgQSBsIJggxCDwIRwhSCF1IaEhziH7IiciVSKCIq8i3SMKIzgjZiOUI8Ij8CQfJE0kfCSrJNolCSU4JWgllyXHJfcmJyZXJocmtyboJxgnSSd6J6sn3CgNKD8ocSiiKNQpBik4KWspnSnQKgIqNSpoKpsqzysCKzYraSudK9EsBSw5LG4soizXLQwtQS12Last4S4WLkwugi63Lu4vJC9aL5Evxy/+MDUwbDCkMNsxEjFKMYIxujHyMioyYzKbMtQzDTNGM38zuDPxNCs0ZTSeNNg1EzVNNYc1wjX9Njc2cjauNuk3JDdgN5w31zgUOFA4jDjIOQU5Qjl/Obw5+To2OnQ6sjrvOy07azuqO+g8JzxlPKQ84z0iPWE9oT3gPiA+YD6gPuA/IT9hP6I/4kAjQGRApkDnQSlBakGsQe5CMEJyQrVC90M6Q31DwEQDREdEikTORRJFVUWaRd5GIkZnRqtG8Ec1R3tHwEgFSEtIkUjXSR1JY0mpSfBKN0p9SsRLDEtTS5pL4kwqTHJMuk0CTUpNk03cTiVObk63TwBPSU+TT91QJ1BxULtRBlFQUZtR5lIxUnxSx1MTU19TqlP2VEJUj1TbVShVdVXCVg9WXFapVvdXRFeSV+BYL1h9WMtZGllpWbhaB1pWWqZa9VtFW5Vb5Vw1XIZc1l0nXXhdyV4aXmxevV8PX2Ffs2AFYFdgqmD8YU9homH1YklinGLwY0Njl2PrZEBklGTpZT1lkmXnZj1mkmboZz1nk2fpaD9olmjsaUNpmmnxakhqn2r3a09rp2v/bFdsr20IbWBtuW4SbmtuxG8eb3hv0XArcIZw4HE6cZVx8HJLcqZzAXNdc7h0FHRwdMx1KHWFdeF2Pnabdvh3VnezeBF4bnjMeSp5iXnnekZ6pXsEe2N7wnwhfIF84X1BfaF+AX5ifsJ/I3+Ef+WAR4CogQqBa4HNgjCCkoL0g1eDuoQdhICE44VHhauGDoZyhteHO4efiASIaYjOiTOJmYn+imSKyoswi5aL/IxjjMqNMY2Yjf+OZo7OjzaPnpAGkG6Q1pE/kaiSEZJ6kuOTTZO2lCCUipT0lV+VyZY0lp+XCpd1l+CYTJi4mSSZkJn8mmia1ZtCm6+cHJyJnPedZJ3SnkCerp8dn4uf+qBpoNihR6G2oiailqMGo3aj5qRWpMelOKWpphqmi6b9p26n4KhSqMSpN6mpqhyqj6sCq3Wr6axcrNCtRK24ri2uoa8Wr4uwALB1sOqxYLHWskuywrM4s660JbSctRO1irYBtnm28Ldot+C4WbjRuUq5wro7urW7LrunvCG8m70VvY++Cr6Evv+/er/1wHDA7MFnwePCX8Lbw1jD1MRRxM7FS8XIxkbGw8dBx7/IPci8yTrJuco4yrfLNsu2zDXMtc01zbXONs62zzfPuNA50LrRPNG+0j/SwdNE08bUSdTL1U7V0dZV1tjXXNfg2GTY6Nls2fHadtr724DcBdyK3RDdlt4c3qLfKd+v4DbgveFE4cziU+Lb42Pj6+Rz5PzlhOYN5pbnH+ep6DLovOlG6dDqW+rl63Dr++yG7RHtnO4o7rTvQO/M8Fjw5fFy8f/yjPMZ86f0NPTC9VD13vZt9vv3ivgZ+Kj5OPnH+lf65/t3/Af8mP0p/br+S/7c/23//9IaG0dIXE5TQ29sb3JTcGFjZaJJH1xOU0NvbG9yU3BhY2XSGhtLTFdOU0NvbG9yoksf1E5PUBBRUlNUVk5TU2l6ZVhOU2ZGbGFnc1ZOU05hbWUjQCgAAAAAAAAQEIAQgBFbQXZlbmlyLUJvb2vSGhtXWFZOU0ZvbnSiVx/UWltcEBJePF9aTlNUYWJTdG9wc1tOU0FsaWdubWVudF8QH05TQWxsb3dzVGlnaHRlbmluZ0ZvclRydW5jYXRpb26AABAEgBPSGhthYl8QEE5TUGFyYWdyYXBoU3R5bGWiYR/VNjc4ORBkZTw9Pk8QGzAuODc4NDMgMC44NzA1OSAwLjgzOTIyIDAuOE8QKzAuODQ5MjI4NTAxMyAwLjg0MDk2NTAzMjYgMC44MDIyOTE3NTA5IDAuOACAC4AO0hobaWpcTlNEaWN0aW9uYXJ5omkf0hobbG1dTlNUZXh0U3RvcmFnZaRub3AfXU5TVGV4dFN0b3JhZ2VfEBlOU011dGFibGVBdHRyaWJ1dGVkU3RyaW5nXxASTlNBdHRyaWJ1dGVkU3RyaW5nAAgAEQAaACQAKQAyADcASQBMAFEAUwBtAHMAfACFAJAAnQCkAKYAqACqAKwAsQC7AL0AwQDGANEA2gDsAPAA+QECAQkBEQEcASIBJAEmASgBKgEsATIBNAE2ATgBOgE8AT4BVQFcAW8BggGKAZUBogGoAbUBygHSAfIB9AH2AfgB/wIEAgoCDAIOAhAOXA5hDm4OcQ5+DoMOiw6ODpcOng6nDq4Otw65DrsOvQ7JDs4O1Q7YDuEO7A74DxoPHA8eDyAPJQ84DzsPRg9kD5IPlA+WD5sPqA+rD7APvg/DD9EP7QAAAAAAAAIBAAAAAAAAAHEAAAAAAAAAAAAAAAAAABAC"
        
        richTextInitializeLightModeSpaceCharThenNewLineChar = "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"
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        choosenAtleastOneNote = 0
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        p1ViewSettings_Showing = false
        p1ViewSettings_ShowingAndSortedIfTrueElseShowing = false
        p1ViewSettings_Sorted = false
        
        p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ""
        p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ""
        p1ViewSettings_ShowCONTAINSTaskName = ""
        p1ViewSettings_ShowCONTAINSTaskDescription = ""
        p1ViewSettings_helpWithShowCONTAINS = ""
        
        p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = false
        p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask = false
        p1ViewSettings_thereIsItemsInCallFromShowButton = false
        
        p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = false
        p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = false
        p1ViewSettings_SortByIncreasing = false
        
        p1ViewSettings_ShowSortRequirementAfterUnshow = false
        p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        p2ViewSettings_Showing = false
        p2ViewSettings_ShowingAndSortedIfTrueElseShowing = false
        p2ViewSettings_Sorted = false
        
        p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ""
        p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ""
        p2ViewSettings_ShowCONTAINSTaskName = ""
        p2ViewSettings_ShowCONTAINSTaskDescription = ""
        p2ViewSettings_helpWithShowCONTAINS = ""
        
        p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = false
        p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask = false
        p2ViewSettings_thereIsItemsInCallFromShowButton = false
        
        p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = false
        p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = false
        p2ViewSettings_SortByIncreasing = false
        
        p2ViewSettings_ShowSortRequirementAfterUnshow = false
        p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        p3ViewSettings_Showing = false
        p3ViewSettings_ShowingAndSortedIfTrueElseShowing = false
        p3ViewSettings_Sorted = false
        
        p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ""
        p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ""
        p3ViewSettings_ShowCONTAINSTaskName = ""
        p3ViewSettings_ShowCONTAINSTaskDescription = ""
        p3ViewSettings_helpWithShowCONTAINS = ""
        
        p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = false
        p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask = false
        p3ViewSettings_thereIsItemsInCallFromShowButton = false
        
        p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = false
        p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = false
        p3ViewSettings_SortByIncreasing = false
        
        p3ViewSettings_ShowSortRequirementAfterUnshow = false
        p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        p4ViewSettings_Showing = false
        p4ViewSettings_ShowingAndSortedIfTrueElseShowing = false
        p4ViewSettings_Sorted = false
        
        p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ""
        p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ""
        p4ViewSettings_ShowCONTAINSTaskName = ""
        p4ViewSettings_ShowCONTAINSTaskDescription = ""
        p4ViewSettings_helpWithShowCONTAINS = ""
        
        p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = false
        p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask = false
        p4ViewSettings_thereIsItemsInCallFromShowButton = false
        
        p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = false
        p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = false
        p4ViewSettings_SortByIncreasing = false
        
        p4ViewSettings_ShowSortRequirementAfterUnshow = false
        p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        currentPopoverPage = 0
        
        isOnPage = 0
        
        p0StarterPageWith4Buttons = true
        p1showPageIMPandURGPopUp = false
        p2showPageIMPPopUp = false
        p3showPageURGPopUp = false
        p4showPageNOTHINGPopUp = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        isThereAnyItem = false // används baserad isOnPage för att generalisera och refactore coden
        isThereMoreThanOneItem = false // används baserad isOnPage för att generalisera och refactore coden
        
            isThereAnyIMPandURGItem = false
            isThereMoreThanOneIMPandURGItem = false
            
            isThereAnyIMPItem = false
            isThereMoreThanOneIMPItem = false
            
            isThereAnyURGItem = false
            isThereMoreThanOneURGItem = false
            
            isThereAnyNOTHINGItem = false
            isThereMoreThanOneNOTHINGItem = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        EditMode = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        AddMode = false
        
        AddOneTaskWithTaskName = ""
        AddItemWithTaskNameFilterResultTextHint = " add with name"
            
        substitoto = ""
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        DeleteMode = false
        rmALLPageMode = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        MoveMode = false
        toPage = 0
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        ShowMode = false
        
        ShowTextFieldTaskNameFilterResultTextHint = ""
        ShowTextFieldTaskDescriptionFilterResultTextHint = ""
        ShowCONTAINSTaskName = ""
        ShowCONTAINSTaskDescription = ""
        helpWithShowCONTAINS = ""
        
        ShowRequirementOptions = true
        
        ShowShowBarForTaskNameIfTrueElseTaskDescription = true
        uselessButUsedinShowItemsAfterSavingTask = false
        thereIsItemsInCallFromShowButton = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        SortMode = false
        SortRequirementOptions = true
        
        TasksIsSortedbyDateIfTrueElsePriority = true
        TasksIsSortedIncreasingIfTrueElseDecreasing = true
        SortByIncreasing = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        ShowFilterAndSortMode = false
        
        showBackButtonForSortinShowingAndSortedIfTrue = false
        
        ShowSortRequirementAfterUnshow = true
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        showMoveAfterShowFilterAndSortMode = true
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        Showing = false
        ShowingAndSortedIfTrueElseShowing = false
        
        ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
        ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
        Sorted = false
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
        isOn = false
        isPresented = false
        dummy1 = true
        
        //  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
        
    }
}


extension AppState {
    
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
    
    
    
    
    func SetTheViewingStateOfAPageInRealm(forPage: Int) {
            if forPage == 1 {
                p1ViewSettings_Showing = Showing
                p1ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
                p1ViewSettings_Sorted = Sorted

                p1ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                p1ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                p1ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                p1ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                p1ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS

                p1ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                p1ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                p1ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton

                p1ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                p1ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                p1ViewSettings_SortByIncreasing = SortByIncreasing

                p1ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                p1ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                p1ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing

            } else if forPage == 2 {
                p2ViewSettings_Showing = Showing
                p2ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
                p2ViewSettings_Sorted = Sorted

                p2ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                p2ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                p2ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                p2ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                p2ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS

                p2ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                p2ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                p2ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton

                p2ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                p2ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                p2ViewSettings_SortByIncreasing = SortByIncreasing

                p2ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                p2ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                p2ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
                
            } else if forPage == 3 {
                p3ViewSettings_Showing = Showing
                p3ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
                p3ViewSettings_Sorted = Sorted

                p3ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                p3ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                p3ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                p3ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                p3ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS

                p3ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                p3ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                p3ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton

                p3ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                p3ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                p3ViewSettings_SortByIncreasing = SortByIncreasing

                p3ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                p3ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                p3ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
                
            } else if forPage == 4 {
                p4ViewSettings_Showing = Showing
                p4ViewSettings_ShowingAndSortedIfTrueElseShowing = ShowingAndSortedIfTrueElseShowing
                p4ViewSettings_Sorted = Sorted

                p4ViewSettings_ShowTextFieldTaskNameFilterResultTextHint = ShowTextFieldTaskNameFilterResultTextHint
                p4ViewSettings_ShowTextFieldTaskDescriptionFilterResultTextHint = ShowTextFieldTaskDescriptionFilterResultTextHint
                p4ViewSettings_ShowCONTAINSTaskName = ShowCONTAINSTaskName
                p4ViewSettings_ShowCONTAINSTaskDescription = ShowCONTAINSTaskDescription
                p4ViewSettings_helpWithShowCONTAINS = helpWithShowCONTAINS

                p4ViewSettings_ShowShowBarForTaskNameIfTrueElseTaskDescription = ShowShowBarForTaskNameIfTrueElseTaskDescription
                p4ViewSettings_uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShowItemsAfterSavingTask
                p4ViewSettings_thereIsItemsInCallFromShowButton = thereIsItemsInCallFromShowButton

                p4ViewSettings_TasksIsSortedbyDateIfTrueElsePriority = TasksIsSortedbyDateIfTrueElsePriority
                p4ViewSettings_TasksIsSortedIncreasingIfTrueElseDecreasing = TasksIsSortedIncreasingIfTrueElseDecreasing
                p4ViewSettings_SortByIncreasing = SortByIncreasing

                p4ViewSettings_ShowSortRequirementAfterUnshow = ShowSortRequirementAfterUnshow
                p4ViewSettings_ShowSortByDateAfterUnshowButtonIfTrueElsePriority = ShowSortByDateAfterUnshowButtonIfTrueElsePriority
                p4ViewSettings_ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
            }
        }
}
