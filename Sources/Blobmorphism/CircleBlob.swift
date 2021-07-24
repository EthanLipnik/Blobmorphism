//
//  CircleBlob.swift
//  CircleBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI

struct CircleBlob: View {
    
    var body: some View {
        Group {
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, *) {
                Circle()
                    .fill(Material.ultraThin)
            } else {
#if canImport(VisualEffects)
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
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
