//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Radu Dan on 20/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
    var rating: Int16
    var body: some View {
        switch rating {
        case 1:
            return Text("😴")
            
        case 2:
            return Text("😬")
            
        case 3:
            return Text("😐")
            
        case 4:
            return Text("🙂")
            
        case 5:
            return Text("😍")
            
        default:
            return Text("😦")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
