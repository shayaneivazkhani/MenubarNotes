
//  RealmManager.swift
//  Notes
//
//  Created by Shayan Eivaz Khani on 2022-10-28.

//  RealmManager.swift.
//  a class called RealmManager, where you will manage everything related to Realm. It'll conform to an ObservableObject.
//  Created by Shayan Eivaz Khani on 2022-05-27.

/*
   Realm is an open-source database that lets you save data offline.
   It's a full-featured, object-oriented, cross-platform database
   that persists data locally on a device.
 
   Realm is a cross platform mobile database for iOS (available
   in Swift & Objective-C) and Android. Realm is built to be better
   and faster than SQLite and Core Data. It is not just better or
   faster, it’s also easier to use and you can do a lot of things
   with just few lines of code.
*/

/**
 On macOS, Realm typically stores its files in your app’s sandboxed Application Support directory:
 
     let realmURL = FileManager.default
         .urls(for: .applicationSupportDirectory, in: .userDomainMask)
         .first!
         .appendingPathComponent("default.realm")
 
 This file stays untouched across app updates unless:

 You manually delete it in your code.
 You change the Realm file location or name.
 You change the Realm schema and don’t handle migration properly.
 Uninstalling the app will remove all local data, including the Realm file.
 
 
    Situation        |          What Happens to Realm Data?      |         Notes
 Basic app update   –––  ✅ Data remains  –––    No changes needed if schema is the same.
 Realm schema changes   –––   ⚠️ Migration required  –––    If you add/remove properties, update your schema version and provide a migration block.
 Realm file location/name changed   –––   ❌ Data lost unless migrated manually  –––    You’d need to migrate the file or manually copy it.
 App is uninstalled (not updated)  –––    ❌ Data lost  –––    Uninstalling the app removes its sandbox, including Realm files.
 */
 /**
 If you update the Realm schema (e.g., add a property), you must handle migration:
 
 let config = Realm.Configuration(
     schemaVersion: 2, // increment this
     migrationBlock: { migration, oldSchemaVersion in
         if oldSchemaVersion < 2 {
             // Migration logic if needed
         }
     }
 )

 Realm.Configuration.defaultConfiguration = config
*/

/**
 if i have data in my version of the app while developing, if i push an update without deleting every record in my own app before  xcode compiles it and uploades it to appstore, will other users get my data?
 
 🔐 Short answer:
 No, your local development data is not included in the version of the app you upload to the App Store. Your users will not receive your local development data.

 🧠 Why?
 Realm stores its data in the app's sandboxed container on your Mac during development. This data is:

 Local to your development machine.
 Stored in ~/Library/Containers/YourAppID/Data/Library/Application Support/...
 Not bundled into the .app or .ipa file when Xcode builds your app for App Store submission.
 The .realm file is not part of your app bundle unless you explicitly add it as a resource, which you almost never should.
 
 🚫 When could your development data accidentally be shipped?
 This would only happen if you manually added your .realm file into the app bundle in Xcode like this:

 Dragging default.realm into your Xcode project.
 Setting it to be included in the app target (i.e., under Copy Bundle Resources).
 📌 If you did that, then yes, your data would be shipped, and all users would receive that copy on first launch — bad idea for production apps.

 ✅ Safe Practice Checklist
 Here’s how to make sure you’re not bundling dev data:

 Never include .realm files in your project. Realm files are runtime data, not resources.
 Confirm this by checking:
    • In Xcode > Project Navigator, make sure no .realm files are listed.
    • In Build Phases > Copy Bundle Resources, make sure there's no .realm file.
 Rely on Realm to create the database on first launch based on your models and migration code.
 
 💬 Bottom line:
 Realm database contents on your dev Mac stay on your dev Mac.
 When your users install the app, their Realm database starts empty (or gets populated by your app logic, API, etc.).
 You are safe, as long as you didn’t bundle the Realm file manually.
*/

import Foundation
import RealmSwift
import SwiftUI

class RealmManager: ObservableObject {
    // Helpers ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    
    var stringBuilder = StringBuilder()
    
    // MARK: – 💧 a variable, called localRealm •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
        /* Create a variable, called localRealm, in which you'll save your Realm. */
    private(set) var localRealm: Realm?
     
    // MARK: – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – –
  
    @Published var AppSettings: [GeneralApplicationSettingsAndValues] = []
    
    @Published var p1Settings: [p1SettingsAndValues] = []
    @Published var p2Settings: [p2SettingsAndValues] = []
    @Published var p3Settings: [p3SettingsAndValues] = []
    @Published var p4Settings: [p4SettingsAndValues] = []
    
/*
     Page 1: IMP and URG
     Page 2: IMP
     Page 3: URG
     Page 4: NOTHING
*/
    // Listorna
    @Published var p1Tasks: [Page1TaskItem] = []
        @Published var p1TasksPriorityZero: [Page1TaskItem] = []
        @Published var p1TasksPriorityOne: [Page1TaskItem] = []
        @Published var p1TasksPriorityTwo: [Page1TaskItem] = []
        @Published var p1TasksPriorityThree: [Page1TaskItem] = []
    @Published var p2Tasks: [Page2TaskItem] = []
        @Published var p2TasksPriorityZero: [Page2TaskItem] = []
        @Published var p2TasksPriorityOne: [Page2TaskItem] = []
        @Published var p2TasksPriorityTwo: [Page2TaskItem] = []
        @Published var p2TasksPriorityThree: [Page2TaskItem] = []
    @Published var p3Tasks: [Page3TaskItem] = []
        @Published var p3TasksPriorityZero: [Page3TaskItem] = []
        @Published var p3TasksPriorityOne: [Page3TaskItem] = []
        @Published var p3TasksPriorityTwo: [Page3TaskItem] = []
        @Published var p3TasksPriorityThree: [Page3TaskItem] = []
    @Published var p4Tasks: [Page4TaskItem] = []
        @Published var p4TasksPriorityZero: [Page4TaskItem] = []
        @Published var p4TasksPriorityOne: [Page4TaskItem] = []
        @Published var p4TasksPriorityTwo: [Page4TaskItem] = []
        @Published var p4TasksPriorityThree: [Page4TaskItem] = []
    
// MARK: ✅ Start Up the Data "world/engine" – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – –
    
    /* Call the openRealm function on initialize of your RealmManager class. And let's call the addCourse function on initialize of the RealmManager.*/
    init() {
        openRealm()
        
// MARK: – OG Original way of doing things ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
/*
        //addCourse()                                               // 1
            getCourses() /* get all the courses saved in Realm. */ // 2
            updateCourses()                                       // 3
*/
        
// MARK: – Fist Start For Realm ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
/*
        createGeneralSettingObjectAndFourPageViewValueObjectInRealm()
        
        addToP1()
            getP1()
            updateP1()
        addToP2()
            getP2()
            updateP2()
        addToP3()
            getP3()
            updateP3()
        addToP4()
            getP4()
            updateP4()
*/
// MARK: – RESTART ( to RESTART -› uncomment endast raden nedan –› RUN & TERMINATE –› comment again –› DONE! :) ・・・・・・・・・・・・・・・・・・・・・
        
        //ResetApplicationByDeleteEverythingInDataBase()
        
// MARK: – NORMAL way of accessing the stored objects (run all functions) ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
        getGeneralAppSettingsAndPageViewSettings()
        updateGeneralAppSettingsAndPageViewSettings()
        
        getP1()
        updateP1()
        
        getP2()
        updateP2()
        
        getP3()
        updateP3()
        
        getP4()
        updateP4()
        
        unmarkAllP1ItemisCurrentlyMarkedMarking()
        unmarkAllP2ItemisCurrentlyMarkedMarking()
        unmarkAllP3ItemisCurrentlyMarkedMarking()
        unmarkAllP4ItemisCurrentlyMarkedMarking()
    }
        /* To open a Realm, use the following code. Before creating our local Realm, we are setting its configuration. Remember to increment the schemaVersion any time you update your Realm schema. Then, we're opening a Realm and it will be saved into the localRealm variable we just created. */
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // Do something, usually updating the schema's variables here
                }
            })
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
// ✅
}
 

extension RealmManager {
    
    //❗️💥 OBS! kör denna 1 gång sedan uncomment och rebuild the app, och då är allting fresh på nytt💥❗️
    func ResetApplicationByDeleteEverythingInDataBase() {
        rmAll()
        createGeneralSettingObjectAndFourPageViewValueObjectInRealm()
    
        addToP1()
            getP1()
            updateP1()
        addToP2()
            getP2()
            updateP2()
        addToP3()
            getP3()
            updateP3()
        addToP4()
            getP4()
            updateP4()
    }
    
    /* radera all Data -> allting som är i alla listor */
    func rmAll() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.deleteAll()
                    
                    updateGeneralAppSettingsAndPageViewSettings()
                    updateP1()
                    updateP2()
                    updateP3()
                    updateP4()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
}


// MARK: – 💥∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙💥

class GeneralApplicationSettingsAndValues: Object
{
    @objc dynamic var applicationExpirationDate = Date()
    
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
    
    @objc dynamic var appSettingExtraInt1 = 0
    @objc dynamic var appSettingExtraBoolan1 = false
    @objc dynamic var appSettingExtraString1 = ""
    
    @objc dynamic var appSettingExtraInt2 = 0
    @objc dynamic var appSettingExtraBoolan2 = false
    @objc dynamic var appSettingExtraString2 = ""
    
    @objc dynamic var appSettingExtraInt3 = 0
    @objc dynamic var appSettingExtraBoolan3 = false
    @objc dynamic var appSettingExtraString3 = ""
}

//💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
    
class p1SettingsAndValues: Object
{
    @objc dynamic var Showing = false
    @objc dynamic var ShowingAndSortedIfTrueElseShowing = false
    @objc dynamic var Sorted = false
    
    @objc dynamic var ShowTextFieldTaskNameFilterResultTextHint = ""
    @objc dynamic var ShowTextFieldTaskDescriptionFilterResultTextHint = ""
    @objc dynamic var ShowCONTAINSTaskName = ""
    @objc dynamic var ShowCONTAINSTaskDescription = ""
    @objc dynamic var helpWithShowCONTAINS = ""
    
    @objc dynamic var ShowShowBarForTaskNameIfTrueElseTaskDescription = true
    @objc dynamic var uselessButUsedinShowItemsAfterSavingTask = false
    @objc dynamic var thereIsItemsInCallFromShowButton = false
    
    @objc dynamic var TasksIsSortedbyDateIfTrueElsePriority = true
    @objc dynamic var TasksIsSortedIncreasingIfTrueElseDecreasing = true
    @objc dynamic var SortByIncreasing = false
    
    @objc dynamic var ShowSortRequirementAfterUnshow = true
    @objc dynamic var ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
    @objc dynamic var ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
    
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

//💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧
    
class p2SettingsAndValues: Object
{
    @objc dynamic var Showing = false
    @objc dynamic var ShowingAndSortedIfTrueElseShowing = false
    @objc dynamic var Sorted = false
    
    @objc dynamic var ShowTextFieldTaskNameFilterResultTextHint = ""
    @objc dynamic var ShowTextFieldTaskDescriptionFilterResultTextHint = ""
    @objc dynamic var ShowCONTAINSTaskName = ""
    @objc dynamic var ShowCONTAINSTaskDescription = ""
    @objc dynamic var helpWithShowCONTAINS = ""
    
