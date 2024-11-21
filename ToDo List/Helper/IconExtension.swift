//
//  IconExtension.swift
//  ToDo List
//
//  Created by Adam Miziev on 18/11/24.
//

import SwiftUI

extension Image {
    func iconImage(_ status: Bool = false) -> some View {
        self
            .font(.title2)
            .foregroundStyle(status ? .accent : .stroke)
    }
}

struct IconExtension: View {
    
    // MARK: - Body
    var body: some View {
        Image(systemName: "circle")
            .iconImage()
    }
}

#Preview {
    IconExtension()
}
