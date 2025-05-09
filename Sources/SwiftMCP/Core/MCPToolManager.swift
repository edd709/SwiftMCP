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

/// Manages MCP tools, inspired by the ToolManager from FastMCP (Python SDK).
/// Handles registration, retrieval, listing, removal, and execution of MCP tools.
public class MCPToolManager {
    /// If true, arguments will be validated locally before tool execution.
    public var validateArgumentsLocal: Bool = true
    /// Internal dictionary of registered tools, keyed by their identifier.
    private var tools: [String: MCPTool] = [:]
    /// If true, a warning will be printed when a duplicate tool is added.
    public var warnOnDuplicateTools: Bool
    
    /// Initializes the MCPToolManager.
    /// - Parameter warnOnDuplicateTools: Whether to warn when adding a duplicate tool. Default is true.
    public init(warnOnDuplicateTools: Bool = true) {
        self.warnOnDuplicateTools = warnOnDuplicateTools
    }
    
    /// Retrieves a tool by its identifier.
    /// - Parameter identifier: The unique identifier of the tool.
    /// - Returns: The corresponding MCPTool if found, otherwise nil.
    public func getTool(identifier: String) -> MCPTool? {
        return tools[identifier]
    }
    
    /// Lists all registered tools.
    /// - Returns: An array of all MCPTool instances.
    public func listTools() -> [MCPTool] {
        return Array(tools.values)
    }

    /// Returns the metadata of all registered tools (correlates with python-sdk).
    /// - Returns: An array of MCPToolMetadata for all registered tools.
    public func listToolMetadata() -> [MCPToolMetadata] {
        return tools.values.map { $0.metadata }
    }
    
    /// Registers a new tool.
    /// If a tool with the same identifier exists, returns the existing tool and optionally prints a warning.
    /// - Parameter tool: The MCPTool to register.
    /// - Returns: The newly registered tool, or the existing tool if a duplicate.
    @discardableResult
    public func addTool(_ tool: MCPTool) -> MCPTool {
        if let existing = tools[tool.identifier] {
            if warnOnDuplicateTools {
                print("[MCPToolManager] Tool already exists: \(tool.identifier)")
            }
            return existing
        }
        tools[tool.identifier] = tool
        return tool
    }
    
    /// Removes a tool by its identifier.
    /// - Parameter identifier: The unique identifier of the tool to remove.
    /// - Returns: True if the tool existed and was removed, false otherwise.
    @discardableResult
    public func removeTool(identifier: String) -> Bool {
        if tools.removeValue(forKey: identifier) != nil {
            return true
        }
        return false
    }

    /// Executes a tool by its identifier and arguments.
    /// - Parameters:
    ///   - identifier: The unique identifier of the tool.
    ///   - arguments: The arguments to pass to the tool (default is empty).
    /// - Returns: The result wrapped in AnyCodable, or nil if the tool is not found.
    public func executeTool(identifier: String, arguments: [String: Any] = [:]) -> AnyCodable? {
        guard let tool = getTool(identifier: identifier) else {
            print("[MCPToolManager] Unknown tool: \(identifier)")
            return nil
        }
        if validateArgumentsLocal {
            let validation = ArgumentValidator.validate(params: arguments, expected: tool.metadata.parameters)
            if !validation.isValid {
                return AnyCodable(["error": validation.errors.joined(separator: "; ")])
            }
        }
        return tool.handler(arguments)
    }

    /// Executes a tool and returns a Result with customizable errors.
    /// - Parameters:
    ///   - identifier: The unique identifier of the tool.
    ///   - arguments: The arguments to pass to the tool (default is empty).
    /// - Returns: A Result containing AnyCodable on success or AnyMCPError on failure.
    public func executeToolWithError(identifier: String, arguments: [String: Any] = [:]) -> Result<AnyCodable, AnyMCPError> {
        guard let tool = getTool(identifier: identifier) else {
            return .failure(AnyMCPError(MCPNotFoundError(identifier: identifier, message: "Tool not found")))
        }
        if validateArgumentsLocal {
            let validation = ArgumentValidator.validate(params: arguments, expected: tool.metadata.parameters)
            if !validation.isValid, let firstError = validation.validationErrors.first {
                return .failure(AnyMCPError(firstError))
            }
        }
        return .success(tool.handler(arguments))
    }
}
