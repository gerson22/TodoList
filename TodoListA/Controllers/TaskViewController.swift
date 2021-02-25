//
//  TaskViewController.swift
//  TodoListA
//
//  Created by Gerson Isaias on 18/02/21.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func save(_ sender: Any) {
        if !tfName.text!.isEmpty {
            let task = Task(tfName.text!, done: false)
            task.add {
                self.navigationController?.popViewController(animated: true)
            }
            
        }else{
            // Faltan campos
            let alert = UIAlertController(title: "Atencion", message:"El campo nombre no se oingreso correctamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style:.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y -= 10
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y += 10
        }
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
