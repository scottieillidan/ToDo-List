//
//  FooterView.swift
//  ToDo List
//
//  Created by Adam Miziev on 19/11/24.
//

import SwiftUI

struct FooterView: View {
    
    // MARK: - Properties
    var tasks: [TaskEntity]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            FooterBackgroundView()
            Text("\(tasks.count) Tasks")
                .bodyFont()
            NavigationLink {
                TaskEditView(task: nil)
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .iconImage(true)
                        .padding(.trailing, 30)
                }
            }
            
        }
    }
}
