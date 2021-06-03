import MetalKit
import SwiftUI

struct MetalView: UIViewRepresentable {
    func makeCoordinator() -> MetalShared.Coordinator {
        MetalShared.Coordinator(self)
    }
    func makeUIView(context: UIViewRepresentableContext<MetalView>) -> MTKView {
        let mtkView = MetalShared.makeView()
        mtkView.delegate = context.coordinator
        return mtkView
    }
    func updateUIView(_ nsView: MTKView, context: UIViewRepresentableContext<MetalView>) {
    }
}
