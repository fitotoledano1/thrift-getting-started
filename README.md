# Apache Thrift Calculator Tutorial

A complete cross-language RPC example using Apache Thrift with a **Java server** and **Swift client**.

## 🎯 Overview

This project demonstrates how to build scalable cross-language services using Apache Thrift, perfect for mobile sync architectures where different platforms need to communicate with a central backend.

### Architecture

```
┌─────────────────┐    ┌─────────────────┐
│   Swift Client  │────│   Java Server   │
│   (iOS/macOS)   │    │   (Backend)     │
└─────────────────┘    └─────────────────┘
         │                       │
         └───────Thrift RPC──────┘
```

## 📁 Project Structure

```
thrift-test-2/
├── thrift/                          # Thrift IDL definitions
│   ├── shared.thrift               #   - Common types
│   └── tutorial.thrift             #   - Calculator service
├── src/main/java/                  # Java server (Maven)
│   ├── CalculatorHandler.java      #   - Service implementation
│   ├── JavaServer.java             #   - Server bootstrap
│   ├── shared/                     #   - Generated shared types
│   └── tutorial/                   #   - Generated calculator types
├── Sources/ThriftCalculatorClient/ # Swift client (SPM)
│   ├── main.swift                  #   - Client implementation
│   └── [generated swift files]    #   - Generated Thrift code
├── Tests/                          # Swift tests
├── pom.xml                         # Maven configuration
├── Package.swift                   # Swift Package Manager
└── build.sh                       # Build script
```

## 🚀 Quick Start

### Prerequisites

- **Apache Thrift** 0.22.0 or later
- **Java** 11+ with Maven
- **Swift** 5.3+ with Swift Package Manager

### Installation

1. **Install Thrift compiler:**
   ```bash
   brew install thrift  # macOS
   ```

2. **Clone and build:**
   ```bash
   git clone <repository>
   cd thrift-test-2
   ./build.sh
   ```

3. **Run the demo:**
   ```bash
   # Terminal 1: Start Java server
   mvn exec:java
   
   # Terminal 2: Run Swift client
   swift run ThriftCalculatorClient
   ```

## 🔧 Services

### Calculator Service

```thrift
service Calculator extends shared.SharedService {
  void ping(),
  i32 add(1:i32 num1, 2:i32 num2),
  i32 calculate(1:i32 logid, 2:Work w) throws (1:InvalidOperation ouch),
  oneway void zip()
}
```

### Supported Operations

- **`ping()`** - Health check
- **`add(n1, n2)`** - Simple addition
- **`calculate(logid, work)`** - Complex operations (add, subtract, multiply, divide)
- **`getStruct(key)`** - Retrieve cached results
- **`zip()`** - Oneway call (fire-and-forget)

### Data Types

```thrift
struct Work {
  1: i32 num1 = 0,
  2: i32 num2,
  3: Operation op,
  4: optional string comment,
}

enum Operation {
  ADD = 1,
  SUBTRACT = 2,
  MULTIPLY = 3,
  DIVIDE = 4
}
```

## 💡 Key Features

### Cross-Language RPC
- **Type Safety**: Compile-time checks in both languages
- **Binary Protocol**: Efficient serialization vs JSON
- **Schema Evolution**: Backward-compatible field additions

### Error Handling
```swift
do {
    let result = try client.calculate(logid: 1, w: work)
} catch let error as InvalidOperation {
    print("Error: \(error.why)")
}
```

### State Management
- Server maintains calculation history
- Clients can retrieve cached results via `getStruct()`

## 🏗️ Development

### Regenerating Code

After modifying `.thrift` files:
```bash
./build.sh
```

### Adding New Fields (Schema Evolution)

```thrift
struct Work {
  1: i32 num1 = 0,
  2: i32 num2,
  3: Operation op,
  4: optional string comment,
  5: optional i64 timestamp,    // ← Safe to add
}
```

### Testing

```bash
# Java tests
mvn test

# Swift tests  
swift test
```

## 📊 Performance Characteristics

| Metric | Thrift Binary | JSON REST |
|--------|---------------|-----------|
| Payload Size | ~60% smaller | Baseline |
| Parse Speed | ~3x faster | Baseline |
| Type Safety | Compile-time | Runtime |
| Schema Evolution | Built-in | Manual |

## 🔗 Use Cases

Perfect for:
- **Mobile Sync** - iOS/Android ↔ Backend
- **Microservices** - Cross-language service communication  
- **Real-time Systems** - Low-latency RPC calls
- **API Gateways** - Type-safe service definitions

## 📚 Learn More

- [Apache Thrift Documentation](https://thrift.apache.org)
- [Thrift Tutorial](https://thrift.apache.org/tutorial/)
- [Swift Thrift Library](https://github.com/apache/thrift/tree/master/lib/swift)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `./build.sh` to verify
5. Submit a pull request

## 📄 License

Licensed under the Apache License, Version 2.0 