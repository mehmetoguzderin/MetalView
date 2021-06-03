import MetalKit
import SwiftUI

struct MetalView: NSViewRepresentable {
    func makeCoordinator() -> MetalShared.Coordinator {
        MetalShared.Coordinator(self)
    }
    func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
        let mtkView = MetalShared.makeView()
        mtkView.delegate = context.coordinator
        return mtkView
    }
    func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {
    }
}
