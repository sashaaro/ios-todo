//
//  ProjectSelectedCell.swift
//  todo
//
//  Created by Alex Danilin on 2/14/17.
//  Copyright © 2017 Alex Danilin. All rights reserved.
//

import UIKit

public class ProjectSelectedCell: UITableViewCell {
    
    @IBOutlet weak var doneImageView: UIImageView!
    
    
    
    public func updateViewElements() {
        //self.selectionStyle =  UITableViewCellSelectionStyle.none // remove selection style
        
        //let image = UIImage();
    
        self.doneImageView.image = self.doneImageView.image!.withRenderingMode(.alwaysTemplate)
        self.doneImageView.tintColor = UIColor.green
        //self.tintColorDidChange()
        //self.doneImageView.isHidden = !self.isSelected;
    }
    

    
    
    
}

