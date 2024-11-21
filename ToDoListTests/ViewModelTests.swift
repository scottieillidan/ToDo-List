//
//  Test.swift
//  ToDoListTests
//
//  Created by Adam Miziev on 21/11/24.
//

import SwiftUI
import XCTest
@testable import ToDo_List

final class ViewModelTests: XCTestCase {
    
    let viewContext = PersistenceController.shared.container.viewContext
    @ObservedObject var vm = ViewModel(PersistenceController.shared.container.viewContext)
    let date = Date()
    
    func testDeleteNonExistentTask() {
        // Arrange
        // Act
        vm.deleteTask(TaskEntity(context: viewContext), viewContext)
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.vm.tasks.count, 0)
        }
    }
    
    func testTasksEqual() {
        // Arrange
        let task = TaskModel(
            title: "Title",
            taskDescription: "Body",
            creationDate: date,
            status: false
        )
        
        // Act
        vm.addTask(nil, from: task, viewContext)
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.vm.tasks[0].title, "Title")
            XCTAssertEqual(self.vm.tasks[0].taskDescription, "Body")
            XCTAssertEqual(self.vm.tasks[0].status, false)
        }
        
    }
    
    func testDeleteTask() {
        // Arrange
        let task = TaskModel(
            title: "Task to delete",
            taskDescription: "Task Description",
            creationDate: Date(),
            status: false
        )
        
        vm.addTask(nil, from: task, viewContext)
        
        let counter = vm.tasks.count
        
        // Act
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let taskToDelete = self.vm.tasks[0]
            self.vm.deleteTask(taskToDelete, self.viewContext)
        }
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(counter, counter - 1)
        }
    }
    
    func testChangeTaskStatus() {
        // Arrange
        let task = TaskModel(
            title: "Task for status change",
            taskDescription: "Task Description",
            creationDate: Date(),
            status: false
        )
        
        vm.addTask(nil, from: task, viewContext)

        // Act
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let taskToChangeStatus = self.vm.tasks[0]
            taskToChangeStatus.status = true
            self.vm.saveContext(self.viewContext)
        }
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.vm.tasks[0].status)
        }
    }
    
    func testTasksNotEqual() {
        // Arrange
        let task = TaskModel(
            title: "Title",
            taskDescription: "Body",
            creationDate: date,
            status: false
        )
        
        // Act
        vm.addTask(nil, from: task, viewContext)
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotEqual(self.vm.tasks[0].title, "Body")
            XCTAssertNotEqual(self.vm.tasks[0].taskDescription, "Title")
            XCTAssertNotEqual(self.vm.tasks[0].status, true)
        }
        
    }
    
    func testTaskNil() {
        // Arrange
        // Act
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(self.vm.tasks[self.vm.tasks.count])
        }
    }
    
}
