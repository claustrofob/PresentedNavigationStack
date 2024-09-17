import SwiftUI

struct PresentedView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.close) var close
    
    @State var isPushed = false
    
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            Button("Push") {
                isPushed = true
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            Button(title) {
                dismiss()
                close()
            }
            .tint(.pink)
        }
        .navigationDestination(isPresented: $isPushed) {
            Text("Pushed view")
        }
    }
}
