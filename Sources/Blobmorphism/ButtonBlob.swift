//
//  ButtonBlob.swift
//  ButtonBlob
//
//  Created by Ethan Lipnik on 7/24/21.
//

import SwiftUI

struct ButtonBlob: View {
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .imageScale(.large)
        }
        .padding()
#if os(iOS)
        .contentShape(Circle())
        .hoverEffect()
#endif
        .background(CircleBlob())
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
                .shadow(radius: 30, y: 20)
                .padding(60)
        }
    }
}
