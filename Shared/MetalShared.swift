import Foundation
import MetalKit
import SwiftUI

struct MetalShared {
    class Coordinator : NSObject, MTKViewDelegate {
        var parent: MetalView
        var device: MTLDevice!
        var commandQueue: MTLCommandQueue!
        
        init(_ parent: MetalView) {
            self.parent = parent
            if let metalDevice = MTLCreateSystemDefaultDevice() {
                self.device = metalDevice
            }
            self.commandQueue = device.makeCommandQueue()!
            super.init()
        }
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        func draw(in view: MTKView) {
            guard let drawable = view.currentDrawable else {
                return
            }
            let commandBuffer = commandQueue.makeCommandBuffer()
            let rpd = view.currentRenderPassDescriptor
            rpd?.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 1, 1)
            rpd?.colorAttachments[0].loadAction = .clear
            rpd?.colorAttachments[0].storeAction = .store
            let re = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd!)
            re?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
    static func makeView() -> MTKView {
        let mtkView = MTKView()
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        mtkView.framebufferOnly = false
        mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        mtkView.drawableSize = mtkView.frame.size
        mtkView.enableSetNeedsDisplay = true
        return mtkView
    }
}
