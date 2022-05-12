//
//  ShareFundView.swift
//  
//
//  Created by Mikhail Borisov on 06.05.2022.
//

import SwiftUI
import Core
import QRCode
import ComposableArchitecture
import DesignSystem

struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct ParticlesModifier: ViewModifier {

    @State var time = 0.0
    @State var scale = 0.5
    let duration = 10.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}

public struct ShareFundView: View {

    let store: Store<ShareFundState, ShareFundAction>
    let gradient = Gradient(colors: [TokenName.brand.color, TokenName.critical.color])

    public init(store: Store<ShareFundState, ShareFundAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Color(uiColor: .systemBackground)
                .overlay {
                    ZStack {
                        Text("🎉")
                            .font(.title)
                            .modifier(ParticlesModifier())
                        VStack(spacing: 20) {
                            Slider()
                            Spacer()
                            QRCodeUI(
                                text: viewStore.url.description,
                                errorCorrection: .medium
                            )!
                            .eyeShape(QRCode.EyeShape.RoundedRect())
                            .dataShape(QRCode.DataShape.Horizontal())
                            .fill(
                                LinearGradient(
                                    gradient: gradient,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 240, height: 240, alignment: .center)
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            Spacer()
                            Button("Поделиться") {
                                viewStore.send(.shareButtonTapped)
                            }
                            .buttonStyle(BrandButtonStyle(color: .info))
                            .disabled(viewStore.isLoading)
                            .opacity(viewStore.isLoading ? 0.5 : 1.0)
                        }
                        .alert(store.scope(state: \.alert), dismiss: .okTapped)
                        .padding([.leading, .trailing, .bottom, .top])
                        .sheet(isPresented: viewStore.binding(\.$showShareSheet)) {
                            ShareSheet(items: [viewStore.url])
                        }
                    }
                }
                .ignoresSafeArea(.all)
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
                .shimmering(active: viewStore.isLoading)
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}

public struct ShareFundView_Preview: PreviewProvider {

    public static var previews: some View {
        ShareFundView(
            store: .init(
                initialState: .init(fundId: .init()),
                reducer: shareFundReducer,
                environment: .dev(
                    environment: ShareFundEnvironment(
                        getFundURLRequest: dummyGetFundURLRequest
                    )
                )
            )
        )
    }
}