    @objc dynamic var ShowShowBarForTaskNameIfTrueElseTaskDescription = true
    @objc dynamic var uselessButUsedinShowItemsAfterSavingTask = false
    @objc dynamic var thereIsItemsInCallFromShowButton = false
    
    @objc dynamic var TasksIsSortedbyDateIfTrueElsePriority = true
    @objc dynamic var TasksIsSortedIncreasingIfTrueElseDecreasing = true
    @objc dynamic var SortByIncreasing = false
    
    @objc dynamic var ShowSortRequirementAfterUnshow = true
    @objc dynamic var ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
    @objc dynamic var ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
    
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

//💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧

class p3SettingsAndValues: Object
{
    @objc dynamic var Showing = false
    @objc dynamic var ShowingAndSortedIfTrueElseShowing = false
    @objc dynamic var Sorted = false
    
    @objc dynamic var ShowTextFieldTaskNameFilterResultTextHint = ""
    @objc dynamic var ShowTextFieldTaskDescriptionFilterResultTextHint = ""
    @objc dynamic var ShowCONTAINSTaskName = ""
    @objc dynamic var ShowCONTAINSTaskDescription = ""
    @objc dynamic var helpWithShowCONTAINS = ""
    
    @objc dynamic var ShowShowBarForTaskNameIfTrueElseTaskDescription = true
    @objc dynamic var uselessButUsedinShowItemsAfterSavingTask = false
    @objc dynamic var thereIsItemsInCallFromShowButton = false
    
    @objc dynamic var TasksIsSortedbyDateIfTrueElsePriority = true
    @objc dynamic var TasksIsSortedIncreasingIfTrueElseDecreasing = true
    @objc dynamic var SortByIncreasing = false
    
    @objc dynamic var ShowSortRequirementAfterUnshow = true
    @objc dynamic var ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
    @objc dynamic var ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
    
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

//💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧💧

class p4SettingsAndValues: Object
 {
    @objc dynamic var Showing = false
    @objc dynamic var ShowingAndSortedIfTrueElseShowing = false
    @objc dynamic var Sorted = false
    
    @objc dynamic var ShowTextFieldTaskNameFilterResultTextHint = ""
    @objc dynamic var ShowTextFieldTaskDescriptionFilterResultTextHint = ""
    @objc dynamic var ShowCONTAINSTaskName = ""
    @objc dynamic var ShowCONTAINSTaskDescription = ""
    @objc dynamic var helpWithShowCONTAINS = ""
    
    @objc dynamic var ShowShowBarForTaskNameIfTrueElseTaskDescription = true
    @objc dynamic var uselessButUsedinShowItemsAfterSavingTask = false
    @objc dynamic var thereIsItemsInCallFromShowButton = false
    
    @objc dynamic var TasksIsSortedbyDateIfTrueElsePriority = true
    @objc dynamic var TasksIsSortedIncreasingIfTrueElseDecreasing = true
    @objc dynamic var SortByIncreasing = false
    
    @objc dynamic var ShowSortRequirementAfterUnshow = true
    @objc dynamic var ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
    @objc dynamic var ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
    
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

extension RealmManager {
    
