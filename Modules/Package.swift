// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
		.library(
			name: "Core",
            type: .static,
			targets: ["Core"]),
		.library(
			name: "DesignSystem",
            type: .static,
			targets: ["DesignSystem"]),
		.library(
			name: "NewsFeature",
            type: .dynamic,
			targets: ["NewsFeature"]),
		.library(
			name: "ShareQrFeature",
            type: .dynamic,
			targets: ["ShareQrFeature"]),
		.library(
			name: "HomeFeature",
            type: .dynamic,
			targets: ["HomeFeature"]),
		.library(
			name: "DashboardFeature",
            type: .dynamic,
			targets: ["DashboardFeature"]),
		.library(
			name: "SettingsFeature",
            type: .dynamic,
			targets: ["SettingsFeature"]),
		.library(
			name: "AuthFeature",
            type: .dynamic,
			targets: ["AuthFeature"]),
        .library(
            name: "OnboardingFeature",
            type: .dynamic,
            targets: ["OnboardingFeature"]),
		.library(
			name: "AppFeature",
            type: .dynamic,
			targets: ["AppFeature"]),
		.library(
			name: "DeeplinkFeature",
            type: .dynamic,
			targets: ["DeeplinkFeature"]),
        .library(name: "PaymentFeature",
                 type: .dynamic,
                 targets: ["PaymentFeature"]),
        .library(name: "OperationRow",
                 type: .dynamic,
                 targets: ["OperationRow"]),
        .library(name: "DetailFeature",
                 type: .dynamic,
                 targets: ["DetailFeature"]),
        .library(name: "CardFeature",
                 type: .dynamic,
                 targets: ["CardFeature"]),
        .library(name: "PreviewFeature",
                 type: .dynamic,
                 targets: ["PreviewFeature"]),
        .library(name: "AddFeature",
                 type: .dynamic,
                 targets: ["AddFeature"]),
        .library(name: "ForgetFeature",
                 type: .dynamic,
                 targets: ["ForgetFeature"])
    ],
    dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.32.0"),
		.package(url: "https://github.com/CrazyMillerGitHub/QrCodeManager", .branch("main")),
		.package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.3.1"),
		.package(url: "https://github.com/stripe/stripe-ios", from: "21.0.0"),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators", .branch("main")),
        .package(url: "https://github.com/onevcat/Kingfisher",  from: "7.2.0")
    ],
	targets: [
		.target(
			name: "Core",
			dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Stripe", package: "stripe-ios")
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
            name: "ForgetFeature",
            dependencies: [
                "DesignSystem",
                "Core"
            ]
        ),
		.target(
			name: "SettingsFeature",
			dependencies: [
                "OperationRow"
			]
		),
		.target(
			name: "AppFeature",
			dependencies: [
				"SettingsFeature",
				"DashboardFeature",
				"HomeFeature",
				"NewsFeature",
				"AuthFeature",
                "OnboardingFeature",
                "DetailFeature",
                "PaymentFeature",
                "PreviewFeature",
                "AddFeature",
                "ForgetFeature",
                "ShareQrFeature",
                .product(name: "TCACoordinators", package: "TCACoordinators")
			]
		),
        .target(
            name: "PaymentFeature",
            dependencies: [
                "Core",
                "DesignSystem"
            ]
        ),
        .target(
            name: "OnboardingFeature",
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
            name: "PreviewFeature",
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
            name: "AddFeature",
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
