//
//  InfoRow.swift
//  
//
//  Created by Mikhail Borisov on 14.04.2022.
//

import SwiftUI
import Core
import DesignSystem

struct InfoRow: View {

    @Binding var infoText: String
    @State var sss: String = ""
    @State var isSelected: Bool = false

    var body: some View {
        VStack {
            InputField(placeholder: "Название сбора", height: 200, binding: $infoText) {
                if isSelected {
                    Text(.init(sss))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .padding([.top, .bottom])
                } else {
                    TextEditor(text: $sss)
                        .lineLimit(3)
                }
    //                .multilineTextAlignment(.leading)
            }
            .overlay {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Chips(title: "Предпросмотр", binding: $isSelected)
                            .padding()
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing, .top])
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
    }
}