    // MARK: – ❗️ Use only Once, because it deletes alla settings and builds 4 new from scratch and adds it it field array
    func createGeneralSettingObjectAndFourPageViewValueObjectInRealm() {
        if let localRealm = localRealm {
            
            do {
                try localRealm.write {
                    
                // 0
                    let newAppSettings = GeneralApplicationSettingsAndValues()
                    
                    newAppSettings.applicationExpirationDate = Date()
                    
                    newAppSettings.extraInt = 0
                    newAppSettings.extraBoolan = false
                    newAppSettings.extraString = ""
                    
                    newAppSettings.appSettingExtraInt1 = 0
                    newAppSettings.appSettingExtraBoolan1 = false
                    newAppSettings.appSettingExtraString1 = ""
                    
                    newAppSettings.appSettingExtraInt2 = 0
                    newAppSettings.appSettingExtraBoolan2 = false
                    newAppSettings.appSettingExtraString2 = ""
                    
                    newAppSettings.appSettingExtraInt3 = 0
                    newAppSettings.appSettingExtraBoolan3 = false
                    newAppSettings.appSettingExtraString3 = ""
                    
                // 1
                    let newSetting1 = p1SettingsAndValues()
                    
                    newSetting1.Showing = false
                    newSetting1.ShowingAndSortedIfTrueElseShowing = false
                    newSetting1.Sorted = false
                    
                    newSetting1.ShowTextFieldTaskNameFilterResultTextHint = ""
                    newSetting1.ShowTextFieldTaskDescriptionFilterResultTextHint = ""
                    newSetting1.ShowCONTAINSTaskName = ""
                    newSetting1.ShowCONTAINSTaskDescription = ""
                    newSetting1.helpWithShowCONTAINS = ""
                    
                    newSetting1.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                    newSetting1.uselessButUsedinShowItemsAfterSavingTask = false
                    newSetting1.thereIsItemsInCallFromShowButton = false
                    
                    newSetting1.TasksIsSortedbyDateIfTrueElsePriority = true
                    newSetting1.TasksIsSortedIncreasingIfTrueElseDecreasing = true
                    newSetting1.SortByIncreasing = false
                    
                    newSetting1.ShowSortRequirementAfterUnshow = true
                    newSetting1.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                    newSetting1.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                    
                    newSetting1.extraInt = 0
                    newSetting1.extraBoolan = false
                    newSetting1.extraString = ""
                    
                    // 2
                    let newSetting2 = p2SettingsAndValues()
                    
                    newSetting2.Showing = false
                    newSetting2.ShowingAndSortedIfTrueElseShowing = false
                    newSetting2.Sorted = false
                    
                    newSetting2.ShowTextFieldTaskNameFilterResultTextHint = ""
                    newSetting2.ShowTextFieldTaskDescriptionFilterResultTextHint = ""
                    newSetting2.ShowCONTAINSTaskName = ""
                    newSetting2.ShowCONTAINSTaskDescription = ""
                    newSetting2.helpWithShowCONTAINS = ""
                    
                    newSetting2.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                    newSetting2.uselessButUsedinShowItemsAfterSavingTask = false
                    newSetting2.thereIsItemsInCallFromShowButton = false
                    
                    newSetting2.TasksIsSortedbyDateIfTrueElsePriority = true
                    newSetting2.TasksIsSortedIncreasingIfTrueElseDecreasing = true
                    newSetting2.SortByIncreasing = false
                    
                    newSetting2.ShowSortRequirementAfterUnshow = true
                    newSetting2.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                    newSetting2.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                    
                    newSetting2.extraInt = 0
                    newSetting2.extraBoolan = false
                    newSetting2.extraString = ""
                    
                    // 3
                    let newSetting3 = p3SettingsAndValues()
                    
                    newSetting3.Showing = false
                    newSetting3.ShowingAndSortedIfTrueElseShowing = false
                    newSetting3.Sorted = false
                    
                    newSetting3.ShowTextFieldTaskNameFilterResultTextHint = ""
                    newSetting3.ShowTextFieldTaskDescriptionFilterResultTextHint = ""
                    newSetting3.ShowCONTAINSTaskName = ""
                    newSetting3.ShowCONTAINSTaskDescription = ""
                    newSetting3.helpWithShowCONTAINS = ""
                    
                    newSetting3.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                    newSetting3.uselessButUsedinShowItemsAfterSavingTask = false
                    newSetting3.thereIsItemsInCallFromShowButton = false
                    
                    newSetting3.TasksIsSortedbyDateIfTrueElsePriority = true
                    newSetting3.TasksIsSortedIncreasingIfTrueElseDecreasing = true
                    newSetting3.SortByIncreasing = false
                    
                    newSetting3.ShowSortRequirementAfterUnshow = true
                    newSetting3.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                    newSetting3.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                    
                    newSetting3.extraInt = 0
                    newSetting3.extraBoolan = false
                    newSetting3.extraString = ""
                    
                    // 4
                    let newSetting4 = p4SettingsAndValues()
                    
                    newSetting4.Showing = false
                    newSetting4.ShowingAndSortedIfTrueElseShowing = false
                    newSetting4.Sorted = false
                    
                    newSetting4.ShowTextFieldTaskNameFilterResultTextHint = ""
                    newSetting4.ShowTextFieldTaskDescriptionFilterResultTextHint = ""
                    newSetting4.ShowCONTAINSTaskName = ""
                    newSetting4.ShowCONTAINSTaskDescription = ""
                    newSetting4.helpWithShowCONTAINS = ""
                    
                    newSetting4.ShowShowBarForTaskNameIfTrueElseTaskDescription = true
                    newSetting4.uselessButUsedinShowItemsAfterSavingTask = false
                    newSetting4.thereIsItemsInCallFromShowButton = false
                    
                    newSetting4.TasksIsSortedbyDateIfTrueElsePriority = true
                    newSetting4.TasksIsSortedIncreasingIfTrueElseDecreasing = true
                    newSetting4.SortByIncreasing = false
                    
                    newSetting4.ShowSortRequirementAfterUnshow = true
                    newSetting4.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = true
                    newSetting4.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = true
                    
                    newSetting4.extraInt = 0
                    newSetting4.extraBoolan = false
                    newSetting4.extraString = ""
                    
                    // 5
                    localRealm.add(newAppSettings)
                    localRealm.add(newSetting1)
                    localRealm.add(newSetting2)
                    localRealm.add(newSetting3)
                    localRealm.add(newSetting4)
                    
                    // 6
                    updateGeneralAppSettingsAndPageViewSettings()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    func getGeneralAppSettingsAndPageViewSettings() {
        if let localRealm = localRealm {
            let appSetting = localRealm.objects(GeneralApplicationSettingsAndValues.self)
            appSetting.forEach { setting in
                AppSettings.append(setting)
            }
            
            let allP1Settings = localRealm.objects(p1SettingsAndValues.self)
            let allP2Settings = localRealm.objects(p2SettingsAndValues.self)
            let allP3Settings = localRealm.objects(p3SettingsAndValues.self)
            let allP4Settings = localRealm.objects(p4SettingsAndValues.self)
            
            allP1Settings.forEach { p1Setting in
                p1Settings.append(p1Setting)
            }
            allP2Settings.forEach { p2Setting in
                p2Settings.append(p2Setting)
            }
            allP3Settings.forEach { p3Setting in
                p3Settings.append(p3Setting)
            }
            allP4Settings.forEach { p4Setting in
                p4Settings.append(p4Setting)
            }
        }
    }
    func updateGeneralAppSettingsAndPageViewSettings() {
        AppSettings = []
        
        p1Settings = []
        p2Settings = []
        p3Settings = []
        p4Settings = []
        
        getGeneralAppSettingsAndPageViewSettings()
    }
    
    
    func setApplicationPage1ViewValues(show: Bool, showANDsortedIfTrueElseShow: Bool, sort: Bool, shoTexFiTaskNamFiReTeHi: String, shoTexFiTaskDescripFiReTeHi: String, shoCONTNam: String, shoCONTDescrip: String, helpWiShoCONT: String, shoshoBaFoNAMIfTruElseDescrip: Bool, uselessButUsedinShoItmAFsavingTask: Bool, thereisItmInCallfroSho: Bool, taskIsSorByDatIfTrueElsePrio: Bool, taskIsSorByINCIfTrueElseDEC: Bool, sorByINC: Bool, shoSorByDatAfterUnShoBuTIfTrueElsePrio: Bool, shoSorByINCAfterUnShoBuTIfTrueElseDEC: Bool) {
        if let localRealm = localRealm {
            let allP1Setting = localRealm.objects(p1SettingsAndValues.self).first
            
            try! localRealm.write {
                if let allP1Setting = allP1Setting {
                    allP1Setting.Showing = show
                    allP1Setting.ShowingAndSortedIfTrueElseShowing = showANDsortedIfTrueElseShow
                    allP1Setting.Sorted = sort
                    
                    allP1Setting.ShowTextFieldTaskNameFilterResultTextHint = shoTexFiTaskNamFiReTeHi
                    allP1Setting.ShowTextFieldTaskDescriptionFilterResultTextHint = shoTexFiTaskDescripFiReTeHi
                    allP1Setting.ShowCONTAINSTaskName = shoCONTNam
                    allP1Setting.ShowCONTAINSTaskDescription = shoCONTDescrip
                    allP1Setting.helpWithShowCONTAINS = helpWiShoCONT
                    
                    allP1Setting.ShowShowBarForTaskNameIfTrueElseTaskDescription = shoshoBaFoNAMIfTruElseDescrip
                    allP1Setting.uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShoItmAFsavingTask
                    allP1Setting.thereIsItemsInCallFromShowButton = thereisItmInCallfroSho
                    
                    allP1Setting.TasksIsSortedbyDateIfTrueElsePriority = taskIsSorByDatIfTrueElsePrio
                    allP1Setting.TasksIsSortedIncreasingIfTrueElseDecreasing = taskIsSorByINCIfTrueElseDEC
                    allP1Setting.SortByIncreasing = sorByINC
                    
                    allP1Setting.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = shoSorByDatAfterUnShoBuTIfTrueElsePrio
                    allP1Setting.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = shoSorByINCAfterUnShoBuTIfTrueElseDEC
                }
            }
        }
    }
    func setApplicationPage2ViewValues(show: Bool, showANDsortedIfTrueElseShow: Bool, sort: Bool, shoTexFiTaskNamFiReTeHi: String, shoTexFiTaskDescripFiReTeHi: String, shoCONTNam: String, shoCONTDescrip: String, helpWiShoCONT: String, shoshoBaFoNAMIfTruElseDescrip: Bool, uselessButUsedinShoItmAFsavingTask: Bool, thereisItmInCallfroSho: Bool, taskIsSorByDatIfTrueElsePrio: Bool, taskIsSorByINCIfTrueElseDEC: Bool, sorByINC: Bool, shoSorByDatAfterUnShoBuTIfTrueElsePrio: Bool, shoSorByINCAfterUnShoBuTIfTrueElseDEC: Bool) {
        if let localRealm = localRealm {
            let allP2Setting = localRealm.objects(p2SettingsAndValues.self).first
            
            try! localRealm.write {
                if let allP2Setting = allP2Setting {
                    allP2Setting.Showing = show
                    allP2Setting.ShowingAndSortedIfTrueElseShowing = showANDsortedIfTrueElseShow
                    allP2Setting.Sorted = sort
                    
                    allP2Setting.ShowTextFieldTaskNameFilterResultTextHint = shoTexFiTaskNamFiReTeHi
                    allP2Setting.ShowTextFieldTaskDescriptionFilterResultTextHint = shoTexFiTaskDescripFiReTeHi
                    allP2Setting.ShowCONTAINSTaskName = shoCONTNam
                    allP2Setting.ShowCONTAINSTaskDescription = shoCONTDescrip
                    allP2Setting.helpWithShowCONTAINS = helpWiShoCONT
                    
                    allP2Setting.ShowShowBarForTaskNameIfTrueElseTaskDescription = shoshoBaFoNAMIfTruElseDescrip
                    allP2Setting.uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShoItmAFsavingTask
                    allP2Setting.thereIsItemsInCallFromShowButton = thereisItmInCallfroSho
                    
                    allP2Setting.TasksIsSortedbyDateIfTrueElsePriority = taskIsSorByDatIfTrueElsePrio
                    allP2Setting.TasksIsSortedIncreasingIfTrueElseDecreasing = taskIsSorByINCIfTrueElseDEC
                    allP2Setting.SortByIncreasing = sorByINC
                    
                    allP2Setting.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = shoSorByDatAfterUnShoBuTIfTrueElsePrio
                    allP2Setting.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = shoSorByINCAfterUnShoBuTIfTrueElseDEC
                }
            }
        }
    }
    func setApplicationPage3ViewValues(show: Bool, showANDsortedIfTrueElseShow: Bool, sort: Bool, shoTexFiTaskNamFiReTeHi: String, shoTexFiTaskDescripFiReTeHi: String, shoCONTNam: String, shoCONTDescrip: String, helpWiShoCONT: String, shoshoBaFoNAMIfTruElseDescrip: Bool, uselessButUsedinShoItmAFsavingTask: Bool, thereisItmInCallfroSho: Bool, taskIsSorByDatIfTrueElsePrio: Bool, taskIsSorByINCIfTrueElseDEC: Bool, sorByINC: Bool, shoSorByDatAfterUnShoBuTIfTrueElsePrio: Bool, shoSorByINCAfterUnShoBuTIfTrueElseDEC: Bool) {
        if let localRealm = localRealm {
            let allP3Setting = localRealm.objects(p3SettingsAndValues.self).first
            
            try! localRealm.write {
                if let allP3Setting = allP3Setting {
                    allP3Setting.Showing = show
                    allP3Setting.ShowingAndSortedIfTrueElseShowing = showANDsortedIfTrueElseShow
                    allP3Setting.Sorted = sort
                    
                    allP3Setting.ShowTextFieldTaskNameFilterResultTextHint = shoTexFiTaskNamFiReTeHi
                    allP3Setting.ShowTextFieldTaskDescriptionFilterResultTextHint = shoTexFiTaskDescripFiReTeHi
                    allP3Setting.ShowCONTAINSTaskName = shoCONTNam
                    allP3Setting.ShowCONTAINSTaskDescription = shoCONTDescrip
                    allP3Setting.helpWithShowCONTAINS = helpWiShoCONT
                    
                    allP3Setting.ShowShowBarForTaskNameIfTrueElseTaskDescription = shoshoBaFoNAMIfTruElseDescrip
                    allP3Setting.uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShoItmAFsavingTask
                    allP3Setting.thereIsItemsInCallFromShowButton = thereisItmInCallfroSho
                    
                    allP3Setting.TasksIsSortedbyDateIfTrueElsePriority = taskIsSorByDatIfTrueElsePrio
                    allP3Setting.TasksIsSortedIncreasingIfTrueElseDecreasing = taskIsSorByINCIfTrueElseDEC
                    allP3Setting.SortByIncreasing = sorByINC
                    
                    allP3Setting.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = shoSorByDatAfterUnShoBuTIfTrueElsePrio
                    allP3Setting.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = shoSorByINCAfterUnShoBuTIfTrueElseDEC
                }
            }
        }
    }
    func setApplicationPage4ViewValues(show: Bool, showANDsortedIfTrueElseShow: Bool, sort: Bool, shoTexFiTaskNamFiReTeHi: String, shoTexFiTaskDescripFiReTeHi: String, shoCONTNam: String, shoCONTDescrip: String, helpWiShoCONT: String, shoshoBaFoNAMIfTruElseDescrip: Bool, uselessButUsedinShoItmAFsavingTask: Bool, thereisItmInCallfroSho: Bool, taskIsSorByDatIfTrueElsePrio: Bool, taskIsSorByINCIfTrueElseDEC: Bool, sorByINC: Bool, shoSorByDatAfterUnShoBuTIfTrueElsePrio: Bool, shoSorByINCAfterUnShoBuTIfTrueElseDEC: Bool) {
        if let localRealm = localRealm {
            let allP4Setting = localRealm.objects(p4SettingsAndValues.self).first
            
            try! localRealm.write {
                if let allP4Setting = allP4Setting {
                    allP4Setting.Showing = show
                    allP4Setting.ShowingAndSortedIfTrueElseShowing = showANDsortedIfTrueElseShow
                    allP4Setting.Sorted = sort
                    
                    allP4Setting.ShowTextFieldTaskNameFilterResultTextHint = shoTexFiTaskNamFiReTeHi
                    allP4Setting.ShowTextFieldTaskDescriptionFilterResultTextHint = shoTexFiTaskDescripFiReTeHi
                    allP4Setting.ShowCONTAINSTaskName = shoCONTNam
                    allP4Setting.ShowCONTAINSTaskDescription = shoCONTDescrip
                    allP4Setting.helpWithShowCONTAINS = helpWiShoCONT
                    
                    allP4Setting.ShowShowBarForTaskNameIfTrueElseTaskDescription = shoshoBaFoNAMIfTruElseDescrip
                    allP4Setting.uselessButUsedinShowItemsAfterSavingTask = uselessButUsedinShoItmAFsavingTask
                    allP4Setting.thereIsItemsInCallFromShowButton = thereisItmInCallfroSho
                    
                    allP4Setting.TasksIsSortedbyDateIfTrueElsePriority = taskIsSorByDatIfTrueElsePrio
                    allP4Setting.TasksIsSortedIncreasingIfTrueElseDecreasing = taskIsSorByINCIfTrueElseDEC
                    allP4Setting.SortByIncreasing = sorByINC
                    
                    allP4Setting.ShowSortByDateAfterUnshowButtonIfTrueElsePriority = shoSorByDatAfterUnShoBuTIfTrueElsePrio
                    allP4Setting.ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing = shoSorByINCAfterUnShoBuTIfTrueElseDEC
                }
            }
        }
    }
}

extension RealmManager {
    
    func getPageViewSettingsValueForPage1() -> (Bool, Bool, Bool, String, String, String, String, String, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool) {
        let bo1 = p1Settings[0].Showing
        let bo2 = p1Settings[0].ShowingAndSortedIfTrueElseShowing
        let bo3 = p1Settings[0].Sorted
        
        let str1 = p1Settings[0].ShowTextFieldTaskNameFilterResultTextHint
        let str2 = p1Settings[0].ShowTextFieldTaskDescriptionFilterResultTextHint
        let str3 = p1Settings[0].ShowCONTAINSTaskName
        let str4 = p1Settings[0].ShowCONTAINSTaskDescription
        let str5 = p1Settings[0].helpWithShowCONTAINS
        
        let bo4 = p1Settings[0].ShowShowBarForTaskNameIfTrueElseTaskDescription
        let bo5 = p1Settings[0].uselessButUsedinShowItemsAfterSavingTask
        let bo6 = p1Settings[0].thereIsItemsInCallFromShowButton
        
        let bo7 = p1Settings[0].TasksIsSortedbyDateIfTrueElsePriority
        let bo8 = p1Settings[0].TasksIsSortedIncreasingIfTrueElseDecreasing
        let bo9 = p1Settings[0].SortByIncreasing
        
        let bo10 = p1Settings[0].ShowSortRequirementAfterUnshow
        let bo11 = p1Settings[0].ShowSortByDateAfterUnshowButtonIfTrueElsePriority
        let bo12 = p1Settings[0].ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
        
        return (bo1, bo2, bo3, str1, str2, str3, str4, str5, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11, bo12)
    }
    
    func getPageViewSettingsValueForPage2() -> (Bool, Bool, Bool, String, String, String, String, String, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool) {
        let bo1 = p2Settings[0].Showing
        let bo2 = p2Settings[0].ShowingAndSortedIfTrueElseShowing
        let bo3 = p2Settings[0].Sorted
        
        let str1 = p2Settings[0].ShowTextFieldTaskNameFilterResultTextHint
        let str2 = p2Settings[0].ShowTextFieldTaskDescriptionFilterResultTextHint
        let str3 = p2Settings[0].ShowCONTAINSTaskName
        let str4 = p2Settings[0].ShowCONTAINSTaskDescription
        let str5 = p2Settings[0].helpWithShowCONTAINS
        
        let bo4 = p2Settings[0].ShowShowBarForTaskNameIfTrueElseTaskDescription
        let bo5 = p2Settings[0].uselessButUsedinShowItemsAfterSavingTask
        let bo6 = p2Settings[0].thereIsItemsInCallFromShowButton
        
        let bo7 = p2Settings[0].TasksIsSortedbyDateIfTrueElsePriority
        let bo8 = p2Settings[0].TasksIsSortedIncreasingIfTrueElseDecreasing
        let bo9 = p2Settings[0].SortByIncreasing
        
        let bo10 = p2Settings[0].ShowSortRequirementAfterUnshow
        let bo11 = p2Settings[0].ShowSortByDateAfterUnshowButtonIfTrueElsePriority
        let bo12 = p2Settings[0].ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
        
        return (bo1, bo2, bo3, str1, str2, str3, str4, str5, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11, bo12)
    }
    
    func getPageViewSettingsValueForPage3() -> (Bool, Bool, Bool, String, String, String, String, String, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool) {
        let bo1 = p3Settings[0].Showing
        let bo2 = p3Settings[0].ShowingAndSortedIfTrueElseShowing
        let bo3 = p3Settings[0].Sorted
        
        let str1 = p3Settings[0].ShowTextFieldTaskNameFilterResultTextHint
        let str2 = p3Settings[0].ShowTextFieldTaskDescriptionFilterResultTextHint
        let str3 = p3Settings[0].ShowCONTAINSTaskName
        let str4 = p3Settings[0].ShowCONTAINSTaskDescription
        let str5 = p3Settings[0].helpWithShowCONTAINS
        
        let bo4 = p3Settings[0].ShowShowBarForTaskNameIfTrueElseTaskDescription
        let bo5 = p3Settings[0].uselessButUsedinShowItemsAfterSavingTask
        let bo6 = p3Settings[0].thereIsItemsInCallFromShowButton
        
        let bo7 = p3Settings[0].TasksIsSortedbyDateIfTrueElsePriority
        let bo8 = p3Settings[0].TasksIsSortedIncreasingIfTrueElseDecreasing
        let bo9 = p3Settings[0].SortByIncreasing
        
        let bo10 = p3Settings[0].ShowSortRequirementAfterUnshow
        let bo11 = p3Settings[0].ShowSortByDateAfterUnshowButtonIfTrueElsePriority
        let bo12 = p3Settings[0].ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
        
        return (bo1, bo2, bo3, str1, str2, str3, str4, str5, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11, bo12)
    }
    
    func getPageViewSettingsValueForPage4() -> (Bool, Bool, Bool, String, String, String, String, String, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool) {
        let bo1 = p4Settings[0].Showing
        let bo2 = p4Settings[0].ShowingAndSortedIfTrueElseShowing
        let bo3 = p4Settings[0].Sorted
        
        let str1 = p4Settings[0].ShowTextFieldTaskNameFilterResultTextHint
        let str2 = p4Settings[0].ShowTextFieldTaskDescriptionFilterResultTextHint
        let str3 = p4Settings[0].ShowCONTAINSTaskName
        let str4 = p4Settings[0].ShowCONTAINSTaskDescription
        let str5 = p4Settings[0].helpWithShowCONTAINS
        
        let bo4 = p4Settings[0].ShowShowBarForTaskNameIfTrueElseTaskDescription
        let bo5 = p4Settings[0].uselessButUsedinShowItemsAfterSavingTask
        let bo6 = p4Settings[0].thereIsItemsInCallFromShowButton
        
        let bo7 = p4Settings[0].TasksIsSortedbyDateIfTrueElsePriority
        let bo8 = p4Settings[0].TasksIsSortedIncreasingIfTrueElseDecreasing
        let bo9 = p4Settings[0].SortByIncreasing
        
        let bo10 = p4Settings[0].ShowSortRequirementAfterUnshow
        let bo11 = p4Settings[0].ShowSortByDateAfterUnshowButtonIfTrueElsePriority
        let bo12 = p4Settings[0].ShowSortByIncreasingAfterUnshowButtonIfTrueElseDecreasing
        
        return (bo1, bo2, bo3, str1, str2, str3, str4, str5, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11, bo12)
    }
}


extension RealmManager {
    /* update alla 4 ApplicationSettingsAndListViewRenderingValue objecten så att dem alla håller den expåirationDate som app 4Time ska ha */
    func setApplicationExpiraitonDate(dat: Date) {
        if let localRealm = localRealm {
            let applicationSettingsAndListValuesObjects = localRealm.objects(GeneralApplicationSettingsAndValues.self)
            
            try! localRealm.write {
                applicationSettingsAndListValuesObjects.forEach { setting in
                    setting.applicationExpirationDate = dat
                }
            }
        }
    }
    /* get ApplicationExpirationdate från alla 4 st settings obj  (i.e. alla 4 har samma sak ändå) */
    func getApplicationExpiraitonDate() -> Date {
        var getDate: Date = Date()
        if let localRealm = localRealm {
            let applicationSettingsAndListValuesObjects = localRealm.objects(GeneralApplicationSettingsAndValues.self)
            
            try! localRealm.write {
                applicationSettingsAndListValuesObjects.forEach { setting in
                    getDate = setting.applicationExpirationDate
                }
            }
        }
        return getDate
    }
    func getApplicationExpiraitonDateForP1() -> Date {
        var getDate: Date = AppSettings[0].applicationExpirationDate
        if let localRealm = localRealm {
            let applicationSettingsAndListValuesObjects = localRealm.objects(GeneralApplicationSettingsAndValues.self)
            
            try! localRealm.write {
                applicationSettingsAndListValuesObjects.forEach { setting in
                    getDate = setting.applicationExpirationDate
                }
            }
        }
        return getDate
    }
    func countHowManySettingsObjectIsSaved() -> Int {
        var thisMuch: Int = AppSettings.count
        
        thisMuch += p1Settings.count
        thisMuch += p2Settings.count
        thisMuch += p3Settings.count
        thisMuch += p4Settings.count
        
        return thisMuch
    }
}


extension RealmManager {
    /* ta alla tasks från sida med @param page som har sina Field variabel isCurrentlyMarkde == true, och skickar dem till en annan sida med @param andAddToPage */
    func removeTasksThatIsCurrentlyMarkedFrom(page: Int, andAddToPage: Int) {
        let addToPage = andAddToPage + 1 // addToPage är i intervallet [0, 3] på grund av hur Picker varierar @State var $toPage
        
        if let localRealm = localRealm {
            
            if page == 1 {
                let p1IsCurrentlyMarkedTasks = localRealm.objects(Page1TaskItem.self).filter("isCurrentlyMarked == true")
                guard !p1IsCurrentlyMarkedTasks.isEmpty else { return }
                
                p1IsCurrentlyMarkedTasks.forEach { task in
                    
                    if addToPage == 1 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page1TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 1
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP1()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 2 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page2TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 2
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP1()
                                updateP2()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 3 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page3TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 3
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP1()
                                updateP3()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 4 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page4TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 4
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP1()
                                updateP4()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                } // forEach
            }
            
            if page == 2 {
                let p2IsCurrentlyMarkedTasks = localRealm.objects(Page2TaskItem.self).filter("isCurrentlyMarked == true")
                guard !p2IsCurrentlyMarkedTasks.isEmpty else { return }
                
                p2IsCurrentlyMarkedTasks.forEach { task in
                    
                    if addToPage == 1 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page1TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 1
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP2()
                                updateP1()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 2 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page2TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 2
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP2()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 3 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page3TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 3
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP2()
                                updateP3()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 4 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page4TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 4
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP2()
                                updateP4()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                } // forEach
            }
            
            if page == 3 {
                let p3IsCurrentlyMarkedTasks = localRealm.objects(Page3TaskItem.self).filter("isCurrentlyMarked == true")
                guard !p3IsCurrentlyMarkedTasks.isEmpty else { return }
                
                p3IsCurrentlyMarkedTasks.forEach {  task in
                    
                    if addToPage == 1 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page1TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 1
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP3()
                                updateP1()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 2 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page2TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 2
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP3()
                                updateP2()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 3 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page3TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 3
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP3()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 4 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page4TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 4
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP3()
                                updateP4()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                } // forEach
            }
            
            if page == 4 {
                let p4IsCurrentlyMarkedTasks = localRealm.objects(Page4TaskItem.self).filter("isCurrentlyMarked == true")
                guard !p4IsCurrentlyMarkedTasks.isEmpty else { return }
                
                p4IsCurrentlyMarkedTasks.forEach { task in
                    
                    if addToPage == 1 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page1TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 1
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP4()
                                updateP1()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 2 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page2TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 2
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP4()
                                updateP2()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 3 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page3TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 3
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP4()
                                updateP3()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                    if addToPage == 4 {
                        do {
                            try localRealm.write {
                                
                                let newTask = Page4TaskItem()
                                
                                newTask.id = Int.random(in: 0...99999999999)
                                
                                newTask.belongsToPage = 4
                                newTask.belongsToCategory = task.belongsToCategory
                                
                                newTask.isDone = task.isDone
                                newTask.isRemoved = task.isRemoved
                                newTask.isCurrentlyMarked = false
                                newTask.isTodaysFocus = task.isTodaysFocus
                                
                                newTask.isLocked = task.isLocked
                                newTask.lockPasswordInteger = task.lockPasswordInteger
                                
                                newTask.taskNAME = task.taskNAME
                                newTask.taskDESCRIPTION = task.taskDESCRIPTION
                                
                                newTask.showDate = task.showDate
                                newTask.taskDate = task.taskDate
                                newTask.soundTheTaskAlarm = task.soundTheTaskAlarm
                                newTask.taskTAG = task.taskTAG
                                newTask.taskPriority = task.taskPriority
                                
                                newTask.isComplex = task.isComplex
                                newTask.alarmDate = task.alarmDate
                                newTask.fromDate = task.fromDate
                                newTask.toDate = task.toDate
                                
                                newTask.numberOfSubTasks = task.numberOfSubTasks
                                newTask.numberOfSubTasksThatisDone = task.numberOfSubTasksThatisDone
                                
                                newTask.extraInt = task.extraInt
                                newTask.extraBoolan = task.extraBoolan
                                newTask.extraString = task.extraString
                                
                                localRealm.delete(task)
                                localRealm.add(newTask)
                                updateP4()
                            }
                        } catch {
                            print("Error adding course to Realm", error)
                        }
                    }
                } // forEach
            }
        }
    }
    func returnTaskDateForATaskItemWith(ID: Int, fromPage: Int) -> Date {
        var d = Date()
        
        if fromPage == 1 {
            d = returnP1TaskDateForTaskItemWith(id: ID)
        }
        if fromPage == 2 {
            d = returnP2TaskDateForTaskItemWith(id: ID)
        }
        if fromPage == 3 {
            d = returnP3TaskDateForTaskItemWith(id: ID)
        }
        if fromPage == 4 {
            d = returnP4TaskDateForTaskItemWith(id: ID)
        }
        
        return d
    }
    func returnTaskPriorityForATaskItemWith(ID: Int, fromPage: Int) -> Int {
        var n: Int = 0
        
        if fromPage == 1 {
            n = returnP1TaskPriorityForTaskItemWith(id: ID)
        }
        if fromPage == 2 {
            n = returnP2TaskPriorityForTaskItemWith(id: ID)
        }
        if fromPage == 3 {
            n = returnP3TaskPriorityForTaskItemWith(id: ID)
        }
        if fromPage == 4 {
            n = returnP4TaskPriorityForTaskItemWith(id: ID)
        }
        
        return n
    }
}


extension RealmManager {
    
    func getAllP1Notes() -> String {
        var i: Int = 0
        stringBuilder.clear()
        
        if let localRealm = localRealm {
            let allPageOneTasks = localRealm.objects(Page1TaskItem.self)
            allPageOneTasks.forEach { task in
                stringBuilder.append("\n\n\n")
                stringBuilder.append("🔺Note: \(i)")
                stringBuilder.append("\n")
                stringBuilder.append("Priority: \(task.taskPriority)")
                stringBuilder.append("\n")
                stringBuilder.append("Content: \n\t\t")
                stringBuilder.append(task.taskNAME)
                stringBuilder.append("\n")
                stringBuilder.append("•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••")
                
                i += 1
            }
        }
        
        return  stringBuilder.toString()
    }
    
    func getAllP2Notes() -> String {
        var i: Int = 0
        stringBuilder.clear()
        
        if let localRealm = localRealm {
            let allPageTwoTasks = localRealm.objects(Page2TaskItem.self)
            allPageTwoTasks.forEach { task in
                stringBuilder.append("\n\n\n")
                stringBuilder.append("🔺Note: \(i)")
                stringBuilder.append("\n")
                stringBuilder.append("Priority: \(task.taskPriority)")
                stringBuilder.append("\n")
                stringBuilder.append("Content: \n\t\t")
                stringBuilder.append(task.taskNAME)
                stringBuilder.append("\n")
                stringBuilder.append("•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••")
                
                i += 1
            }
        }
        
        return  stringBuilder.toString()
    }
    
    func getAllP3Notes() -> String {
        var i: Int = 0
        stringBuilder.clear()
        
        if let localRealm = localRealm {
            let allPageThreeTasks = localRealm.objects(Page3TaskItem.self)
            allPageThreeTasks.forEach { task in
                stringBuilder.append("\n\n\n")
                stringBuilder.append("🔺Note: \(i)")
                stringBuilder.append("\n")
                stringBuilder.append("Priority: \(task.taskPriority)")
                stringBuilder.append("\n")
                stringBuilder.append("Content: \n\t\t")
                stringBuilder.append(task.taskNAME)
                stringBuilder.append("\n")
                stringBuilder.append("•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••")
                
                i += 1
            }
        }
        
        return  stringBuilder.toString()
    }
    
    func getAllP4Notes() -> String {
        var i: Int = 0
        stringBuilder.clear()
        
        if let localRealm = localRealm {
            let allPageFourTasks = localRealm.objects(Page4TaskItem.self)
            allPageFourTasks.forEach { task in
                stringBuilder.append("\n\n\n")
                stringBuilder.append("🔺Note: \(i)")
                stringBuilder.append("\n")
                stringBuilder.append("Priority: \(task.taskPriority)")
                stringBuilder.append("\n")
                stringBuilder.append("Content: \n\t\t")
                stringBuilder.append(task.taskNAME)
                stringBuilder.append("\n")
                stringBuilder.append("•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••")
                
                i += 1
            }
        }
        
        return  stringBuilder.toString()
    }
}

// MARK: – ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️


class Page1TaskItem: Object
 {
    @objc dynamic var id = 0
    
    @objc dynamic var belongsToPage = 1
    @objc dynamic var belongsToCategory = 0
 
    @objc dynamic var isDone = false
    @objc dynamic var isRemoved = false
    @objc dynamic var isCurrentlyMarked = false
    @objc dynamic var isTodaysFocus = false
    
    @objc dynamic var isLocked = false
    @objc dynamic var lockPasswordInteger = 0
 
    @objc dynamic var taskNAME = ""
    @objc dynamic var taskDESCRIPTION = ""
 
    @objc dynamic var showDate = false
    @objc dynamic var taskDate = Date()
    @objc dynamic var soundTheTaskAlarm = false
    @objc dynamic var taskTAG = ""
    @objc dynamic var taskPriority = 0
 
    @objc dynamic var isComplex = false
    @objc dynamic var alarmDate = Date()
    @objc dynamic var fromDate = Date()
    @objc dynamic var toDate = Date()
    
    @objc dynamic var numberOfSubTasks = 0
    @objc dynamic var numberOfSubTasksThatisDone = 0
 
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

extension RealmManager {
    
    func getP1() {
        if let localRealm = localRealm {
            let allPageOneTasks = localRealm.objects(Page1TaskItem.self)
            allPageOneTasks.forEach { task in
                p1Tasks.insert(task, at: 0)
                if (task.taskPriority == 0) {
                    p1TasksPriorityZero.insert(task, at: 0)
                }
                if (task.taskPriority == 1) {
                    p1TasksPriorityOne.insert(task, at: 0)
                }
                if (task.taskPriority == 2) {
                    p1TasksPriorityTwo.insert(task, at: 0)
                }
                if (task.taskPriority == 3) {
                    p1TasksPriorityThree.insert(task, at: 0)
                }
            }
        }
    }
    
    func addToP1() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page1TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 0
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = ""
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP1()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    func addOneTaskToP1WithTasName(text: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page1TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 1
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = text
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP1()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    
    func deleteFromP1(id: Int) {
        if let localRealm = localRealm {
            let allPageOneTasks = localRealm.objects(Page1TaskItem.self)
            let allPageOneTasksWithThatID = allPageOneTasks.filter("id == \(id)")
            guard !allPageOneTasksWithThatID.isEmpty else { return }

            do {
                try localRealm.write {
                    localRealm.delete(allPageOneTasksWithThatID)
                    
                    updateP1()
                }
            } catch {
                print("Error deleting allPageOneTasksWithThatID", error)
            }
        }
    }
    
    func updateP1() {
        p1Tasks = []
        
        p1TasksPriorityZero = []
        p1TasksPriorityOne = []
        p1TasksPriorityTwo = []
        p1TasksPriorityThree = []
        
        getP1()
    }
    
    func updateP1ItemTextDatePriority(id: Int, name: String, tex: String, dat: Date, prio: Int) {
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the id == @param id, and return the first and assign to allPage1
                
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    aPageOneTask.taskNAME = name
                    aPageOneTask.taskDESCRIPTION = tex
                    aPageOneTask.taskDate = dat
                    aPageOneTask.taskPriority = prio
                    
                    updateP1()
                }
            }
        }
    }
    func updateP1ItemPriorityWith(id: Int, priority: Int) {
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    aPageOneTask.taskPriority = priority
                    
                    updateP1()
                }
            }
        }
    }
    func updateP1ItemIsDoneMarking(id: Int, markDone: Bool) {
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    aPageOneTask.isDone = markDone
                    
                    updateP1()
                }
            }
        }
    }
    func updateP1ItemisCurrentlyMarkedMarking(id: Int, isMarked: Bool) {
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    aPageOneTask.isCurrentlyMarked = isMarked
                    
                    updateP1()
                }
            }
        }
    }
    
    func deleteAllP1ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let allPageOneTasks = localRealm.objects(Page1TaskItem.self)
            let allPageOneTasksThatIsCurrentlyMarked = allPageOneTasks.filter("isCurrentlyMarked == true")
            guard !allPageOneTasksThatIsCurrentlyMarked.isEmpty else { return }

            do {
                try localRealm.write {
                    localRealm.delete(allPageOneTasksThatIsCurrentlyMarked)
                    
                    updateP1()
                }
            } catch {
                print("Error deleting allPageOneTasks ThatisCurrentlyMarkedMarking", error)
            }
        }
    }
    func unmarkAllP1ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let p1IsCurrentlyMarkedTasks = localRealm.objects(Page1TaskItem.self).filter("isCurrentlyMarked == true")
            
            try! localRealm.write {
                p1IsCurrentlyMarkedTasks.forEach { p1task in
                    p1task.isCurrentlyMarked = false
                }
            }
        }
    }
    
    func returnP1TaskNameForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    text = aPageOneTask.taskNAME
                }
            }
        }
        return text
    }
    func returnP1TaskDescriptionForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    text = aPageOneTask.taskDESCRIPTION
                }
            }
        }
        return text
    }
    func returnP1TaskDateForTaskItemWith(id: Int) -> Date {
        var d = Date()
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    d = aPageOneTask.taskDate
                }
            }
        }
        return d
    }
    func returnP1TaskPriorityForTaskItemWith(id: Int) -> Int {
        var n: Int = 0
        if let localRealm = localRealm {
            let aPageOneTask = localRealm.objects(Page1TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageOneTask = aPageOneTask {
                    n = aPageOneTask.taskPriority
                }
            }
        }
        return n
    }
     
    /* radera all Data på page 1 -> allting som är i listan för sida Importan & Urgent */
    func rmAllP1Tasks() {
        if let localRealm = localRealm {
            let allPageOneTasks = localRealm.objects(Page1TaskItem.self)
            
            do {
                try localRealm.write {
                    localRealm.delete(allPageOneTasks)
                    
                    updateP1()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func isThereAnyP1Item() -> Bool {
        let thereIsItem: Bool = !(p1Tasks.isEmpty)
        return thereIsItem
    }
    func isThereMoreP1Items() -> Bool {
        var thereIsMoreThanOneItem: Bool = false
        if (p1Tasks.count > 1) {
            thereIsMoreThanOneItem = true
        }
        return thereIsMoreThanOneItem
    }
    
// MARK: – SORT
    
    func sortP1(_ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if byDateIfTrueOrPriority {
            if IncOrDec {
                sortP1ByDateLowToHigh()
            } else {
                sortP1ByDateHighToLow()
            }
        } else {
            if IncOrDec {
                sortP1ByPriorityLowToHigh()
            } else {
                sortP1ByPriorityHighToLow()
            }
        }
    }
    func sortP1ByDateLowToHigh() {
        if let localRealm = localRealm {
            p1Tasks = []
            let allPageOne = localRealm.objects(Page1TaskItem.self).sorted(byKeyPath: "taskDate", ascending: false)
            allPageOne.forEach { p1task in
                p1Tasks.insert(p1task, at: 0)
            }
        }
    }
    func sortP1ByDateHighToLow() {
        if let localRealm = localRealm {
            p1Tasks = []
            let allPageOne = localRealm.objects(Page1TaskItem.self).sorted(byKeyPath: "taskDate", ascending: true)
            allPageOne.forEach { p1task in
                p1Tasks.insert(p1task, at: 0)
            }
        }
    }
    func sortP1ByPriorityLowToHigh() {
        if let localRealm = localRealm {
            p1Tasks = []
            let allPageOne = localRealm.objects(Page1TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: false)
            allPageOne.forEach { p1task in
                p1Tasks.insert(p1task, at: 0)
            }
        }
    }
    func sortP1ByPriorityHighToLow() {
        if let localRealm = localRealm {
            p1Tasks = []
            let allPageOne = localRealm.objects(Page1TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: true)
            allPageOne.forEach { p1task in
                p1Tasks.insert(p1task, at: 0)
            }
        }
    }
    
// MARK: – SHOW
    
    func showP1ItemsNameContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskNAME CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(allPageOne.isEmpty) {
                thereIs = true
                p1Tasks = []
                allPageOne.forEach { p1task in
                    p1Tasks.insert(p1task, at: 0)
                }
            }
        }
        return thereIs
    }
    func showP1ItemsDescriptionContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(allPageOne.isEmpty) {
                thereIs = true
                p1Tasks = []
                allPageOne.forEach { p1task in
                    p1Tasks.insert(p1task, at: 0)
                }
            }
        }
        return thereIs
    }
    
