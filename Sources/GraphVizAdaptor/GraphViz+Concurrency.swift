//
//  GraphViz+Concurrency.swift
//
//
//  Created by Kyle on 2024/1/16.
//

import Foundation
import GraphViz

extension Graph {
    public func render(using layout: LayoutAlgorithm,
                       to format: Format,
                       with options: Renderer.Options = [],
                       on queue: DispatchQueue = .main) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            render(using: layout, to: format, with: options, on: queue) { result in
                continuation.resume(with: result)
            }
        }
    }
}
