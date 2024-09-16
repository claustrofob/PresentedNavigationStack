import SwiftUI

struct PresentedView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.close) var close
    
    let title: String
    
    var body: some View {
        Text(title)
            .navigationTitle(title)
            .toolbar {
                Button(title) {
                    dismiss()
                    close()
                }
                .tint(.pink)
            }
    }
}