// MARK: – SHOW/Filter and Sort
    
    func FilterAndSortP1(_ showByTaskNameifTrueElseDescription: Bool, _ ifHasText: String, _ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if let localRealm = localRealm {
            
            if showByTaskNameifTrueElseDescription {
                if byDateIfTrueOrPriority {
                    
                    if IncOrDec {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    } else {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    }
                } else {
                    if IncOrDec {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    } else {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    }
                }
            } else {
                if byDateIfTrueOrPriority {
                    if IncOrDec {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    } else {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    }
                } else {
                    if IncOrDec {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    } else {
                        let allPageOne = localRealm.objects(Page1TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(allPageOne.isEmpty) {
                            p1Tasks = []
                            allPageOne.forEach { p1task in
                                p1Tasks.insert(p1task, at: 0)
                            }
                        }
                    }
                }
            }
        }
    }

}


// MARK: – ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️


class Page2TaskItem: Object
 {
    @objc dynamic var id = 0
    
    @objc dynamic var belongsToPage = 2
    @objc dynamic var belongsToCategory = 0
 
    @objc dynamic var isDone = false
    @objc dynamic var isRemoved = false
    @objc dynamic var isCurrentlyMarked = false
    @objc dynamic var isTodaysFocus = false
    
    @objc dynamic var isLocked = false
    @objc dynamic var lockPasswordInteger = 0
 
    @objc dynamic var taskNAME = ""
    @objc dynamic var taskDESCRIPTION = ""
 
    @objc dynamic var showDate = false
    @objc dynamic var taskDate = Date()
    @objc dynamic var soundTheTaskAlarm = false
    @objc dynamic var taskTAG = ""
    @objc dynamic var taskPriority = 0
 
    @objc dynamic var isComplex = false
    @objc dynamic var alarmDate = Date()
    @objc dynamic var fromDate = Date()
    @objc dynamic var toDate = Date()
    
    @objc dynamic var numberOfSubTasks = 0
    @objc dynamic var numberOfSubTasksThatisDone = 0
 
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

extension RealmManager {
    
    func getP2() {
        if let localRealm = localRealm {
            let allPageTwoTasks = localRealm.objects(Page2TaskItem.self)
            allPageTwoTasks.forEach { task in
                p2Tasks.insert(task, at: 0)
                if (task.taskPriority == 0) {
                    p2TasksPriorityZero.insert(task, at: 0)
                }
                if (task.taskPriority == 1) {
                    p2TasksPriorityOne.insert(task, at: 0)
                }
                if (task.taskPriority == 2) {
                    p2TasksPriorityTwo.insert(task, at: 0)
                }
                if (task.taskPriority == 3) {
                    p2TasksPriorityThree.insert(task, at: 0)
                }
            }
        }
    }
    
    func addToP2() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page2TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 2
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = ""
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP2()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    func addOneTaskToP2WithTasName(text: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page2TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 2
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = text
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP2()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    
    func deleteFromP2(id: Int) {
        if let localRealm = localRealm {
            let allPage2TaskWithThatID = localRealm.objects(Page2TaskItem.self).filter("id == \(id)")
            
            guard !allPage2TaskWithThatID.isEmpty else { return }
            do {
                try localRealm.write {
                    localRealm.delete(allPage2TaskWithThatID)
                    
                    updateP2()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func updateP2() {
        p2Tasks = []
        
        p2TasksPriorityZero = []
        p2TasksPriorityOne = []
        p2TasksPriorityTwo = []
        p2TasksPriorityThree = []
        
        getP2()
    }
    
    func updateP2ItemTextDatePriority(id: Int, name: String, tex: String, dat: Date, prio: Int) {
        if let localRealm = localRealm {
            let aPage2Task = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the id == @param id, and return the first and assign to allPage1
                
            try! localRealm.write {
                if let aPage2Task = aPage2Task {
                    aPage2Task.taskNAME = name
                    aPage2Task.taskDESCRIPTION = tex
                    aPage2Task.taskDate = dat
                    aPage2Task.taskPriority = prio
                    
                    updateP2()
                }
            }
        }
    }
    func updateP2ItemIsDoneMarking(id: Int, markDone: Bool) {
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    aPageTwoTask.isDone = markDone
                    
                    updateP2()
                }
            }
        }
    }
    func updateP2ItemPriorityWith(id: Int, priority: Int) {
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    aPageTwoTask.taskPriority = priority
                    
                    updateP2()
                }
            }
        }
    }
    func updateP2ItemisCurrentlyMarkedMarking(id: Int, isMarked: Bool) {
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    aPageTwoTask.isCurrentlyMarked = isMarked
                    
                    updateP2()
                }
            }
        }
    }
    
    func deleteAllP2ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let allPageTwoTasks = localRealm.objects(Page2TaskItem.self)
            let allPageTwoTasksThatIsCurrentlyMarked = allPageTwoTasks.filter("isCurrentlyMarked == true")
            guard !allPageTwoTasksThatIsCurrentlyMarked.isEmpty else { return }

            do {
                try localRealm.write {
                    localRealm.delete(allPageTwoTasksThatIsCurrentlyMarked)
                    
                    updateP2()
                }
            } catch {
                print("Error deleting allPageTwoTasks ThatisCurrentlyMarkedMarking", error)
            }
        }
    }
    func unmarkAllP2ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let p2IsCurrentlyMarkedTasks = localRealm.objects(Page2TaskItem.self).filter("isCurrentlyMarked == true")
            
            try! localRealm.write {
                p2IsCurrentlyMarkedTasks.forEach { p2task in
                    p2task.isCurrentlyMarked = false
                }
            }
        }
    }
    
    func returnP2TaskNameForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    text = aPageTwoTask.taskNAME
                }
            }
        }
        return text
    }
    func returnP2TaskDescriptionForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    text = aPageTwoTask.taskDESCRIPTION
                }
            }
        }
        return text
    }
    func returnP2TaskDateForTaskItemWith(id: Int) -> Date {
        var d = Date()
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    d = aPageTwoTask.taskDate
                }
            }
        }
        return d
    }
    func returnP2TaskPriorityForTaskItemWith(id: Int) -> Int {
        var n: Int = 0
        if let localRealm = localRealm {
            let aPageTwoTask = localRealm.objects(Page2TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageTwoTask = aPageTwoTask {
                    n = aPageTwoTask.taskPriority
                }
            }
        }
        return n
    }
    
    /* radera all Data på page 1 -> allting som är i listan för sida Importan & Urgent */
    func rmAllP2Tasks() {
        if let localRealm = localRealm {
            let allOfP2Tasks = localRealm.objects(Page2TaskItem.self)
            do {
                try localRealm.write {
                    localRealm.delete(allOfP2Tasks)
                    
                    updateP2()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func isThereAnyP2Item() -> Bool {
        let thereIsItem: Bool = !(p2Tasks.isEmpty)
        return thereIsItem
    }
    func isThereMoreP2Items() -> Bool {
        var thereIsMoreThanOneItem: Bool = false
        
        if (p2Tasks.count > 1) {
            thereIsMoreThanOneItem = true
        }
        return thereIsMoreThanOneItem
    }
    
// MARK: – SORT
    
    func sortP2(_ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if byDateIfTrueOrPriority {
            if IncOrDec {
                sortP2ByDateLowToHigh()
            } else {
                sortP2ByDateHighToLow()
            }
        } else {
            if IncOrDec {
                sortP2ByPriorityLowToHigh()
            } else {
                sortP2ByPriorityHighToLow()
            }
        }
    }
    func sortP2ByDateLowToHigh() {
        if let localRealm = localRealm {
            p2Tasks = []
            let customP2Tasks = localRealm.objects(Page2TaskItem.self).sorted(byKeyPath: "taskDate", ascending: false)
            customP2Tasks.forEach { aTask in
                p2Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP2ByDateHighToLow() {
        if let localRealm = localRealm {
            p2Tasks = []
            let customP2Tasks = localRealm.objects(Page2TaskItem.self).sorted(byKeyPath: "taskDate", ascending: true)
            customP2Tasks.forEach { aTask in
                p2Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP2ByPriorityLowToHigh() {
        if let localRealm = localRealm {
            p2Tasks = []
            let customP2Tasks = localRealm.objects(Page2TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: false)
            customP2Tasks.forEach { aTask in
                p2Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP2ByPriorityHighToLow() {
        if let localRealm = localRealm {
            p2Tasks = []
            let customP2Tasks = localRealm.objects(Page2TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: true)
            customP2Tasks.forEach { aTask in
                p2Tasks.insert(aTask, at: 0)
            }
        }
    }
    
// MARK: – SHOW
    
    func showP2ItemsNameContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskNAME CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(customP2Tasks.isEmpty) {
                thereIs = true
                p2Tasks = []
                customP2Tasks.forEach { aTask in
                    p2Tasks.insert(aTask, at: 0)
                }
            }
        }
        return thereIs
    }
    func showP2ItemsDescriptionContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(customP2Tasks.isEmpty) {
                thereIs = true
                p2Tasks = []
                customP2Tasks.forEach { aTask in
                    p2Tasks.insert(aTask, at: 0)
                }
            }
        }
        return thereIs
    }
    
// MARK: – SHOW/Filter and Sort
    
    func FilterAndSortP2(_ showByTaskNameifTrueElseDescription: Bool, _ ifHasText: String, _ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if let localRealm = localRealm {
            
            if showByTaskNameifTrueElseDescription {
                if byDateIfTrueOrPriority {
                    
                    if IncOrDec {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                } else {
                    
                    if IncOrDec {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                }
            } else {
                if byDateIfTrueOrPriority {
                    if IncOrDec {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                } else {
                    if IncOrDec {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP2Tasks = localRealm.objects(Page2TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(customP2Tasks.isEmpty) {
                            p2Tasks = []
                            customP2Tasks.forEach { aTask in
                                p2Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                }
            }
        }
    }
}


// MARK: – ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️


class Page3TaskItem: Object
 {
    @objc dynamic var id = 0
    
    @objc dynamic var belongsToPage = 3
    @objc dynamic var belongsToCategory = 0
 
    @objc dynamic var isDone = false
    @objc dynamic var isRemoved = false
    @objc dynamic var isCurrentlyMarked = false
    @objc dynamic var isTodaysFocus = false
    
    @objc dynamic var isLocked = false
    @objc dynamic var lockPasswordInteger = 0
 
    @objc dynamic var taskNAME = ""
    @objc dynamic var taskDESCRIPTION = ""
 
    @objc dynamic var showDate = false
    @objc dynamic var taskDate = Date()
    @objc dynamic var soundTheTaskAlarm = false
    @objc dynamic var taskTAG = ""
    @objc dynamic var taskPriority = 0
 
    @objc dynamic var isComplex = false
    @objc dynamic var alarmDate = Date()
    @objc dynamic var fromDate = Date()
    @objc dynamic var toDate = Date()
    
    @objc dynamic var numberOfSubTasks = 0
    @objc dynamic var numberOfSubTasksThatisDone = 0
 
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

extension RealmManager {
    
    func getP3() {
        if let localRealm = localRealm {
            let allPageThreeTasks = localRealm.objects(Page3TaskItem.self)
            allPageThreeTasks.forEach { task in
                p3Tasks.insert(task, at: 0)
                if (task.taskPriority == 0) {
                    p3TasksPriorityZero.insert(task, at: 0)
                }
                if (task.taskPriority == 1) {
                    p3TasksPriorityOne.insert(task, at: 0)
                }
                if (task.taskPriority == 2) {
                    p3TasksPriorityTwo.insert(task, at: 0)
                }
                if (task.taskPriority == 3) {
                    p3TasksPriorityThree.insert(task, at: 0)
                }
            }
        }
    }
    
    func addToP3() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page3TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 3
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = ""
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP3()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    func addOneTaskToP3WithTasName(text: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page3TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 3
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = text
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP3()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    
    func deleteFromP3(id: Int) {
        if let localRealm = localRealm {
            let allPage3TaskWithThatID = localRealm.objects(Page3TaskItem.self).filter("id == \(id)")
            
            guard !allPage3TaskWithThatID.isEmpty else { return }
            do {
                try localRealm.write {
                    localRealm.delete(allPage3TaskWithThatID)
                    
                    updateP3()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func updateP3() {
        p3Tasks = []
        
        p3TasksPriorityZero = []
        p3TasksPriorityOne = []
        p3TasksPriorityTwo = []
        p3TasksPriorityThree = []
        
        getP3()
    }
    
    func updateP3ItemTextDatePriority(id: Int, name: String, tex: String, dat: Date, prio: Int) {
        if let localRealm = localRealm {
            let aPage3Task = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the id == @param id, and return the first and assign to allPage1
            
            try! localRealm.write {
                if let aPage3Task = aPage3Task {
                    aPage3Task.taskNAME = name
                    aPage3Task.taskDESCRIPTION = tex
                    aPage3Task.taskDate = dat
                    aPage3Task.taskPriority = prio
                    
                    updateP3()
                }
            }
        }
    }
    func updateP3ItemPriorityWith(id: Int, priority: Int) {
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    aPageThreeTask.taskPriority = priority
                    
                    updateP3()
                }
            }
        }
    }
    func updateP3ItemIsDoneMarking(id: Int, markDone: Bool) {
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    aPageThreeTask.isDone = markDone
                    
                    updateP3()
                }
            }
        }
    }
    func updateP3ItemisCurrentlyMarkedMarking(id: Int, isMarked: Bool) {
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    aPageThreeTask.isCurrentlyMarked = isMarked
                    
                    updateP3()
                }
            }
        }
    }
    
    func deleteAllP3ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let allPageThreeTasks = localRealm.objects(Page3TaskItem.self)
            let allPageThreeTasksThatIsCurrentlyMarked = allPageThreeTasks.filter("isCurrentlyMarked == true")
            guard !allPageThreeTasksThatIsCurrentlyMarked.isEmpty else { return }

            do {
                try localRealm.write {
                    localRealm.delete(allPageThreeTasksThatIsCurrentlyMarked)
                    
                    updateP3()
                }
            } catch {
                print("Error deleting allPageThreeTasks ThatisCurrentlyMarkedMarking", error)
            }
        }
    }
    func unmarkAllP3ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let p3IsCurrentlyMarkedTasks = localRealm.objects(Page3TaskItem.self).filter("isCurrentlyMarked == true")
            
            try! localRealm.write {
                p3IsCurrentlyMarkedTasks.forEach { p3task in
                    p3task.isCurrentlyMarked = false
                }
            }
        }
    }
    
    func returnP3TaskNameForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    text = aPageThreeTask.taskNAME
                }
            }
        }
        return text
    }
    func returnP3TaskDescriptionForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    text = aPageThreeTask.taskDESCRIPTION
                }
            }
        }
        return text
    }
    func returnP3TaskDateForTaskItemWith(id: Int) -> Date {
        var d = Date()
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    d = aPageThreeTask.taskDate
                }
            }
        }
        return d
    }
    func returnP3TaskPriorityForTaskItemWith(id: Int) -> Int {
        var n: Int = 0
        if let localRealm = localRealm {
            let aPageThreeTask = localRealm.objects(Page3TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageThreeTask = aPageThreeTask {
                    n = aPageThreeTask.taskPriority
                }
            }
        }
        return n
    }
    
    /* radera all Data på page 1 -> allting som är i listan för sida Importan & Urgent */
    func rmAllP3Tasks() {
        if let localRealm = localRealm {
            let allOfP3Tasks = localRealm.objects(Page3TaskItem.self)
            do {
                try localRealm.write {
                    localRealm.delete(allOfP3Tasks)
                    
                    updateP3()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func isThereAnyP3Item() -> Bool {
        let thereIsItem: Bool = !(p3Tasks.isEmpty)
        return thereIsItem
    }
    func isThereMoreP3Items() -> Bool {
        var thereIsMoreThanOneItem: Bool = false
        
        if (p3Tasks.count > 1) {
            thereIsMoreThanOneItem = true
        }
        return thereIsMoreThanOneItem
    }
    
// MARK: – SORT
    
    func sortP3(_ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if byDateIfTrueOrPriority {
            if IncOrDec {
                sortP3ByDateLowToHigh()
            } else {
                sortP3ByDateHighToLow()
            }
        } else {
            if IncOrDec {
                sortP3ByPriorityLowToHigh()
            } else {
                sortP3ByPriorityHighToLow()
            }
        }
    }
    func sortP3ByDateLowToHigh() {
        if let localRealm = localRealm {
            p3Tasks = []
            let customP3Tasks = localRealm.objects(Page3TaskItem.self).sorted(byKeyPath: "taskDate", ascending: false)
            customP3Tasks.forEach { aTask in
                p3Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP3ByDateHighToLow() {
        if let localRealm = localRealm {
            p3Tasks = []
            let customP3Tasks = localRealm.objects(Page3TaskItem.self).sorted(byKeyPath: "taskDate", ascending: true)
            customP3Tasks.forEach { aTask in
                p3Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP3ByPriorityLowToHigh() {
        if let localRealm = localRealm {
            p3Tasks = []
            let customP3Tasks = localRealm.objects(Page3TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: false)
            customP3Tasks.forEach { aTask in
                p3Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP3ByPriorityHighToLow() {
        if let localRealm = localRealm {
            p3Tasks = []
            let customP3Tasks = localRealm.objects(Page3TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: true)
            customP3Tasks.forEach { aTask in
                p3Tasks.insert(aTask, at: 0)
            }
        }
    }
    
// MARK: – SHOW
    
    func showP3ItemsNameContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskNAME CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(customP3Tasks.isEmpty) {
                thereIs = true
                p3Tasks = []
                customP3Tasks.forEach { aTask in
                    p3Tasks.insert(aTask, at: 0)
                }
            }
        }
        return thereIs
    }
    func showP3ItemsDescriptionContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(customP3Tasks.isEmpty) {
                thereIs = true
                p3Tasks = []
                customP3Tasks.forEach { aTask in
                    p3Tasks.insert(aTask, at: 0)
                }
            }
        }
        return thereIs
    }
    
// MARK: – SHOW/Filter and Sort
    
    func FilterAndSortP3(_ showByTaskNameifTrueElseDescription: Bool, _ ifHasText: String, _ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if let localRealm = localRealm {
            
            if showByTaskNameifTrueElseDescription {
                if byDateIfTrueOrPriority {
                    
                    if IncOrDec {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                } else {
                    
                    if IncOrDec {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                }
            } else {
                if byDateIfTrueOrPriority {
                    if IncOrDec {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                } else {
                    if IncOrDec {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP3Tasks = localRealm.objects(Page3TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(customP3Tasks.isEmpty) {
                            p3Tasks = []
                            customP3Tasks.forEach { aTask in
                                p3Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                }
            }
        }
    }
}


// MARK: – ⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️


class Page4TaskItem: Object
 {
    @objc dynamic var id = 0
    
    @objc dynamic var belongsToPage = 4
    @objc dynamic var belongsToCategory = 0
 
    @objc dynamic var isDone = false
    @objc dynamic var isRemoved = false
    @objc dynamic var isCurrentlyMarked = false
    @objc dynamic var isTodaysFocus = false
    
    @objc dynamic var isLocked = false
    @objc dynamic var lockPasswordInteger = 0
 
    @objc dynamic var taskNAME = ""
    @objc dynamic var taskDESCRIPTION = ""
 
    @objc dynamic var showDate = false
    @objc dynamic var taskDate = Date()
    @objc dynamic var soundTheTaskAlarm = false
    @objc dynamic var taskTAG = ""
    @objc dynamic var taskPriority = 0
 
    @objc dynamic var isComplex = false
    @objc dynamic var alarmDate = Date()
    @objc dynamic var fromDate = Date()
    @objc dynamic var toDate = Date()
    
    @objc dynamic var numberOfSubTasks = 0
    @objc dynamic var numberOfSubTasksThatisDone = 0
 
    @objc dynamic var extraInt = 0
    @objc dynamic var extraBoolan = false
    @objc dynamic var extraString = ""
}

extension RealmManager {
    
    func getP4() {
        if let localRealm = localRealm {
            let allPageFourTasks = localRealm.objects(Page4TaskItem.self)
            allPageFourTasks.forEach { task in
                p4Tasks.insert(task, at: 0)
                if (task.taskPriority == 0) {
                    p4TasksPriorityZero.insert(task, at: 0)
                }
                if (task.taskPriority == 1) {
                    p4TasksPriorityOne.insert(task, at: 0)
                }
                if (task.taskPriority == 2) {
                    p4TasksPriorityTwo.insert(task, at: 0)
                }
                if (task.taskPriority == 3) {
                    p4TasksPriorityThree.insert(task, at: 0)
                }
            }
        }
    }
    
    func addToP4() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page4TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 4
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = ""
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP4()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    func addOneTaskToP4WithTasName(text: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Page4TaskItem()
                    
                    newTask.id = Int.random(in: 0...99999999999)
                    
                    newTask.belongsToPage = 4
                    newTask.belongsToCategory = 0
                    
                    newTask.isDone = false
                    newTask.isRemoved = false
                    newTask.isCurrentlyMarked = false
                    newTask.isTodaysFocus = false
                    
                    newTask.isLocked = false
                    newTask.lockPasswordInteger = 0
                    
                    newTask.taskNAME = text
                    newTask.taskDESCRIPTION = ""
                    
                    newTask.showDate = false
                    newTask.taskDate = Date()
                    newTask.soundTheTaskAlarm = false
                    newTask.taskTAG = ""
                    newTask.taskPriority = 0
                    
                    newTask.isComplex = false
                    newTask.alarmDate = Date()
                    newTask.fromDate = Date()
                    newTask.toDate = Date()
                    
                    newTask.numberOfSubTasks = 0
                    newTask.numberOfSubTasksThatisDone = 0
                    
                    newTask.extraInt = 0
                    newTask.extraBoolan = false
                    newTask.extraString = ""
                    
                    localRealm.add(newTask)
                    updateP4()
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    
    func deleteFromP4(id: Int) {
        if let localRealm = localRealm {
            let allPage4TaskWithThatID = localRealm.objects(Page4TaskItem.self).filter("id == \(id)")
            
            guard !allPage4TaskWithThatID.isEmpty else { return }
            do {
                try localRealm.write {
                    localRealm.delete(allPage4TaskWithThatID)
                    
                    updateP4()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func updateP4() {
        p4Tasks = []
        
        p4TasksPriorityZero = []
        p4TasksPriorityOne = []
        p4TasksPriorityTwo = []
        p4TasksPriorityThree = []
        
        getP4()
    }
    
    func updateP4ItemTextDatePriority(id: Int, name: String, tex: String, dat: Date, prio: Int) {
        if let localRealm = localRealm {
            let aPage4Task = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the id == @param id, and return the first and assign to allPage1
            
            try! localRealm.write {
                if let aPage4Task = aPage4Task {
                    aPage4Task.taskNAME = name
                    aPage4Task.taskDESCRIPTION = tex
                    aPage4Task.taskDate = dat
                    aPage4Task.taskPriority = prio
                    
                    updateP4()
                }
            }
        }
    }
    func updateP4ItemPriorityWith(id: Int, priority: Int) {
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    aPageFourTask.taskPriority = priority
                    
                    updateP4()
                }
            }
        }
    }
    func updateP4ItemIsDoneMarking(id: Int, markDone: Bool) {
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    aPageFourTask.isDone = markDone
                    
                    updateP4()
                }
            }
        }
    }
    func updateP4ItemisCurrentlyMarkedMarking(id: Int, isMarked: Bool) {
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    aPageFourTask.isCurrentlyMarked = isMarked
                    
                    updateP4()
                }
            }
        }
    }
    
    func deleteAllP4ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let allPageFourTasks = localRealm.objects(Page4TaskItem.self)
            let allPageFourTasksThatIsCurrentlyMarked = allPageFourTasks.filter("isCurrentlyMarked == true")
            guard !allPageFourTasksThatIsCurrentlyMarked.isEmpty else { return }

            do {
                try localRealm.write {
                    localRealm.delete(allPageFourTasksThatIsCurrentlyMarked)
                    
                    updateP4()
                }
            } catch {
                print("Error deleting allPageFourTasks ThatisCurrentlyMarkedMarking", error)
            }
        }
    }
    func unmarkAllP4ItemisCurrentlyMarkedMarking() {
        if let localRealm = localRealm {
            let p4IsCurrentlyMarkedTasks = localRealm.objects(Page4TaskItem.self).filter("isCurrentlyMarked == true")
            
            try! localRealm.write {
                p4IsCurrentlyMarkedTasks.forEach { p4task in
                    p4task.isCurrentlyMarked = false
                }
            }
        }
    }
    
    func returnP4TaskNameForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    text = aPageFourTask.taskNAME
                }
            }
        }
        return text
    }
    func returnP4TaskDescriptionForTaskItemWith(id: Int) -> String {
        var text = ""
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    text = aPageFourTask.taskDESCRIPTION
                }
            }
        }
        return text
    }
    func returnP4TaskDateForTaskItemWith(id: Int) -> Date {
        var d = Date()
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    d = aPageFourTask.taskDate
                }
            }
        }
        return d
    }
    func returnP4TaskPriorityForTaskItemWith(id: Int) -> Int {
        var n: Int = 0
        if let localRealm = localRealm {
            let aPageFourTask = localRealm.objects(Page4TaskItem.self).filter("id == \(id)").first
            
            try! localRealm.write {
                if let aPageFourTask = aPageFourTask {
                    n = aPageFourTask.taskPriority
                }
            }
        }
        return n
    }
    
    /* radera all Data på page 1 -> allting som är i listan för sida Importan & Urgent */
    func rmAllP4Tasks() {
        if let localRealm = localRealm {
            let allOfP4Tasks = localRealm.objects(Page4TaskItem.self)
            do {
                try localRealm.write {
                    localRealm.delete(allOfP4Tasks)
                    
                    updateP4()
                }
            } catch {
                print("Error deleting course", error)
            }
        }
    }
    
    func isThereAnyP4Item() -> Bool {
        let thereIsItem: Bool = !(p4Tasks.isEmpty)
        return thereIsItem
    }
    func isThereMoreP4Items() -> Bool {
        var thereIsMoreThanOneItem: Bool = false
        
        if (p4Tasks.count > 1) {
            thereIsMoreThanOneItem = true
        }
        return thereIsMoreThanOneItem
    }
    
