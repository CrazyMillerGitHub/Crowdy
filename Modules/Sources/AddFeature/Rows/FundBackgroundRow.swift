//
//  FundBackgroundRow.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem

struct FundBackgroundRow: View {

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image = .init(uiImage: .init())

    var body: some View {
        Color.brand.color
            .overlay(
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(content: {
                        VStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "plus.square")
                                .font(.title)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
            )
            .frame(height: 128)
            .onTapGesture {
                showingImagePicker = true
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding([.leading, .trailing, .top])
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

