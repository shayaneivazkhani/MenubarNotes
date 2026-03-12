//
//  ListPage_TopMenu.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

struct ListPage_TopMenu: View {
    
    // MARK: –  AppStorage section för att behålla page view values/settings i USERDEFAULTS istället för Realm
    
    @EnvironmentObject var sharedAppState: AppState
    
    // MARK: – 💧 Connect our RealmManager to View ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @EnvironmentObject var realmManager: RealmManager
    
    //  MARK: – AppStorage sextion för att behålla page view values/settings i USERDEFAULTS istället för Realm ・・・・・・
    
    @State private var isPresented = false
    @State private var confirmation = ""
    
    // MARK: – För att meddela ContentView add man har addat en task så att .onChange {} listener automatiskt öppnar EditorPagen med den texten som precis hade addats ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Binding var addedOneTask: Bool
    
    init(_ didOrDidNotAdd: Binding<Bool>) {
        self._addedOneTask = didOrDidNotAdd
    }
    
    var body: some View {
        
// HStacken som innehåller alla edit och sort buttons
        HStack (spacing: 1) {
            ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                
// MARK: – 🔅 if !($sharedAppState.EditMode.wrappedValue) {
                if !($sharedAppState.EditMode.wrappedValue) {
                    HStack {
                        if $sharedAppState.popOverHasBeenDetachedByUser.wrappedValue {
                            Spacer().frame(width: 20.00)
                        }
                        
                        if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                            Button(
                                action: {
                                    addOneTask()
                                    //addedOneTask = true
                                    addedOneTask.toggle()
                                },
                                label: {
                                    Text(" Add")
                                        .foregroundColor(Color.BlueEdit)
                                        .bold()
                                        .font(.headline)
                                }
                            ).buttonStyle(ClearImageBackground2())
                                //.keyboardShortcut("a", modifiers: [.command])
                                //.keyboardShortcut("a", modifiers: [.command, .shift]))
                                //.keyboardShortcut(.defaultAction)
                            
                            if $sharedAppState.isThereAnyItem.wrappedValue {
                                Divider()
                                    .frame(width: 2, height: 32, alignment: .leading)
                                    .background(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                HStack (spacing: 0) {
                                    Button(
                                        action: {
                                            moveTasks()
                                        },
                                        label: {
                                            Text("Move   ")
                                                .foregroundColor(Color.BlueEdit)
                                                .bold()
                                                .font(.headline)
                                        }
                                    ).buttonStyle(ClearImageBackground())
                                    
                                    Divider()
                                        .frame(width: 2, height: 32, alignment: .leading)
                                        .background(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                    
                                    Button(
                                        action: {
                                            removeTasks()
                                        },
                                        label: {
                                            Text("   Remove")
                                                .foregroundColor(Color.BlueEdit)
                                                .bold()
                                                .font(.headline)
                                        }
                                    ).buttonStyle(ClearImageBackground())
                                }
                            } // MARK: – för if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                            
                        } // MARK: – if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                        
                    }.frame(width: 370, alignment: .leading) //.frame(width: 480, alignment: .leading) //.frame(width: 320, alignment: .leading) //.frame(width: 230, alignment: .leading)  // MARK: – HStack
                } // MARK: –  if !($sharedAppState.EditMode.wrappedValue) {
                
// MARK: – ⚡️ if $sharedAppState.EditMode.wrappedValue {
                if $sharedAppState.EditMode.wrappedValue {
                    HStack (spacing: 2) {
                        if $sharedAppState.popOverHasBeenDetachedByUser.wrappedValue {
                            Spacer().frame(width: 20.00)
                        }
                        
                        //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                        Button(
                            action: {
                                sharedAppState.choosenAtleastOneNote = 0
                                resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                            },
                            label: {
                                Text(" Done  ")
                                    .foregroundColor(Color.BlueEdit)
                                    .bold()
                                    .font(.headline)
                                    .frame(alignment: .leading)
                            }
                        ).buttonStyle(ClearImageBackground())
                            //.keyboardShortcut("d", modifiers: [.command])
                        Divider()
                            .frame(width: 2, height: 32, alignment: .leading)
                            .background(sharedAppState.darkMode ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                        //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                        
                        
                        if $sharedAppState.isThereAnyItem.wrappedValue {
 // 3 ⚡️inside EDIT  mode - DeleteMode ∙∙∙∙∙
                            if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                HStack (spacing:0) {
                                    Button(
                                        action: {
                                            if (sharedAppState.choosenAtleastOneNote > 0) {
                                                sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = true
                                                isPresented = true
                                                
                                                /*removeSelectedTasks()
                                                sharedAppState.choosenAtleastOneNote = 0
                                                resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)*/
                                            } else {
                                                if (sharedAppState.choosenAtleastOneNote < 0) {
                                                    sharedAppState.choosenAtleastOneNote = 0
                                                    
                                                    resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                                } else if (sharedAppState.choosenAtleastOneNote == 0) {
                                                    withAnimation {
                                                        sharedAppState.showToast = true
                                                    }
                                                }
                                            }
                                            
                                            /*removeSelectedTasks()
                                             sharedAppState.choosenAtleastOneNote = 0
                                             resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                             */
                                        },
                                        label: {
                                            HStack (spacing: 6) {
                                                Text("  Remove")
                                                    .foregroundColor((sharedAppState.choosenAtleastOneNote > 0) ? Color.RedTRASHAndRM : Color.gray)
                                                    .bold()
                                                    .font(.headline)
                                                Text("\(sharedAppState.choosenAtleastOneNote)")
                                                    .font(.custom("Avenir", size: 13))
                                                    .bold()
                                                    .offset(CGSize(width: 0.00, height: 1.00))
                                                Text(sharedAppState.choosenAtleastOneNote > 0 ? "(forever)" : "")
                                                    .font(.custom("Courier", size: 11))
                                                    .bold()
                                                    .offset(CGSize(width: 0.00, height: 1.00))
                                            }
                                        }
                                    ).buttonStyle(ClearImageBackground())
                                     //.disabled(!(sharedAppState.choosenAtleastOneNote == 0))
                                     //.disabled(sharedAppState.choosenAtleastOneNote <= 0)
                                    .disabled(sharedAppState.choosenAtleastOneNote < 0)
                                    .help(Text("Remove Marked Tasks"))
                                }.confirmationDialog("Are you sure you want to permanently delete \(sharedAppState.choosenAtleastOneNote) \(sharedAppState.choosenAtleastOneNote == 1 ? "note" : "notes")?", isPresented: $isPresented, titleVisibility: .automatic,
                                                     actions: {
                                                        Button("Yes – Delete", role: .destructive) {
                                                            isPresented = false
                                                            
                                                            if (sharedAppState.choosenAtleastOneNote > 0) {
                                                                removeSelectedTasks()
                                                                sharedAppState.choosenAtleastOneNote = 0
                                                                resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                                            } else {
                                                                if (sharedAppState.choosenAtleastOneNote < 0) {
                                                                    sharedAppState.choosenAtleastOneNote = 0
                                                                    
                                                                    resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                                                } else if (sharedAppState.choosenAtleastOneNote == 0) {
                                                                    withAnimation {
                                                                        sharedAppState.showToast = true
                                                                    }
                                                                }
                                                            }
                                                            
                                                            sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false
                                                        }.disabled(sharedAppState.choosenAtleastOneNote < 0)
                                                        //Button("No – Cancel", role: .destructive) {
                                                        Button("No – Cancel", role: .cancel) {
                                                            sharedAppState.choosenAtleastOneNote = 0
                                                            resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                                            
                                                            sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false
                                                        }
                                                    },
                                                    message: {
                                                        Text("")
                                                    }
                                                )
                            } // MARK: –  if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue)  {
// 4 ⚡️ EDIT mode - MoveMode ∙∙∙∙∙
                            if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                                Text("  to ")
                                    //.font(.custom("Avenir", size: 11))
                                    .font(.custom("Avenir", size: 13))
                                    .bold()
                                    .offset(CGSize(width: 0.00, height: 1.00))
                                Picker(selection: $sharedAppState.toPage, label: Text("")) {
                                    ForEach(0..<sharedAppState.pages.count, id: \.self) {
                                        Text(self.sharedAppState.pages[$0])
                                            .font(.custom("Avenir", size: 12))
                                            //.font(.custom("Avenir", size: 10))
                                            //.bold()
                                    }
                                }.labelsHidden()
                                 //.frame(width: 130)
                                //.frame(width: 90)
                                 .frame(width: 110)
                                 //.offset(CGSize(width: 0.00, height: 0.00))
                                
                                Button(
                                    action: {
                                        if (sharedAppState.choosenAtleastOneNote > 0) {
                                            moveSelectedTasks()
                                            sharedAppState.choosenAtleastOneNote = 0
                                            resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                        } else {
                                            if (sharedAppState.choosenAtleastOneNote < 0) {
                                                sharedAppState.choosenAtleastOneNote = 0
                                                
                                                resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                            } else if (sharedAppState.choosenAtleastOneNote == 0) {
                                                withAnimation {
                                                    sharedAppState.showToast = true
                                                }
                                            }
                                        }
                                        /*moveSelectedTasks()
                                        sharedAppState.choosenAtleastOneNote = 0
                                        resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
                                        */
                                    },
                                    label: {
                                        HStack (spacing: 6) {
                                            Text(" Move")
                                                .foregroundColor((sharedAppState.choosenAtleastOneNote > 0) ? Color.BlueEdit : Color.gray)
                                                .bold()
                                                .font(.headline)
                                            
                                            Text("\(sharedAppState.choosenAtleastOneNote)")
                                            //.font(.custom("Avenir", size: 11))
                                                .font(.custom("Avenir", size: 13))
                                                .bold()
                                                .offset(CGSize(width: 0.00, height: 1.00))
                                        }
                                    }
                                ).buttonStyle(ClearImageBackground())
                                 //.disabled(!(sharedAppState.choosenAtleastOneNote > 0))
                                 .disabled(sharedAppState.choosenAtleastOneNote < 0)
                                 .help(Text("Move Marked Tasks"))
                            } // MARK: – if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                        } // MARK: – if $sharedAppState.isThereAnyItem.wrappedValue {
                        
                    }.frame(width: 370, alignment: .leading) //.frame(width: 480, alignment: .leading) //.frame(width: 320, alignment: .leading) //.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $sharedAppState.EditMode.wrappedValue {
                } // MARK: – if $sharedAppState.EditMode.wrappedValue {
                
            } // MARK: – ZStack inside HStack
            ListPageName($sharedAppState.isOnPage.wrappedValue)
                //.offset(CGSize(width: 18.00, height: 0.00))
        }.frame(width: 490, height: 18, alignment: .leading) //.frame(width: 550, height: 18, alignment: .leading) //.frame(width: 390, height: 18, alignment: .leading) //.frame(width: 300, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
    }
}


