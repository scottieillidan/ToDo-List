//
//  FontExtension.swift
//  ToDo List
//
//  Created by Adam Miziev on 18/11/24.
//

import SwiftUI

extension Text {
    
    func titleFont(_ status: Bool = false) -> some View {
        self
            .font(
                .system(
                    size: 16,
                    weight: .medium
                )
            )
            .strikethrough(status)
            .opacity(status ? 0.5 : 1)
            .animation(.default, value: status)
    }
    
    func bodyFont(_ status: Bool = false) -> some View {
        self
            .font(
                .system(
                    size: 12
                )
            )
            .lineLimit(2)
            .opacity(status ? 0.5 : 1)
            .animation(.default, value: status)
    }
    
    func dateFont() -> some View {
        self
            .font(
                .system(
                    size: 12
                )
            )
            .opacity(0.5)
    }
}

extension TextField {
    
    func titleFont() -> some View {
        self
            .font(
                .system(
                    size: 34,
                    weight: .bold
                )
            )
    }
    
    func bodyFont() -> some View {
        self
            .font(
                .system(
                    size: 16
                )
            )
    }
}

struct FontExtension: View {
    
    // MARK: - Body
    var body: some View {
        Text("Title Font")
            .titleFont()
        Text("Body Font")
            .bodyFont()
        Text("18/11/24")
            .dateFont()
    }
}

#Preview {
    FontExtension()
}
