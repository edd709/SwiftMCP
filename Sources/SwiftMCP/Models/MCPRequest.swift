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

/// Represents a request within the MCP protocol.
///
/// This structure encapsulates a single request in the MCP protocol, including its unique identifier, method, and parameters.
///
/// - Parameters:
///   - id: Unique identifier for the request.
///   - method: Method or action to be executed.
///   - params: Parameters for the request, can be any value compatible with JSON using `AnyCodable`.
/**
 Represents a request exchanged in the MCP protocol.

 Contains a unique identifier, the method to be executed, and parameters for the request.
 */
public struct MCPRequest: Codable {
    /// Initializes a new MCPRequest.
    /// - Parameters:
    ///   - id: Unique identifier for the request.
    ///   - method: The method or action to be executed.
    ///   - params: The parameters for the request, as an `AnyCodable` value.
    public init(id: String, method: String, params: AnyCodable) {
        self.id = id
        self.method = method
        self.params = params
    }
    /// Unique identifier for the request.
    public let id: String
    /// The method or action to be executed.
    public let method: String
    /// The parameters for the request, compatible with JSON.
    public let params: AnyCodable
}