extension ListPage_TopMenu {
    
    func countTasks() {
        let page = sharedAppState.isOnPage
        
        if page == 1 {
            CountIMPandURGTasks()
        } else if page == 2 {
            CountIMPTasks()
        } else if page == 3 {
            CountURGTasks()
        } else if page == 4 {
            CountNOTHINGTasks()
        }
    }
    
    func addOneTask() {
        let page = sharedAppState.isOnPage
        
        if page == 1 {
            realmManager.addToP1()
            CountIMPandURGTasks()
        } else if page == 2 {
            realmManager.addToP2()
            CountIMPTasks()
        } else if page == 3 {
            realmManager.addToP3()
            CountURGTasks()
        } else if page == 4 {
            realmManager.addToP4()
            CountNOTHINGTasks()
        }
    }
    
    func editTasks() {
        countTasks()
        sharedAppState.EditMode = true
        
        sharedAppState.AddMode = false
        sharedAppState.MoveMode = false
        sharedAppState.DeleteMode = false
        sharedAppState.rmALLPageMode = false
        sharedAppState.SortMode = false
        sharedAppState.ShowMode = false
    }
    
    func moveTasks() {
        countTasks()
        sharedAppState.EditMode = true
        
        sharedAppState.AddMode = false
        sharedAppState.MoveMode = true
        sharedAppState.DeleteMode = false
        sharedAppState.rmALLPageMode = false
        sharedAppState.SortMode = false
        sharedAppState.ShowMode = false
    }
    
