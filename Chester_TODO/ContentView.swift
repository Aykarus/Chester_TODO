//
//  ContentView.swift
//  Chester_TODO
//
//  Created by Chester Cari on 2020-10-04.
//

import SwiftUI

//struct Taskss:Identifiable, Hashable {
//    var id = UUID()
//    var name: String
//    var compl: Bool
//
//}

struct ContentView: View {
    @EnvironmentObject var taskViewModel : TaskViewModel
    //    @State private var taskssList = [Task]()
    @State private var selection: Int? = 0
    @State private var taskList = [Task]()
    
    var body: some View {
        
        NavigationView{
            ZStack{
                List{
                    ForEach(self.taskViewModel.taskList, id:\.self){task in
                        HStack{
                            Text("\(task.title ?? "Unknown")")
                            Spacer()
                            if(task.completion == true){
                                Image(systemName: "checkmark.circle")
                            }else{
                                Image(systemName: "circle")
                                
                            }
                            //                            Text("\(String(task.completion))")
                        }.onTapGesture{
                            //                            task.completion = true;
                            self.taskViewModel.toogleTask(task: task)
//                            print("\(task.title ?? "Unknown" )")
                        }
                    }//ForEach
                    .onDelete{(indexSet) in
                        for index in indexSet{
                            //                        taskssList.remove(at: index)
                            self.taskViewModel.deleteTask(task: self.taskViewModel.taskList[index])
                        }
                    }
                }//List
                .navigationBarTitle("To Do", displayMode: .inline)
                .toolbar{
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            self.selection = 1
                            print("selction 2 pressed")
                        }, label:{
                            Image(systemName: "plus")
                        })
                    }
                }//toolbar
                
                NavigationLink(destination: AddTaskView(), tag: 1, selection: $selection){}.hidden()
                
            }//Zstack
            
            
        }//NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            //            self.loadFakeData()
            self.taskViewModel.getAllTasks()
            taskList = self.taskViewModel.taskList
            print(taskList)
            //            for task in self.taskViewModel.taskList{
            //                print(#function,"Name: \(task.title ?? "unknown")")
            //            }
        }
    }
    
    func loadFakeData(){
        //        let task1 = Taskss(name: "Hello task 1", compl: false)
        //        let task2 = Taskss(name: "Hello task 2", compl: true)
        //        let task3 = Taskss(name: "Hello task 3", compl: false)
        //
        //        self.taskssList.append(task1)
        //        self.taskssList.append(task2)
        //        self.taskssList.append(task3)
        
        //        self.taskViewModel.insertTask(name: "Hello new Task", complete: false)
        
    }
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
