//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI
import LocalAuthentication

struct AuthView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView{
        VStack {
            Text("Bienvenido a Caard.")
                .font(.title.weight(.black))
                .foregroundColor(Color.white)
            Button {
                authViewModel.authentication()
            } label: {
                Text("Acceder con Face ID")
                Image(systemName: "faceid")
            }.foregroundColor(Color.white)
                .font(.body.weight(.bold))
                .padding()
                .fullScreenCover(isPresented: $authViewModel.auth, content: {
                    CardView()
                })
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.sRGB, red: 0.7686274509803922, green: 0.6745098039215687, blue: 0.9882352941176471, opacity: 1))
            .ignoresSafeArea()
            .onAppear {
                authViewModel.authentication()
            }
            .navigationBarHidden(true)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
