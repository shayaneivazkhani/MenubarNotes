//
//  ListPage_TopMenu_original_before_refactoring.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-15.
//

import Foundation
import SwiftUI

struct ListPage_TopMenu_original_before_refactoring: View {
    
    // MARK: – values of User preferenses/settings ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: –  AppStorage sextion för att behålla page view values/settings i USERDEFAULTS istället för Realm
    
    @EnvironmentObject var sharedAppState: AppState
    
    // MARK: – 💧 Connect our RealmManager to View ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    @EnvironmentObject var realmManager: RealmManager
    
    //  MARK: – AppStorage sextion för att behålla page view values/settings i USERDEFAULTS istället för Realm ・・・・・・
    
    
    var body: some View {
        
// MARK: –  PAGE 1 TopMenu🟠🟠🟠🟠🟠🟠🟠
        
        if $sharedAppState.p1showPageIMPandURGPopUp.wrappedValue && !($sharedAppState.p0StarterPageWith4Buttons.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($sharedAppState.p3showPageURGPopUp.wrappedValue) && !($sharedAppState.p4showPageNOTHINGPopUp.wrappedValue) {
            
            // HStacken som innehåller alla edit och sort buttons
            HStack (spacing: 10) {
                ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                    
                    // MARK: – PAGE 1 🔅 if !($sharedAppState.EditMode.wrappedValue) {
                    if !($sharedAppState.EditMode.wrappedValue) {
                        HStack {
                            
                            //.................
                            
                            if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                                
                                Button(
                                    action: {
                                        CountIMPandURGTasks()
                                        sharedAppState.EditMode = true
                                        
                                        sharedAppState.AddMode = true
                                        sharedAppState.MoveMode = false
                                        sharedAppState.DeleteMode = false
                                        sharedAppState.rmALLPageMode = false
                                        sharedAppState.SortMode = false
                                        sharedAppState.ShowMode = false
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
                                
                                if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                                    Divider()
                                        .frame(width: 2, height: 32, alignment: .leading)
                                        .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                    Button(
                                        action: {
                                            CountIMPandURGTasks()
                                            sharedAppState.EditMode = true
                                            
                                            sharedAppState.AddMode = false
                                            sharedAppState.MoveMode = false
                                            sharedAppState.DeleteMode = false
                                            sharedAppState.rmALLPageMode = false
                                            sharedAppState.SortMode = false
                                            sharedAppState.ShowMode = false
                                        },
                                        label: {
                                            Text("Edit")
                                                .foregroundColor(Color.BlueEdit)
                                                .bold()
                                                .font(.headline)
                                        }
                                    ).buttonStyle(ClearImageBackground2())
                                    /*if $sharedAppState.isThereMoreThanOneIMPandURGItem.wrappedValue {
                                     Divider()
                                     .frame(width: 2, height: 32, alignment: .leading)
                                     .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                     //.overlay(.pink)
                                     Button(
                                     action: {
                                     sharedAppState.ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                     sharedAppState.ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                     sharedAppState.ShowCONTAINSTaskName = ""
                                     sharedAppState.ShowCONTAINSTaskDescription = ""
                                     
                                     sharedAppState.EditMode = true
                                     
                                     sharedAppState.AddMode = false
                                     sharedAppState.MoveMode = false
                                     sharedAppState.DeleteMode = false
                                     sharedAppState.rmALLPageMode = false
                                     sharedAppState.SortMode = false
                                     sharedAppState.ShowMode = true
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
                                     action: {sharedAppState.EditMode = true
                                     
                                     sharedAppState.AddMode = false
                                     sharedAppState.MoveMode = false
                                     sharedAppState.DeleteMode = false
                                     sharedAppState.rmALLPageMode = false
                                     sharedAppState.SortMode = true
                                     sharedAppState.ShowMode = false
                                     },
                                     label: {
                                     Text("Sort")
                                     .foregroundColor(Color.BlueEdit)
                                     .bold()
                                     .font(.headline)
                                     }
                                     ).buttonStyle(ClearImageBackground2())
                                     } // MARK: – för if $isThereMoreThanOneIMPandURGItem.wrappedValue {
                                     */
                                } // MARK: – för if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                                
                            } // MARK: – if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                            
                            
                            //.................
                            
                            if $sharedAppState.Showing.wrappedValue && !($sharedAppState.Sorted.wrappedValue) {
                                
                                if !($sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                    
                                    if !($sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.Showing = false
                                                realmManager.updateP1() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                                
                                                resetEditModeValuesAndCountTasksFor(page: 1)
                                            },
                                            label: {
                                                Text(" Unshow")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground2())
                                    }
                                    /*if $isThereMoreThanOneIMPandURGItem.wrappedValue {
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
                                     
                                     realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                     ShowingAndSortedIfTrueElseShowing = true
                                     
                                     //SetTheViewingStateOfAPageInRealm(forPage: 1)
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
                                     
                                     realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP1(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
                                     ShowingAndSortedIfTrueElseShowing = true
                                     
                                     //SetTheViewingStateOfAPageInRealm(forPage: 1)
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
                                     } // MARK: – för if $isThereMoreThanOneIMPandURGItem.wrappedValue { */
                                    
                                } // MARK: – för if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                if $sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                    Button(
                                        action: {
                                            sharedAppState.Showing = false
                                            sharedAppState.ShowFilterAndSortMode = false
                                            sharedAppState.ShowingAndSortedIfTrueElseShowing = false
                                            
                                            realmManager.updateP1() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                            resetEditModeValuesAndCountTasksFor(page: 1)
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
                            
                            if $sharedAppState.Sorted.wrappedValue && !($sharedAppState.Showing.wrappedValue) {
                                Button(
                                    action: {
                                        sharedAppState.Sorted = false
                                        realmManager.updateP1() // this will show originala datan som är baserad på orndingen som TaskItems är Added/Removed by the USER since the beginning of times.
                                        
                                        resetEditModeValuesAndCountTasksFor(page: 1)
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
                            
                            if $sharedAppState.Showing.wrappedValue && $sharedAppState.Sorted.wrappedValue {
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
                                        sharedAppState.Sorted = false
                                        sharedAppState.Showing = false
                                    }
                            }
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack
                    } // MARK: –  if !($sharedAppState.EditMode.wrappedValue) {
                    // MARK: – PAGE 1 ⚡️ if $sharedAppState.EditMode.wrappedValue {
                    if $sharedAppState.EditMode.wrappedValue {
                        HStack (spacing: 2) {
                            
                            //ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
                            Button(
                                action: {
                                    resetEditModeValuesAndCountTasksFor(page: 1)
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
                            
                            // 1. ADD ⚡️∙∙∙∙∙
                            if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                Text(" ")
                                HStack (spacing: 1) {
                                    Button(
                                        action: {
                                            realmManager.addToP1()
                                            CountIMPandURGTasks()
                                            
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
                                     root.hasVerticalScroller = false
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
                                     root.hasVerticalScroller = false
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
                                     realmManager.addOneTaskToP1WithTasName(text: substitoto)
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
                            } // MARK: – if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) &&  !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            // 2. EDIT ⚡️∙∙∙∙∙
                            if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                                Text(" ")
                                if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                                    HStack (spacing: 0) {
                                        Button(
                                            action: {
                                                CountIMPandURGTasks()
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = true
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
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
                                                CountIMPandURGTasks()
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = true
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text(" Remove")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                } // MARK: – if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                                
                            } // MARK: –  if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                                // 2.1 inside EDIT  ⚡️∙∙∙∙∙
                                if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Button(
                                        action: {
                                            realmManager.deleteAllP1ItemisCurrentlyMarkedMarking()
                                            CountIMPandURGTasks()
                                            if !sharedAppState.isThereAnyIMPandURGItem {
                                                resetEditModeValuesAndCountTasksFor(page: 1)
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
                                    
                                    if !($sharedAppState.rmALLPageMode.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.rmALLPageMode = true
                                            },
                                            label: {
                                                Text(" rm -a")
                                                    .foregroundColor(Color.RedTRASHAndRM)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                    if $sharedAppState.rmALLPageMode.wrappedValue {
                                        HStack (spacing: 2) {
                                            Button(
                                                action: {
                                                    realmManager.rmAllP1Tasks()
                                                    CountIMPandURGTasks()
                                                    
                                                    sharedAppState.EditMode = false
                                                    sharedAppState.rmALLPageMode = false
                                                    sharedAppState.DeleteMode = false
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
                                                    if sharedAppState.rmALLPageMode {
                                                        sharedAppState.rmALLPageMode = false
                                                    } else {
                                                        sharedAppState.rmALLPageMode = true
                                                    }
                                                },
                                                label: {
                                                    Text("n")
                                                        .font(.custom("Avenir", size: 15))
                                                        .foregroundColor(Color.BlueEdit)
                                                }
                                            ).buttonStyle(ClearImageBackground())
                                        }
                                    }
                                } // MARK: –  if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue)  {
                                // 2.2 inside EDIT ⚡️∙∙∙∙∙
                                if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text("  to :")
                                        .font(.custom("Avenir", size: 11))
                                    Picker(selection: $sharedAppState.toPage, label: Text("")) {
                                        ForEach(0..<sharedAppState.pages.count, id: \.self) {
                                            Text(self.sharedAppState.pages[$0])
                                                .font(.custom("Avenir", size: 10))
                                        }
                                    }.labelsHidden()
                                    Button(
                                        action: {
                                            let addTasksToPage = sharedAppState.toPage
                                            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 1, andAddToPage: addTasksToPage)
                                            
                                            CountIMPandURGTasks()
                                            if !sharedAppState.isThereAnyIMPandURGItem {
                                                resetEditModeValuesAndCountTasksFor(page: 1)
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
                                    
                                } // MARK: – if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                            } // MARK: – if $sharedAppState.isThereAnyIMPandURGItem.wrappedValue {
                            
                            if $sharedAppState.isThereMoreThanOneIMPandURGItem.wrappedValue {
                                // 3 SHOW ⚡️∙∙∙∙∙
                                if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text(" ")
                                    if $sharedAppState.ShowRequirementOptions.wrappedValue {
                                        Text("show ")
                                            .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                        HStack (spacing: 3) {
                                            Button(
                                                action: {
                                                    sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                    sharedAppState.ShowRequirementOptions = false
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
                                    if !($sharedAppState.ShowRequirementOptions.wrappedValue) {
                                        
                                        /*
                                         if $ShowShowBarForTaskNameIfTrueElseTaskDescription.wrappedValue {
                                         if colorScheme == .dark {
                                         DarkModeHStackEditorControllerView(text: $ShowCONTAINSTaskName)
                                         .onNSView(
                                         added: { nsview in
                                         let root = nsview.subviews[0] as! NSScrollView
                                         root.hasVerticalScroller = false
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
                                         root.hasVerticalScroller = false
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
                                         root.hasVerticalScroller = false
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
                                         root.hasVerticalScroller = false
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
                                         callCorrectRealmShowInShowMode(page: 1)
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
                                    
                                } // MARK: – för if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                // 4 SORT ⚡️∙∙∙∙∙
                                if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                    HStack (spacing: 3) {
                                        Text(" ")
                                        
                                        if $sharedAppState.SortRequirementOptions.wrappedValue {
                                            Text("by ")
                                                .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                            HStack (spacing: 4) {
                                                Button(
                                                    action: {
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = true
                                                        sharedAppState.SortRequirementOptions = false
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
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = false
                                                        sharedAppState.SortRequirementOptions = false
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
                                        if !($sharedAppState.SortRequirementOptions.wrappedValue) {
                                            HStack (spacing: 4) {
                                                
                                                if $sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
                                                    Text("by date")
                                                        .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                    Button(
                                                        action: {
                                                            callCorrectRealmSortFor(page: 1, true, true)
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
                                                            callCorrectRealmSortFor(page: 1, true, false)
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
                                                if !($sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
                                                    Text("by priority")
                                                        .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                                    Button(
                                                        action: {
                                                            callCorrectRealmSortFor(page: 1, false, true)
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
                                                            callCorrectRealmSortFor(page: 1, false, false)
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
                                } // MARK: –  if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                
                            } // MARK: – if $isThereMoreThanOneIMPandURGItem.wrappedValue {
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $sharedAppState.EditMode.wrappedValue {
                    } // MARK: – if $sharedAppState.EditMode.wrappedValue {
                    
                } // MARK: – ZStack inside HStack
                
                ListPageName(1)
                    .offset(CGSize(width: 18.00, height: 0.00))
            }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
            
        }// MARK: – för if $p1showPageIMPandURGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
        
// MARK: –  PAGE 2 TopMenu🟠🟠🟠🟠🟠🟠🟠
        
        if $sharedAppState.p2showPageIMPPopUp.wrappedValue && !($sharedAppState.p0StarterPageWith4Buttons.wrappedValue) && !($sharedAppState.p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p3showPageURGPopUp.wrappedValue) && !($sharedAppState.p4showPageNOTHINGPopUp.wrappedValue) {
            
            // HStacken som innehåller alla edit och sort buttons
            HStack (spacing: 10) {
                ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                    
                    // MARK: – PAGE 2 🔅 if !($sharedAppState.EditMode.wrappedValue) {
                    if !($sharedAppState.EditMode.wrappedValue) {
                        HStack {
                            
                            //.................
                            
                            if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                                
                                Button(
                                    action: {
                                        CountIMPTasks()
                                        
                                        sharedAppState.EditMode = true
                                        
                                        sharedAppState.AddMode = true
                                        sharedAppState.MoveMode = false
                                        sharedAppState.DeleteMode = false
                                        sharedAppState.rmALLPageMode = false
                                        sharedAppState.SortMode = false
                                        sharedAppState.ShowMode = false
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
                                
                                if $sharedAppState.isThereAnyIMPItem.wrappedValue {
                                    Divider()
                                        .frame(width: 2, height: 32, alignment: .leading)
                                        .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                    Button(
                                        action: {
                                            CountIMPTasks()
                                            sharedAppState.EditMode = true
                                            
                                            sharedAppState.AddMode = false
                                            sharedAppState.MoveMode = false
                                            sharedAppState.DeleteMode = false
                                            sharedAppState.rmALLPageMode = false
                                            sharedAppState.SortMode = false
                                            sharedAppState.ShowMode = false
                                        },
                                        label: {
                                            Text("Edit")
                                                .foregroundColor(Color.BlueEdit)
                                                .bold()
                                                .font(.headline)
                                        }
                                    ).buttonStyle(ClearImageBackground2())
                                    if $sharedAppState.isThereMoreThanOneIMPItem.wrappedValue {
                                        Divider()
                                            .frame(width: 2, height: 32, alignment: .leading)
                                            .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                        //.overlay(.pink)
                                        Button(
                                            action: {
                                                sharedAppState.ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                                sharedAppState.ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                                sharedAppState.ShowCONTAINSTaskName = ""
                                                sharedAppState.ShowCONTAINSTaskDescription = ""
                                                
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = true
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
                                            action: {sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = true
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text("Sort")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground2())
                                    } // MARK: – för if $isThereMoreThanOneIMPItem.wrappedValue {
                                    
                                } // MARK: – för if $sharedAppState.isThereAnyIMPItem.wrappedValue {
                                
                            } // MARK: – if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                            
                            //.................
                            
                            if $sharedAppState.Showing.wrappedValue && !($sharedAppState.Sorted.wrappedValue) {
                                
                                if !($sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                    
                                    if !($sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.Showing = false
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
                                     
                                     realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP2(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                if $sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                    Button(
                                        action: {
                                            sharedAppState.Showing = false
                                            sharedAppState.ShowFilterAndSortMode = false
                                            sharedAppState.ShowingAndSortedIfTrueElseShowing = false
                                            
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
                            
                            if $sharedAppState.Sorted.wrappedValue && !($sharedAppState.Showing.wrappedValue) {
                                Button(
                                    action: {
                                        sharedAppState.Sorted = false
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
                            
                            if $sharedAppState.Showing.wrappedValue && $sharedAppState.Sorted.wrappedValue {
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
                                        sharedAppState.Sorted = false
                                        sharedAppState.Showing = false
                                    }
                            }
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack
                    } // MARK: –  if !($sharedAppState.EditMode.wrappedValue) {
                    // MARK: – PAGE 2 ⚡️ if $sharedAppState.EditMode.wrappedValue {
                    if $sharedAppState.EditMode.wrappedValue {
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
                            if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
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
                            } // MARK: – if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) &&  !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            // 2 ⚡️∙∙∙∙∙
                            if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                                Text(" ")
                                if $sharedAppState.isThereAnyIMPItem.wrappedValue {
                                    HStack (spacing: 0) {
                                        Button(
                                            action: {
                                                CountIMPTasks()
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = true
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
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
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = true
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text(" Remove")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                } // MARK: – if $sharedAppState.isThereAnyIMPItem.wrappedValue {
                                
                            } // MARK: –  if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            if $sharedAppState.isThereAnyIMPItem.wrappedValue {
                                // 3 ⚡️∙∙∙∙∙
                                if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Button(
                                        action: {
                                            realmManager.deleteAllP2ItemisCurrentlyMarkedMarking()
                                            CountIMPTasks()
                                            if !sharedAppState.isThereAnyIMPItem {
                                                resetEditModeValuesAndCountTasksFor(page: 2)
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
                                    
                                    if !($sharedAppState.rmALLPageMode.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.rmALLPageMode = true
                                            },
                                            label: {
                                                Text(" rm -a")
                                                    .foregroundColor(Color.RedTRASHAndRM)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                    if $sharedAppState.rmALLPageMode.wrappedValue {
                                        HStack (spacing: 2) {
                                            Button(
                                                action: {
                                                    realmManager.rmAllP2Tasks()
                                                    CountIMPTasks()
                                                    
                                                    sharedAppState.EditMode = false
                                                    sharedAppState.rmALLPageMode = false
                                                    sharedAppState.DeleteMode = false
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
                                                    if sharedAppState.rmALLPageMode {
                                                        sharedAppState.rmALLPageMode = false
                                                    } else {
                                                        sharedAppState.rmALLPageMode = true
                                                    }
                                                },
                                                label: {
                                                    Text("n")
                                                        .font(.custom("Avenir", size: 15))
                                                        .foregroundColor(Color.BlueEdit)
                                                }
                                            ).buttonStyle(ClearImageBackground())
                                        }
                                    }
                                } // MARK: –  if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue)  {
                                // 4 ⚡️∙∙∙∙∙
                                if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text("  to :")
                                        .font(.custom("Avenir", size: 11))
                                    Picker(selection: $sharedAppState.toPage, label: Text("")) {
                                        ForEach(0..<sharedAppState.pages.count, id: \.self) {
                                            Text(self.sharedAppState.pages[$0])
                                                .font(.custom("Avenir", size: 10))
                                        }
                                    }.labelsHidden()
                                    Button(
                                        action: {
                                            let addTasksToPage = sharedAppState.toPage
                                            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 2, andAddToPage: addTasksToPage)
                                            
                                            CountIMPTasks()
                                            if !sharedAppState.isThereAnyIMPItem {
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
                                    
                                } // MARK: – if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                            } // MARK: – if $sharedAppState.isThereAnyIMPItem.wrappedValue {
                            
                            if $sharedAppState.isThereMoreThanOneIMPItem.wrappedValue {
                                // 5 ⚡️∙∙∙∙∙
                                if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text(" ")
                                    if $sharedAppState.ShowRequirementOptions.wrappedValue {
                                        Text("show ")
                                            .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                        HStack (spacing: 3) {
                                            Button(
                                                action: {
                                                    sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                    sharedAppState.ShowRequirementOptions = false
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
                                    if !($sharedAppState.ShowRequirementOptions.wrappedValue) {
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
                                    
                                } // MARK: – för if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                // 6 ⚡️∙∙∙∙∙
                                if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                    HStack (spacing: 3) {
                                        Text(" ")
                                        
                                        if $sharedAppState.SortRequirementOptions.wrappedValue {
                                            Text("by ")
                                                .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                            HStack (spacing: 4) {
                                                Button(
                                                    action: {
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = true
                                                        sharedAppState.SortRequirementOptions = false
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
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = false
                                                        sharedAppState.SortRequirementOptions = false
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
                                        if !($sharedAppState.SortRequirementOptions.wrappedValue) {
                                            HStack (spacing: 4) {
                                                
                                                if $sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
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
                                                if !($sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
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
                                } // MARK: –  if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                
                            } // MARK: – if $isThereMoreThanOneIMPItem.wrappedValue {
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $sharedAppState.EditMode.wrappedValue {
                    } // MARK: – if $sharedAppState.EditMode.wrappedValue {
                    
                } // MARK: – ZStack inside HStack
                
                ListPageName(2)
                    .offset(CGSize(width: 18.00, height: 0.00))
            }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
            
        } // MARK: – för if $sharedAppState.p2showPageIMPPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
        
// MARK: –  PAGE 3 TopMenu🟠🟠🟠🟠🟠🟠🟠
        
        if $sharedAppState.p3showPageURGPopUp.wrappedValue && !($sharedAppState.p0StarterPageWith4Buttons.wrappedValue) && !($sharedAppState.p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($sharedAppState.p4showPageNOTHINGPopUp.wrappedValue) {
            
            // HStacken som innehåller alla edit och sort buttons
            HStack (spacing: 10) {
                ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                    
                    // MARK: – PAGE 3 🔅 if !($sharedAppState.EditMode.wrappedValue) {
                    if !($sharedAppState.EditMode.wrappedValue) {
                        HStack {
                            
                            //.................
                            
                            if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                                
                                Button(
                                    action: {
                                        CountURGTasks()
                                        
                                        sharedAppState.EditMode = true
                                        
                                        sharedAppState.AddMode = true
                                        sharedAppState.MoveMode = false
                                        sharedAppState.DeleteMode = false
                                        sharedAppState.rmALLPageMode = false
                                        sharedAppState.SortMode = false
                                        sharedAppState.ShowMode = false
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
                                
                                if $sharedAppState.isThereAnyURGItem.wrappedValue {
                                    Divider()
                                        .frame(width: 2, height: 32, alignment: .leading)
                                        .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                    Button(
                                        action: {
                                            CountURGTasks()
                                            sharedAppState.EditMode = true
                                            
                                            sharedAppState.AddMode = false
                                            sharedAppState.MoveMode = false
                                            sharedAppState.DeleteMode = false
                                            sharedAppState.rmALLPageMode = false
                                            sharedAppState.SortMode = false
                                            sharedAppState.ShowMode = false
                                        },
                                        label: {
                                            Text("Edit")
                                                .foregroundColor(Color.BlueEdit)
                                                .bold()
                                                .font(.headline)
                                        }
                                    ).buttonStyle(ClearImageBackground2())
                                    if $sharedAppState.isThereMoreThanOneURGItem.wrappedValue {
                                        Divider()
                                            .frame(width: 2, height: 32, alignment: .leading)
                                            .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                        //.overlay(.pink)
                                        Button(
                                            action: {
                                                sharedAppState.ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                                sharedAppState.ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                                sharedAppState.ShowCONTAINSTaskName = ""
                                                sharedAppState.ShowCONTAINSTaskDescription = ""
                                                
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = true
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
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = true
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text("Sort")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground2())
                                    } // MARK: – för if $isThereMoreThanOneURGItem.wrappedValue {
                                    
                                } // MARK: – för if $sharedAppState.isThereAnyURGItem.wrappedValue {
                                
                            } // MARK: – if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                            
                            //.................
                            
                            if $sharedAppState.Showing.wrappedValue && !($sharedAppState.Sorted.wrappedValue) {
                                
                                if !($sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                    
                                    if !($sharedAppState.showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.Showing = false
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
                                     
                                     realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP3(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                if $sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                    Button(
                                        action: {
                                            sharedAppState.Showing = false
                                            sharedAppState.ShowFilterAndSortMode = false
                                            sharedAppState.ShowingAndSortedIfTrueElseShowing = false
                                            
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
                            
                            if $sharedAppState.Sorted.wrappedValue && !($sharedAppState.Showing.wrappedValue) {
                                Button(
                                    action: {
                                        sharedAppState.Sorted = false
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
                            
                            if $sharedAppState.Showing.wrappedValue && $sharedAppState.Sorted.wrappedValue {
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
                                        sharedAppState.Sorted = false
                                        sharedAppState.Showing = false
                                    }
                            }
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack
                    } // MARK: –  if !($sharedAppState.EditMode.wrappedValue) {
                    // MARK: – PAGE 3 ⚡️ if $sharedAppState.EditMode.wrappedValue {
                    if $sharedAppState.EditMode.wrappedValue {
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
                            if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
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
                            } // MARK: – if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) &&  !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            // 2 ⚡️∙∙∙∙∙
                            if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                                Text(" ")
                                if $sharedAppState.isThereAnyURGItem.wrappedValue {
                                    HStack (spacing: 0) {
                                        Button(
                                            action: {
                                                CountURGTasks()
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = true
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
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
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = true
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text(" Remove")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                } // MARK: – if $sharedAppState.isThereAnyURGItem.wrappedValue {
                                
                            } // MARK: –  if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            if $sharedAppState.isThereAnyURGItem.wrappedValue {
                                // 3 ⚡️∙∙∙∙∙
                                if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Button(
                                        action: {
                                            realmManager.deleteAllP3ItemisCurrentlyMarkedMarking()
                                            CountURGTasks()
                                            if !sharedAppState.isThereAnyURGItem {
                                                resetEditModeValuesAndCountTasksFor(page: 3)
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
                                    
                                    if !($sharedAppState.rmALLPageMode.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.rmALLPageMode = true
                                            },
                                            label: {
                                                Text(" rm -a")
                                                    .foregroundColor(Color.RedTRASHAndRM)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                    if $sharedAppState.rmALLPageMode.wrappedValue {
                                        HStack (spacing: 2) {
                                            Button(
                                                action: {
                                                    realmManager.rmAllP3Tasks()
                                                    CountURGTasks()
                                                    
                                                    sharedAppState.EditMode = false
                                                    sharedAppState.rmALLPageMode = false
                                                    sharedAppState.DeleteMode = false
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
                                                    if sharedAppState.rmALLPageMode {
                                                        sharedAppState.rmALLPageMode = false
                                                    } else {
                                                        sharedAppState.rmALLPageMode = true
                                                    }
                                                },
                                                label: {
                                                    Text("n")
                                                        .font(.custom("Avenir", size: 15))
                                                        .foregroundColor(Color.BlueEdit)
                                                }
                                            ).buttonStyle(ClearImageBackground())
                                        }
                                    }
                                } // MARK: –  if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue)  {
                                // 4 ⚡️∙∙∙∙∙
                                if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text("  to :")
                                        .font(.custom("Avenir", size: 11))
                                    Picker(selection: $sharedAppState.toPage, label: Text("")) {
                                        ForEach(0..<sharedAppState.pages.count, id: \.self) {
                                            Text(self.sharedAppState.pages[$0])
                                                .font(.custom("Avenir", size: 10))
                                        }
                                    }.labelsHidden()
                                    Button(
                                        action: {
                                            let addTasksToPage = sharedAppState.toPage
                                            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 3, andAddToPage: addTasksToPage)
                                            
                                            CountURGTasks()
                                            if !sharedAppState.isThereAnyURGItem {
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
                                    
                                } // MARK: – if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                            } // MARK: – if $sharedAppState.isThereAnyURGItem.wrappedValue {
                            
                            if $sharedAppState.isThereMoreThanOneURGItem.wrappedValue {
                                // 5 ⚡️∙∙∙∙∙
                                if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text(" ")
                                    if $sharedAppState.ShowRequirementOptions.wrappedValue {
                                        Text("show ")
                                            .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                        HStack (spacing: 3) {
                                            Button(
                                                action: {
                                                    sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                    sharedAppState.ShowRequirementOptions = false
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
                                    if !($sharedAppState.ShowRequirementOptions.wrappedValue) {
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
                                    
                                } // MARK: – för if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                // 6 ⚡️∙∙∙∙∙
                                if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                    HStack (spacing: 3) {
                                        Text(" ")
                                        
                                        if $sharedAppState.SortRequirementOptions.wrappedValue {
                                            Text("by ")
                                                .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                            HStack (spacing: 4) {
                                                Button(
                                                    action: {
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = true
                                                        sharedAppState.SortRequirementOptions = false
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
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = false
                                                        sharedAppState.SortRequirementOptions = false
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
                                        if !(sharedAppState.$SortRequirementOptions.wrappedValue) {
                                            HStack (spacing: 4) {
                                                
                                                if $sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
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
                                                if !($sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
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
                                } // MARK: –  if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                
                            } // MARK: – if $isThereMoreThanOneURGItem.wrappedValue {
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $sharedAppState.EditMode.wrappedValue {
                    } // MARK: – if $sharedAppState.EditMode.wrappedValue {
                    
                } // MARK: – ZStack inside HStack
                
                ListPageName(3)
                    .offset(CGSize(width: 18.00, height: 0.00))
            }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {

        }  // MARK: – för if $p3showPageURGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($p4showPageNOTHINGPopUp.wrappedValue) {
        
// MARK: –  PAGE 4 TopMenu🟠🟠🟠🟠🟠🟠🟠
        
        if $sharedAppState.p4showPageNOTHINGPopUp.wrappedValue && !($sharedAppState.p0StarterPageWith4Buttons.wrappedValue) && !($sharedAppState.p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($sharedAppState.p3showPageURGPopUp.wrappedValue) {
            
            // HStacken som innehåller alla edit och sort buttons
            HStack (spacing: 10) {
                ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                    
                    // MARK: – PAGE 4 🔅 if !($sharedAppState.EditMode.wrappedValue) {
                    if !($sharedAppState.EditMode.wrappedValue) {
                        HStack {
                            
                            //.................
                            
                            if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                                
                                Button(
                                    action: {
                                        CountNOTHINGTasks()
                                        
                                        sharedAppState.EditMode = true
                                        
                                        sharedAppState.AddMode = true
                                        sharedAppState.MoveMode = false
                                        sharedAppState.DeleteMode = false
                                        sharedAppState.rmALLPageMode = false
                                        sharedAppState.SortMode = false
                                        sharedAppState.ShowMode = false
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
                                
                                if $sharedAppState.isThereAnyNOTHINGItem.wrappedValue {
                                    Divider()
                                        .frame(width: 2, height: 32, alignment: .leading)
                                        .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                    Button(
                                        action: {
                                            CountNOTHINGTasks()
                                            sharedAppState.EditMode = true
                                            
                                            sharedAppState.AddMode = false
                                            sharedAppState.MoveMode = false
                                            sharedAppState.DeleteMode = false
                                            sharedAppState.rmALLPageMode = false
                                            sharedAppState.SortMode = false
                                            sharedAppState.ShowMode = false
                                        },
                                        label: {
                                            Text("Edit")
                                                .foregroundColor(Color.BlueEdit)
                                                .bold()
                                                .font(.headline)
                                        }
                                    ).buttonStyle(ClearImageBackground2())
                                    if $sharedAppState.isThereMoreThanOneNOTHINGItem.wrappedValue {
                                        Divider()
                                            .frame(width: 2, height: 32, alignment: .leading)
                                            .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                        //.overlay(.pink)
                                        Button(
                                            action: {
                                                sharedAppState.ShowTextFieldTaskNameFilterResultTextHint = "if name contains       "
                                                sharedAppState.ShowTextFieldTaskDescriptionFilterResultTextHint = "if description contains"
                                                sharedAppState.ShowCONTAINSTaskName = ""
                                                sharedAppState.ShowCONTAINSTaskDescription = ""
                                                
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = true
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
                                            action: {sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = true
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text("Sort")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground2())
                                    } // MARK: – för if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                                    
                                } // MARK: – för if $sharedAppState.isThereAnyNOTHINGItem.wrappedValue {
                                
                            } // MARK: – if !($sharedAppState.Sorted.wrappedValue) && !($sharedAppState.Showing.wrappedValue) {
                            
                            //.................
                            
                            if $sharedAppState.Showing.wrappedValue && !(sharedAppState.$Sorted.wrappedValue) {
                                
                                if !(sharedAppState.$ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                    
                                    if !(sharedAppState.$showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.Showing = false
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
                                     
                                     realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                     
                                     realmManager.FilterAndSortP4(sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription, sharedAppState.helpWithShowCONTAINS, sharedAppState.ShowSortByDateAfterUnshowButtonIfTrueElsePriority, sharedAppState.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                if $sharedAppState.ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                    Button(
                                        action: {
                                            sharedAppState.Showing = false
                                            sharedAppState.ShowFilterAndSortMode = false
                                            sharedAppState.ShowingAndSortedIfTrueElseShowing = false
                                            
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
                            
                            if $sharedAppState.Sorted.wrappedValue && !($sharedAppState.Showing.wrappedValue) {
                                Button(
                                    action: {
                                        sharedAppState.Sorted = false
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
                            
                            if $sharedAppState.Showing.wrappedValue && $sharedAppState.Sorted.wrappedValue {
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
                                        sharedAppState.Sorted = false
                                        sharedAppState.Showing = false
                                    }
                            }
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack
                    } // MARK: –  if !($sharedAppState.EditMode.wrappedValue) {
                    
                    // MARK: – PAGE 4 ⚡️ if $sharedAppState.EditMode.wrappedValue {
                    if $sharedAppState.EditMode.wrappedValue {
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
                            if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
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
                            } // MARK: – if $sharedAppState.AddMode.wrappedValue && !($sharedAppState.DeleteMode.wrappedValue) &&  !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            // 2 ⚡️∙∙∙∙∙
                            if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                                Text(" ")
                                if $sharedAppState.isThereAnyNOTHINGItem.wrappedValue {
                                    HStack (spacing: 0) {
                                        Button(
                                            action: {
                                                CountNOTHINGTasks()
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = true
                                                sharedAppState.DeleteMode = false
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
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
                                                sharedAppState.EditMode = true
                                                
                                                sharedAppState.AddMode = false
                                                sharedAppState.MoveMode = false
                                                sharedAppState.DeleteMode = true
                                                sharedAppState.rmALLPageMode = false
                                                sharedAppState.SortMode = false
                                                sharedAppState.ShowMode = false
                                            },
                                            label: {
                                                Text(" Remove")
                                                    .foregroundColor(Color.BlueEdit)
                                                    .bold()
                                                    .font(.headline)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                } // MARK: – if $sharedAppState.isThereAnyNOTHINGItem.wrappedValue {
                                
                            } // MARK: –  if !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                            
                            if $sharedAppState.isThereAnyNOTHINGItem.wrappedValue {
                                // 3 ⚡️∙∙∙∙∙
                                if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Button(
                                        action: {
                                            realmManager.deleteAllP4ItemisCurrentlyMarkedMarking()
                                            CountNOTHINGTasks()
                                            if !sharedAppState.isThereAnyNOTHINGItem {
                                                resetEditModeValuesAndCountTasksFor(page: 4)
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
                                    
                                    if !($sharedAppState.rmALLPageMode.wrappedValue) {
                                        Button(
                                            action: {
                                                sharedAppState.rmALLPageMode = true
                                            },
                                            label: {
                                                Text(" rm -a")
                                                    .foregroundColor(Color.RedTRASHAndRM)
                                            }
                                        ).buttonStyle(ClearImageBackground())
                                    }
                                    if $sharedAppState.rmALLPageMode.wrappedValue {
                                        HStack (spacing: 2) {
                                            Button(
                                                action: {
                                                    realmManager.rmAllP4Tasks()
                                                    CountNOTHINGTasks()
                                                    
                                                    sharedAppState.EditMode = false
                                                    sharedAppState.rmALLPageMode = false
                                                    sharedAppState.DeleteMode = false
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
                                                    if sharedAppState.rmALLPageMode {
                                                        sharedAppState.rmALLPageMode = false
                                                    } else {
                                                        sharedAppState.rmALLPageMode = true
                                                    }
                                                },
                                                label: {
                                                    Text("n")
                                                        .font(.custom("Avenir", size: 15))
                                                        .foregroundColor(Color.BlueEdit)
                                                }
                                            ).buttonStyle(ClearImageBackground())
                                        }
                                    }
                                } // MARK: –  if $sharedAppState.DeleteMode.wrappedValue && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue)  {
                                // 4 ⚡️∙∙∙∙∙
                                if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text("  to :")
                                        .font(.custom("Avenir", size: 11))
                                    Picker(selection: $sharedAppState.toPage, label: Text("")) {
                                        ForEach(0..<sharedAppState.pages.count, id: \.self) {
                                            Text(self.sharedAppState.pages[$0])
                                                .font(.custom("Avenir", size: 10))
                                        }
                                    }.labelsHidden()
                                    Button(
                                        action: {
                                            let addTasksToPage = sharedAppState.toPage
                                            realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 4, andAddToPage: addTasksToPage)
                                            
                                            CountNOTHINGTasks()
                                            if !sharedAppState.isThereAnyNOTHINGItem {
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
                                    
                                } // MARK: – if $sharedAppState.MoveMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue)  && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                
                            } // MARK: – if $sharedAppState.isThereAnyNOTHINGItem.wrappedValue {
                            
                            if $sharedAppState.isThereMoreThanOneNOTHINGItem.wrappedValue {
                                // 5 ⚡️∙∙∙∙∙
                                if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                    
                                    Text(" ")
                                    if $sharedAppState.ShowRequirementOptions.wrappedValue {
                                        Text("show ")
                                            .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                        HStack (spacing: 3) {
                                            Button(
                                                action: {
                                                    sharedAppState.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                                                    sharedAppState.ShowRequirementOptions = false
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
                                    if !($sharedAppState.ShowRequirementOptions.wrappedValue) {
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
                                    
                                } // MARK: – för if $sharedAppState.ShowMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.SortMode.wrappedValue) {
                                // 6 ⚡️∙∙∙∙∙
                                if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                    HStack (spacing: 3) {
                                        Text(" ")
                                        
                                        if $sharedAppState.SortRequirementOptions.wrappedValue {
                                            Text("by ")
                                                .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                            HStack (spacing: 4) {
                                                Button(
                                                    action: {
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = true
                                                        sharedAppState.SortRequirementOptions = false
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
                                                        sharedAppState.TasksIsSortedbyDateIfTrueElsePriority = false
                                                        sharedAppState.SortRequirementOptions = false
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
                                        if !($sharedAppState.SortRequirementOptions.wrappedValue) {
                                            HStack (spacing: 4) {
                                                
                                                if $sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue {
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
                                                if !($sharedAppState.TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
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
                                } // MARK: –  if $sharedAppState.SortMode.wrappedValue && !($sharedAppState.AddMode.wrappedValue) && !($sharedAppState.MoveMode.wrappedValue) && !($sharedAppState.DeleteMode.wrappedValue) && !($sharedAppState.ShowMode.wrappedValue) {
                                
                            } // MARK: – if $isThereMoreThanOneNOTHINGItem.wrappedValue {
                            
                        }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $sharedAppState.EditMode.wrappedValue {
                    } // MARK: – if $sharedAppState.EditMode.wrappedValue {
                    
                } // MARK: – ZStack inside HStack
                
                ListPageName(4)
                    .offset(CGSize(width: 18.00, height: 0.00))
            }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
            
        } // MARK: – för if $p4showPageNOTHINGPopUp.wrappedValue && !($p0StarterPageWith4Buttons.wrappedValue) && !($p1showPageIMPandURGPopUp.wrappedValue) && !($sharedAppState.p2showPageIMPPopUp.wrappedValue) && !($p3showPageURGPopUp.wrappedValue) {
    }
    
}



extension ListPage_TopMenu_original_before_refactoring {
    func CountIMPandURGTasks() {
        let isThereAny = realmManager.isThereAnyP1Item()
        let isThereMore = realmManager.isThereMoreP1Items()
        sharedAppState.isThereAnyIMPandURGItem = isThereAny
        sharedAppState.isThereMoreThanOneIMPandURGItem = isThereMore
    }
    func CountIMPTasks() {
        let isThereAny = realmManager.isThereAnyP2Item()
        let isThereMore = realmManager.isThereMoreP2Items()
        sharedAppState.isThereAnyIMPItem = isThereAny
        sharedAppState.isThereMoreThanOneIMPItem = isThereMore
    }
    func CountURGTasks() {
        let isThereAny = realmManager.isThereAnyP3Item()
        let isThereMore = realmManager.isThereMoreP3Items()
        sharedAppState.isThereAnyURGItem =  isThereAny
        sharedAppState.isThereMoreThanOneURGItem = isThereMore
    }
    func CountNOTHINGTasks() {
        let isThereAny = realmManager.isThereAnyP4Item()
        let isThereMore = realmManager.isThereMoreP4Items()
        sharedAppState.isThereAnyNOTHINGItem = isThereAny
        sharedAppState.isThereMoreThanOneNOTHINGItem = isThereMore
    }
}

extension ListPage_TopMenu_original_before_refactoring {
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


extension ListPage_TopMenu_original_before_refactoring {
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
}
