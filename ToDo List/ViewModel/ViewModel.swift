//
//  ViewModel.swift
//  ToDo List
//
//  Created by Adam Miziev on 18/11/24.
//

import Foundation
import CoreData

final class ViewModel: ObservableObject {
            
    @Published var tasks: [TaskEntity] = []
    
    init(_ context: NSManagedObjectContext) {
        self.refreshTasks(context)
    }
    
    /// Фильтрация для поиска.
    func filterTasks(by searchTerm: String) -> [TaskEntity] {
        var filtered: [TaskEntity] {
            guard !searchTerm.isEmpty else { return tasks }
            let prefix = tasks.filter { $0.title!.hasPrefix(searchTerm) }
            let contains = tasks.filter { $0.title!.localizedCaseInsensitiveContains(searchTerm) }
            return prefix.isEmpty ? contains : prefix
        }
        
        return filtered
    }
    
    /// Форматирование даты.
    func formatCreationDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Core Data
    /// Обновление данных.
    func refreshTasks(_ context: NSManagedObjectContext) {
        DispatchQueue.main.async {
            self.tasks = self.fetchTasks(context)
        }
    }
    
    /// Получение данных.
    func fetchTasks(_ context: NSManagedObjectContext) -> [TaskEntity] {
        var result: [TaskEntity] = []
        do {
            result =  try context.fetch(fetchRequest()) as [TaskEntity]
        } catch {
            print("Error fetching tasks.")
        }
        return result
    }
    
    /// Создание запроса на получение данных.
    func fetchRequest() -> NSFetchRequest<TaskEntity> {
        let request = TaskEntity.fetchRequest()
        request.sortDescriptors = sortOrder()
        return request
    }
    
    /// Сортировка данных по дате создания.
    func sortOrder() -> [NSSortDescriptor] {
        let sortedTasks = NSSortDescriptor(keyPath: \TaskEntity.creationDate, ascending: false)
        return [sortedTasks]
    }
    
    /// Сохранение данных в Core Data.
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
            self.refreshTasks(context)
        } catch {
            print("Error saving data.")
        }
    }
    
    /// Удаление задачи.
    func deleteTask(_ task: TaskEntity, _ context: NSManagedObjectContext) {
        context.delete(task)
        
        saveContext(context)
    }
    
    /// Добавление задачи.
    func addTask(_ task: TaskEntity?, from taskModel: TaskModel, _ context: NSManagedObjectContext) {
        
        var currentTask: TaskEntity? = task
        if currentTask == nil {
            currentTask = TaskEntity(context: context)
        }
        
        currentTask!.id = taskModel.id
        currentTask!.title = taskModel.title
        currentTask!.taskDescription = taskModel.taskDescription
        currentTask!.creationDate = taskModel.creationDate
        currentTask!.status = taskModel.status
        
        saveContext(context)
    }
    
    // MARK: - DummyJson
    func fetchDummyJson(_ context: NSManagedObjectContext) async {
        guard let url = URL(string: "https://dummyjson.com/todos") else { return }
        
        do {
            let data = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(DummyJsonModel.self, from: data.0) {
                decodedResponse.todos.forEach { todo in
                    let task = TaskEntity(context: context)
                    task.id = UUID()
                    task.title = todo.todo
                    task.creationDate = Date()
                    task.status = todo.completed
                }
                
                saveContext(context)
            }
        } catch {
            print("Coudn't get dummyJson!")
        }
    }
    
}
