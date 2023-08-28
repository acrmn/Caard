//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI
import LocalAuthentication

@MainActor class AuthViewModel: ObservableObject {

    @Published var auth = false
    
    func authentication() {
        let laContext = LAContext()
        var error: NSError?
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate") { authenticated, error in
                if let error = error {
                    print("Error authenticating: \(error.localizedDescription)")
                    return
                } else {
                    self.auth = true
                }
            }
        } else {
            print("Cannot access Face ID")
        }
    }
}
