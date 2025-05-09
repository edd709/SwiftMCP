//
//  Copyright (c) 2025 Erio Daniel Díaz
//
//  This source file is part of the SwiftMCP open-source project.
//  Licensed under the MIT License. See LICENSE file in the project root for full license information.
//
//  DISCLAIMER:
//  This software is provided "as is", without warranty of any kind, express or implied,
//  including but not limited to the warranties of merchantability, fitness for a particular purpose,
//  and noninfringement. In no event shall the authors or copyright holders be liable for any claim,
//  damages or other liability, whether in an action of contract, tort or otherwise, arising from,
//  out of or in connection with the software or the use or other dealings in the software.
//

import Foundation

/// Represents an MCP request message received by the server.
/// Encapsulates the information required to process a resource, tool, or prompt request.
public struct MCPRequestMessage: Codable {
    /// Unique identifier for the request.
    public let id: String
    /// The type of request (e.g., "resource", "tool", "prompt").
    public let type: String
    /// The identifier for the target resource, tool, or prompt.
    public let identifier: String
    /// Optional parameters for the request, encoded as a dictionary.
    public let params: [String: AnyCodable]?
}

/// Represents an MCP response message sent by the server.
/// Contains the result or error for a processed request.
public struct MCPResponseMessage: Codable {
    /// Unique identifier for the corresponding request.
    public let id: String
    /// The result of the request, if successful.
    public let result: AnyCodable?
    /// An error message, if the request failed.
    public let error: String?
}

extension MCPServer {
    /// Processes an MCP request message and returns the corresponding response.
    /// - Parameter request: The MCPRequestMessage to process.
    /// - Returns: An MCPResponseMessage containing the result or error.
    public func handle(request: MCPRequestMessage) -> MCPResponseMessage {
        switch request.type {
        case "resource":
            if let resource = resources[request.identifier] {
                let result = resource.handler(request.params ?? [:])
                return MCPResponseMessage(id: request.id, result: result, error: nil)
            } else {
                return MCPResponseMessage(id: request.id, result: nil, error: "Resource not found")
            }
        case "tool":
            if let tool = tools[request.identifier] {
                let result = tool.handler(request.params ?? [:])
                return MCPResponseMessage(id: request.id, result: result, error: nil)
            } else {
                return MCPResponseMessage(id: request.id, result: nil, error: "Tool not found")
            }
        case "prompt":
            if let prompt = prompts[request.identifier] {
                let result = prompt.handler(request.params ?? [:])
                return MCPResponseMessage(id: request.id, result: result, error: nil)
            } else {
                return MCPResponseMessage(id: request.id, result: nil, error: "Prompt not found")
            }
        default:
            return MCPResponseMessage(id: request.id, result: nil, error: "Unknown request type")
        }
    }
}
