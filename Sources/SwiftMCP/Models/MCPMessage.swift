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

/// Represents a message within the MCP protocol.
///
/// This structure is used to encapsulate a single message exchanged in the MCP protocol, including its role, content, and optional annotations.
///
/// - Parameters:
///   - role: The role of the sender of the message (e.g., "user", "assistant").
///   - content: The main content of the message. Can be any value compatible with JSON using `AnyCodable`.
///   - annotations: Optional metadata to enrich the message (such as audience, priority, etc.).
/**
 Represents a message exchanged in the MCP protocol.

 Contains the sender's role, the main content, and optional annotations for metadata.
 */
public struct MCPMessage: Codable {
    /// Initializes a new MCPMessage.
    /// - Parameters:
    ///   - role: The role of the sender (e.g., "user", "assistant").
    ///   - content: The main content of the message, as an `AnyCodable` value.
    ///   - annotations: Optional metadata for the message, such as audience or priority.
    public init(role: String, content: AnyCodable, annotations: Annotations?) {
        self.role = role
        self.content = content
        self.annotations = annotations
    }
    /// The role of the sender of the message (e.g., "user", "assistant").
    public let role: String
    /// The main content of the message, compatible with JSON.
    public let content: AnyCodable
    /// Optional metadata to enrich the message (e.g., audience, priority).
    public let annotations: Annotations?
}
