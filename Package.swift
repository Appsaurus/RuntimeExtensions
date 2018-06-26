// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "RuntimeExtensions",
	products: [
		.library(name: "RuntimeExtensions", targets: ["RuntimeExtensions"])
	],
	dependencies: [
		.package(url: "https://github.com/wickwirew/Runtime",  .upToNextMajor(from: "0.6.0")),
		.package(url: "https://github.com/Appsaurus/SwiftTestUtils",  .upToNextMajor(from: "1.0.0"))
	],
	targets: [
		.target(name: "RuntimeExtensions", dependencies: ["Runtime"], path: "Sources/Shared"),
		.testTarget(name: "RuntimeExtensionsTests", dependencies: ["RuntimeExtensions", "SwiftTestUtils"], path: "RuntimeExtensionsTests/Shared")
	]
)
