// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ThriftCalculatorClient",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apache/thrift.git", from: "0.22.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products from dependencies.
        .target(
            name: "ThriftCalculatorClient",
            dependencies: [.product(name: "Thrift", package: "thrift")]),
        .testTarget(
            name: "ThriftCalculatorClientTests",
            dependencies: ["ThriftCalculatorClient"]),
    ]
) 