//
//  ConverterTests.swift
//
//
//  Created by Kyle on 2024/1/16.
//

@testable import GraphConverter
import GraphModel
import XCTest

final class ConverterTests: XCTestCase {
    private func loadURL() -> URL? {
        guard let dataURL = Bundle.module.url(forResource: "ag", withExtension: "json")
        else {
            XCTFail("Fail to init data")
            return nil
        }
        return dataURL
    }
    
    func testGraphDecoding() throws {
        guard let dataURL = loadURL() else { return }
        let data = try Data(contentsOf: dataURL)
        let model = try AGGraph(data: data)
        XCTAssertEqual(model.version, 2)
    }
                            
    func testConvert() throws {
        guard let dataURL = loadURL() else { return }
        let data = try Data(contentsOf: dataURL)
        let model = try AGGraph(data: data)
        let agGraph = model.graphs[0]
        let graph = Converter.convert(agGraph)
        XCTAssertEqual(graph.nodes.count, agGraph.nodes.count)
        XCTAssertEqual(graph.edges.count, agGraph.edges.count)
        XCTAssertEqual(graph.subgraphs.count, agGraph.subgraphs.count)
    }
}
