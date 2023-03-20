// swift-tools-version:4.0

import PackageDescription

let pkg = Package(name: "ArculusPromiseKit")
pkg.products = [
    .library(name: "ArculusPromiseKit", targets: ["ArculusPromiseKit"]),
]

let pmk: Target = .target(name: "ArculusPromiseKit")
pmk.path = "Sources"
pmk.exclude = [
    "AnyPromise.swift",
    "AnyPromise.m",
    "PMKCallVariadicBlock.m",
    "dispatch_promise.m",
    "join.m",
    "when.m",
    "NSMethodSignatureForBlock.m",
    "after.m",
    "hang.m",
    "race.m",
    "Deprecations.swift"
]
pkg.swiftLanguageVersions = [3, 4, 5]
pkg.targets = [
    pmk,
    .testTarget(name: "APlus", dependencies: ["ArculusPromiseKit"], path: "Tests/A+"),
    .testTarget(name: "CorePromise", dependencies: ["ArculusPromiseKit"], path: "Tests/CorePromise"),
]
