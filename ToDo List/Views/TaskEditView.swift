//
//  TaskEditView.swift
//  ToDo List
//
//  Created by Adam Miziev on 20/11/24.
//

import SwiftUI

struct TaskEditView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var vm: ViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var task: TaskEntity?
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var creationDate: Date = Date()
    @State private var status: Bool = false
    
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isContentFocused: Bool
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Title", text: $title, axis: .vertical)
                    .titleFont()
                    .focused($isTitleFocused)
                    .submitLabel(.next)
                    .onChange(of: title, {
                        guard let newValueLastChar = title.last else { return }
                        if newValueLastChar == "\n" {
                            title.removeLast()
                            isContentFocused = true
                        }
                    })
                
                if let creationDate = task?.creationDate {
                    Text(vm.formatCreationDate(creationDate))
                        .dateFont()
                }
                
                TextField("Description", text: $content, axis: .vertical)
                    .bodyFont()
                    .focused($isContentFocused)
            }
            .padding(.horizontal, 20)
        }
        
        // MARK: - Navigation Bar
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - Tool Bar
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                /// Adding / Updating a task to Core Data.
                if((isTitleFocused || isContentFocused) && !title.isEmpty) {
                    Button("Done") {
                        withAnimation {
                            if isTitleFocused {
                                isTitleFocused = false
                            } else if isContentFocused {
                                isContentFocused = false
                            }
                            
                            DispatchQueue.main.async {
                                vm.addTask(
                                    task,
                                    from: TaskModel(
                                        title: title,
                                        taskDescription: content,
                                        creationDate: creationDate,
                                        status: status
                                    ),
                                    viewContext
                                )
                            }
                            
                            dismiss()
                        }
                    }
                }
            }
        }
        
        // MARK: - onAppear
        .onAppear {
            if let task = task {
                self.title = task.title!
                self.content = task.taskDescription ?? self.content
                self.creationDate = task.creationDate!
                self.status = task.status
            } else {
                isTitleFocused = true
            }
        }
    }
}
