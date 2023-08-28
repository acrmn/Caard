//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI

extension UIView {
    // Transform UIView in UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
