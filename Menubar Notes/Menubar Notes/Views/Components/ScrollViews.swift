
//  PopoverPageController.swift
//  Notes
//
//  Created by Shayan Eivaz Khani on 2022-10-28.

import SwiftUI

struct PopoverPageController<Content: View>: View {
    
    @EnvironmentObject var sharedAppState: AppState
    
    @Namespace private var namespace
    
//•••••••••••••••••••••••••••••••••••••••••••••••••
    
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    @State private var isExpanded: Bool = false
    
    var body: some View {
        if #available(macOS 26.0, *) {
            GlassEffectContainer(spacing: 10.0) {
                ZStack {
                    //Color.clear.edgesIgnoringSafeArea(.all)
                    (sharedAppState.darkMode ? Color.PopOverControllerDarkMode.opacity(0.2) : Color.PopoverControllerLightMode.opacity(0.35)).edgesIgnoringSafeArea(.all)
                    
                    /*if #available(macOS 26.0, *) {
                        GlassEffectContainer(spacing: 10.0) {
                            Color.clear.frame(width: 53, height: 75, alignment: .top).glassEffect(.clear.interactive(), in: .rect(cornerRadius: 9.0))
                            .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 9, style: .continuous))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous)).offset(CGSize(width: 4.00, height: 0.00))
                                .glassEffect(Color.black.opacity(0.25).blendMode(.destinationOut))
                                .glassEffectID("eraser", in: namespace)
                            Color.clear.frame(width: 53, height: 75, alignment: .top).glassEffect(.clear.interactive(), in: .rect(cornerRadius: 9.0)).tint(Color.blue)
                            // Adds Liquid Glass to the button.
                            //.glassEffect()
                            
                            #if os(macOS)
                            //.tint(.clear)
                            #endif
                            // Adds an identifier to the button for animation.
                            //.glassEffectID("togglebutton", in: namespace)
                            //.glassEffect()
                            //.glassEffect(.clear, in: .rect(cornerRadius: 9.0))
                             
                            //Color.clear.edgesIgnoringSafeArea(.all).glassEffect(.clear, in: .rect(cornerRadius: 9.0))
                            
                            //Color.clear.frame(width: 53, height: 75).glassEffect(.clear.interactive(), in: .rect(cornerRadius: 9.0)).glassEffectID("eraser", in: namespace)
                            VStack {
                                Button(
                                    action: {
                                    },
                                    label: {
                                        //Text("Dismiss")
                                        Text("Close")
                                    }
                                ).glassEffect()
                            }.frame(width: 250, height: 160).glassEffect(.regular, in: .rect(cornerRadius: 9.0))//.tint(Color.blue)
                        }
                    } else {
                        
                    }
                     
                     if #available(macOS 12.0, *) {
                                 Rectangle()
                                     .fill(Color.clear)
                                     .frame(width: 300, height: 200)
                                     .background(.ultraThinMaterial)
                             } else {
                                 Rectangle()
                                     .fill(Color.clear)
                                     .frame(width: 300, height: 200)
                                     .background(Color.white.opacity(0.6))
                             }
                     */
                    
                    GeometryReader { geometry in
                        LazyHStack(spacing: 0) {
                            self.content.frame(width: geometry.size.width)
                        }.frame(width: geometry.size.width, alignment: .leading)
                         .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                         .offset(x: self.translation)
                    }
                    
                }.frame(width: 530, height: 755) //.frame(width: 430, height: 675) //.frame(width: 420, height: 525)//.frame(width: 470, height: 725)
                //.background(sharedAppState.darkMode ? Color.PopOverControllerDarkMode.opacity(0.5) : Color.PopoverControllerLightMode.opacity(0.1)) // MARK: – 🌈 färgera avgör hela Popoverns background färg
                //.background(Color.clear)
                .shadow(color: sharedAppState.darkMode ? Color.neuPurp.opacity(0.8): Color.neuOrange.opacity(0.3), radius: 0.2, x: 0, y: 0) // MARK: – 🌈 ifall shadowen is "un-commented" då får allting på Popovern en shadow runt sig. Allting förutom editorns texter och ZStacken med Date and Priority
            }
            
        } else {
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    LazyHStack(spacing: 0) {
                        self.content.frame(width: geometry.size.width)
                    }.frame(width: geometry.size.width, alignment: .leading)
                     .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                     .offset(x: self.translation)
                }
            }.frame(width: 530, height: 755) //.frame(width: 430, height: 675) //.frame(width: 420, height: 525)//.frame(width: 470, height: 725)
             .background(sharedAppState.darkMode ? Color.PopOverControllerDarkMode : Color.PopoverControllerLightMode) // MARK: – 🌈 färgera avgör hela Popoverns background färg
             //.shadow(color: sharedAppState.darkMode ? Color.neuPurp: Color.neuGray, radius: 0.9, x: 0, y: 0) // MARK: – 🌈 ifall shadowen is "un-commented" då får allting på Popovern en shadow runt sig. Allting förutom editorns texter och ZStacken med Date and Priority
        }
       
    }
}



/*
    Use in ContentView.swift as list of notrs
     
    Elevator {
        Other_View()
        Other_View()
        Other_View()
     }
*/
struct Elevator<Content: View>: ContainerView {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    @EnvironmentObject var sharedAppState: AppState
    
