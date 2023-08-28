//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI
import PhotosUI

// This view represents a UIKit ViewController
struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?    // selected image
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
}

class Coordinator: NSObject, PHPickerViewControllerDelegate {
    
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider else {
            return
        }
        
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { image, error in
                if let error = error {
                    print("Error loading image. \(error)")
                } else {
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
}
