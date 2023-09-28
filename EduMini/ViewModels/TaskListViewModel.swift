//
//  TaskListViewModel.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    
    @Published var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        taskRepository.$tasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.taskCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task)
    }
    
    func updateTask(task: Task) {
        taskRepository.updateTask(task)
    }
    
    func deleteTask(task: Task) {
        taskRepository.deleteTask(task)
    }
}
