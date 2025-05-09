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

/// Represents an image within the MCP protocol.
/// Encapsulates image data and its format for transport and processing.
public struct MCPImage: Codable {
    /// The binary data of the image.
    public let data: Data
    /// The format of the image (e.g., "png", "jpeg").
    public let format: String
    
    /// Initializes a new MCPImage.
    /// - Parameters:
    ///   - data: The binary data of the image.
    ///   - format: The format of the image (e.g., "png", "jpeg").
    public init(data: Data, format: String) {
        self.data = data
        self.format = format
    }
}
