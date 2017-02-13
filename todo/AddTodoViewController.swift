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

    var dataObject : [String] = ["Hello","Bye","Good Night"];

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.projectsPicker.dataSource = self;
        self.projectsPicker.delegate = self;
    }
    
    @IBAction func touchUp(_ sender: Any) {
        print(self.todoText.text ?? "empty")
        print("touch")
    }
    
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.dataObject.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.dataObject[row];
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    }*/
}
