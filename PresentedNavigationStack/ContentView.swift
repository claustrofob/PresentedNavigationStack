//
//  ContentView.swift
//  PresentedNavigationStack
//
//  Created by Mikalai Zmachynski on 16/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            MainView()
        }
    }
}
