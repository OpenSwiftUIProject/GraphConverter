//
//  ConvertCommand.swift
//
//
//  Created by Kyle on 2024/1/16.
//

import ArgumentParser
import Foundation
import GraphModel
import GraphViz
import GraphVizAdaptor

@main
struct ConvertCommand: AsyncParsableCommand {
    @Option(name: [.short, .customLong("input")], transform: { URL(filePath: $0) })
    var inputFile: URL

    @Option(name: [.short, .customLong("output")], transform: { URL(filePath: $0) })
    var outputFile: URL
    
    @Option(name: [.short, .customLong("format")], transform: { Format(rawValue: $0)! })
    var format: GraphViz.Format = .dot
    
    func run() async throws {
        let data = try Data(contentsOf: inputFile)
        let model = try AGGraph(data: data)
        let graph = Converter.convert(model.graphs[0])
        let graphData = try await graph.render(using: .dot, to: format)
        try graphData.write(to: outputFile)
    }
    
    func validate() throws {
        guard FileManager.default.fileExists(atPath: inputFile.path()) else {
            throw ValidationError("File does not exist at \(inputFile.path())")
        }
    }
}

struct ValidationError: LocalizedError {
    var message: String
    init(_ message: String) {
        self.message = message
    }
    
    var errorDescription: String? { message }
}

extension Format: Codable {}
