//
//  TaskCellView.swift
//  ToDo List
//
//  Created by Adam Miziev on 18/11/24.
//

import SwiftUI

struct TaskCellView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var vm: ViewModel
    
    var task: TaskEntity
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: task.status ? "checkmark.circle" : "circle")
                .iconImage(task.status)
                .onTapGesture {
                    if(!task.status) {
                        task.status = true
                        vm.saveContext(viewContext)
                    }
                }
                .animation(.default, value: task.status)
            TaskCellDescriptionView(task: task)
                .environmentObject(vm)
            Spacer()
        }
    }
}