    var body: some View {
        ZStack {
            /*Color(.green)
                .edgesIgnoringSafeArea(.all)*/
            
            /*
             ZStack {
                 /*if sharedAppState.darkMode {
                     Image("ListBackgroundLeatherDark")
                         .resizable()
                         //.scaledToFit()
                         //.frame(width: 80, height: 75)
                         .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                 }
                 if colorScheme == .light {
                     Image("ListBackgroundLeatherLigth")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 305, height: 410)
                         .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                 }*/
                 
                 ScrollView(.vertical) {
                     LazyVStack(content: content)
                         //.padding(5)
                 } //.shadow(color: sharedAppState.darkMode ? Color.neuItemDarkShadowUP: Color.neuItemLightShadowUP, radius: 1, x: -1, y: -1) // MARK: 🌈 shadowen som läggs på varje view på en Row i Listorna av Itemsen
                   //.shadow(color: sharedAppState.darkMode ? Color.neuItemDarkShadowDOWN: Color.neuItemLightShadowDOWN, radius: 1, x: 1, y: 1) // MARK: 🌈 shadowen som läggs på varje view på en Row i Listorna av Itemsen
                   //.background(sharedAppState.darkMode ? Color.neuBlueNeon : Color.red)
                   .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous)) // MARK: 🌈 bestämmer shapen på ScrollViewn som Listan av Itemsen finns inside
                   //.shadow(radius: 4)
                   .padding(7) // MARK: 🌈 avståndet mellan gränsen av taskitemsen och den list backgrund gränsen som den lägg på i en ZStack
             }.frame(width: 495, height: 620) //.frame(width: 555, height: 540) //.frame(width: 395, height: 540) //.frame(width: 305, height: 410)   /* hur stor ska listan vara */
              .background(sharedAppState.darkMode ? Color.ListPageBackgroundDarkMode : Color.ListPageBackgroundLightMode)
              .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)) // MARK: 🌈 bestämmer shapen på List Backgrounder (i.e. denna ZStacken)
              //.shadow(radius: 4) // MARK: 🌈 shadow runt ZStacken som är List backgrounden
              /*.shadow(color: sharedAppState.darkMode ? Color.ListElevatorShadowDarkModeUP: Color.ListElevatorShadowLightModeUP, radius: 2, x: -1, y: -1) // MARK: Elevator – 🌈 shadow runt Listan med Itemsen
              .shadow(color: sharedAppState.darkMode ? Color.ListElevatorShadowDarkModeDOWN : Color.ListElevatorShadowLightModeDOWN, radius: 2, x: 1, y: 1) // MARK: Elevator – 🌈 shadow runt Listan med Itemsen */
              .shadow(color: sharedAppState.darkMode ? Color.ListElevatorShadowDarkModeDOWN : Color.ListElevatorShadowLightModeUP, radius: 4, x: 0, y: 0)
             */
            
            ScrollView(.vertical) {
                LazyVStack(content: content)
                    //.clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .padding(5)
            } //.shadow(color: sharedAppState.darkMode ? Color.neuItemDarkShadowUP: Color.neuItemLightShadowUP, radius: 1, x: -1, y: -1) // MARK: 🌈 shadowen som läggs på varje view på en Row i Listorna av Itemsen
              //.shadow(color: sharedAppState.darkMode ? Color.neuItemDarkShadowDOWN: Color.neuItemLightShadowDOWN, radius: 1, x: 1, y: 1) // MARK: 🌈 shadowen som läggs på varje view på en Row i Listorna av Itemsen
              //.background(sharedAppState.darkMode ? Color.neuBlueNeon : Color.red)
            //.background(sharedAppState.darkMode ? Color.ListPageBackgroundDarkMode : Color.ListPageBackgroundLightMode)
                .background(Color.clear)
                //.clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous)) // MARK: 🌈 bestämmer shapen på ScrollViewn som Listan av Itemsen finns inside
              //.shadow(radius: 4)
              .padding(1) // MARK: 🌈 avståndet mellan gränsen av taskitemsen och den list backgrund gränsen som den lägg på i en ZStack
        }
    }
}

/*
     Use in ContentView.seiwt / some view:
     
     Carousel {
        Other_View()
        Other_View()
        Other_View()
     }
*/

struct Carousel<Content: View>: ContainerView {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    @EnvironmentObject var sharedAppState: AppState
    
    var body: some View {
        ZStack {
            Color.white
            ScrollView(.horizontal) {
                LazyHStack(content: content)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous)) // MARK: 🌈 bestämmer shapen på ScrollViewn som Listan av Itemsen finns inside
                    .background(Color.white)
            }.frame(width: 450, height: 55)
            //.frame(minWidth: 450, idealWidth: 450, maxWidth: .infinity, minHeight: 55, idealHeight: 55, maxHeight: .infinity)
        }.background(sharedAppState.darkMode ? Color.ListPageBackgroundDarkMode : Color.ListPageBackgroundLightMode)
         .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)) // MARK: 🌈 bestämmer shapen på List Backgrounder (i.e. denna ZStacken)
         .preferredColorScheme(.light)  // MARK: – 💥 Force View to use light or dark mode
    }
}



protocol ContainerView: View {
    associatedtype Content
    init(content: @escaping () -> Content)
}

extension ContainerView {
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(content: content)
    }
}
