import SwiftUI

struct MainView: View {
    @State var isPresentedSheet = false
    @State var isPresentedCustom = false
    
    var body: some View {
        VStack {
            Button("Present sheet") {
                isPresentedSheet = true
            }
            Button("Present custom") {
                isPresentedCustom = true
            }
        }
        .navigationTitle("Some title")
        .sheet(isPresented: $isPresentedSheet) {
            NavigationStack {
                PresentedView()
            }
        }
        .customPresentation(isPresented: $isPresentedCustom) {
            NavigationStack {
                PresentedView()
            }
        }
    }
}
