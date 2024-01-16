//
//  AGGraph.swift
//
//
//  Created by Kyle on 2024/1/16.
//

import Foundation

public struct AGGraph: Codable {
    public var graphs: [Graph]
    public var version: Int
}

extension AGGraph {
    public struct Graph: Codable {
        public var id: Int
        public var changeCount: Int
        public var transactionCount: Int
        public var updateCount: Int
        public var subgraphs: [Subgraph]
        public var nodes: [Node]
        public var edges: [Edge]
        public var trees: [Tree]
        public var types: [Type]
    }
}

extension AGGraph {
    public struct Subgraph: Codable {
        public var contextId: Int
        public var id: Int
        public var nodes: [Int]
        public var parents: [Int]?
        public var children: [Int]?
    }
}

extension AGGraph {
    public struct Node: Codable {
        public var desc: String
        public var flags: Int
        public var subgraphFlags: Int?
        public var id: Int
        public var type: Int
        public var value: String?
    }
}

extension AGGraph {
    public struct Edge: Codable {
        public var dst: Int
        public var src: Int
        public var offset: Int?
        public var flags: Int?
    }
}

extension AGGraph {
    public struct Tree: Codable {
        public var children: [Int]?
        public var desc: String?
        public var flags: Int?
        public var node: Int?
        public var nodes: [Int]?
        public var offset: Int?
        public var creator: Int?
        public var value: Value?
    }
}

extension AGGraph {
    public struct Value: Codable {
        public var environment: ValueNode
        public var phase: ValueNode
    }
    
    public struct ValueNode: Codable {
        public var node: Int
    }
}

extension AGGraph {
    public struct `Type`: Codable {
        public var flags: Int
        public var id: Int
        public var size: Int
        public var name: String
        public var value: String
    }
}

extension AGGraph {
    private static let decoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public init(data: Data) throws {
        self = try AGGraph.decoder.decode(AGGraph.self, from: data)
    }
}
