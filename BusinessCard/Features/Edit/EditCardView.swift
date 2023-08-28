//
//  Created by Carmen Alonso
//
// Do not use or distribute without authorization
//

import SwiftUI

struct EditCardView: View {
    
    @ObservedObject var cardViewModel: CardViewModel
    @StateObject var editCardViewModel = EditCardViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

        Form {
            Section {
                HStack {
                    Spacer()
                Image(uiImage: cardViewModel.card.image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width/1.5, height: UIScreen.main.bounds.size.width/1.5, alignment: .center)
                    .scaledToFill()
                    .clipShape(Circle())
                    .onTapGesture {
                        editCardViewModel.presentImagePicker = true
                    }
                    .onChange(of: editCardViewModel.selectedImage) { newValue in
                        guard let selectedImage = editCardViewModel.selectedImage else {
                            return
                        }
                        cardViewModel.card.image = selectedImage
                    }
                    .sheet(isPresented: $editCardViewModel.presentImagePicker) {
                        ImagePicker(image: $editCardViewModel.selectedImage)
                    }
                    Spacer()
                }
            }
            Section {
                TextField("Name", text: $cardViewModel.card.name)
                TextField("Name", text: $cardViewModel.card.role)
            }
            Section {
                TextField("Name", text: $cardViewModel.card.email)
                    .autocapitalization(.none)
                TextField("Name", text: $cardViewModel.card.web)
                    .autocapitalization(.none)
                TextField("Name", text: $cardViewModel.card.phone)
            }
            
            ColorPicker("Color", selection: $cardViewModel.card.color)

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.sRGB, red: 0.94902, green:  0.94902, blue: 0.96863, opacity: 1))
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Editar Caard")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        cardViewModel.save()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Atrás")
                        }
                    }
                }
            }
        }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView(cardViewModel: CardViewModel())
    }
}
