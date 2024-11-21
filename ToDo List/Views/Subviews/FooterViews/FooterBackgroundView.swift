//
//  FooterBackgroundView.swift
//  ToDo List
//
//  Created by Adam Miziev on 19/11/24.
//

import SwiftUI

struct FooterBackgroundView: View {
    
    // MARK: - Body
    var body: some View {
        Rectangle()
            .fill(.customGray)
            .ignoresSafeArea()
            .frame(height: 80)
    }
}

#Preview {
    FooterBackgroundView()
}
