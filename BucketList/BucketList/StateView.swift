//
//  StateView.swift
//  BucketList
//
//  Created by Radu Dan on 19/10/2020.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailView: View {
    var body: some View {
        Text("Something went wrong.")
    }
}

struct StateView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState: LoadingState = .loading
    
    var body: some View {
        Group {
            switch loadingState {
            case .loading:
                LoadingView()
                
            case .success:
                SuccessView()
                
            case .failed:
                FailView()
            }
        }
        Text("Hello, world!")
            .onTapGesture {
                let str = "Test Message"
                let fileName = "message.txt"

                do {
                    try FileManager.write(text: str, fileName: fileName)
                    let input = try FileManager.read(fileName: fileName)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView()
    }
}
