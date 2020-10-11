//
//  TaskViewModel.swift
//  Chester_TODO
//
//  Created by Chester Cari on 2020-10-04.
//

import Foundation
import CoreData
import SwiftUI
import UIKit

public class TaskViewModel : ObservableObject{
    @Published var selectedTask : Task?
    @Published var taskList = [Task]()
    
    private let moc : NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertTask(name: String, complete: Bool){
        do{
            let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: moc) as! Task
            
            newTask.title = name
            newTask.completion = complete
            
            try moc.save()
            self.getAllTasks()
            
            print("Task successfully created")
            print(newTask)
            
        }catch let error as NSError{
            print("Something went wrong. Couldn't create Task.")
            print("\(error) \(error.localizedDescription)")
        }
    }
    
//    func findUserByEmail(email: String){
//        let fetchRequest = NSFetchRequest<User>(entityName: "User")
//
//        //filters WHERE - optional
//        let predicate = NSPredicate(format: "email == %@", email)
//        fetchRequest.predicate = predicate
//
//
//        //to sort the retrieved results ORDER BY - optional
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        do{
//            if let matchedUser = try moc.fetch(fetchRequest).first{
//                self.loggedInUser = matchedUser
//                print("Matching user found")
//            }
//        }catch let error as NSError{
//            print("Something went wrong. Couldn't fetch the user account details.")
//            print("\(error) \(error.localizedDescription)")
//        }
//    }
    
    func getAllTasks(){
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        do{
            let result = try moc.fetch(fetchRequest)
            taskList = result as [Task]
//            print(taskList)
            
        }catch let error as NSError{
            print(#function,"Couldn't fetch \(error)")
        }
    }
    
//    func updateUser(){
//        do{
//            try moc.save()
//            print(#function, "The user info has been updated successfully")
//        }catch let error as NSError{
//            print(#function, "unable to update info \(error.localizedDescription)")
//        }
//    }
    func toogleTask(task: Task){
        do{
            if(task.completion == true){
                task.completion = false;
            }else{
                task.completion = true;
            }
            try moc.save()
            print(#function, "The Task info has been toggled successfully")
            self.getAllTasks()
        }catch let error as NSError{
            print(#function, "unable to update info \(error.localizedDescription)")
        }
    }
    
    func deleteTask(task: Task){
        do{
            moc.delete(task)
            try moc.save()
            print(#function, "The Task info has been deleted successfully")
            self.getAllTasks()
        }catch let error as NSError{
            print(#function, "unable to update info \(error.localizedDescription)")
        }
    }

}
