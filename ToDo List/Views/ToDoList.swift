//
//  ToDoList.swift
//  ToDo List
//
//  Created by Adam Miziev on 18/11/24.
//

import SwiftUI

struct ToDoList: View {
    
    // MARK: - Properties
    @EnvironmentObject private var vm: ViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("firstLaunch") private var firstLaunch: Bool = true
    
    @State private var searchTerm = ""
    
    @FocusState private var searchFocused: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                // MARK: - List
                TaskListView(tasks: vm.filterTasks(by: searchTerm))
                    .environmentObject(vm)
                
                // MARK: - Footer
                FooterView(tasks: vm.filterTasks(by: searchTerm))
            }
            
            // MARK: - Navigation Bar
            .navigationTitle("Tasks")
            .searchable(text: $searchTerm, prompt: "Search")
            .focused($searchFocused)
            
            // MARK: - ToolBar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if firstLaunch {
                        ProgressView()
                    }
                }
            }
            
            /// Загрузка DummyJson, при первом запуске.
            .task {
                if firstLaunch {
                    await vm.fetchDummyJson(viewContext)
                    firstLaunch = false
                }
            }
        }
    }
}

#Preview {
    @Previewable var vm = ViewModel(PersistenceController.shared.container.viewContext)
    let context = PersistenceController.shared.container.viewContext
    
    ToDoList()
        .environment(\.managedObjectContext, context)
        .environmentObject(vm)
        .colorScheme(.dark)
}
