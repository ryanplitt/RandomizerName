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
    @State var numberOfSelected = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                List(viewModel.names) { user in
                    Text(user.name)
                }
                HStack {
                    Text("Number Of Selected:")
                    Spacer()
                    Stepper(String(numberOfSelected)) {
                        if numberOfSelected < viewModel.names.count {
                            numberOfSelected += 1
                        }
                    } onDecrement: {
                        if numberOfSelected > 1 {
                            numberOfSelected -= 1
                        }
                    }
                }
                .padding()
                Button {
                    viewModel.selectRandomUsers(numberOfUsers: numberOfSelected)
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
        .alert(viewModel.randomUsers.map({ $0.name }).joined(separator: ", "), isPresented: $presentRandomName) {
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
