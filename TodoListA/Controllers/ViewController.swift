//
//  ViewController.swift
//  TodoListA
//
//  Created by Gerson Isaias on 18/02/21.
//
import Foundation
import UIKit

class ViewController: UIViewController, TaskDelegate {
    
    @IBOutlet weak var svListTask: UIStackView!
    @IBOutlet weak var scListTask: UIScrollView!
    var listDone = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    @IBAction func willAdd(_ sender: Any) {
        self.performSegue(withIdentifier: "sgTaskForm", sender: nil)
    }
    
    @IBAction func DoneOrDontDone(_ sender: UIBarButtonItem) {
        if(sender.tag == 0){
            sender.tag = 1
            sender.title = "Done"
            listDone = true
        }else{
            sender.title = "Not Done"
            sender.tag = 0
            listDone = false
        }
        self.loadData()
    }
    func loadData() {
        clearStackView();
        let height = 100
        let spacing = 10
        var positionY = 0
        App.shared.tasks = Task.all()
        if App.shared.tasks.count > 0 {
            var i = 0
            App.shared.tasks.reversed().filter({ $0.done == listDone }).forEach { (task) in
                let itemTask = UIItemTask(frame: CGRect(x: 0, y: positionY, width: Int(self.view.frame.size.width), height: height))
                itemTask._delegate = self
                itemTask.build(task)
                self.svListTask.addSubview(itemTask)
                i += 1
                positionY += height + spacing
            }
            
            scListTask.contentSize.height = CGFloat(App.shared.tasks.count * (height + spacing))
        }
    }
    
    func clearStackView(){
        self.svListTask.subviews.forEach { (itemtask) in
            itemtask.removeFromSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Aparecio")
        loadData()
    }
    
    func onChangeDone() {
        print("Cambio")
        self.loadData()
    }
    
}

