//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI

@MainActor class EditCardViewModel: ObservableObject {
    
    @Published var presentImagePicker = false
    @Published var profilePic: Image = Image("profilepic")
    @Published var selectedImage: UIImage?
    
}
