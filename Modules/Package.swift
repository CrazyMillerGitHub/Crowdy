// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Modules",
	platforms: [.iOS(.v15)],
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
			name: "DashboardFeature",
			targets: ["DashboardFeature"]),
		.library(
			name: "SettingsFeature",
			targets: ["SettingsFeature"]),
		.library(
			name: "AuthFeature",
			targets: ["AuthFeature"]),
		.library(
			name: "AppFeature",
			targets: ["AppFeature"]),
		.library(
			name: "DeeplinkFeature",
			targets: ["DeeplinkFeature"]),
        .library(name: "PaymentFeature",
                 targets: ["PaymentFeature"]),
        .library(name: "FundsDetailsFeature",
                 targets: ["FundsDetailsFeature"]),
        .library(name: "OperationRow",
                 targets: ["OperationRow"]),
        .library(name: "DetailFeature",
                 targets: ["DetailFeature"]),
        .library(name: "CardFeature",
                 targets: ["CardFeature"])
    ],
    dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.32.0"),
		.package(url: "https://github.com/CrazyMillerGitHub/QrCodeManager", .branch("main")),
		.package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.3.1"),
		.package(url: "https://github.com/stripe/stripe-ios", from: "21.0.0"),
        .package(url: "https://github.com/CrazyMillerGitHub/ResizableSheet", .branch("main")),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators", .branch("main"))
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
			name: "AuthFeature",
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
			name: "DashboardFeature",
			dependencies: [
				"DesignSystem",
				"Core"
			]
		),
		.target(
			name: "SettingsFeature",
			dependencies: [
                "OperationRow",
                .product(name: "ResizableSheet", package: "ResizableSheet")
			]
		),
		.target(
			name: "AppFeature",
			dependencies: [
				"SettingsFeature",
				"DashboardFeature",
				"HomeFeature",
				"HomeRow",
				"NewsFeature",
				"AuthFeature",
                "DetailFeature"
			]
		),
        .target(
            name: "PaymentFeature",
            dependencies: [
                .product(name: "Stripe", package: "stripe-ios")
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
            name: "FundsDetailsFeature",
            dependencies: [
                "Core",
                "DesignSystem"
            ]
        ),
        .target(
            name: "OperationRow",
            dependencies: [
                "Core",
                "DesignSystem"
            ]
        ),
        .target(
            name: "DetailFeature",
            dependencies: [
                "Core",
                "DesignSystem"
            ]
        ),
        .target(
            name: "CardFeature",
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
