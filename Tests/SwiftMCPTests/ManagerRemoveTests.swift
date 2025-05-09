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

/// Unit tests for MCP manager removal operations, including tools, resources, and prompts.
final class ManagerRemoveTests: XCTestCase {
    /// Tests adding and removing a tool from the MCPToolManager.
    /// Verifies that the tool can be added, removed, and cannot be removed twice.
    func testRemoveTool() {
        let manager = MCPToolManager()
        let tool = MCPTool(metadata: MCPToolMetadata(identifier: "sumar", name: "Sumar", description: nil, parameters: ["a": "int", "b": "int"])) { _ in AnyCodable(0) }
        manager.addTool(tool)
        XCTAssertNotNil(manager.getTool(identifier: "sumar"))
        XCTAssertTrue(manager.removeTool(identifier: "sumar"))
        XCTAssertNil(manager.getTool(identifier: "sumar"))
        // Attempt to remove a tool that does not exist; should return false.
        XCTAssertFalse(manager.removeTool(identifier: "sumar"))
    }

    /// Tests adding and removing a resource from the MCPResourceManager.
    /// Verifies that the resource can be added, removed, and cannot be removed twice.
    func testRemoveResource() {
        let manager = MCPResourceManager()
        let resource = MCPResource(metadata: MCPResourceMetadata(identifier: "user_profile", name: "Perfil", description: nil, mimeType: "application/json")) { _ in AnyCodable([:]) }
        manager.addResource(resource)
        XCTAssertNotNil(manager.getResource(identifier: "user_profile"))
        XCTAssertTrue(manager.removeResource(identifier: "user_profile"))
        XCTAssertNil(manager.getResource(identifier: "user_profile"))
        XCTAssertFalse(manager.removeResource(identifier: "user_profile"))
    }

    /// Tests adding and removing a prompt from the MCPPromptManager.
    /// Verifies that the prompt can be added, removed, and cannot be removed twice.
    func testRemovePrompt() {
        let manager = MCPPromptManager()
        let prompt = MCPPrompt(metadata: MCPPromptMetadata(identifier: "saludo", name: "Saludo", description: nil, arguments: [])) { _ in AnyCodable("Hola") }
        manager.addPrompt(prompt)
        XCTAssertNotNil(manager.getPrompt(identifier: "saludo"))
        XCTAssertTrue(manager.removePrompt(identifier: "saludo"))
        XCTAssertNil(manager.getPrompt(identifier: "saludo"))
        // Attempt to remove a prompt that does not exist; should return false.
        XCTAssertFalse(manager.removePrompt(identifier: "saludo"))
    }
}

