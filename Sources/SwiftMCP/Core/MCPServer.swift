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

/// Core class for the MCP server. Allows registration and exposure of resources, tools, and prompts.
public class MCPServer: @unchecked Sendable {
    // Exposición pública de metadatos serializables para handshake/capabilities
    /// Array of prompt metadata for handshake/capabilities exposure.
    public var promptMetadatas: [MCPPromptMetadata] {
        prompts.values.map { $0.metadata }
    }
    /// Array of resource metadata for handshake/capabilities exposure.
    public var resourceMetadatas: [MCPResourceMetadata] {
        resources.values.map { $0.metadata }
    }
    /// Array of tool metadata for handshake/capabilities exposure.
    public var toolMetadatas: [MCPToolMetadata] {
        tools.values.map { $0.metadata }
    }
    
    /// Returns the handler function for a resource by its identifier.
    ///
    /// - Parameter identifier: The identifier of the resource.
    /// - Returns: The handler function if found, or nil otherwise.
    public func handlerForResource(_ identifier: String) -> (([String: Any]) -> AnyCodable)? {
        return resources[identifier]?.handler
    }

    /// The name of the MCP server instance.
    public let name: String
    
    /// Dictionary of registered resources.
    ///
    /// This property stores all registered resources, keyed by their identifiers.
    private(set) var resources: [String: MCPResource] = [:]
    
    /// Dictionary of registered tools.
    ///
    /// This property stores all registered tools, keyed by their identifiers.
    private(set) var tools: [String: MCPTool] = [:]
    
    /// Dictionary of registered prompts.
    ///
    /// This property stores all registered prompts, keyed by their identifiers.
    private(set) var prompts: [String: MCPPrompt] = [:]
    
    /// Initializes a new MCPServer instance.
    ///
    /// - Parameter name: The name of the server.
    public init(name: String) {
        self.name = name
    }

    /// Registers a resource (GET-like).
    ///
    /// - Parameter resource: The MCPResource to register.
    public func registerResource(_ resource: MCPResource) {
        resources[resource.identifier] = resource
    }

    /// Registers a tool (POST-like).
    ///
    /// - Parameter tool: The MCPTool to register.
    public func registerTool(_ tool: MCPTool) {
        tools[tool.identifier] = tool
    }

    /// Registers a reusable prompt.
    ///
    /// - Parameter prompt: The MCPPrompt to register.
    public func registerPrompt(_ prompt: MCPPrompt) {
        prompts[prompt.identifier] = prompt
    }

    /// Returns the handler function for a prompt by its identifier.
    ///
    /// - Parameter identifier: The identifier of the prompt.
    /// - Returns: The handler function if found, or nil otherwise.
    public func handlerForPrompt(_ identifier: String) -> (([String: Any]) -> AnyCodable)? {
        prompts[identifier]?.handler
    }

    /// Returns the handler function for a tool by its identifier.
    /// - Parameter identifier: The identifier of the tool.
    /// - Returns: The handler function if found, or nil otherwise.
    public func handlerForTool(_ identifier: String) -> (([String: Any]) -> AnyCodable)? {
        tools[identifier]?.handler
    }
}
