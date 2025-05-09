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

// MARK: - MCPTool

/// Serializable model to expose MCP tools via API/protocol (does not include handler).
public struct MCPSerializableTool: Codable, Equatable {
    /// The name of the tool.
    public let name: String
    /// An optional description of the tool.
    public let description: String?
    /// The input schema for the tool. Equivalent to a dictionary [String: Any] in Python.
    public let inputSchema: [String: AnyCodable]
    
    /// Initializes a new MCPSerializableTool.
    /// - Parameters:
    ///   - name: The name of the tool.
    ///   - description: An optional description of the tool.
    ///   - inputSchema: The input schema for the tool.
    public init(name: String, description: String? = nil, inputSchema: [String: AnyCodable] = [:]) {
        self.name = name
        self.description = description
        self.inputSchema = inputSchema
    }
}

// MARK: - ListToolsResult

/// Represents the result of listing available MCP tools.
public struct MCPListToolsResult: Codable, Equatable {
    /// The list of available tools.
    public let tools: [MCPSerializableTool]
    /// Initializes a new MCPListToolsResult.
    /// - Parameter tools: The list of available tools.
    public init(tools: [MCPSerializableTool]) {
        self.tools = tools
    }
}

// MARK: - CallToolRequestParams

/// Parameters for requesting a tool call.
public struct MCPCallToolRequestParams: Codable, Equatable {
    /// The name of the tool to call.
    public let name: String
    /// The arguments to pass to the tool (optional).
    public let arguments: [String: AnyCodable]?
    /// Initializes a new MCPCallToolRequestParams.
    /// - Parameters:
    ///   - name: The name of the tool to call.
    ///   - arguments: The arguments to pass to the tool (optional).
    public init(name: String, arguments: [String: AnyCodable]? = nil) {
        self.name = name
        self.arguments = arguments
    }
}

// MARK: - CallToolResult

/// Represents the result of a tool call.
public struct MCPCallToolResult: Codable, Equatable {
    /// The content returned by the tool call. This can be TextContent, ImageContent, EmbeddedResource, etc.
    public let content: [AnyCodable]
    /// Indicates whether the result is an error.
    public let isError: Bool
    /// Initializes a new MCPCallToolResult.
    /// - Parameters:
    ///   - content: The content returned by the tool call.
    ///   - isError: Indicates whether the result is an error (default is false).
    public init(content: [AnyCodable], isError: Bool = false) {
        self.content = content
        self.isError = isError
    }
}
