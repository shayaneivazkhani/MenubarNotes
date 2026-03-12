
/*
 
// HStacken som innehåller alla edit och sort buttons
                                    HStack (spacing: 10) {
                                        ZStack { // Hela ska finnas inside detta ZStacken förutom Task Page namen
                                            
// MARK: – PAGE 1 🔅 if !($EditMode.wrappedValue) {
                                            if !($EditMode.wrappedValue) {
                                                HStack {
                                                    
                                                    //.................
                                                    
                                                    if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                        
                                                        Button(
                                                            action: {
                                                                CountIMPandURGTasks()
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
                                                        
                                                        if $isThereAnyIMPandURGItem.wrappedValue {
                                                            Divider()
                                                                .frame(width: 2, height: 32, alignment: .leading)
                                                                .background(colorScheme == .dark ? Color.DividerBackgroundDarkMode : Color.DividerBackgroundLightMode)
                                                            Button(
                                                                action: {
                                                                    CountIMPandURGTasks()
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
                                                            if $isThereMoreThanOneIMPandURGItem.wrappedValue {
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
                                                            } // MARK: – för if $isThereMoreThanOneIMPandURGItem.wrappedValue {
                                                            
                                                        } // MARK: – för if $isThereAnyIMPandURGItem.wrappedValue {
                                                        
                                                    } // MARK: – if !($Sorted.wrappedValue) && !($Showing.wrappedValue) {
                                                    
                                                    
                                                    //.................
                                                    
                                                    if $Showing.wrappedValue && !($Sorted.wrappedValue) {
                                                        
                                                        if !($ShowingAndSortedIfTrueElseShowing.wrappedValue) {
                                                            
                                                            if !($showBackButtonForSortinShowingAndSortedIfTrue.wrappedValue) {
                                                                Button(
                                                                    action: {
                                                                        Showing = false
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
                                                                                                                                                            
                                                                                                                                                            realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                                                                                                                                            
                                                                                                                                                            realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                                                                                                                                            
                                                                                                                                                            realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                                                                                                                                            
                                                                                                                                                            realmManager.FilterAndSortP1(ShowShowBarForTaskNameIfTrueElseTaskDescription, helpWithShowCONTAINS, ShowSortByDateAfterUnshowButtonIfTrueElsePriority, ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing)
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
                                                        if $ShowingAndSortedIfTrueElseShowing.wrappedValue {
                                                            Button(
                                                                action: {
                                                                    Showing = false
                                                                    ShowFilterAndSortMode = false
                                                                    ShowingAndSortedIfTrueElseShowing = false
                                                                    
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
                                                    
                                                    if $Sorted.wrappedValue && !($Showing.wrappedValue) {
                                                        Button(
                                                            action: {
                                                                Sorted = false
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
// MARK: – PAGE 1 ⚡️ if $EditMode.wrappedValue {
                                            if $EditMode.wrappedValue {
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
                                                    if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
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
                                                    } // MARK: – if $AddMode.wrappedValue && !($DeleteMode.wrappedValue) &&  !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                    
                                  // 2. EDIT ⚡️∙∙∙∙∙
                                                    if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                        
                                                        Text(" ")
                                                        if $isThereAnyIMPandURGItem.wrappedValue {
                                                            HStack (spacing: 0) {
                                                                Button(
                                                                    action: {
                                                                        CountIMPandURGTasks()
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
                                                                        CountIMPandURGTasks()
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
                                                        } // MARK: – if $isThereAnyIMPandURGItem.wrappedValue {
                                                        
                                                    } // MARK: –  if !($AddMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($MoveMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                    
                                                    if $isThereAnyIMPandURGItem.wrappedValue {
                            // 2.1 inside EDIT  ⚡️∙∙∙∙∙
                                                        if $DeleteMode.wrappedValue && !($MoveMode.wrappedValue) && !($AddMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                            
                                                            Button(
                                                                action: {
                                                                    realmManager.deleteAllP1ItemisCurrentlyMarkedMarking()
                                                                    CountIMPandURGTasks()
                                                                    if !isThereAnyIMPandURGItem {
                                                                        resetEditModeValuesAndCountTasksFor(page: 1)
                                                                    }
                                                                    
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
                                                                            realmManager.rmAllP1Tasks()
                                                                            CountIMPandURGTasks()
                                                                            
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
                             // 2.2 inside EDIT ⚡️∙∙∙∙∙
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
                                                                    realmManager.removeTasksThatIsCurrentlyMarkedFrom(page: 1, andAddToPage: addTasksToPage)
                                                                    
                                                                    CountIMPandURGTasks()
                                                                    if !isThereAnyIMPandURGItem {
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
                                                            
                                                        } // MARK: – if $MoveMode.wrappedValue && !($AddMode.wrappedValue)  && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) && !($SortMode.wrappedValue) {
                                                        
                                                    } // MARK: – if $isThereAnyIMPandURGItem.wrappedValue {
                                                    
                                                    if $isThereMoreThanOneIMPandURGItem.wrappedValue {
                                      // 3 SHOW ⚡️∙∙∙∙∙
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
                                                            
                                                        } // MARK: – för if $ShowMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($SortMode.wrappedValue) {
                                       // 4 SORT ⚡️∙∙∙∙∙
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
                                                                        if !($TasksIsSortedbyDateIfTrueElsePriority.wrappedValue) {
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
                                                        } // MARK: –  if $SortMode.wrappedValue && !($AddMode.wrappedValue) && !($MoveMode.wrappedValue) && !($DeleteMode.wrappedValue) && !($ShowMode.wrappedValue) {
                                                        
                                                    } // MARK: – if $isThereMoreThanOneIMPandURGItem.wrappedValue {
                                                    
                                                }.frame(width: 230, alignment: .leading) // MARK: – HStack (spacing: 2) inside if $EditMode.wrappedValue {
                                            } // MARK: – if $EditMode.wrappedValue {
                                            
                                        } // MARK: – ZStack inside HStack
                                      
                                        ListPageName(1)
                                            .offset(CGSize(width: 18.00, height: 0.00))
                                    }.frame(width: 305, height: 18, alignment: .leading) // MARK: – HStacken som är inside VStack (spacing: 8) { som är inside VStack (spacing: 10) {
*/
