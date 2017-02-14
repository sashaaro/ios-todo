//
//  AddTodoViewController.swift
//  todo
//
//  Created by Alex Danilin on 2/13/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var todoText: UITextField!
    @IBOutlet weak var projectsPicker: UIPickerView!

    let repository: Repository = Repository();
    var projects = [Project]()
    
    var selectedProject: Project?;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.projectsPicker.dataSource = self;
        self.projectsPicker.delegate = self;
        
        self.repository.findProjects(callback: { projects in
            self.projects = projects
            self.selectedProject = self.projects.first
            self.projectsPicker.reloadAllComponents()
        })
        
        self.todoText.placeholder = "Введите задачу.."
    }
    
    @IBAction func add(_ sender: Any) {
        let todo = Todo()
        todo.text = self.todoText.text!
        todo.project = self.selectedProject
        repository.persistTodo(todo: todo)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.projects.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.projects[row].title;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedProject = self.projects[row]
    }
}
