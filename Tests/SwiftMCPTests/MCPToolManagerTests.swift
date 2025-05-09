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

/// Unit tests for MCPToolManager functionality, including tool execution and validation.
final class MCPToolManagerTests: XCTestCase {
    /// Tests that a tool executes correctly when called with valid arguments.
    /// Expects the result to match the sum of the input integers.
    func testExecuteTool_CorrectArguments_ReturnsResult() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
                func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeTool(identifier: "sum", arguments: ["a": 2, "b": 3])
        XCTAssertEqual(result?.value as? [String: Int], ["result": 5])
        func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}

    /// Tests that the tool returns a validation error when a required argument is missing.
    /// Expects an error stating the missing argument.
    func testExecuteTool_MissingArgument_ReturnsValidationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
                func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeTool(identifier: "sum", arguments: ["a": 2])
        let errorDict = result?.value as? [String: String]
        XCTAssertEqual(errorDict?["error"], "Missing parameter 'b'")
        func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}

    /// Tests that the tool returns a validation error when an argument is of the wrong type.
    /// Expects an error indicating a type mismatch.
    func testExecuteTool_WrongTypeArgument_ReturnsValidationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
                func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeTool(identifier: "sum", arguments: ["a": "dos", "b": 3])
        let errorDict = result?.value as? [String: String]
        XCTAssertEqual(errorDict?["error"], "The parameter 'a' must be Int")
        func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}

    /// Tests that the handler executes even if argument validation is disabled.
    /// Expects the handler to run and return a result or handler error.
    func testExecuteTool_ValidationDisabled_HandlerExecutes() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                // If the handler receives the wrong type, this may crash
                if let a = params["a"] as? Int, let b = params["b"] as? Int {
                    return AnyCodable(["result": a + b])
                } else {
                    return AnyCodable(["error": "Handler error"])
                    func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
                func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        toolManager.validateArgumentsLocal = false
        let result = toolManager.executeTool(identifier: "sum", arguments: ["a": "dos", "b": 3])
        let errorDict = result?.value as? [String: String]
        XCTAssertEqual(errorDict?["error"], "Handler error")
        func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
    func testExecuteToolWithError_notFound() {
        let manager = MCPToolManager()
        let result = manager.executeToolWithError(identifier: "nope")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPNotFoundError)
            XCTAssertEqual(error.message, "Tool not found")
        default:
            XCTFail("Expected failure for not found tool")
        }
    }

    func testExecuteToolWithError_success() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2, "b": 3])
        switch result {
        case .success(let val):
            XCTAssertEqual((val.value as? [String: Int])?["result"], 5)
        default:
            XCTFail("Expected success for valid tool")
        }
    }

    func testExecuteToolWithError_validationError() {
        let sumaToolMetadata = MCPToolMetadata(
            identifier: "sum",
            name: "Sum two integers",
            description: "Adds two integers",
            parameters: ["a": "int", "b": "int"]
        )
        let sumaTool = MCPTool(
            metadata: sumaToolMetadata,
            handler: { params in
                let a = params["a"] as! Int
                let b = params["b"] as! Int
                return AnyCodable(["result": a + b])
            }
        )
        let toolManager = MCPToolManager()
        toolManager.addTool(sumaTool)
        let result = toolManager.executeToolWithError(identifier: "sum", arguments: ["a": 2])
        switch result {
        case .failure(let error):
            XCTAssertTrue(error.underlyingError is MCPValidationError)
            XCTAssertTrue(error.message.contains("Missing parameter"))
        default:
            XCTFail("Expected failure for validation error")
        }
    }
}
