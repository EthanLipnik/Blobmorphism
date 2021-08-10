//
//  RectangleBlob.swift
//  RectangleBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI

public struct RectangleBlob: View {
    public let intensity: BlurIntensity
    
    public init(intensity: BlurIntensity = .thin) {
        self.intensity = intensity
    }
    
    public var body: some View {
        Group {
            switch intensity {
            case .thin:
                Rectangle()
                    .fill(Material.ultraThin)
            case .material:
                Rectangle()
                    .fill(Material.regular)
            case .thick:
                Rectangle()
                    .fill(Material.thick)
            }
        }
    }
}

struct RectangleBlobView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.green], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            RectangleBlob()
                .aspectRatio(1/1, contentMode: .fit)
                .shadow(radius: 30, y: 20)
                .padding(60)
        }
    }
}
