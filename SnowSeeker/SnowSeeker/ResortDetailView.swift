//
//  ResortDetailView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

struct ResortDetailView: View {
    let resort: Resort
    
    private var size: String {
        switch resort.size {
        case 1:
            return "Small"
            
        case 2:
            return "Average"
            
        default:
            return "Large"
        }
    }
    
    private var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            Text("Size: \(size)")
                .layoutPriority(1)
            
            Spacer()
                .frame(height: 0)
            
            Text("Price: \(price)")
                .layoutPriority(1)
        }
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailView(resort: Resort.example)
    }
}
