//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI

struct ShareView: View {
    
    @Binding var cardSnapshot: UIImage
    @State private var isShare = false
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: cardSnapshot)
                .resizable()
                .scaledToFit()
                .frame( alignment: .center)
                .padding()
            Button {
                isShare = true
            } label: {
                Text("Compartir")
            }.padding()
                .foregroundColor(.white)
                .background(Color(.sRGB, red: 0.7686274509803922, green: 0.6745098039215687, blue: 0.9882352941176471, opacity: 1))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .font(.title2)
                .background(SharingViewController(isPresenting: $isShare) {

                     let av = UIActivityViewController(activityItems: [cardSnapshot], applicationActivities: nil)

                     av.completionWithItemsHandler = { _, _, _, _ in
                            isShare = false // required for re-open !!!
                        }
                        return av
                })
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(cardSnapshot: .constant(UIImage(systemName: "person.fill")!))
    }
}
