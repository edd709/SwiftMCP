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

/// Represents a response to an MCP request.
///
/// This struct contains the response data for an MCP operation, including the original request identifier, the result, and an optional error.
public struct MCPResponse: Codable {
    public init(id: String, result: AnyCodable, error: MCPError? = nil) {
        self.id = id
        self.result = result
        self.error = error
    }
    /// The identifier of the original request.
    public let id: String
    /// The result of the operation, of any type compatible with `AnyCodable`.
    public let result: AnyCodable?
    /// Details of the error if the operation failed (optional).
    public let error: MCPError?
}
