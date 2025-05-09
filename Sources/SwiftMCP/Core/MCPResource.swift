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

/// Represents the metadata for an MCP resource (GET-like), exposing data to the LLM.
/// This struct is serializable and does not include the handler.
public struct MCPResourceMetadata: Codable, Equatable {
    /// Unique identifier for the resource.
    public let identifier: String
    /// Human-readable name of the resource.
    public let name: String
    /// Optional description of the resource.
    public let description: String?
    /// MIME type of the resource's output (default is "text/plain").
    public let mimeType: String
    
    /// Initializes a new MCPResourceMetadata instance.
    /// - Parameters:
    ///   - identifier: Unique identifier for the resource.
    ///   - name: Human-readable name of the resource.
    ///   - description: Optional description of the resource.
    ///   - mimeType: MIME type of the resource output (default is "text/plain").
    public init(identifier: String, name: String, description: String? = nil, mimeType: String = "text/plain") {
        self.identifier = identifier
        self.name = name
        self.description = description
        self.mimeType = mimeType
    }
}

/// Represents a complete MCP resource (not Codable, includes the handler).
/// This struct combines resource metadata with a handler function to process requests.
public struct MCPResource {
    /// Metadata describing the resource.
    public let metadata: MCPResourceMetadata
    /// Handler function that processes input parameters and returns a result as AnyCodable.
    public let handler: ([String: Any]) -> AnyCodable
    
    /// Initializes a new MCPResource instance.
    /// - Parameters:
    ///   - metadata: Metadata describing the resource.
    ///   - handler: Function that processes input parameters and returns a result.
    public init(metadata: MCPResourceMetadata,
                handler: @escaping ([String: Any]) -> AnyCodable) {
        self.metadata = metadata
        self.handler = handler
    }
    
    /// Shortcut access to the resource's unique identifier.
    public var identifier: String { metadata.identifier }
    /// Shortcut access to the resource's name.
    public var name: String { metadata.name }
    /// Shortcut access to the resource's description.
    public var description: String? { metadata.description }
    /// Shortcut access to the resource's MIME type.
    public var mimeType: String { metadata.mimeType }
}

