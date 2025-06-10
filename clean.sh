#!/bin/bash

# Thrift Calculator Clean Script
echo "🧹 Cleaning Thrift Calculator Project..."

# Remove generated code
echo "Removing generated Thrift code..."
rm -rf gen-java gen-swift

# Remove build artifacts
echo "Removing build artifacts..."
rm -rf target .build

# Remove Swift package resolved
echo "Removing Swift Package resolved..."
rm -f Package.resolved

# Remove generated code from source directories
echo "Cleaning source directories..."
find src/main/java/shared src/main/java/tutorial -name "*.java" -not -name "CalculatorHandler.java" -not -name "JavaServer.java" -delete 2>/dev/null || true
find Sources/ThriftCalculatorClient -name "*.swift" -not -name "main.swift" -delete 2>/dev/null || true

echo "✅ Project cleaned!"
echo "Run ./build.sh to regenerate everything." 