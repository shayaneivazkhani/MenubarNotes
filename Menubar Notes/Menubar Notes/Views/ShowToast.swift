//
//  ShowToast.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-01.
//

import SwiftUI

struct FabulaToastView: View {
    
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Text("Show Toast!")
                .onTapGesture {
                    withAnimation {
                        showToast = true
                    }
                }
        }
        .showToast(showToast: $showToast.animation(), content: FabulaToast(showToast: $showToast.animation(), toastData: FabulaToast.ToastData(title: "Attention❗️", message: "Operation available only if you select text", backgroundColor: Color.white), position: .bottom))
        
#if os(macOS)
        //.frame(width: 410, height: 630)
        //.frame(width: 500, height: 500)
#endif
    }
}


public struct P107_Toast: View {
    
    @State private var showTopToast = false
    @State private var showBottomToast = false
    
    public init() {}
    public var body: some View {
        VStack {
            Button {
                withAnimation {
                    showTopToast = true
                }
            } label: {
                Text("Show Top Toast!")
            }.buttonStyle(PlainButtonStyle())
            
            Divider()
                .frame(width: 44)
                .padding()
            
            Button {
                withAnimation {
                    showBottomToast = true
                }
                print("bottom")
            } label: {
                Text("Show Bottom Toast!")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .showToast(showToast: $showTopToast, content:
                    FabulaToast(showToast: $showTopToast,
                                toastData: FabulaToast.ToastData(title: "Title", message: "Messages", backgroundColor: Color.orange),
                                position: .top))
        .showToast(showToast: $showBottomToast, content:
                    FabulaToast(showToast: $showBottomToast,
                                toastData: FabulaToast.ToastData(title: "Title", message: "Messages", backgroundColor: Color.orange),
                                position: .bottom))
    }
}


struct ToastView: View {
    
    let toastData: FabulaToast.ToastData
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width:22)
            //Image(systemName: "checkmark")
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(toastData.title))
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(LocalizedStringKey(toastData.message))
                    .font(.callout)
                    .opacity(0.9)
            }
            Spacer()
        }//.frame(width: 390)
        /*
        .background(
            RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .stroke(.red, lineWidth: CGFloat(0.5))
        )*/
        /*.overlay(
            RoundedRectangle(cornerRadius: 9, style: .continuous)
                .stroke(.red, lineWidth: CGFloat(0.5))
        )*/
        .foregroundColor(Color.black)
        .padding(.vertical, 14)
        .padding(5)
    }
}



struct FabulaToast: View {
    
    enum ToastPosition {
        case top
        case bottom
    }
    
    struct ToastData {
        var title: String
        var message: String
        var backgroundColor: Color
    }
    /*
    struct ToastData {
        var title: String
        var message: String
        var backgroundColor: Color
    }
    
        .background(toastData.backgroundColor.opacity(0.3))
        .background(.ultraThinMaterial)*/
    @Binding var showToast: Bool
    let toastData: ToastData
    var position: ToastPosition
    
    var body: some View {
    
        VStack {
            if position == .bottom {
                Spacer()
            }
            
            ToastView(toastData: toastData)
                .background(
                    //toastData.backgroundColor.opacity(0.3)
                    toastData.backgroundColor
                )
                .background(.ultraThinMaterial)
                //.background(.ultraThickMaterial)
                .cornerRadius(9)
                .background(
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .stroke(.black, lineWidth: CGFloat(4.0))
                            //.foregroundColor(toastData.backgroundColor)
                )
                /*.overlay(
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .stroke(.red, lineWidth: CGFloat(2.0))
                            .foregroundColor(toastData.backgroundColor.opacity(0.3))
                )*/
            
            /*if #available(macOS 12.0, *) {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.3))
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
            } else {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.8))
                    .cornerRadius(8)
            }*/
            
            if position == .top {
                Spacer()
            }
        }
        //.padding()
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .opacity(self.showToast ? 1.0 : 0)
        .transition(.move(edge: position == .top ? .top : .bottom))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    self.showToast = false
                }
            }
        }
        /*.onTapGesture {
            withAnimation {
                self.showToast = false
            }
        }*/
    }
}


struct ToastModifier<T: View>: ViewModifier {
    
    @Binding var showToast: Bool
    let content: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                if showToast {
                    self.content
                } else {
                    EmptyView()
                }
            }
        }
    }
}


extension View {
    func showToast<T: View>(showToast: Binding<Bool>, content: T) -> some View {
        self.modifier(ToastModifier(showToast: showToast, content: content))
    }
}

// Orginal Code ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

/*
public struct P107_Toast: View {
    
    @State private var showTopToast = false
    @State private var showBottomToast = false
    
    public init() {}
    public var body: some View {
        VStack {
            Button {
                withAnimation {
                    showTopToast = true
                }
            } label: {
                Text("Show Top Toast!")
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider()
                .frame(width: 44)
                .padding()
            
            Button {
                withAnimation {
                    showBottomToast = true
                }
                print("bottom")
            } label: {
                Text("Show Bottom Toast!")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .showToast(showToast: $showTopToast, content:
                    FabulaToast(showToast: $showTopToast,
                                toastData: FabulaToast.ToastData(title: "Title", message: "Messages", backgroundColor: Color.orange),
                                position: .top))
        .showToast(showToast: $showBottomToast, content:
                    FabulaToast(showToast: $showBottomToast,
                                toastData: FabulaToast.ToastData(title: "Title", message: "Messages", backgroundColor: Color.orange),
                                position: .bottom))
    }
}


fileprivate
struct ToastView: View {
    
    let toastData: FabulaToast.ToastData
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(toastData.title))
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(LocalizedStringKey(toastData.message))
                    .font(.callout)
                    .opacity(0.9)
            }
            Spacer()
        }
        .foregroundColor(Color.fabulaBack0)
        .padding(10)
    }
}

fileprivate
struct FabulaToastView: View {
    
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Text("Show Toast!")
                .onTapGesture {
                    withAnimation {
                        showToast = true
                    }
                }
        }
        .showToast(showToast: $showToast.animation(), content: FabulaToast(showToast: $showToast.animation(), toastData: FabulaToast.ToastData(title: "Title", message: "your message", backgroundColor: Color.orange), position: .top))
        
#if os(macOS)
        .frame(width: 500, height: 500)
#endif
    }
}

fileprivate
struct FabulaToast: View {
    
    enum ToastPosition {
        case top
        case bottom
    }
    
    struct ToastData {
        var title: String
        var message: String
        var backgroundColor: Color
    }
    
    @Binding var showToast: Bool
    let toastData: ToastData
    var position: ToastPosition
    
    var body: some View {
        VStack {
            if position == .bottom {
                Spacer()
            }
            if #available(macOS 12.0, *) {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.3))
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            } else {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.8))
                    .cornerRadius(10)
            }
            
            if position == .top {
                Spacer()
            }
        }
        .padding()
        .opacity(self.showToast ? 1.0 : 0)
        .transition(.move(edge: position == .top ? .top : .bottom))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.showToast = false
                }
            }
        }
        .onTapGesture {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

fileprivate
struct ToastModifier<T: View>: ViewModifier {
    
    @Binding var showToast: Bool
    let content: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                if showToast {
                    self.content
                }else {
                    EmptyView()
                }
            }
        }
    }
}

fileprivate
extension View {
    func showToast<T: View>(showToast: Binding<Bool>, content: T) -> some View {
        self.modifier(ToastModifier(showToast: showToast, content: content))
    }
}

struct P107_Toast_Previews: PreviewProvider {
    static var previews: some View {
        P107_Toast()
    }
}
*/
