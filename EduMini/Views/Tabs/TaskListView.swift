//
//  TaskListView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 13/08/2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    let tasks = testDataTask
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    List {
                        Section {
                            ForEach(taskListVM.taskCellViewModels.indices, id: \.self) { index in
                                let taskCellVM = taskListVM.taskCellViewModels[index]
                                TaskCell(taskCellVM: taskCellVM)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button(action: {
                                            if index < taskListVM.taskCellViewModels.count {
                                                let taskToDelete = taskListVM.taskCellViewModels[index].task
                                                self.taskListVM.deleteTask(task: taskToDelete)
                                            }
                                        }) {
                                            Image(systemName: "trash.fill")
                                        }
                                        .tint(.red)
                                        
                                    }
                            }
                            .listRowSeparatorTint(Color("DarkBabyBlueColor"))
                            
                            if presentAddNewItem {
                                TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                                    self.taskListVM.addTask(task: task)
                                    self.presentAddNewItem.toggle()
                                }
                            }
                        } header: {
                            Text("Do zrobienia")
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                                .foregroundColor(Color.white)
                                .textCase(.none)
                                .shadow(radius: 2)

                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(
                        Image("profileBG")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .edgesIgnoringSafeArea(.all)
                            .background(Color.clear)
                    )

                    
                    
                    Button(action: { self.presentAddNewItem.toggle() }) {
                        HStack {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.width * 0.1)
                                .foregroundColor(Color.secondary)
                                .shadow(radius: 2)
                            
                            Text("Dodaj nowe zadanie")
                                .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                                .foregroundColor(Color.secondary)
                                .shadow(radius: 1)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
                .foregroundColor(Color("DarkBabyBlueColor"))
            
            TextField("Wprowadź nazwę zadania", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
            .foregroundColor(Color.black.opacity(0.8))
            .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.04))
            .autocorrectionDisabled()
        }
    }
}
