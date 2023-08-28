//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import Foundation
import SwiftUI

@MainActor class CardViewModel: ObservableObject {
    
    @Published var card = Card.example
    
    @Published var showingSheet = false
    @Published var cardSnapshot: UIImage = UIImage(systemName: "person.fill")!
    @Published var isSheetViewShowing = false
    let largeConfig = UIImage.SymbolConfiguration(weight: .bold)
    
    var dataUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("CardData").appendingPathExtension("json")
    }
    
    init() {    // Load Card Data
        if FileManager.default.fileExists(atPath: dataUrl.path) {
            if let data = try? Data(contentsOf: dataUrl) {
                let decoder = JSONDecoder()
                do {
                    let card = try decoder.decode(Card.self, from: data)
                    self.card = card
                } catch {
                    print("Error DECODING Caard \(error)")
                }
            }
        }
    }
    
    func save() {   // Save User's Changes of the Card
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.card)
            try data.write(to: dataUrl)
        } catch {
            print("Error ENCODING and saving Caard \(error)")
        }
    }
}
