//
//  ButtonBlob.swift
//  ButtonBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI

public struct ButtonBlob: View {
    public let systemImage: String
    public let intensity: BlurIntensity
    public let action: () -> Void
    
    public init(systemImage: String, intensity: BlurIntensity = .thin, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.intensity = intensity
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .imageScale(.large)
        }
        .padding()
#if os(iOS)
        .contentShape(Circle())
        .hoverEffect()
#endif
        .background(CircleBlob(intensity: intensity).shadow(color: Color("Shadow"), radius: 15, y: 10))
        .transition(.scale)
    }
}

struct ButtonBlob_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            ButtonBlob(systemImage: "square.and.arrow.up.fill") {
                
            }
            .padding(60)
        }
    }
}
