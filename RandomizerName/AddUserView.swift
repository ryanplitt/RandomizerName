//
//  AddUserView.swift
//  RandomizerName
//
//  Created by Ryan Plitt on 3/2/22.
//

import SwiftUI

struct AddUserView: View {
    @EnvironmentObject var viewModel: NamesViewModel
    @State var name: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
                VStack(spacing: 50) {
                    TextField("Name", text: $name)
                    Button("Done") {
                        viewModel.add(userWithName: name)
                        dismiss()
                    }
                }
                .frame(width: 200)
            .navigationTitle("Add User")
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
            .environmentObject(NamesViewModel())
    }
}
