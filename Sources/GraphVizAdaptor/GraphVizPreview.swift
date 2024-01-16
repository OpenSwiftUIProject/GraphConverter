//
//  GraphVizPreview.swift
//
//
//  Created by Kyle on 2024/1/16.
//

#if DEBUG
import GraphViz
import AppKit
import SwiftUI

func loadImage() async throws -> NSImage? {
    var graph = Graph(directed: true)
    let a = Node("a")
    let b = Node("b")
    let c = Node("c")
    graph.append(Edge(from: a, to: b))
    graph.append(Edge(from: a, to: c))
    var b_c = Edge(from: b, to: c)
    b_c.constraint = false
    graph.append(b_c)
    let data = try await graph.render(using: .dot, to: .svg)
    let image = NSImage(data: data)
    return image
}
#Preview {
    struct DemoView: View {
        @State private var image: NSImage?
        
        var body: some View {
            Group {
                if let image {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("Loading")
                        .task {
                            image = try? await loadImage()
                        }
                }
            }
            .frame(width: 500, height: 500)
        }
    }
    return DemoView()
}

#endif
