// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DataFace",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "DataFace", targets: ["DataFace"]),
    .library(name: "DataFaceCore", targets: ["DataFaceCore"]),
    .library(name: "DataFaceUI", targets: ["DataFaceUI"]),
  ],
  dependencies: [
    .package(name: "Epoxy", url: "https://github.com/airbnb/epoxy-ios", branch: "master"),
    .package(url: "https://github.com/airbnb/MagazineLayout", branch: "master"),
  ],
  targets: [
    .target(
      name: "DataFace",
      dependencies: [
        "DataFaceCore",
        "DataFaceUI",
      ]),
    .target(name: "DataFaceCore"),
    .target(name: "DataFaceUI", dependencies: [
      "Epoxy",
      "MagazineLayout",
      "DataFaceCore",
    ]),
  ])

#if swift(>=5.6)
// Add the Airbnb Swift formatting plugin if possible
package.dependencies.append(.package(url: "https://github.com/airbnb/swift", .upToNextMajor(from: "1.0.1")))
#endif
