//
//  ContentSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI

struct ContentSection: View {

    var body: some View {
        lazy var text: String = {
            return """
            I want to create plane, that will be greatest in the world. It’s better than Boeing or Sukhoi.
            Benefits:
            * First item
            * Second item
            * Third item
            * Fourth item
            """
        }()
        
        return Text(.init(text))
            .padding(.top)
            .listRowSeparator(.hidden)
    }
}
