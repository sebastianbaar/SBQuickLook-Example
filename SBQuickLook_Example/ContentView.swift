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
            SBQLFileItem(url: URL(string: "https://invalid-url-example.com/nodata")!, title: "Invalid URL"),
            SBQLFileItem(url: URL(string: "https://invalid-url-example.com/nodata.no-extension")!, title: "Invalid URL & extension"),
            SBQLFileItem(url: URL(string: "https://filesamples.com/samples/image/heic/sample1.heic")!, title: "HEIC image"),
            SBQLFileItem(url: localFileURL, title: "LOCAL FILE"),
            SBQLFileItem(url: URL(string: "https://filesamples.com/samples/image/png/sample_1280%C3%97853.png")!, title: "Nice PNG Image", mediaType: "png"),
            SBQLFileItem(url: URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-zip-file.zip")!),
            SBQLFileItem(url: URL(string: "https://filesamples.com/samples/image/heic/sample1.heic")!, urlRequest: basicAuthRequest),
            SBQLFileItem(url: URL(string: "https://filesamples.com/samples/audio/mp3/sample3.mp3")!),
            SBQLFileItem(url: URL(string: "https://filesamples.com/samples/code/swift/sample3.swift")!),
            SBQLFileItem(url: URL(string: "https://filesamples.com/samples/code/swift/sample3.swift")!),
            SBQLFileItem(url: URL(string: "https://developer.apple.com/augmented-reality/quick-look/models/stratocaster/fender_stratocaster.usdz")!, title: "Augmented reality object")
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
            SBQuickLookView(fileItems: fileItems, configuration: configuration) { result in
                switch result {
                case .success(let downloadError):
                    if let downloadError {
                        print(downloadError)
                    }
                case .failure(let error):
                    switch error.type {
                    case .emptyFileItems:
                        print("emptyFileItems")
                    case .qlPreviewControllerError:
                        print("qlPreviewControllerError")
                    case .download(let errorFileItems):
                        print("all items failed downloading")
                        print(errorFileItems)
                    }
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
