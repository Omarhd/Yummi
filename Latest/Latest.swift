//
//  Latest.swift
//  Latest
//
//  Created by Omar Abdulrahman on 23/09/2022.
//

import WidgetKit
import SwiftUI
import Intents

struct LatestEntryView : View {
    
    let date = Date()
    
    var body: some View {
        Text("")
    }
}



struct Latest_Previews: PreviewProvider {
    static var previews: some View {
        LatestEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
