//
//  Open4TimeLinks.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI

struct Open4TimeLinks: View {
    @State private var url: URL = URL(string: "https://4timeapps.com/terms-of-use")!
    
    var body: some View {
        //ZStack {
            //Color.black
            Menu("Links") {
                
                /*Button("Bing") {
                                    url = URL(string: "https://4timeapps.com/terms-of-use")!
                                 }.buttonStyle(ClearImageBackground()) */
                            
                /*Button("Google") {
                                url = URL(string: "https://google.com")!
                             }
                                 Button("Yahoo!") {
                                 url = URL(string: "https://yahoo.com")!
                             }*/
            } primaryAction: {
                NSWorkspace.shared.open(url)
            }.menuStyle(MyMenuStyle3())
            .frame(width: 65)
             //.background(Color.gray, in: Capsule())
            //}.frame(width: 60, height: 18)
            //.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
