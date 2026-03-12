//
//  Stepper_Examples.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation
import SwiftUI


struct Stepper_View: View {
    @State private var c: Double = 0
    @State private var f: Double = 32
    
    var body: some View {
        List {
            Stepper {
                Text("Temp \(formatVal(c)) C / \(formatVal(f)) F")
            } onIncrement: {
                self.c += 1
                self.f = self.c * (9/5) + 32
            } onDecrement: {
                self.c -= 1
                self.f = self.c * (9/5) + 32
            } onEditingChanged: {
                print("\($0)")
            }
        }
    }
    
    func formatVal(_ v: Double) -> String {
        return String(format: "%.2f", v)
    }
}

struct Stepper_View2: View {
    @State private var c: Double = 0
    @State private var f: Double = 32
    
    var body: some View {
        Form {
            Stepper("Temp \(formatVal(c)) C / \(formatVal(f)) F", onIncrement: {
                self.c += 1
                self.f = self.c * (9/5) + 32
            }, onDecrement: {
                self.c -= 1
                self.f = self.c * (9/5) + 32
            }, onEditingChanged: {
                print("\($0)")
            })
        }
    }
    
    func formatVal(_ v: Double) -> String {
        return String(format: "%.2f", v)
    }
}


struct Stepper_View3: View {
    @State private var v: Double = 0
    
    var body: some View {
        Form {
            Stepper("Value = \(formatVal(v))",
                    value: $v,
                    in: 0...21,
                    step: 3,
                    onEditingChanged: {
                print("\($0)")
            })
        }
    }
    
    func formatVal(_ v: Double) -> String {
        return String(format: "%.2f", v)
    }
}


