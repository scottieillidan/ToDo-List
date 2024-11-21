//
//  TaskCellDescriptionView.swift
//  ToDo List
//
//  Created by Adam Miziev on 19/11/24.
//

import SwiftUI

struct TaskCellDescriptionView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var vm: ViewModel
    
    var task: TaskEntity
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(task.title ?? "")
                .titleFont(task.status)
            if let description = task.taskDescription, description != "" {
                Text(description)
                    .bodyFont(task.status)
            }
            if let date = task.creationDate {
                Text(vm.formatCreationDate(date))
                    .dateFont()
            }
            
        }
        .padding(.vertical, 5)
    }
}
