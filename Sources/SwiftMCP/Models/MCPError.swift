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

/// Represents an error within the MCP (Multi-Channel Protocol).
///
/// Contains a numeric error code, a human-readable description, and optional additional data relevant to the error.
///
/// - Parameter code: Numeric code representing the error.
/// - Parameter message: Human-readable description of the error.
/// - Parameter data: Optional dictionary with additional information about the error.
public struct MCPError: Codable {
    /// Initializes a new MCPError.
    /// - Parameters:
    ///   - code: Numeric code representing the error.
    ///   - message: Human-readable description of the error.
    ///   - data: Optional dictionary with additional information about the error.
    public init(code: Int, message: String, data: [String: AnyCodable]?) {
        self.code = code
        self.message = message
        self.data = data
    }
    /// Numeric code representing the error.
    public let code: Int
    /// Human-readable description of the error.
    public let message: String
    /// Optional dictionary with additional information about the error.
    public let data: [String: AnyCodable]?
}
