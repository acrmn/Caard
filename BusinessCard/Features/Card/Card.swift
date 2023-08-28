//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import Foundation
import SwiftUI

struct Card: Codable {
    
    var name: String
    var role: String
    var email: String
    var phone: String
    var web: String
    
    var color: Color {
        get {
            storedColor.color
        }
        set {
            storedColor = StoredColor(color: newValue)
        }
    }
    private var storedColor: StoredColor
    
    var image: UIImage {
        get {
            storedImage.image
        }
        set {
            storedImage = StoredImage(image: newValue)
        }
    }
    private var storedImage: StoredImage
    
    static let example = Card(name: "Nombre",
                              role: "Puesto",
                              email: "Email",
                              phone: "Telefono",
                              web: "Web",
                              storedColor: StoredColor(color: Color(.sRGB, red: 0.8901960784313725, green: 0.8745098039215686, blue: 0.9137254901960784, opacity: 1)),
                              storedImage: StoredImage(image: UIImage(named: "default")!))
    
}

struct StoredColor: Codable {
    
    var red: Double = 1
    var green: Double = 1
    var blue: Double = 1
    var opacity: Double = 1
    
    init(color: Color) {
        if let components = color.cgColor?.components {
            self.red = components[0]
            self.green = components[1]
            self.blue = components[2]
            self.opacity = components[3]
        }
    }
    
    var color: Color {
        Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
}

struct StoredImage: Codable {
    
    var data: Data = Data()
    
    init(image: UIImage){
        if let data = image.jpegData(compressionQuality: 0.8) {
            self.data = data
        }
    }
    
    var image: UIImage {
        UIImage(data: data) ?? UIImage(systemName: "person.fill")!
    }
    
}

