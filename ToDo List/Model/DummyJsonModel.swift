//
//  DummyJsonModel.swift
//  ToDo List
//
//  Created by Adam Miziev on 20/11/24.
//

import Foundation

struct DummyJsonModel: Codable {
    var todos: [DummyJsonTodoModel]
    var total: Int
    var skip: Int
    var limit: Int
}

struct DummyJsonTodoModel: Codable, Identifiable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
}
