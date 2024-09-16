import SwiftUI

struct CustomPresentationView<ViewContent: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        @Binding private var isPresented: Bool
        
        init(isPresented: Binding<Bool>) {
            self._isPresented = isPresented
            super.init()
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isPresented = false
        }
    }
    
    @Binding private var isPresented: Bool
    @ViewBuilder private let content: () -> ViewContent
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> ViewContent) {
        self._isPresented = isPresented
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isPresented {
            if uiViewController.presentedViewController == nil {
                let view = content()
                    .environment(\.close, CloseAction(isPresented: $isPresented))
                let hostingViewController = UIHostingController(rootView: view)
                hostingViewController.presentationController?.delegate = context.coordinator
                uiViewController.present(hostingViewController, animated: true)
            }
        } else if
            let presentedViewController = uiViewController.presentedViewController,
            !presentedViewController.isBeingDismissed
        {
            presentedViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented)
    }
}

struct CustomPresentationModifier<ViewContent: View>: ViewModifier {
    @Binding private var isPresented: Bool
    @ViewBuilder private let viewContent: () -> ViewContent
    
    public init(isPresented: Binding<Bool>, @ViewBuilder viewContent: @escaping () -> ViewContent) {
        self._isPresented = isPresented
        self.viewContent = viewContent
    }
    
    func body(content: Content) -> some View {
        content.background(CustomPresentationView(isPresented: _isPresented, content: viewContent))
    }
}

public extension View {
    func customPresentation<ViewContent: View>(isPresented: Binding<Bool>, @ViewBuilder viewContent: @escaping () -> ViewContent) -> some View {
        modifier(CustomPresentationModifier(isPresented: isPresented, viewContent: viewContent))
    }
}
