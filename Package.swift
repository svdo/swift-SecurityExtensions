// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SecurityExtensions",
    platforms: [
        .macOS(.v10_14), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SecurityExtensions",
            targets: ["SecurityExtensions"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/iosdevzone/IDZSwiftCommonCrypto",
            from: "0.13.1"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SecurityExtensions",
            dependencies: ["IDZSwiftCommonCrypto"],
            path: "SecurityExtensions",
            exclude: ["Info.plist"]
        )
    ]
)
