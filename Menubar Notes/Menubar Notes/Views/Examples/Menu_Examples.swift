//
//  Menu_Examples.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

/* OKLART ännu hur den ska implementeras & ifall det ens är användsbart
struct Multi_Function_Button: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("current_button") private var which_button: Int = 0
    @AppStorage("multi_function_button") private var multi_func_button_name: String = "Day Counter"
    
    var body: some View {
        
        HStack (spacing: 0) {
            Menu("open") {
            //Menu {
                Button("Day Counter") {
                    which_button = 0
                }
                Button("Week Finder") {
                    which_button = 1
                }
                Button("Export All Notes") {
                    which_button = 2
                }
             
            /*} label: {
                Label(" ", systemImage: "magnifyingglass.circle.fill") */
            } primaryAction: {
                if (which_button = 0) {
                    
                }
                if (which_button = 1) {
                    
                }
                if (which_button = 2) {
                    
                }
            }.menuStyle(MyMenuStyle3())
             .frame(width: 65)
            
            Text(multi_func_button)
                .font(.system(size: 9, weight: .light, design: .monospaced))
                .frame(alignment: .leading)
            
        }
    }
}
*/


struct Menu_Picker: View {
    var body: some View {
        Menu("My Menu") {
            Button("Option A") { }
            Button("Option B") { }
            Menu("Submenu") {
                Button("Sub option A") { }
                Button("Sub option B") { }
                Button("Sub option C") { }
            }
        }.frame(width: 150)
         .menuStyle(MyMenuStyle())
    }
}

