//
//  UIItemTask.swift
//  TodoListA
//
//  Created by Gerson Isaias on 18/02/21.
//

import UIKit

class UIItemTask: UIView {

    private var labelText:UILabel!
    private var checkbox:CheckBox!
    public private(set) var task:Task!
    public var _delegate:TaskDelegate?
    
    func build(_ task:Task){
        labelText = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        labelText.text = task.name.uppercased()
        labelText.textColor = UIColor.link
        labelText.font = UIFont(name: "Arial Bold", size: 14.0)
        
        checkbox = CheckBox.init()
        checkbox.tag = task.id
        checkbox.frame = CGRect(x: self.frame.size.width-70, y: 25, width: 40, height: 40)
        checkbox.style = .tick
        checkbox.isChecked = task.done!
        checkbox.borderStyle = .roundedSquare(radius: 3)
        checkbox.addTarget(self, action: #selector(onCheckChanged(_:)), for: .valueChanged)
        self.backgroundColor = UIColor.white
        self.addSubview(labelText)
        self.addSubview(checkbox)
        
    }
    
    @objc func onCheckChanged(_ sender:CheckBox){
        if sender.isChecked {
            let tasks:[Task] = App.shared.tasks
            tasks.forEach { (task) in
                if(task.id == sender.tag){
                    task.wasDone()
                }
            }
        }
        _delegate?.onChangeDone()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
