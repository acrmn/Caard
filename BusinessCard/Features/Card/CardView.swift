//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI

struct CardView: View {
    
    @StateObject var cardViewModel = CardViewModel()
    
    var cardPreview: some View {
        VStack {
            Spacer()
            HStack{
                Image(uiImage: cardViewModel.card.image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.width/2, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
            }.padding(.leading, 80)
                .padding(.trailing, 80)
                
            Text(cardViewModel.card.name)
                .padding()
            Text(cardViewModel.card.role)
                .padding()
            Spacer()
            Text(cardViewModel.card.email)
                .padding()
            Text(cardViewModel.card.web)
                .padding()
            Text(cardViewModel.card.phone)
                .padding()
            Spacer()
        }
    }
    
    var cardContent: some View {
        VStack {
            HStack{
                Image(uiImage: cardViewModel.card.image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.width/2, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
            }.padding(.leading, 80)
                .padding(.trailing, 80)
            Text(cardViewModel.card.name)
                .padding()
                .font(.title)
                .background(Color.clear)
            Text(cardViewModel.card.role)
                .padding()
                .font(.title2)
                .background(Color.clear)
            Spacer()
            Text(cardViewModel.card.email)
                .padding()
                .font(.title3)
                .background(Color.clear)
            Text(cardViewModel.card.web)
                .padding()
                .font(.title3)
                .background(Color.clear)
            Text(cardViewModel.card.phone)
                .padding()
                .font(.title3)
                .background(Color.clear)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Button {
                        cardViewModel.cardSnapshot = cardPreview.asImage(cardColor: cardViewModel.card.color)
                        cardViewModel.showingSheet.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .padding(.trailing, 20)
                    }.sheet(isPresented: $cardViewModel.showingSheet) {
                        NavigationView {
                            ShareView(cardSnapshot: $cardViewModel.cardSnapshot)
                                .navigationTitle("Previsualización")
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarColor(backgroundColor: UIColor(named: "Mauve"), titleColor: .white)
                                
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .trailing)
                
                cardContent
                
                HStack{
                    NavigationLink(destination: EditCardView(cardViewModel: cardViewModel)){
                        Image(systemName: "square.and.pencil").font(.title.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 40)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                    }
                }.frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)

            }.frame(maxWidth: .infinity)
                .background(cardViewModel.card.color)
                .ignoresSafeArea()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView()
//            CardView(cardSnapshot: Image(systemName: "person.fill"))
//                .previewDevice((PreviewDevice(rawValue: "iPhone 8")))
        }
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
