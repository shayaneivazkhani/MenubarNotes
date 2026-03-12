//
//  Alert_Examples.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

struct Alerts: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        Alerts()
    }
} */



/**Alert (1): Title as String
 
 
 
 func alert<S, A>(_ title: S, isPresented: Binding<Bool>, @ViewBuilder actions: () -> A) -> some View where S : StringProtocol, A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    title: A string for the alert title.
  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.
 */
struct Alert_View: View {
    @State var show = false
    
    var body: some View {
        Button("Open") {
            show = true
        }
        .alert(String("Document Options"), isPresented: $show) {
            Button("Print") { }
            
            Button("Share...") { }
        }
    }
}




/**Alert (2): Title as String, with Presenting Data
 
 
 
 func alert<S, A, T>(_ title: S, isPresented: Binding<Bool>, presenting data: T?, @ViewBuilder actions: (T) -> A) -> some View where S : StringProtocol, A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    title: A string for the alert title.
  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    presenting: a value of any type. This value will be passed to the actions closure as an argument.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.
 
 */
struct Alert_View2: View {
    @State var show = false
    
    var body: some View {
        Button("Open") {
            show = true
        }
        .alert(String("Document Options"), isPresented: $show, presenting: "file.doc") { documentName in
            Button("Print '\(documentName)'") { }
            
            Button("Share...") { }
        }
    }
}




/**Alert (3): Title as Text
 
 
 
 func alert<A>(_ title: Text, isPresented: Binding<Bool>, @ViewBuilder actions: () -> A) -> some View where A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    title: A Text view for the alert title.
  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.
 
 */
struct Alert_View3: View {
    @State var show = false
    
    var body: some View {
        Button("Open") {
            show = true
        }
        .alert(Text("Document Options"), isPresented: $show) {
            Button("Print") { }
            
            Button("Share...") { }
        }
    }
}




/**Alert (4): Title as Text, with Presenting Data
 
 
 
 func alert<A, T>(_ title: Text, isPresented: Binding<Bool>, presenting data: T?, @ViewBuilder actions: (T) -> A) -> some View where A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    title: A Text view for the alert title.
  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    presenting: a value of any type. This value will be passed to the actions closure as an argument.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.
 
 */
struct Alert_View4: View {
    @State var show = false
    
    var body: some View {
        Button("Open") {
            show = true
        }
        .alert(Text("Document Options"), isPresented: $show, presenting: "file.doc") { documentName in
            Button("Print '\(documentName)'") { }
            
            Button("Share...") { }
        }
    }
}




/**Alert (5): Title as LocalizedStringKey
 
 
 
 func alert<A>(_ titleKey: LocalizedStringKey, isPresented: Binding<Bool>, @ViewBuilder actions: () -> A) -> some View where A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    titleKey: A localized string key for the alert title.
  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.
 */
struct Alert_View5: View {
    @State var show = false
    
    var body: some View {
        Button("Open") {
            show = true
        }
        .alert(LocalizedStringKey("Document Options"), isPresented: $show) {
            Button("Print") { }
            
            Button("Share...") { }
        }
    }
}





/**Alert (6): Title as Localized String Key, with Presenting Data
 
 
 
 func alert<A, T>(_ titleKey: LocalizedStringKey, isPresented: Binding<Bool>, presenting data: T?, @ViewBuilder actions: (T) -> A) -> some View where A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    titleKey: A localized string key for the alert title.
  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    presenting: a value of any type. This value will be passed to the actions closure as an argument.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.

 */
struct Alert_View6: View {
    @State var show = false
    
    var body: some View {
        Button("Open") {
            show = true
        }
        .alert(LocalizedStringKey("Document Options"), isPresented: $show, presenting: "file.doc") { documentName in
            Button("Print '\(documentName)'") { }
            
            Button("Share...") { }
        }
    }
}




