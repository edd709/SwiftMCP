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

/// Represents the execution context for MCP resource and tool handlers.
/// Provides request data and additional user information for handler logic.
public struct MCPExecutionContext {
    /// The request data passed to the handler, typically containing parameters and payload.
    public let request: [String: AnyCodable]
    /// Optional user information or metadata associated with the request.
    public let userInfo: [String: Any]?
    // You can extend this struct to add more context fields as needed for your application.
}
