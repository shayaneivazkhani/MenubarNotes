//
//  CustomTabView.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-26.
//

/*
import SwiftUI

struct ExampleTabView: View {
    
    var body: some View {
        CustomTabView(
            tabBarPosition: .top,
            content: [
                (
                    tabText: "Tab 1",
                    tabIconName: "icons.general.home",
                    view: AnyView(
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Text("First Tab!")
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(Color.blue)
                    )
                ),
                (
                    tabText: "Tab 2",
                    tabIconName: "icons.general.list",
                    view: AnyView(
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Text("Second Tab!")
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(Color.red)
                    )
                ),
                (
                    tabText: "Tab 3",
                    tabIconName: "icons.general.cog",
                    view: AnyView(
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Text("Third Tab!")
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(Color.yellow)
                    )
                )
            ]
        )
    }
}



public extension Color {

    #if os(macOS)
    static let backgroundColor = Color(NSColor.windowBackgroundColor)
    static let secondaryBackgroundColor = Color(NSColor.controlBackgroundColor)
    #else
    static let backgroundColor = Color(UIColor.systemBackground)
    static let secondaryBackgroundColor = Color(UIColor.secondarySystemBackground)
    #endif
}

public struct CustomTabView: View {
    
    public enum TabBarPosition { // Where the tab bar will be located within the view
        case top
        case bottom
    }
    
    private let tabBarPosition: TabBarPosition
    private let tabText: [String]
    private let tabIconNames: [String]
    private let tabViews: [AnyView]
    
    @State private var selection = 0
    
    public init(tabBarPosition: TabBarPosition, content: [(tabText: String, tabIconName: String, view: AnyView)]) {
        self.tabBarPosition = tabBarPosition
        self.tabText = content.map{ $0.tabText }
        self.tabIconNames = content.map{ $0.tabIconName }
        self.tabViews = content.map{ $0.view }
    }
    
    public var tabBar: some View {
        
        HStack {
            Spacer()
            ForEach(0..<tabText.count) { index in
                HStack {
                    Image(self.tabIconNames[index])
                    Text(self.tabText[index])
                }
                .padding()
                .foregroundColor(self.selection == index ? Color.accentColor : Color.primary)
                .background(Color.secondaryBackgroundColor)
                .onTapGesture {
                    self.selection = index
                }
            }
            Spacer()
        }
        .padding(0)
        .background(Color.secondaryBackgroundColor) // Extra background layer to reset the shadow and stop it applying to every sub-view
        .shadow(color: Color.clear, radius: 0, x: 0, y: 0)
        .background(Color.secondaryBackgroundColor)
        .shadow(
            color: Color.black.opacity(0.25),
            radius: 3,
            x: 0,
            y: tabBarPosition == .top ? 1 : -1
        )
        .zIndex(99) // Raised so that shadow is visible above view backgrounds
    }
    public var body: some View {
        
        VStack(spacing: 0) {
            
            if (self.tabBarPosition == .top) {
                tabBar
            }
            
            tabViews[selection]
                .padding(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if (self.tabBarPosition == .bottom) {
                tabBar
            }
        }
        .padding(0)
    }
}



// MARK: -  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

struct ExampleTabView2: View {
var body: some View {
    CustomTabView2(
        content: [
            (
                title: "Profile",
                icon: "person.crop.circle",
                view: AnyView (
                    EmptyView()
                )
            ),
            (
                title: "Appearance",
                icon: "paintpalette",
                view: AnyView(
                    EmptyView()
                )
            ),
            (
                title: "Privacy",
                icon: "hand.raised",
                view: AnyView (
                    EmptyView()
                )
            ),
            (
                title: "Folders",
                icon: "folder.badge.gearshape",
                view: AnyView (
                    EmptyView()
                )
            ),
            (
                title: "Paint",
                icon: "paintbrush",
                view: AnyView(
                    EmptyView()
                )
            ),
            (
                title: "Draw",
                icon: "paintbrush.pointed",
                view: AnyView(
                    EmptyView()
                )
            ),
            (
                title: "Apple",
                icon: "apple.logo",
                view: AnyView(
                    EmptyView()
                )
            )
            ]
        )
    }
}

public struct CustomTabView2: View {
    private let titles: [String]
    private let icons: [String]
    private let tabViews: [AnyView]

@State private var selection = 0
@State private var indexHovered = -1

public init(content: [(title: String, icon: String, view: AnyView)]) {
    self.titles = content.map{ $0.title }
    self.icons = content.map{ $0.icon }
    self.tabViews = content.map{ $0.view }
}

public var tabBar: some View {
    HStack {
        Spacer()
        ForEach(0..<titles.count, id: \.self) { index in

            VStack {
                Image(systemName: self.icons[index])
                    .font(.largeTitle)
                Text(self.titles[index])
            }
            .frame(height: 30)
            .padding(15)
            .background(Color.gray.opacity(((self.selection == index) || (self.indexHovered == index)) ? 0.3 : 0),
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous))

            .frame(height: 80)
            .padding(.horizontal, 0)
            .foregroundColor(self.selection == index ? Color("SettingsV4") : Color("SettingsV5"))
            .onHover(perform: { hovering in
                if hovering {
                    indexHovered = index
                } else {
                    indexHovered = -1
                }
            })
            .onTapGesture {
                self.selection = index
            }
        }
        Spacer()
    }
    .padding(0)
    .background(Color("SettingsV1"))
}

public var body: some View {
    VStack(spacing: 0) {
        tabBar

        tabViews[selection]
            .padding(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(0)
    }
}

// MARK: -  ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

public struct CustomTabView3: View {
    
    public enum TabBarPosition { // Where the tab bar will be located within the view
        case top
        case bottom
    }
    
    private let tabBarPosition: TabBarPosition
    private let tabText: [String]
    private let tabIconNames: [String]
    private let tabViews: [AnyView]
    
    @State private var selection = 0
    
        public init(tabBarPosition: TabBarPosition, content: [(tabText: String, tabIconName: String, view: AnyView)]) {
        self.tabBarPosition = tabBarPosition
        self.tabText = content.map{ $0.tabText }
        self.tabIconNames = content.map{ $0.tabIconName }
        self.tabViews = content.map{ $0.view }
        }
    
        public var tabBar: some View {
        VStack {
            Spacer()
                .frame(height: 5.0)
            HStack {
                Spacer()
                    .frame(width: 50)
                ForEach(0..<tabText.count) { index in
                    VStack {
                        Image(systemName: self.tabIconNames[index])
                            .font(.system(size: 40))
                        Text(self.tabText[index])
                    }
                    .frame(width: 65, height: 65)
                    .padding(5)
                    .foregroundColor(self.selection == index ? Color.accentColor : Color.primary)
                    .background(Color.secondaryBackgroundColor)
                    .onTapGesture {
                        self.selection = index
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(self.selection == index ? Color.backgroundColor.opacity(0.33) : Color.red.opacity(0.0))
                    )               .onTapGesture {
                        self.selection = index
                    }

                }
                Spacer()
            }
            .frame(alignment: .leading)
            .padding(0)
            .background(Color.secondaryBackgroundColor) // Extra background layer to reset the shadow and stop it applying to every sub-view
            .shadow(color: Color.clear, radius: 0, x: 0, y: 0)
            .background(Color.secondaryBackgroundColor)
            .shadow(
                color: Color.black.opacity(0.25),
                radius: 3,
                x: 0,
                y: tabBarPosition == .top ? 1 : -1
            )
            .zIndex(99) // Raised so that shadow is visible above view backgrounds
        }
        }

    public var body: some View {
        VStack(spacing: 0) {
                if (self.tabBarPosition == .top) {
                tabBar
            }
        
            tabViews[selection]
            .padding(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
            if (self.tabBarPosition == .bottom) {
            tabBar
            }
    }
    .padding(0)
    }
}
*/
