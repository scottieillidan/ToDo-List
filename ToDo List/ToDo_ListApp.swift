//
//  ToDo_ListApp.swift
//  ToDo List
//
//  Created by Adam Miziev on 18/11/24.
//

import SwiftUI

@main
struct ToDo_ListApp: App {
    
    // MARK: - Properties
    let context = PersistenceController.shared.container.viewContext
    
    @StateObject var vm: ViewModel
    
    // MARK: - Initializer
    init() {
        let vm = ViewModel(context)
        
        self._vm = StateObject(wrappedValue: vm)
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ToDoList()
                .environment(\.managedObjectContext, context)
                .environmentObject(vm)
                .colorScheme(.dark)
        }
    }
}
