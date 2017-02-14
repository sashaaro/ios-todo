
//
//  Repository.swift
//  todo
//
//  Created by Alex Danilin on 2/13/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit
import Alamofire

// API repository
class Repository: NSObject {
    let API_URL = "https://oblakotodo.herokuapp.com/api";
    
    // async fetch projects
    public func findProjects(callback: @escaping ([Project]) -> Void) {
        var projects = [Project]()
        Alamofire.request(self.API_URL + "/projects").responseJSON { response in
            if let JSON = response.result.value {
                let list = JSON as! [Dictionary<String, AnyObject>]
                for projectData in list {
                    let project = Project()
                    project.id = projectData["id"] as? Int
                    project.title = projectData["title"] as? String
                    
                    for todoData in projectData["todos"] as! [Dictionary<String, AnyObject>] {
                        let todo = Todo()
                        todo.id = todoData["id"] as? Int
                        todo.text = todoData["text"] as? String
                        todo.isCompleted = (todoData["isCompleted"] as? Bool)!
                        
                        project.todos.append(todo)
                    }
                    
                    projects.append(project)
                }
                callback(projects)
            } else {
                // TODO Repository Exception
                fatalError("Request project fail")
            }
        }
    }
    
    public func persistTodoStatus (todo: Todo) {
        let parameters: Parameters = [
            "id": todo.id,
            "isCompleted": todo.isCompleted
        ]
        Alamofire.request(self.API_URL + "/todo_change_status", method: .post, parameters: parameters).responseJSON { response in
            
        }
    }
    
    public func persistTodo(todo: Todo) {
        if (todo.id != nil) {
            fatalError("cant perist exists todo")
        }
        /*if (todo.project == nil) {
            fatalError("")
        }*/
        
        let parameters: Parameters = [
            "text": todo.text,
            "project_id": todo.project!.id
        ]
        
        Alamofire.request(self.API_URL + "/create_todo", method: .put, parameters: parameters).responseJSON { response in
            if (response.response?.statusCode == 200) {
                // TODO success callback
            } else {
                // TODO fetch errors 
                // TODO fail callback
                if let JSON = response.result.value {
                    print(JSON)
                }
            }
        }
    }
}
