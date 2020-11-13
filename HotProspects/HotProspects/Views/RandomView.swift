//
//  RandomView.swift
//  HotProspects
//
//  Created by Radu Dan on 11/11/2020.
//

import SwiftUI
import SamplePackage

struct RandomView: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