/**Alert (7)
 
 
 
 func alert(isPresented: Binding<Bool>, content: () -> Alert) -> some View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    isPresented: The variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    content: A closure that returns an Alert.

You can omit the cancel button label, in which case, a default will be used.

If you need to customize the alert, you can pass a value. Use this other method instead: alert(item:content:)
 */
/*struct Alert_View7: View {
    @State private var show: Bool = false
    
    var body: some View {
        
        Button("Open Sheet") {
            self.show = true
        }
        .padding(10).border(show ? Color.red : Color.clear)
        .alert(isPresented: $show, content: anAlert)
        
    }
    
    func anAlert() -> Alert {
        let send = ActionSheet.Button.default(Text("Send")) { print("hit send") }

        // If the cancel label is omitted, the default "Cancel" text will be shown
        let cancel = ActionSheet.Button.cancel(Text("Abort")) { print("hit abort") }
        
        return Alert(title: Text("Title"), message: Text("Message goes here"), primaryButton: send, secondaryButton: cancel)
    }
} */



/** Alert (8): Title from Error Description
 
 
 
 func alert<E, A>(isPresented: Binding<Bool>, error: E?, @ViewBuilder actions: () -> A) -> some View where E : LocalizedError, A : View
 


Use this modifier to present an Alert when a variable toggles from false to true.

Parameters

  ▪    isPresented: the variable used to trigger the Alert presentation. Upon dismissal, isPresented will be automatically set back to false.
  ▪    error: an error that adopts the LocalizedError protocol. The error's  description will be used for the alert title.
  ▪    actions: a ViewBuilder closure that returns a list of buttons to display in the alert.

All actions dismiss the alert after the action runs. The default button shows with greater prominence. You may increase a button's prominence, using keyboardShortcut(.defaultAction)

If no actions are provided, a single "OK" button is added automatically. If at least one action is provided, a "Cancel" button will be added automatically, but only if none of the specified actions is a button with the .cancel role.

SwiftUI may reorder the buttons, based on prominence and role.
 */
enum SaveError: LocalizedError {
     case denied
     case already_exists
     
     var errorDescription: String? {
         switch self {
         case .denied: return "Permission Denied"
         case .already_exists: return "Already Exists"
         }
     }
 }
 
 struct Alert_View8: View {
     @State var show = false
         
     var body: some View {
         Button(String("Open")) {
             show = true
         }
         .alert(isPresented: $show, error: SaveError.denied) {
             Button("Retry") {
                 
             }
             
             Button("Discard") {
                 
             }
         }
     }
 }




/**Alert (9)
 
 
 
 func alert<Item>(item: Binding<Item?>, content: (Item) -> Alert) -> some View where Item : Identifiable
 


Use this modifier to present an Alert that is passed a value. It needs the following parameters:

Parameters

  ▪    item: A value provided to build the Alert, which will be presented, when it goes from nil to some value. The item needs to conform with Identifiable. Upon dismissal, the item is automatically set back to nil.
  ▪    content: A closure that is passed an item and returns an Alert.

You can omit the cancel button label, in which case, a default will be used.
 
 */
struct MyItem: Identifiable {
    let id = UUID()
    let name: String
    let message: String
}

/*struct Alert_View9: View {
    @State private var selection: MyItem? = nil
    
    var body: some View {

        VStack(spacing: 20) {
            Button("Save user's first name") {
                self.selection = MyItem(name: "First Name", message: "Saving first name")
            }
            
            Button("Save user's last name") {
                self.selection = MyItem(name: "Last Name", message: "Saving last name")
            }
        }
        .alert(item: $selection, content: anAlert)
        
    }
    
    func anAlert(item: MyItem) -> Alert {

        let save = ActionSheet.Button.default(Text("Save " + item.name)) { print("hit save") }

        // If the cancel label is omitted, the default "Cancel" text will be shown
        let cancel = ActionSheet.Button.cancel(Text("Abort")) { print("hit abort") }
        
        return Alert(title: Text(item.name),
                     message: Text(item.message),
                     primaryButton: save,
                     secondaryButton: cancel)
    }
} */
