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

/// Represents the context for MCP (Multi-Channel Protocol) operations.
///
/// Contains a list of MCP messages and can be extended to include additional context fields as needed by your application schema.
///
/// - Parameter messages: An array of MCPMessage objects that are part of the current context.
public struct MCPContext: Codable {
    /// The list of MCP messages included in this context.
    public let messages: [MCPMessage]
    // You can add other fields here according to your application schema.
}
