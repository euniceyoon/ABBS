//
//  Profile.swift
//  abbs edit2
//
//  Created by Eunice Yoon on 4/21/25.
//

import SwiftUI

struct Profile: View {
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            Button("Edit Profile") {
                showSheet = true
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            EditProfile()
        }
    }
}

#Preview {
    Profile()
}
