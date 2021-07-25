//
//  RoundedBlob.swift
//  RoundedBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI
#if canImport(VisualEffects)
import VisualEffects
#endif

public struct RoundedBlob: View {
    public var cornerRadius: Double = 15
    public let intensity: BlurIntensity
    
    public init(cornerRadius: Double = 15, intensity: BlurIntensity = .thin) {
        self.cornerRadius = cornerRadius
        self.intensity = intensity
    }
    
    public var body: some View {
        Group {
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, *) {
                switch intensity {
                case .thin:
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(Material.ultraThin)
                case .material:
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(Material.regular)
                case .thick:
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(Material.thick)
                }
            } else {
#if canImport(VisualEffects)
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
#else
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.secondary)
#endif
            }
        }
    }
}

struct RoundedBlobView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            RoundedBlob()
                .aspectRatio(1/1, contentMode: .fit)
                .shadow(radius: 30, y: 20)
                .padding(60)
        }
    }
}
