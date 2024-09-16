import SwiftUI

struct PresentedView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.close) var close
    
    var body: some View {
        Text("Presented page")
            .navigationTitle("Presented page")
            .toolbar {
                Button("Button") {
                    dismiss()
                    close()
                }
            }
    }
}
