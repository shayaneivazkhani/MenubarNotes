//
//  CustomTextView.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-28.
//
import Foundation
import SwiftUI
import AppKit

/** ANVÄNDNING:
    
    Ersatt NSTextView i följande:       RichTextEditor() ––> viewConfiguration: { richTextView in ––> if let textView = richTextView as? NSTextView {
*/
class CustomTextView: NSTextView {
    override var readablePasteboardTypes: [NSPasteboard.PasteboardType] {
        return [.string, .rtf] // Exclude .tiff, .png, etc.
    }

    /*override func read(from pboard: NSPasteboard, type: NSPasteboard.PasteboardType) -> Bool {
        // Optionally handle pasting yourself
        return super.read(from: pboard, type: type)
    }*/
}
