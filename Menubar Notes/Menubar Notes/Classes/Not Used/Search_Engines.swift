//
//  Search_Engines.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import SwiftUI
import Foundation

struct Search_Engines: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    @AppStorage("engine_url") private var url: URL = URL(string: "https://google.com")!
    
    @AppStorage("engine_name") private var engine_url_name: String = "Google"
    
    var body: some View {
        Menu("Search") {
        //Menu {
            Button("Bing") {
                url = URL(string: "https://bing.com")!
                engine_url_name = "Bing"
            }
            Button("ChatGPT") {
                url = URL(string: "https://chat.openai.com/auth/login")!
                engine_url_name = "ChatGPT"
            }
            Button("Desmos") {
                url = URL(string: "https://www.desmos.com/calculator")!
                engine_url_name = "Desmos"
            }
            Button("DuckDuckGo") {
                url = URL(string: "https://duckduckgo.com")!
                engine_url_name = "DuckDuckGo"
            }
            Button("Ecosia") {
                url = URL(string: "https://ecosia.com")!
                engine_url_name = "Ecosia"
            }
            Button("Google") {
                url = URL(string: "https://google.com")!
                engine_url_name = "Google"
            }
            Button("Wikipedia") {
                url = URL(string: "https://www.wikipedia.org")!
                engine_url_name = "Wikipedia"
            }
            Button("WolframAlpha") {
                url = URL(string: "https://www.wolframalpha.com")!
                engine_url_name = " WolframAlpha"
            }
            Button("Yahoo!") {
                url = URL(string: "https://yahoo.com")!
                engine_url_name = "Yahoo!"
            }
            Button("Youtube") {
                url = URL(string: "https://www.youtube.com")!
                engine_url_name = "Youtube"
            }
        /*} label: {
            Label(" ", systemImage: "magnifyingglass.circle.fill") */
        } primaryAction: {
            NSWorkspace.shared.open(url)
        }.menuStyle(MyMenuStyle3())
         .frame(width: 65)
    }
}
