//
//  ExportSingelNote.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-07-15.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers


struct ExportNoteSheetView: View {
    
    @EnvironmentObject var sharedAppState: AppState

    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        ZStack {
            sharedAppState.darkMode ? Color.generalSheetBackgroundColorDarkMode : Color.generalSheetBackgroundColorLightMode
            VStack {
                VStack (spacing: 8) {
                    Text("Export this note as")
                        //.font(.system(size: 11, weight: .bold, design: .monospaced))
                        .font(.custom("Avenir", size: 14))
                        .foregroundColor(sharedAppState.darkMode ? .white : .black)
                    Spacer()
                        .frame(height: 4)
                    FILE_EXPORTER_SINGLE_DOCUMENT()
                }.frame(width: 250, height: 90)//.frame(width: 1200, height: 600) // VStack (spacing: 5) {
                Button(
                    action: {
                        sharedAppState.someSheetIsActiveWaitingForUserActionToCloseSheet = false
                        dismiss()
                    },
                    label: {
                        //Text("Dismiss")
                        Text("Close")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(sharedAppState.darkMode ? .white : .black)
                            .shadow(radius: 0.6)
                    }
                )
            }.frame(width: 250, height: 160)
        }.frame(width: 250, height: 160)
            .preferredColorScheme(sharedAppState.darkMode ? .dark : .light)
    }
}


struct FILE_EXPORTER_SINGLE_DOCUMENT: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var showRichExporter = false
    @State private var showPlainExporter = false
    
    @AppStorage("SINGLENOTERICHTEXTATTRIBUTEDSTRINGEXPORT") private var singleNoteRichTextAttributedStringExport: String = ""
    @AppStorage("SINGLENOTERICHTEXTSTRINGEXPORT") private var singleNoteRichTextStringExport: String = ""
    
    var body: some View {
        let fileDocRichText = MyFileDocument_SINGLE_RichText_Note(txt: loadAttributedTexttFromAppStorage(singleNoteRichTextAttributedStringExport))
        let fileDocPlainText = MyFileDocument_SINGLE_PlainText_Note(txt: singleNoteRichTextStringExport)
        
        HStack {
            Button("attributed text") {
                self.showRichExporter = true
            }.fileExporter(isPresented: $showRichExporter, document: fileDocRichText, contentType: .rtf, defaultFilename: "note_attributed.rtf") { result in
                switch result {
                    case .failure(let error):
                        print("Error \(error.localizedDescription)")
                    //case .success(let url):
                    case .success(_):
                       // print("\(url) exported!")
                        self.showRichExporter = false
                        dismiss()
                    }
            }
            
            Text("  or  ")
                .font(.custom("Avenir", size: 14))
            
            Button("plain text") {
                self.showPlainExporter = true
            }.fileExporter(isPresented: $showPlainExporter, document: fileDocPlainText, contentType: .plainText, defaultFilename: "note_plain.txt") { result in
                switch result {
                    case .failure(let error):
                        print("Error \(error.localizedDescription)")
                    //case .success(let url):
                    case .success(_):
                        //print("\(url) exported!")
                        self.showPlainExporter = false
                        dismiss()
                }
            }
        }
    }
    
    func decodeAttributedString(from base64: String) -> NSAttributedString? {
        guard let data = Data(base64Encoded: base64) else {
            //print("Base64 decoding failed")
            return nil
        }
        
        do {
            let attributedString = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
            return attributedString
        } catch {
            //print("Decoding failed: \(error)")
            return nil
        }
    }
    func loadAttributedTexttFromAppStorage(_ text: String) -> NSAttributedString {
        if let decoded = decodeAttributedString(from: text) {
            return decoded
        } else {
            return NSAttributedString(string: text)
        }
    }
}

//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

//struct MyFileDocument_SINGLE_RichText_Note: FileDocument {
/** Stored property 'txt' of 'Sendable'-conforming struct 'MyFileDocument_SINGLE_RichText_Note' has non-sendable type 'NSAttributedString'
 Mark the struct as @unchecked Sendable,
        i.e. MyFileDocument_SINGLE_RichText_Note: FileDocument {
            ––> MyFileDocument_SINGLE_RichText_Note: FileDocument, @unchecked Sendable {
 
        This tells the compiler: “I know NSAttributedString isn’t Sendable, but I’ll manage the risks.”
 */
struct MyFileDocument_SINGLE_RichText_Note: FileDocument, @unchecked Sendable {
    static var readableContentTypes: [UTType] { [.rtf] }

    var txt: NSAttributedString

    init(txt: NSAttributedString) {
        self.txt = txt
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }

        // Decode from RTF
        self.txt = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        // Encode to RTF
        let data = try txt.data(from: NSRange(location: 0, length: txt.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])
        return FileWrapper(regularFileWithContents: data)
    }
}

struct MyFileDocument_SINGLE_PlainText_Note: FileDocument {
    var txt: String
    
    static var readableContentTypes: [UTType] {
        return [.plainText]
    }
    
    init(txt: String) {
        self.txt = txt
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            self.txt = String(data: data, encoding: .utf8) ?? ""
        } else {
            self.txt = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = txt.data(using: .utf8)!
        return FileWrapper(regularFileWithContents: data)
    }
}
