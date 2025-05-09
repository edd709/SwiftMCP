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

/// Base protocol for custom MCP errors.
/// Conforms to Swift's `Error` and `CustomStringConvertible` protocols, and requires a descriptive message.
public protocol MCPErrorProtocol: Error, CustomStringConvertible {
    /// A human-readable message describing the error.
    var message: String { get }
}

/// Represents an argument validation error in the MCP framework.
/// Includes the path to the invalid argument and a descriptive message.
public struct MCPValidationError: MCPErrorProtocol {
    /// The path to the argument that failed validation.
    public let path: String
    /// A human-readable message describing the validation error.
    public let message: String
    /// A string representation of the validation error.
    public var description: String { "[ValidationError] \(path): \(message)" }
    /// Initializes a new MCPValidationError.
    /// - Parameters:
    ///   - path: The path to the invalid argument.
    ///   - message: A descriptive error message.
    public init(path: String, message: String) {
        self.path = path
        self.message = message
    }
}

/// Represents an error indicating that a resource, tool, or prompt was not found.
public struct MCPNotFoundError: MCPErrorProtocol {
    /// The identifier of the missing resource, tool, or prompt.
    public let identifier: String
    /// A human-readable message describing the error.
    public let message: String
    /// A string representation of the not found error.
    public var description: String { "[NotFoundError] \(identifier): \(message)" }
    /// Initializes a new MCPNotFoundError.
    /// - Parameters:
    ///   - identifier: The identifier of the missing entity.
    ///   - message: A descriptive error message.
    public init(identifier: String, message: String) {
        self.identifier = identifier
        self.message = message
    }
}

/// Represents an error indicating a duplicate resource, tool, or prompt.
public struct MCPDuplicateError: MCPErrorProtocol {
    /// The identifier of the duplicated resource, tool, or prompt.
    public let identifier: String
    /// A human-readable message describing the error.
    public let message: String
    /// A string representation of the duplicate error.
    public var description: String { "[DuplicateError] \(identifier): \(message)" }
    /// Initializes a new MCPDuplicateError.
    /// - Parameters:
    ///   - identifier: The identifier of the duplicated entity.
    ///   - message: A descriptive error message.
    public init(identifier: String, message: String) {
        self.identifier = identifier
        self.message = message
    }
}
