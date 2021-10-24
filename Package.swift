// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "RuntimeExtensions",
	products: [
		.library(name: "RuntimeExtensions", targets: ["RuntimeExtensions"])
	],
	dependencies: [
        .package(url: "https://github.com/wickwirew/Runtime", .revision("dad03135d7701a4e7b3a4051e75d6b37bd8e178e")),
		.package(url: "https://github.com/Appsaurus/SwiftTestUtils", from: "1.0.0")
	],
	targets: [
		.target(name: "RuntimeExtensions", dependencies: ["Runtime"], path: "Sources/Shared"),
		.testTarget(name: "RuntimeExtensionsTests", dependencies: ["RuntimeExtensions", "SwiftTestUtils"], path: "RuntimeExtensionsTests/Shared")
	]
)
