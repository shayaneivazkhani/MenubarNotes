//
//  ListPageName.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

struct ListPageName: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    private var nameForPage: Int = 0
    
    init(_ page: Int) {
        nameForPage = page
    }
    var body: some View {
        if #available(macOS 26.0, *) {
            VStack (alignment: .trailing) {
                switch nameForPage
                {
                case 1:
                    Text("Important Notes")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 0.8)
                        //.frame(alignment: .trailing)
                        .minimumScaleFactor(0.8) //<--Here – Automatic adjust font size in Text()
                        
                case 2:
                    Text("Useful Notes ")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                        .minimumScaleFactor(0.8)
                    
                case 3:
                    Text("Urgent Notes")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                        .minimumScaleFactor(0.8)
                    
                case 4:
                    Text("Other Notes")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                    
                default:
                    Text("")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                    
                }
            }.frame(width: 115, alignment: .trailing)
            //.fixedSize(horizontal: true, vertical: false)
        } else {
            VStack (alignment: .trailing) {
                switch nameForPage
                {
                case 1:
                    Text("Important Notes")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 0.8)
                        //.frame(alignment: .trailing)
                        .minimumScaleFactor(0.8) //<--Here – Automatic adjust font size in Text()
                    
                case 2:
                    Text("Useful Notes ")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                        .minimumScaleFactor(0.8)
                    
                case 3:
                    Text("Urgent Notes")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                        .minimumScaleFactor(0.8)
                    
                case 4:
                    Text("Other Notes")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                    
                default:
                    Text("")
                        .font(.custom("Avenir", size: 13))
                        //.foregroundColor(sharedAppState.darkMode ? Color.ListPageNameDarkMode : Color.ListPageNameLightMode)
                        .shadow(radius: 1)
                    
                }
            }.frame(width: 115, alignment: .trailing)
            //.fixedSize(horizontal: true, vertical: false)
        }
    }
}
