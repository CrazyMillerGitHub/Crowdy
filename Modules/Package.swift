// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
		.library(
			name: "Core",
            type: .dynamic,
			targets: ["Core"]),
		.library(
			name: "DesignSystem",
            type: .dynamic,
			targets: ["DesignSystem"]),
		.library(
			name: "NewsFeature",
            type: .static,
			targets: ["NewsFeature"]),
		.library(
			name: "ShareQrFeature",
            type: .dynamic,
			targets: ["ShareQrFeature"]),
		.library(
			name: "HomeFeature",
            type: .static,
			targets: ["HomeFeature"]),
		.library(
			name: "DashboardFeature",
            type: .static,
			targets: ["DashboardFeature"]),
		.library(
			name: "SettingsFeature",
            type: .static,
			targets: ["SettingsFeature"]),
		.library(
			name: "AuthFeature",
            type: .static,
			targets: ["AuthFeature"]),
        .library(
            name: "OnboardingFeature",
            type: .static,
            targets: ["OnboardingFeature"]),
		.library(
			name: "AppFeature",
            type: .dynamic,
			targets: ["AppFeature"]),
		.library(
			name: "DeeplinkFeature",
            type: .static,
			targets: ["DeeplinkFeature"]),
        .library(name: "PaymentFeature",
                 type: .static,
                 targets: ["PaymentFeature"]),
        .library(name: "OperationRow",
                 type: .static,
                 targets: ["OperationRow"]),
        .library(name: "DetailFeature",
                 type: .static,
                 targets: ["DetailFeature"]),
        .library(name: "CardFeature",
                 type: .static,
                 targets: ["CardFeature"]),
        .library(name: "PreviewFeature",
                 type: .static,
                 targets: ["PreviewFeature"]),
        .library(name: "AddFeature",
                 type: .static,
                 targets: ["AddFeature"]),
        .library(name: "ForgetFeature",
                 type: .static,
                 targets: ["ForgetFeature"]),
        .library(name: "EditProfileFeature",
                 type: .static,
                 targets: ["EditProfileFeature"])
    ],
    dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.32.0"),
		.package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.3.1"),
		.package(url: "https://github.com/stripe/stripe-ios", from: "21.0.0"),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators", .branch("main")),
        .package(url: "https://github.com/onevcat/Kingfisher",  from: "7.2.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "3.2.1"),
        .package(url: "https://github.com/dagronf/QRCode", .branch("main"))
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
		.target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios")
            ]
        ),
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
				.product(name: "QRCode", package: "QRCode")
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
            name: "EditProfileFeature",
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
                "EditProfileFeature",
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
