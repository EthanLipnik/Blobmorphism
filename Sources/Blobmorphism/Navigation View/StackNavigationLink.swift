//
//  StackNavigationLink.swift
//  StackNavigationLink
//
//  Created by Ethan Lipnik on 8/5/21.
//

import SwiftUI

public struct StackNavigationLink<Destination: View, Label: View>: View {
    public let style: Style
    public let matchGeometry: Bool
    public let destination: Destination
    public let label: Label
    public let background: StackNavigationBackground
    private let id: UUID = UUID()
    
    @State private var isInteracting: Bool = false
    
    @Namespace var nspace
    
    public enum Style {
        case button
        case card
    }
    
    @Environment(\.stackNavigationControls) var controls
    
    public init(style: Style = .button, matchGeometry: Bool = false, background: StackNavigationBackground = .default, @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
        self.style = style
        self.matchGeometry = matchGeometry
        self.destination = destination()
        self.label = label()
        self.background = background
    }
    
    public var body: some View {
        Group {
            switch style {
            case .button:
                Button(action: push) {
                    label
                }
            case .card:
                Group {
                    if matchGeometry {
                        label.matchedGeometryEffect(id: id, in: nspace, properties: .position)
                    } else {
                        label
                    }
                }
                .scaleEffect(isInteracting ? 0.9 : 1)
                .animation(.spring(), value: isInteracting)
                .onTapGesture(perform: push)
                .onLongPressGesture { isPressing in
                    self.isInteracting = isPressing
                } perform: {}
                .onHover { isHovering in
                    isInteracting = isHovering
                }
            }
        }
    }
    
    private func push() {
        controls.push(StackContentItem(namespace: matchGeometry ? nspace : nil, id: id, item: {
            AnyView(destination)
        }, background: background))
    }
}

struct StackNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        StackNavigationView {
            StackNavigationLink {
                Text("Hey")
            } label: {
                Text("Go to next item")
            }
        }
    }
}
