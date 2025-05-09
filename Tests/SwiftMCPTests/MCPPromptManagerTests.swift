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
@testable import SwiftMCP

/// Unit tests for MCPPromptManager, ensuring correct prompt rendering and error handling.
final class MCPPromptManagerTests: XCTestCase {
    /// Tests that rendering a prompt with a non-existent identifier returns a not found error.
    func testRenderPromptWithError_notFound() {
        let manager = MCPPromptManager()
        let result = manager.renderPromptWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Prompt not found")
        default:
            XCTFail("Expected failure for not found prompt")
        }
    }

    /// Tests that rendering a prompt with a valid identifier returns the expected result.
    func testRenderPromptWithError_success() {
        let manager = MCPPromptManager()
        let metadata = MCPPromptMetadata(identifier: "test", name: "Test", description: "", arguments: [])
let prompt = MCPPrompt(metadata: metadata, handler: { args in AnyCodable("ok") })
        manager.addPrompt(prompt)
        let result = manager.renderPromptWithError(identifier: "test")
        switch result {
        case .success(let val):
            XCTAssertEqual(val.value as? String, "ok")
        default:
            XCTFail("Expected success for valid prompt")
        }
    }
}
