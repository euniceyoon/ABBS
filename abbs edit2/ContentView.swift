//
//  ContentView.swift
//  abbs edit2
//
//  Created by Eunice Yoon on 4/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2
    
    var body: some View {
//        Label("Hello", systemImage: "star")
        
//        EditProfile_Eunice()
        
        TabView(selection: $selectedTab) {
            SwipeHome()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                .tag(0)
            
            Liked()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Liked")
                }
                .tag(1)
            
            
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
