//
//  ReceiptAddViewController.swift
//  ReceiptApp
//
//  Created by Ryan Johnson on 1/19/19.
//  Copyright © 2019 Ryan Johnson. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ReceiptAddViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var kbdh:CGFloat = 0
    var data:JSON?
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    var groups:[Int:String] = [:]
    
    func isDouble(s:String) -> Bool {
        
        if let doubleValue = Double(s) {
            
            if doubleValue >= 0 {
                return true
            }
        }
        
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups[ Array(groups.keys)[row]]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ReceiptAddViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReceiptAddViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(ReceiptLineitem.doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.name.inputAccessoryView = toolbar
        
        Alamofire.request(appDelegate.url + "/api/v1/listgroup", method: .get, parameters: ["user_email": appDelegate.email!, "user_token": appDelegate.token!]).responseString { response in
            if let result = response.result.value {
                print(result)
                let json = JSON(parseJSON: result)
                print("json")
                print(json)
                for (key, subJson) in json {
                    if let title = subJson.string {
                        self.groups[Int(key)!] = title;
                    }
                }
                print(self.groups)
                self.picker.reloadAllComponents()
            }
        }
        
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.height == UIScreen.main.bounds.height {
                //self.view.frame.origin.y -= keyboardSize.height
                if (self.kbdh == 0) {
                    self.kbdh = keyboardSize.height
                }
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: UIScreen.main.bounds.height - self.kbdh)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: UIScreen.main.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.dictionary!["result"]!.array!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReceiptLineitem = tableView.dequeueReusableCell(withIdentifier: "lineitemIdentifier", for: indexPath) as! ReceiptLineitem
        let json:[JSON] = data!.dictionary!["result"]!.array![indexPath.row].array!
        cell.name.text = json[0].string!
        if (json[1].string != nil) {
            cell.price.text = json[1].string!
        }
        cell.tableView = self;
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            if var el:JSON = (self.data?.dictionary?["result"]) {
                el.arrayObject?.remove(at: indexPath.row)
                self.data?.dictionaryObject?["result"] = el
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print("FAIL")
            }
            
           
        }
    }
    @IBAction func addRow(_ sender: Any) {
        if var el:JSON = (self.data?.dictionary?["result"]) {
            el.arrayObject?.append(JSON(parseJSON: "[\"\", \"\"]"))
            self.data?.dictionaryObject?["result"] = el
            tbleView.reloadData()
        } else {
            print("FAIL")
        }
    }
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        var ok = true
        for tr:ReceiptLineitem in self.tbleView!.visibleCells as! [ReceiptLineitem] {
            if (tr.name.text! == "" || tr.price.text == nil || tr.price.text! == "" || !isDouble(s: tr.price.text!) || self.name.text! == "")  {
                ok = false
                break
            }
        }
        if (groups.count == 0) {
            ok = false
        }
        if (ok) {
            Alamofire.request(appDelegate.url + "/receipts/create", method: .post, parameters: ["user_email": appDelegate.email!, "user_token": appDelegate.token!, "lineItems": data!.dictionary!["result"]!.rawString()!, "groupID":  Array(groups.keys)[picker.selectedRow(inComponent: 0)], "description":"", "name":self.name.text!]).responseString { response in
                if let result = response.result.value {
                    print(result)
                    let json = JSON(parseJSON: result)
                    if (json["status"].string != nil && json["status"].string! == "OK") {
                        self.dismiss(animated: true, completion: nil)
                    }
                    print(json)
                } else {
                    let alert = UIAlertController(title: "Error", message: "That didn't work", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Validation Error", message: "Please fill out all form fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}
