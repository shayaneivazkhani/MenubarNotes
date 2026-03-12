
//
//  FILE_EXPORTER_MULTIPLE_DOCUMENT.swift
//  menubarstyle
//
//  Created by Shayan Eivaz Khani on 2022-12-25.
//

import SwiftUI
import UniformTypeIdentifiers


struct ExportView: View {
        
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            
            VStack (spacing: 5) {
                ZStack {
                    
                    Color.secondary.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    Color.secondary.opacity(0.7).clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(12)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(24)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(36)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(48)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(60)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(72)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(84)
                    Color.secondary.clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous)).padding(100)
                    
                    VStack (spacing: 12) {
                        FILE_EXPORTER_MULTIPLE_DOCUMENT()
                    }
                    
                }.frame(width: 305, height: 200)  // ZStack
                 .preferredColorScheme(.dark)  // MARK: – 💥 Force View to use light or dark mode
            }.frame(width: 305, height: 200) // VStack (spacing: 5) {
        }
}

/** File Exporter (2): Multiple Documents
 
    func fileExporter<C>(isPresented: Binding<Bool>, documents: C, contentType: UTType, onCompletion: @escaping (Result<[URL], Error>) -> Void) -> some View where C : Collection, C.Element : FileDocument
        This modifier presents a platform dependent system interface that allows the user to export multiple in-memory documents. For a single document, visit fileExporter(isPresented:document:contentType,defaultFilename:onCompletion) above.

    Parameters

      ▪    isPresented: a boolean used to trigger the presentation (platform dependent). Upon dismissal, isPresented will be automatically set back to false, before the onCompletion closure is executed.
      ▪    documents: a collection of FileDocument to export. If document is empty, the presentation will not occur.
      ▪    contentType: the content type of the file to export. The type must be included in the FileDocument's writableContentTypes property, if it is not, the first type will be used instead.
      ▪    onCompletion: a callback closure that will be executed once the exporting is complete. It receives the Result of the operation with the URL array of the exported files or the Error (if one occurred). This closure is not executed if the user cancels the operation.
 */
struct FILE_EXPORTER_MULTIPLE_DOCUMENT: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("PAGE1EXPORT") private var p1FileExportString: String = ""
    @AppStorage("PAGE2EXPORT") private var p2FileExportString: String = ""
    @AppStorage("PAGE3EXPORT") private var p3FileExportString: String = ""
    @AppStorage("PAGE4EXPORT") private var p4FileExportString: String = ""
    
    @AppStorage("showExporter") private var showExporter = false
    
    var body: some View {
        
        let fileDocs = [MyFileDocument_MULTIPLE(txt: "\(p1FileExportString)", preferredFilename: "Important.txt"),
                        MyFileDocument_MULTIPLE(txt: "\(p2FileExportString)", preferredFilename: "Useful.txt"),
                        MyFileDocument_MULTIPLE(txt: "\(p3FileExportString)", preferredFilename: "Urgent.txt"),
                        MyFileDocument_MULTIPLE(txt: "\(p4FileExportString)", preferredFilename: "Other.txt")]
        
        Button(
            action: {
                self.showExporter = true
            },
            label: {
                Text("Export All Notes")
                    .foregroundColor(Color.BlueEdit)
                    .bold()
                    .font(.headline)
                    /*.font(.system(size: 11, weight: .bold, design: .monospaced))
                      .foregroundColor(colorScheme == .dark ? Color.neuGrayLight : Color.neuGrayLight)
                      .shadow(radius: 0.6)
                     */
            }
        ).buttonStyle(ClearImageBackground())
         .fileExporter(isPresented: $showExporter, documents: fileDocs, contentType: .plainText) { result in
            switch result {
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            //case .success(let urls):
            case .success(_):
                print("Exported!")
                /*for u in urls {
                     print("\(u) exported!")
                 }*/
            }
            
            p1FileExportString = ""
            p2FileExportString = ""
            p3FileExportString = ""
            p4FileExportString = ""
        }
    }
}


struct MyFileDocument_MULTIPLE: FileDocument {
    var txt: String
    var preferredFilename: String
    
    static var readableContentTypes: [UTType] {
        return [.plainText]
    }
    
    init(txt: String, preferredFilename: String) {
        self.txt = txt
        self.preferredFilename = preferredFilename
    }
    
    init(configuration: ReadConfiguration) throws {
        self.preferredFilename = "filename.txt"
        
        if let data = configuration.file.regularFileContents {
            self.txt = String(data: data, encoding: .utf8) ?? ""
        } else {
            self.txt = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = txt.data(using: .utf8)!
    
        let fw = FileWrapper(regularFileWithContents: data)
        fw.preferredFilename = preferredFilename
        
        return fw
    }
}

/*struct FILE_EXPORTER_MULTIPLE_DOCUMENT_Previews: PreviewProvider {
    static var previews: some View {
        FILE_EXPORTER_MULTIPLE_DOCUMENT()
    }
} */




//–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

/*
/** FileExporter (1): Single Document
 
 
     func fileExporter<D>(isPresented: Binding<Bool>, document: D?, contentType: UTType, defaultFilename: String? = nil, onCompletion: @escaping (Result<URL, Error>) -> Void) -> some View where D : FileDocument
        This modifier presents a platform dependent system interface that allows the user to export a single in-memory document. For multiple documents visit fileExporter(isPresented:documents:contentType:onCompletion) below.

    Parameters

      ▪    isPresented: a boolean used to trigger the presentation (platform dependent). Upon dismissal, isPresented will be automatically set back to false, before the onCompletion closure is executed.
      ▪    document: the document to export, conforming to FileDocument. If document is nil, the presentation will not occur.
      ▪    contentType: the content type of the file to export. The type must be included in the FileDocument's writableContentTypes property, if it is not, the first type will be used instead.
      ▪    defaultFilename: the default filename that is suggested to the user.
      ▪    onCompletion: a callback closure that will be executed once the exporting is complete. It receives the Result of the operation with the URL of the exported file or the Error (if one occurred). This closure is not executed if the user cancels the operation.
 */
struct FILE_EXPORTER_SINGLE_DOCUMENT: View {
    @State private var showExporter = false
    
    var body: some View {
        let fileDoc = MyFileDocument_SINGLE(txt: "Hello World!")

        Button("Export document") {
            self.showExporter = true
        }
        .fileExporter(isPresented: $showExporter, document: fileDoc, contentType: .plainText, defaultFilename: "my-file.txt") { result in
            switch result {
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                case .success(let url):
                    print("\(url) exported!")
            }
        }

    }
}


struct MyFileDocument_SINGLE: FileDocument {
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


struct FILE_EXPORTER_SINGLE_DOCUMENT_Previews: PreviewProvider {
    static var previews: some View {
        FILE_EXPORTER_SINGLE_DOCUMENT()
    }
} */
