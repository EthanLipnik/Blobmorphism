//
//  StackContentItem.swift
//  StackContentItem
//
//  Created by Ethan Lipnik on 8/5/21.
//

import SwiftUI

public struct StackContentItem<Item: View>: View, Hashable, Identifiable {
    @Environment(\.stackNavigationControls) var controls
    
    public static func == (lhs: StackContentItem<Item>, rhs: StackContentItem<Item>) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public let item: Item
    public let background: StackNavigationBackground
    public let id: UUID
    private let nspace: Namespace.ID?
    
    @State private var offset: CGSize = .zero
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    
    public init(namespace: Namespace.ID?, id: UUID = UUID(), @ViewBuilder item: @escaping () -> Item, background: StackNavigationBackground = StackNavigationBackground.default) {
        self.nspace = namespace
        self.id = id
        self.item = item()
        self.background = background
    }
    
    public var body: some View {
        let content = Group {
            item
                .background(background
                                .view
                                .frame(
                                    width: UIScreen.main.bounds.size.width,
                                    height: UIScreen.main.bounds.size.height)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: scale == 1 ? 0 : 60,
                                        style: .continuous))
                                .shadow(
                                    color: Color("Shadow"),
                                    radius: 30, y: 10))
            //            if blurredBackground {
            //                item
            //                    .background(RoundedBlob(cornerRadius: scale == 1 ? 0 : 60, intensity: .material).frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height).shadow(color: Color("Shadow"), radius: 30, y: 10))
            //            } else {
            //                item
            //                    .background(RoundedRectangle(cornerRadius: scale == 1 ? 0 : 60, style: .continuous).fill(Color.secondary).frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height).shadow(color: Color("Shadow"), radius: 30, y: 10))
            //            }
        }
            .offset(y: -5)
            .animation(.interactiveSpring(), value: scale)
        
        Group {
            if let nspace = nspace {
                content.matchedGeometryEffect(id: id, in: nspace)
            } else {
                content.transition(.move(edge: .trailing))
            }
        }
        .offset(offset)
        .scaleEffect(scale)
        .opacity(opacity)
        .animation(.interactiveSpring(), value: scale)
        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .global)
                    .onChanged({ value in
            guard value.startLocation.x <= 20 else { return }
            withAnimation(.spring()) {
                offset = CGSize(width: value.translation.width, height: value.translation.height / 5)
                scale = min(max(1 - (value.translation.width / 500), 0.85), 1)
            }
        })
                    .onEnded({ value in
            if value.translation.width >= 50 && value.startLocation.x <= 20 {
                withAnimation(.easeOut(duration: 0.4)) {
                    controls.pop()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    offset = .zero
                    scale = 1
                }
            } else {
                withAnimation(.spring()) {
                    offset = .zero
                    scale = 1
                }
            }
        }))
    }
}

public struct StackNavigationBackground {
    public var view: AnyView
    
    public static var `default`: StackNavigationBackground {
        return StackNavigationBackground(view: AnyView(RectangleBlob(intensity: .material)))
    }
    
    public static func custom<Content: View>(@ViewBuilder content: @escaping () -> Content) -> StackNavigationBackground {
        return StackNavigationBackground(view: AnyView(content()))
    }
}
