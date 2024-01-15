// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "TCAExampleApp",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "TCAExampleApp",
            type: .static,
            targets: [
                "TCAExampleApp"
            ]
        )
    ],
    dependencies: [
       .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.17.0")
    ],
    targets: [
        .target(
            name: "TCAExampleApp",
            dependencies: [
            	 .product(name: "ComposableArchitecture", package: "swift-composable-architecture", condition: .when(platforms: [.macOS, .iOS])),
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)