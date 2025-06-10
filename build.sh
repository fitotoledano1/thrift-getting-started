#!/bin/bash

# Thrift Calculator Build Script
set -e

echo "🔧 Building Thrift Calculator Project..."

# Clean previous generated code
echo "🧹 Cleaning previous generated code..."
rm -rf gen-java gen-swift

# Generate Java code
echo "☕ Generating Java code..."
thrift --gen java thrift/shared.thrift
thrift --gen java thrift/tutorial.thrift

# Generate Swift code
echo "🍎 Generating Swift code..."
thrift --gen swift thrift/shared.thrift
thrift --gen swift thrift/tutorial.thrift

# Copy generated Java code to Maven structure
echo "📁 Copying Java code to Maven structure..."
cp -r gen-java/* src/main/java/

# Copy generated Swift code to Swift package
echo "📦 Copying Swift code to package..."
cp gen-swift/*.swift Sources/ThriftCalculatorClient/

# Build Java server
echo "🏗️ Building Java server..."
mvn compile

# Build Swift client
echo "🔨 Building Swift client..."
swift build

echo "✅ Build complete!"
echo ""
echo "To run:"
echo "  Java Server: mvn exec:java"
echo "  Swift Client: swift run ThriftCalculatorClient" 