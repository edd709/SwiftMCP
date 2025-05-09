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

import XCTest
import SwiftMCP

/// Unit tests for MCPResource functionality, including parameter validation and response structure.
///
/// This test suite covers the MCPResource class, which is responsible for handling requests and
/// returning responses. The tests focus on the validation of parameters and the structure of the
/// responses.
final class MCPResourceTests: XCTestCase {
    /// Test that the user profile resource returns the correct response when all parameters are valid.
    ///
    /// This test case verifies that the user profile resource returns a successful response when all
    /// required parameters are provided. The test creates an instance of MCPServer, registers a
    /// resource with a handler, and then calls the handler with valid parameters.
    func testUserProfileResource_validParams() {
        // Create an instance of MCPServer
        let mcpServer = MCPServer(name: "Test")
        
        // Define the metadata for the user profile resource
        let metadata = MCPResourceMetadata(identifier: "user_profile", name: "User Profile", description: nil, mimeType: "application/json")
        
        // Register the user profile resource with a handler
        mcpServer.registerResource(MCPResource(metadata: metadata, handler: { params in
            // Validate and extract parameters
            guard let name = params["name"] as? String else {
                return AnyCodable(["error": "Missing parameter 'name' or not a String"])
            }
            guard let age = params["age"] as? Int else {
                return AnyCodable(["error": "Missing parameter 'age' or not an Int"])
            }
            guard let active = params["active"] as? Bool else {
                return AnyCodable(["error": "Missing parameter 'active' or not a Bool"])
            }
            // Return a successful response
            return AnyCodable([
                "name": name,
                "age": age,
                "active": active,
                "message": "Profile received successfully."
            ])
        }))
        
        // All required parameters provided
        let params: [String: Any] = ["name": "Erio", "age": 30, "active": true]
        let result = mcpServer.handlerForResource("user_profile")?(params)
        let dict = result?.value as? [String: Any]
        XCTAssertEqual(dict?["name"] as? String, "Erio")
        XCTAssertEqual(dict?["age"] as? Int, 30)
        XCTAssertEqual(dict?["active"] as? Bool, true)
        XCTAssertEqual(dict?["message"] as? String, "Profile received successfully.")
    }

    /// Test that the user profile resource returns an error when a required parameter is missing.
    ///
    /// This test case verifies that the user profile resource returns an error response when a
    /// required parameter is missing. The test creates an instance of MCPServer, registers a
    /// resource with a handler, and then calls the handler with missing parameters.
    func testUserProfileResource_missingParams() {
        // Create an instance of MCPServer
        let mcpServer = MCPServer(name: "Test")
        
        // Define the metadata for the user profile resource
        let metadata = MCPResourceMetadata(identifier: "user_profile", name: "User Profile", description: nil, mimeType: "application/json")
        
        // Register the user profile resource with a handler
        mcpServer.registerResource(MCPResource(metadata: metadata, handler: { params in
            // Validate and extract parameters
            guard let name = params["name"] as? String else {
                return AnyCodable(["error": "Missing parameter 'name' or not a String"])
            }
            guard let age = params["age"] as? Int else {
                return AnyCodable(["error": "Missing parameter 'age' or not an Int"])
            }
            guard let active = params["active"] as? Bool else {
                return AnyCodable(["error": "Missing parameter 'active' or not a Bool"])
            }
            // Return a successful response
            return AnyCodable([
                "name": name,
                "age": age,
                "active": active,
                "message": "Profile received successfully."
            ])
        }))
        
        // Missing the 'age' parameter
        let params: [String: Any] = ["name": "Erio", "active": true]
        let result = mcpServer.handlerForResource("user_profile")?(params)
        let dict = result?.value as? [String: Any]
        XCTAssertEqual(dict?["error"] as? String, "Missing parameter 'age' or not an Int")
    }
}
