//
//  QRCodeView.swift
//  
//
//  Created by Mikhail Borisov on 06.05.2022.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    let url: String

    var body: some View {
        Image(uiImage: generateQRCodeImage(url))
            .interpolation(.none)
            .resizable()
    }

    private func generateQRCodeImage(_ url: String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        guard let qrCodeImage = filter.outputImage, let cgImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) else {
            return UIImage()
        }
        return UIImage(cgImage: cgImage)
    }
}
