//
//  CircleBlob.swift
//  CircleBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI
#if canImport(VisualEffects)
import VisualEffects
#endif

public struct CircleBlob: View {
    public let intensity: BlurIntensity
    
    public init(intensity: BlurIntensity = .thin) {
        self.intensity = intensity
    }
    
    public var body: some View {
        Group {
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, *) {
                switch intensity {
                case .thin:
                    Circle()
                        .fill(Material.ultraThin)
                case .material:
                    Circle()
                        .fill(Material.regular)
                case .thick:
                    Circle()
                        .fill(Material.thick)
                }
            } else {
#if canImport(VisualEffects)
                Group {
                    switch intensity {
                    case .thin:
                        VisualEffectBlur(blurStyle: .systemThinMaterial)
                    case .material:
                        VisualEffectBlur(blurStyle: .regular)
                    case .thick:
                        VisualEffectBlur(blurStyle: .systemThickMaterial)
                    }
                }
                    .clipShape(Circle())
#else
                Circle()
                    .fill(Color.secondary)
#endif
            }
        }
    }
}

struct CircleBlobView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            CircleBlob()
                .aspectRatio(1/1, contentMode: .fit)
                .shadow(radius: 30, y: 20)
                .padding(60)
        }
    }
}
