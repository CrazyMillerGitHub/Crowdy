// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
	platforms: [.iOS(.v14)],
    products: [
		.library(
			name: "Core",
			targets: ["Core"]),
		.library(
			name: "DesignSystem",
			targets: ["DesignSystem"]),
		.library(
			name: "NewsFeature",
			targets: ["NewsFeature"]),
		.library(
			name: "ShareQrFeature",
			targets: ["ShareQrFeature"]),
		.library(
			name: "HomeFeature",
			targets: ["HomeFeature"]),
		.library(
			name: "HomeRow",
			targets: ["HomeRow"]),
		.library(
			name: "SearchFeature",
			targets: ["SearchFeature"]),
		.library(
			name: "SettingsFeature",
			targets: ["SettingsFeature"]),
		.library(
			name: "AppFeature",
			targets: ["AppFeature"]),
		.library(
			name: "DeeplinkFeature",
			targets: ["DeeplinkFeature"])
    ],
    dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.32.0"),
		.package(url: "https://github.com/CrazyMillerGitHub/QrCodeManager", .branch("main")),
		.package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.3.1")
    ],
	targets: [
		.target(
			name: "Core",
			dependencies: [
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
			]
		),
		.target(name: "DesignSystem"),
		.target(
			name: "NewsFeature",
			dependencies: [
				"Core",
				"DesignSystem"
			]
		),
		.target(
			name: "ShareQrFeature",
			dependencies: [
				"DesignSystem",
				"Core",
				.product(name: "QrCodeManager", package: "QrCodeManager")
			]
		),
		.target(
			name: "HomeFeature",
			dependencies: [
				"DesignSystem",
				"Core"
			]
		),
		.target(
			name: "SearchFeature",
			dependencies: [
				"DesignSystem",
				"Core"
			]
		),
		.target(
			name: "SettingsFeature",
			dependencies: [
				"DesignSystem",
				"Core"
			]
		),
		.target(
			name: "AppFeature",
			dependencies: [
				"SettingsFeature",
				"SearchFeature",
				"HomeFeature"
			]
		),
		.target(
			name: "HomeRow",
			dependencies: [
				"Core",
				"DesignSystem"
			]
		),
		.target(
			name: "DeeplinkFeature",
			dependencies: [
				.product(name: "Parsing", package: "swift-parsing")
			]
		)
	]
)
