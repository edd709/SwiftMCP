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

/// Representa un prompt reutilizable MCP.
/// Representa un argumento que puede recibir un prompt MCP.
public struct MCPPromptArgument: Codable, Equatable {
    public let name: String
    public let description: String?
    public let type: String // Ejemplo: "string", "int", "bool", "object", etc.
    public let required: Bool
    
    public init(name: String, description: String? = nil, type: String = "string", required: Bool = false) {
        self.name = name
        self.description = description
        self.type = type
        self.required = required
    }
}

/// Metadata serializable de un prompt MCP (sin el handler).
public struct MCPPromptMetadata: Codable, Equatable {
    public let identifier: String
    public let name: String
    public let description: String?
    public let arguments: [MCPPromptArgument]
    
    public init(identifier: String,
                name: String,
                description: String? = nil,
                arguments: [MCPPromptArgument] = []) {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.arguments = arguments
    }
}

/// Prompt MCP completo (no Codable, incluye handler).
public struct MCPPrompt {
    public let metadata: MCPPromptMetadata
    public let handler: ([String: Any]) -> AnyCodable
    
    public init(metadata: MCPPromptMetadata,
                handler: @escaping ([String: Any]) -> AnyCodable) {
        self.metadata = metadata
        self.handler = handler
    }
    
    // Accesos rápidos a los campos principales
    public var identifier: String { metadata.identifier }
    public var name: String { metadata.name }
    public var description: String? { metadata.description }
    public var arguments: [MCPPromptArgument] { metadata.arguments }
}

