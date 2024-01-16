//
//  ConvertCommand.swift
//
//
//  Created by Kyle on 2024/1/16.
//

import ArgumentParser
import Foundation
import GraphModel
import GraphVizAdaptor

@main
struct ConvertCommand: AsyncParsableCommand {
    func run() async throws {
        // TODO: Load from json file
        let data = Data()
        let model = try AGGraph(data: data)
        let graph = Converter.convert(model)
        let graphData = try await graph.render(using: .dot, to: .dot)
        // TODO: Use option here
        if let dot = String(data: data, encoding: .utf8) {
            print(dot)
        }
    }
}
