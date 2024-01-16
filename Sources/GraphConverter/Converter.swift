//
//  Converter.swift
//
//
//  Created by Kyle on 2024/1/16.
//

import GraphModel
import GraphViz

enum Converter {
    static func convert(_ agGraph: AGGraph.Graph) -> Graph {
        agGraph.converted()
    }
}

extension AGGraph.Graph {
    func converted() -> Graph {
        var graph = Graph(directed: true)
        let nodes = nodes.map { $0.converted(in: self) }
        graph.append(contentsOf: nodes)
        let edges = edges.map { $0.converted(in: self) }
        graph.append(contentsOf: edges)
        let subgraphs = subgraphs.map { $0.converted(in: self) }
        graph.append(contentsOf: subgraphs)
        return graph
    }
}

extension AGGraph.Node {
    func converted(in _: AGGraph.Graph) -> Node {
        Node(desc)
    }
}

extension AGGraph.Edge {
    func converted(in agGraph: AGGraph.Graph) -> Edge {
        let fromNode = agGraph.nodes[src].converted(in: agGraph)
        let toNode = agGraph.nodes[dst].converted(in: agGraph)
        return Edge(from: fromNode, to: toNode, direction: .forward)
    }
}

extension AGGraph.Subgraph {
    func converted(in agGraph: AGGraph.Graph) -> Subgraph {
        var subgraph = Subgraph(id: id.description)
        for node in nodes {
            subgraph.append(agGraph.nodes[node].converted(in: agGraph))
        }
        return subgraph
    }
}
