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

/// Manages MCP resources, inspired by the ResourceManager from FastMCP (Python SDK).
/// Provides methods to register, retrieve, list, and remove resources within the MCP framework.
public class MCPResourceManager {
    /// Indicates whether argument validation should be performed locally (default is true).
    public var validateArgumentsLocal: Bool = true
    private var resources: [String: MCPResource] = [:]
    /// Indicates whether a warning should be printed when attempting to add a duplicate resource.
    public var warnOnDuplicateResources: Bool
    
    /// Initializes a new MCPResourceManager.
    /// - Parameter warnOnDuplicateResources: Whether to warn on duplicate resource registration (default is true).
    public init(warnOnDuplicateResources: Bool = true) {
        self.warnOnDuplicateResources = warnOnDuplicateResources
    }
    
    /// Retrieves a resource by its identifier.
    /// - Parameter identifier: The identifier of the resource to retrieve.
    /// - Returns: The MCPResource if found, or nil otherwise.
    public func getResource(identifier: String) -> MCPResource? {
        return resources[identifier]
    }
    
    /// Lists all registered resources.
    /// - Returns: An array of all MCPResource objects currently registered.
    public func listResources() -> [MCPResource] {
        return Array(resources.values)
    }

    /// Returns the metadata for all registered resources (correlates with the Python SDK).
    /// - Returns: An array of MCPResourceMetadata objects for all registered resources.
    public func listResourceMetadata() -> [MCPResourceMetadata] {
        return resources.values.map { $0.metadata }
    }
    
    /// Registers a new resource.
    /// - Parameter resource: The MCPResource to register.
    /// - Returns: The registered MCPResource, or the existing one if a duplicate is found.
    @discardableResult
    public func addResource(_ resource: MCPResource) -> MCPResource {
        if let existing = resources[resource.identifier] {
            if warnOnDuplicateResources {
                print("[MCPResourceManager] Resource already exists: \(resource.identifier)")
            }
            return existing
        }
        resources[resource.identifier] = resource
        return resource
    }
    
    /// Removes a resource by its identifier.
    /// - Parameter identifier: The identifier of the resource to remove.
    /// - Returns: True if the resource existed and was removed, false otherwise.
    @discardableResult
    public func removeResource(identifier: String) -> Bool {
        if resources.removeValue(forKey: identifier) != nil {
            return true
        }
        return false
    }

    /// Lee un recurso por identificador y argumentos.
    public func readResource(identifier: String, arguments: [String: Any] = [:]) -> AnyCodable? {
        guard let resource = getResource(identifier: identifier) else {
            print("[MCPResourceManager] Unknown resource: \(identifier)")
            return nil
        }
        if validateArgumentsLocal {
            // No hay metadata.parameters en MCPResourceMetadata, así que asumimos que se provee por convención o extensión
            // Si se agrega en el futuro, aquí debe ir la validación
        }
        return resource.handler(arguments)
    }

    /// Lee un recurso y retorna Result con errores customizables
    public func readResourceWithError(identifier: String, arguments: [String: Any] = [:]) -> Result<AnyCodable, AnyMCPError> {
        guard let resource = getResource(identifier: identifier) else {
            return .failure(AnyMCPError(MCPNotFoundError(identifier: identifier, message: "Resource not found")))
        }
        // Si en el futuro se agrega validación de argumentos, aquí debe ir el chequeo y retorno de MCPValidationError
        return .success(resource.handler(arguments))
    }
}
