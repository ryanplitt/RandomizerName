//
//  NamesView.swift
//  RandomizerName
//
//  Created by Ryan Plitt on 3/2/22.
//

import SwiftUI

struct NamesView: View {
    @EnvironmentObject var viewModel: NamesViewModel
    @State var presentRandomName: Bool = false
    @State var presentAddUser: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.names) { user in
                    Text(user.name)
                }
                Button {
                    viewModel.selectRandomUser()
                    presentRandomName = true
                } label: {
                    Text("Select Random User")
                }
                .padding(.bottom)
            }
            .navigationTitle("Names")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        presentAddUser = true
                    }
                }
            }
        }
        .sheet(isPresented: $presentAddUser, onDismiss: nil, content: {
            AddUserView()
        })
        .alert(viewModel.randomUser?.name ?? "Uh Oh", isPresented: $presentRandomName) {
            Button("Ok", role: .cancel) {}
        }
    }
}

struct NamesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NamesView()
                .previewDevice("iPhone 12")
                .environmentObject(NamesViewModel())
            NamesView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 12")
                .environmentObject(NamesViewModel())
        }
    }
}
