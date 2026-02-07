// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MicroStreaksLogic",
    platforms: [.macOS(.v14)],
    products: [.library(name: "MicroStreaksLogic", targets: ["MicroStreaksLogic"])],
    targets: [
        .target(name: "MicroStreaksLogic", path: "Services", sources: ["StreakService.swift", "SessionScalingService.swift"]),
        .testTarget(name: "MicroStreaksLogicTests", dependencies: ["MicroStreaksLogic"], path: "Tests")
    ]
)
