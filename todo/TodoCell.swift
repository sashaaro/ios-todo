//
//  TodoCell.swift
//  todo
//
//  Created by Alex Danilin on 2/9/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

public class TodoCell: UITableViewCell
{
    @IBOutlet public weak var checkBox: M13Checkbox!
    
    public var todo: Todo? // TODO not use now. maybe remove
    private let repository: Repository = Repository(); // TODO remove. will be Injected?!
    
    @IBAction func toggleCheckbox(_ sender: M13Checkbox) {
        self.todo?.isCompleted = sender.checkState.rawValue == "Checked"
        self.repository.persistTodoStatus(todo: self.todo!)
    }
    
    // TODO use that method
    public func beforeRender() {
        self.textLabel?.text = self.todo?.text

        if (self.todo?.isCompleted == true) {
            self.checkBox.checkState = M13Checkbox.CheckState(rawValue: "Checked")!
        } else {
            self.checkBox.checkState = M13Checkbox.CheckState(rawValue: "Unchecked")!
        }
    }

}
