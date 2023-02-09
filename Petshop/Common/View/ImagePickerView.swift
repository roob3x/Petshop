//
//  ImagePickerView.swift
//  Petshop
//
//  Created by Roberto Filho on 09/02/23.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, imageData: $imageData, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let pickerController = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerController.sourceType = .photoLibrary
        }
        else {
            pickerController.sourceType = sourceType
        }
        
        pickerController.delegate = context.coordinator
        return pickerController
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    init(image: Binding<Image?>, imageData: Binding<Data?>, isPresented: Binding<Bool>) {
        self._image = image
        self._imageData = imageData
        self._isPresented = isPresented
    }
    
    //metodo que gerencia quando uma imagem é selecionada
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = Image(uiImage: image)
            self.imageData = image.jpegData(compressionQuality: 0.5)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
