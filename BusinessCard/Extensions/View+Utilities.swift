//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI

extension View {
    func asImage(cardColor: Color) -> UIImage {
        // UIHostingController integrates SwiftUI views in UIKit views
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.top))
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        controller.view.backgroundColor = UIColor(cardColor)
        
        // Transform the View built into an Image
        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
    
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}
