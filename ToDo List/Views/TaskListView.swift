//
//  TaskListView.swift
//  ToDo List
//
//  Created by Adam Miziev on 20/11/24.
//

import SwiftUI

struct TaskListView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var vm: ViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var tasks: [TaskEntity]
    
    // MARK: - Body
    var body: some View {
        List(tasks, id: \.id) { task in
            NavigationLink {
                TaskEditView(task: task)
                    .environmentObject(vm)
            } label: {
                TaskCellView(task: task)
                    .environmentObject(vm)
                    .contextMenu {
                        
                        /// Edit.
                        NavigationLink{
                            TaskEditView(task: task)
                                .environmentObject(vm)
                        } label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                        
                        /// Share.
                        ShareLink(
                            "Share",
                            item: task.title ?? "Task",
                            preview: SharePreview(task.title ?? "Task")
                        )
                        
                        /// Detete.
                        Button {
                            withAnimation {
                                DispatchQueue.main.async {
                                    vm.deleteTask(task, viewContext)
                                }
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .foregroundStyle(.customRed, .customRed)
                        }
                    }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(.zero))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                Divider()
                    .opacity(tasks.last == task ? 0 : 1)
                    .padding(.horizontal, 20),
                alignment: .bottom
            )
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .padding(.bottom, 80)
    }
}
