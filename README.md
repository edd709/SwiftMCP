# SwiftMCP

## Overview

**SwiftMCP** is a modular and extensible Swift implementation of the Message Communication Protocol (MCP). It is designed for modern servers and applications that require flexible, type-safe data serialization and seamless integration with AI, LLMs, or any system that leverages contextual messaging and tool invocation.

---

## Objectives

- **Standardization:** Provide a robust, standards-compliant SDK for the MCP protocol in Swift, ensuring interoperability with other MCP implementations.
- **Flexibility:** Support arbitrary, dynamic data structures using Swift's `Codable` protocol and the custom `AnyCodable` type.
- **Extensibility:** Allow easy extension for new message types, annotations, and protocol features.
- **Reliability:** Enable safe, predictable serialization/deserialization and error handling across all MCP models.

---

## Utility

SwiftMCP is ideal for:
- Building AI-powered servers and clients that communicate using the MCP protocol.
- Integrating external tools, resources, or contextual data with LLM-based applications.
- Creating custom workflows, chatbots, or agentic systems requiring structured, extensible messaging.
- Bridging Swift applications with other platforms or services that use MCP (e.g., TypeScript, Python, etc.).

---

## Main Models

- **AnyCodable:** Encodes and decodes any JSON-compatible value using `Codable`. Supports primitives, arrays, dictionaries, and nulls.
- **MCPMessage:** Represents a protocol message with sender role, content, and optional annotations.
- **MCPRequest:** Encapsulates a protocol request, including unique ID, method/action, and parameters.
- **MCPResponse:** Encapsulates a protocol response, including the original request ID, result, and optional error.
- **MCPError:** Standard structure for protocol errors, including code, message, and optional data.
- **Annotations:** Optional metadata for messages (e.g., audience, priority).
- **MCPContext:** Groups related MCP messages for contextual operations.

---

## Installation

Add SwiftMCP to your project using Swift Package Manager:

```swift
.package(url: "https://github.com/your-org/SwiftMCP.git", from: "1.0.0")
```

Import in your source files:

```swift
import SwiftMCP
```

---

## Usage Examples

### 1. Encoding and Decoding Arbitrary Data

```swift
let value: AnyCodable = AnyCodable(["key": 123, "active": true, "comment": nil])
let data = try JSONEncoder().encode(value)
let decoded = try JSONDecoder().decode(AnyCodable.self, from: data)
print(decoded.value) // ["key": 123, "active": true, "comment": nil]
```

### 2. Creating and Serializing an MCPMessage

```swift
let message = MCPMessage(
    role: "user",
    content: AnyCodable(["text": "Hello, world!", "timestamp": 1715270400]),
    annotations: Annotations(audience: "assistant", priority: 1)
)
let jsonData = try JSONEncoder().encode(message)
```

### 3. Making an MCPRequest

```swift
let request = MCPRequest(
    id: UUID().uuidString,
    method: "getWeather",
    params: AnyCodable(["city": "London"])
)
let requestData = try JSONEncoder().encode(request)
```

### 4. Handling an MCPResponse

```swift
let response = MCPResponse(
    id: request.id,
    result: AnyCodable(["temperature": 18.5]),
    error: nil
)
let responseData = try JSONEncoder().encode(response)
```

### 5. Error Handling

```swift
let error = MCPError(
    code: 404,
    message: "Resource not found",
    data: AnyCodable(["resource": "weather"])
)
let errorResponse = MCPResponse(
    id: request.id,
    result: nil,
    error: error
)
```

---

## Running Tests

SwiftMCP uses **SwiftTest** for unit testing. Tests cover all models, serialization/deserialization, edge cases, and error handling.

To run tests:

```sh
swift test
```

---

## Requirements

- Swift 6.1 or newer
- macOS 14.0+

---

## Project Structure

- `Sources/SwiftMCP/Models/` — Main protocol models
- `Tests/SwiftMCPTests/` — Unit tests using SwiftTest

---

## Contributing

Contributions are welcome! Please open an issue or pull request for suggestions, improvements, or bug reports.

---

## License

MIT License
