//
//  ContentView.swift
//  SBQuickLook_Example
//
//  Created by Sebastian Baar on 23.02.23.
//

import SwiftUI
import SBQuickLook

// swiftlint:disable line_length
struct ContentView: View {
    @State var isShown = false

    let fileItems: [SBQLFileItem]
    let configuration: SBQLConfiguration

    init() {
        let localFileURL = Bundle.main.url(forResource: "sample-local-pdf", withExtension: "pdf")!

        var basicAuthRequest = URLRequest(url: URL(string: "https://www.example.com")!)
        basicAuthRequest.addValue("Basic YmlsbHk6c2VjcmV0cGFzc3dvcmQ=", forHTTPHeaderField: "Authorization")

        let localFileDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        configuration = SBQLConfiguration(localFileDir: localFileDir)

        fileItems = [
            SBQLFileItem(url: URL(string: "https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_PDF.pdf")!, title: "Test PDF"),
            SBQLFileItem(url: URL(string: "https://calibre-ebook.com/downloads/demos/demo.docx")!),
            SBQLFileItem(url: URL(string: "https://invalid-url-example.com/nodata")!),
            SBQLFileItem(url: URL(string: "https://invalid-url-example.com/nodata.no-extension")!),
            SBQLFileItem(url: URL(string: "https://file-examples.com/storage/fe197d899c63f609e194cb1/2017/10/file_example_JPG_100kB.jpg")!),
            SBQLFileItem(url: localFileURL, title: "LOCAL FILE"),
            SBQLFileItem(url: URL(string: "https://file-examples.com/storage/fe197d899c63f609e194cb1/2017/10/file_example_PNG_500kB.png")!, title: "Nice PNG Image", mediaType: "png"),
            SBQLFileItem(url: URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-zip-file.zip")!),
            SBQLFileItem(url: URL(string: "https://file-examples.com/storage/fe197d899c63f609e194cb1/2017/10/file_example_GIF_3500kB.gif")!, urlRequest: basicAuthRequest),
            SBQLFileItem(url: URL(string: "https://file-examples.com/storage/fe197d899c63f609e194cb1/2017/11/file_example_MP3_5MG.mp3")!)
        ]
    }

    var body: some View {
        VStack {
            Button {
                isShown.toggle()
            } label: {
                Text("Open QuickLook of files")
            }
        }
        .fullScreenCover(isPresented: $isShown, content: {
            SBQuickLookView(fileItems: fileItems, configuration: configuration)
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
