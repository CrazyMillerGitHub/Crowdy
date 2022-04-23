//
//  ImageView.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import PhotosUI
import SwiftUI

public struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?

    public init(image: Binding<UIImage?>) {
        self._image = image
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}
