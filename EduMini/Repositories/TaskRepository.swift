//
//  TaskRepository.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 27/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class TaskRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadTasksData()
    }
    
    func loadTasksData() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addTask(_ task: Task){
        do {
            var addedTask = task
            addedTask.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task){
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTask(_ task: Task) {
        if let taskID = task.id {
            db.collection("tasks").document(taskID).delete { error in
                if let error = error {
                    print("Unable to delete task: \(error.localizedDescription)")
                } else {
                    print("Task deleted successfully.")
                }
            }
        }
    }
}
