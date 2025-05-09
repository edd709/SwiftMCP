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

/// Manages MCP prompts, inspired by the PromptManager from FastMCP (Python SDK).
/// Provides methods to register, retrieve, list, and render prompts within the MCP framework.
public class MCPPromptManager {
    private var prompts: [String: MCPPrompt] = [:]
    /// Indicates whether a warning should be printed when attempting to add a duplicate prompt.
    public var warnOnDuplicatePrompts: Bool
    
    /// Initializes a new MCPPromptManager.
    /// - Parameter warnOnDuplicatePrompts: Whether to warn on duplicate prompt registration (default is true).
    public init(warnOnDuplicatePrompts: Bool = true) {
        self.warnOnDuplicatePrompts = warnOnDuplicatePrompts
    }
    
    /// Retrieves a prompt by its identifier.
    /// - Parameter identifier: The identifier of the prompt to retrieve.
    /// - Returns: The MCPPrompt if found, or nil otherwise.
    public func getPrompt(identifier: String) -> MCPPrompt? {
        return prompts[identifier]
    }
    
    /// Lists all registered prompts.
    /// - Returns: An array of all MCPPrompt objects currently registered.
    public func listPrompts() -> [MCPPrompt] {
        return Array(prompts.values)
    }

    /// Returns the metadata for all registered prompts (correlates with the Python SDK).
    /// - Returns: An array of MCPPromptMetadata objects for all registered prompts.
    public func listPromptMetadata() -> [MCPPromptMetadata] {
        return prompts.values.map { $0.metadata }
    }
    
    /// Registers a new prompt.
    /// - Parameter prompt: The MCPPrompt to register.
    /// - Returns: The registered MCPPrompt, or the existing one if a duplicate is found.
    @discardableResult
    public func addPrompt(_ prompt: MCPPrompt) -> MCPPrompt {
        if let existing = prompts[prompt.identifier] {
            if warnOnDuplicatePrompts {
                print("[MCPPromptManager] Prompt already exists: \(prompt.identifier)")
            }
            return existing
        }
        prompts[prompt.identifier] = prompt
        return prompt
    }
    
    /// Removes a prompt by its identifier.
    /// - Parameter identifier: The identifier of the prompt to remove.
    /// - Returns: True if the prompt existed and was removed, false otherwise.
    @discardableResult
    public func removePrompt(identifier: String) -> Bool {
        if prompts.removeValue(forKey: identifier) != nil {
            return true
        }
        return false
    }

    /// Renders a prompt by its identifier and arguments.
    /// - Parameters:
    ///   - identifier: The identifier of the prompt to render.
    ///   - arguments: The arguments to pass to the prompt handler (default is empty).
    /// - Returns: The result of the prompt handler, or nil if the prompt is not found.
    public func renderPrompt(identifier: String, arguments: [String: Any] = [:]) -> AnyCodable? {
        guard let prompt = getPrompt(identifier: identifier) else {
            print("[MCPPromptManager] Unknown prompt: \(identifier)")
            return nil
        }
        return prompt.handler(arguments)
    }

    /// Renders a prompt and returns a Result with customizable errors.
    /// - Parameters:
    ///   - identifier: The identifier of the prompt to render.
    ///   - arguments: The arguments to pass to the prompt handler (default is empty).
    /// - Returns: A Result containing the result or an AnyMCPError if not found.
    public func renderPromptWithError(identifier: String, arguments: [String: Any] = [:]) -> Result<AnyCodable, AnyMCPError> {
        guard let prompt = getPrompt(identifier: identifier) else {
            return .failure(AnyMCPError(MCPNotFoundError(identifier: identifier, message: "Prompt not found")))
        }
        return .success(prompt.handler(arguments))
    }
}
