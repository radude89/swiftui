//
//  RatingView.swift
//  Bookworm
//
//  Created by Radu Dan on 20/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage: Image?
    var offColor = Color.gray
    
    var onImage = Image(systemName: "star.fill")
    var onColor = Color.yellow
    
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
                    .accessibilityLabel(
                        Text("\(number == 1 ? "One star" : "\(number) stars")")
                    )
                    .accessibility(removeTraits: .isImage)
                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected])
            }
        }
    }
    
    private func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
