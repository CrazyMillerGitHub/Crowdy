//
//  File.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct AddView: View {

    private let store: Store<AddState, AddAction>

    public init(store: Store<AddState, AddAction>) {
        self.store = store
    }

    public var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 64)
                        .padding()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 124)
                        .padding()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 300)
                        .padding()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 128)
                        .padding()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 128)
                        .padding()
                    Button("Опубликовать") {
                    }
                    .padding()
                    .buttonStyle(BrandButtonStyle())
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Отменить") {
                            
                        }
                    }
                }
            }
            .navigationTitle("Создать сбор")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
