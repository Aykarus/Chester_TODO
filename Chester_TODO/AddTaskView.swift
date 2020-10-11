//
//  AddTaskView.swift
//  Chester_TODO
//
//  Created by Chester Cari on 2020-10-07.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskViewModel : TaskViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var task_name = ""
    
    var body: some View {
        VStack{
            Spacer()
            TextField("Task Name", text: $task_name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            Button(action: {
                self.taskViewModel.insertTask(name: task_name, complete: false)
                self.presentationMode.wrappedValue.dismiss()
            }, label:{
                Text("Add Task")
                Image(systemName: "plus")
            })
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
