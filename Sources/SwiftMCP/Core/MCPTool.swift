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

/// Represents the metadata for an MCP tool (POST-like), allowing actions to be executed.
/// Serializable metadata for an MCP tool (without the handler).
///
/// - Parameters:
///   - identifier: Unique identifier for the tool.
///   - name: Name of the tool.
///   - description: Optional description of the tool.
///   - parameters: Dictionary mapping parameter names to their types.
public struct MCPToolMetadata: Codable, Equatable {
    /// Unique identifier for the tool.
    public let identifier: String
    /// Name of the tool.
    public let name: String
    /// Optional description of the tool.
    public let description: String?
    /// Dictionary mapping parameter names to their types.
    public let parameters: [String: String]
    
    /// Initializes the MCPToolMetadata with the provided values.
    /// - Parameters:
    ///   - identifier: Unique identifier for the tool.
    ///   - name: Name of the tool.
    ///   - description: Optional description of the tool.
    ///   - parameters: Dictionary mapping parameter names to their types.
    public init(identifier: String, name: String, description: String? = nil, parameters: [String: String] = [:]) {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.parameters = parameters
    }
}

/// Complete MCP tool (not Codable, includes the handler).
/// This struct represents a full tool with its metadata and execution handler.
public struct MCPTool {
    /// Metadata describing the tool.
    public let metadata: MCPToolMetadata
    /// Handler function that executes the tool's action.
    /// Takes a dictionary of arguments and returns an AnyCodable result.
    public let handler: ([String: Any]) -> AnyCodable
    
    /// Initializes the MCPTool with the given metadata and handler.
    /// - Parameters:
    ///   - metadata: The metadata for the tool.
    ///   - handler: The function to execute when the tool is called.
    public init(metadata: MCPToolMetadata,
                handler: @escaping ([String: Any]) -> AnyCodable) {
        self.metadata = metadata
        self.handler = handler
    }
    
    /// Shortcut to access the tool's identifier.
    public var identifier: String { metadata.identifier }
    /// Shortcut to access the tool's name.
    public var name: String { metadata.name }
    /// Shortcut to access the tool's description.
    public var description: String? { metadata.description }
    /// Shortcut to access the tool's parameters.
    public var parameters: [String: String] { metadata.parameters }
}