    func removeTasks() {
        countTasks()
        sharedAppState.EditMode = true
        
        sharedAppState.AddMode = false
        sharedAppState.MoveMode = false
        sharedAppState.DeleteMode = true
        sharedAppState.rmALLPageMode = false
        sharedAppState.SortMode = false
        sharedAppState.ShowMode = false
    }
    
    func moveSelectedTasks() {
        let page = sharedAppState.isOnPage
        let addTasksToPage = sharedAppState.toPage
        
        if page == 1 {
            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 1, andAddToPage: addTasksToPage)
            CountIMPandURGTasks()
        } else if page == 2 {
            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 2, andAddToPage: addTasksToPage)
            CountIMPTasks()
        } else if page == 3 {
            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 3, andAddToPage: addTasksToPage)
            CountURGTasks()
        } else if page == 4 {
            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 4, andAddToPage: addTasksToPage)
            CountNOTHINGTasks()
        }
        if !sharedAppState.isThereAnyItem {
            resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
        }
    }
    
    func removeSelectedTasks() {
        let page = sharedAppState.isOnPage
        
        if page == 1 {
            realmManager.deleteAllP1ItemisCurrentlyMarkedMarking()
            CountIMPandURGTasks()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
                         callCorrectRealmSortFor(page: 1, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                         } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                         realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                         } else {
                         if sharedAppState.Showing && !sharedAppState.Sorted {
                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 1)
                         }
                         }
                         */
        } else if page == 2 {
            realmManager.deleteAllP2ItemisCurrentlyMarkedMarking()
            CountIMPTasks()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
                         callCorrectRealmSortFor(page: 2, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                         } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                         realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                         } else {
                         if sharedAppState.Showing && !sharedAppState.Sorted {
                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 2)
                         }
                         }*/
        } else if page == 3 {
            realmManager.deleteAllP3ItemisCurrentlyMarkedMarking()
            CountURGTasks()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
                             callCorrectRealmSortFor(page: 3, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                             } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                             realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                             } else {
                             if sharedAppState.Showing && !sharedAppState.Sorted {
                             setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 3)
                             }
                             }*/
        } else if page == 4 {
            realmManager.deleteAllP4ItemisCurrentlyMarkedMarking()
            CountNOTHINGTasks()
            
            /*if sharedAppState.Sorted && !sharedAppState.Showing {
                         callCorrectRealmSortFor(page: 4, sharedAppState.TasksIsSortedbyDateIfTrueElsePriority, sharedAppState.TasksIsSortedIncreasingIfTrueElseDecreasing)
                         } else if sharedAppState.ShowingAndSortedIfTrueElseShowing {
                         realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                         } else {
                         if sharedAppState.Showing && !sharedAppState.Sorted {
                         setShowValuesAndCallCorrectRealmShowInSaveAndExitButtonFor(page: 4)
                         }
                         }*/
        }
        
        if !sharedAppState.isThereAnyItem {
            resetEditModeValuesAndCountTasksFor(page: sharedAppState.isOnPage)
        }
    }
}


extension ListPage_TopMenu {
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
}

extension ListPage_TopMenu {
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
}


extension ListPage_TopMenu {
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
        } else if page == 2 {
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
        } else if page == 3 {
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
        } else if page == 4 {
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
}
