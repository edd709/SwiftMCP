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

/// Optional metadata for MCP messages.
///
/// This struct provides additional, optional information that can be attached to MCP messages, such as the intended audience and message priority.
public struct Annotations: Codable {
    /// Initializes a new `Annotations` object.
    /// - Parameters:
    ///   - audience: The target audience for the message (e.g., ["user", "admin"]).
    ///   - priority: The priority of the message (e.g., 1.0 for high priority).
    public init(audience: [String]?, priority: Double?) {
        self.audience = audience
        self.priority = priority
    }

    /// The target audience for the message (e.g., ["user", "admin"]).
    public let audience: [String]?
    /// The priority of the message (e.g., 1.0 for high priority).
    public let priority: Double?
}