// MARK: – SORT
    
    func sortP4(_ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if byDateIfTrueOrPriority {
            if IncOrDec {
                sortP4ByDateLowToHigh()
            } else {
                sortP4ByDateHighToLow()
            }
        } else {
            if IncOrDec {
                sortP4ByPriorityLowToHigh()
            } else {
                sortP4ByPriorityHighToLow()
            }
        }
    }
    func sortP4ByDateLowToHigh() {
        if let localRealm = localRealm {
            p4Tasks = []
            let customP4Tasks = localRealm.objects(Page4TaskItem.self).sorted(byKeyPath: "taskDate", ascending: false)
            customP4Tasks.forEach { aTask in
                p4Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP4ByDateHighToLow() {
        if let localRealm = localRealm {
            p4Tasks = []
            let customP4Tasks = localRealm.objects(Page4TaskItem.self).sorted(byKeyPath: "taskDate", ascending: true)
            customP4Tasks.forEach { aTask in
                p4Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP4ByPriorityLowToHigh() {
        if let localRealm = localRealm {
            p4Tasks = []
            let customP4Tasks = localRealm.objects(Page4TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: false)
            customP4Tasks.forEach { aTask in
                p4Tasks.insert(aTask, at: 0)
            }
        }
    }
    func sortP4ByPriorityHighToLow() {
        if let localRealm = localRealm {
            p4Tasks = []
            let customP4Tasks = localRealm.objects(Page4TaskItem.self).sorted(byKeyPath: "taskPriority", ascending: true)
            customP4Tasks.forEach { aTask in
                p4Tasks.insert(aTask, at: 0)
            }
        }
    }
    
// MARK: – SHOW
        
    func showP4ItemsNameContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskNAME CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(customP4Tasks.isEmpty) {
                thereIs = true
                p4Tasks = []
                customP4Tasks.forEach { aTask in
                    p4Tasks.insert(aTask, at: 0)
                }
            }
        }
        return thereIs
    }
    func showP4ItemsDescriptionContaining(name: String) -> Bool {
        var thereIs: Bool = false
        if let localRealm = localRealm {
            let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(name)'") // find all Page1 objects in localRealm (Our Realm Database) of type Page1, with the taskNAME == @param name and return
            if !(customP4Tasks.isEmpty) {
                thereIs = true
                p4Tasks = []
                customP4Tasks.forEach { aTask in
                    p4Tasks.insert(aTask, at: 0)
                }
            }
        }
        return thereIs
    }
    
// MARK: – SHOW/Filter and Sort
    
    func FilterAndSortP4(_ showByTaskNameifTrueElseDescription: Bool, _ ifHasText: String, _ byDateIfTrueOrPriority: Bool, _ IncOrDec: Bool) {
        if let localRealm = localRealm {
            
            if showByTaskNameifTrueElseDescription {
                if byDateIfTrueOrPriority {
                    
                    if IncOrDec {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                } else {
                    
                    if IncOrDec {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskNAME CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                }
            } else {
                if byDateIfTrueOrPriority {
                    if IncOrDec {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: false)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskDate", ascending: true)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                } else {
                    if IncOrDec {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: false)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    } else {
                        let customP4Tasks = localRealm.objects(Page4TaskItem.self).filter("taskDESCRIPTION CONTAINS '\(ifHasText)'").sorted(byKeyPath: "taskPriority", ascending: true)
                        if !(customP4Tasks.isEmpty) {
                            p4Tasks = []
                            customP4Tasks.forEach { aTask in
                                p4Tasks.insert(aTask, at: 0)
                            }
                        }
                    }
                }
            }
        }
    }
}


// MARK: – 💥∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙💥

/*
class SubTaskItem: Object
{
   
   @objc dynamic var baseTask: TaskItem?
    
   @objc dynamic var id = 0
    
   @objc dynamic var subTaskbelongsToTasksInPage = 0
   @objc dynamic var subTaskbelongsToBaseTaskWithID = 0
   @objc dynamic var subTaskisDone = false
   @objc dynamic var subTaskisCurrentlyMarked = false
   @objc dynamic var subTaskNAME = ""
   @objc dynamic var subTaskDESCRIPTION = ""
   @objc dynamic var subTaskshowDate = false
   @objc dynamic var subTaskDate = Date()
   @objc dynamic var subTasktaskPriority = 0
   @objc dynamic var subTaskAlarmDate = Date()
   @objc dynamic var subTaskIsFromDate = Date()
   @objc dynamic var subTaskIsToDate = Date()
   @objc dynamic var subTaskextraInt = 0
   @objc dynamic var subTaskextraBoolan = false
   @objc dynamic var subTaskextraString = ""
    
    
    // skapa sedan en SubTask med var sub = SubTask(Int.random(in: 0...99999999999))
    convenience init(ID: Int) {
        self.init() //Please note this says 'self' and not 'super'
        
        self.id = ID
         
        self.subTaskbelongsToTasksInPage = 0
        self.subTaskbelongsToBaseTaskWithID = 0
        self.subTaskisDone = false
        self.subTaskisCurrentlyMarked = false
        self.subTaskNAME = ""
        self.subTaskDESCRIPTION = ""
        self.subTaskshowDate = false
        self.subTaskDate = Date()
        self.subTasktaskPriority = 0
        self.subTaskAlarmDate = Date()
        self.subTaskIsFromDate = Date()
        self.subTaskIsToDate = Date()
        self.subTaskextraInt = 0
        self.subTaskextraBoolan = false
        self.subTaskextraString = ""
    }
}
 
extension RealmManager {
}
*/
