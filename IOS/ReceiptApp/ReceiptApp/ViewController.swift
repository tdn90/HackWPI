//
//  ViewController.swift
//  ReceiptApp
//
//  Created by Ryan Johnson on 1/18/19.
//  Copyright © 2019 Ryan Johnson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var usern: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.loadDefaults()
        if (appDelegate.token != nil) {
            activity.isHidden = false
            activity.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the desired number of seconds.
                self.activity.isHidden = true
                self.activity.stopAnimating()
                self.performSegue(withIdentifier: "LoginDoneSegue", sender: self)
            }
            print("Found Stored Token!")
        } else {
            print("No Stored Token!")
            activity.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func authfail() {
        let alert = UIAlertController(title: "Authentication Error", message: "Login Failed.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }

    @IBAction func login(_ sender: Any) {
        
        // Clear the cookies on a new login
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies(for: URL(string: appDelegate.url)!) {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
        activity.isHidden = false
        activity.startAnimating()
        Alamofire.request(appDelegate.url + "/users/sign_in", method: .post, parameters: ["user[email]": usern.text!, "user[password]": pass.text!, "user[remember_me]": 0, "commit": "Log in", "utf8": "✓", "mode": "json"]).responseString { response in
            if let result = response.result.value {
                let json = JSON(parseJSON: result)
                if (json["authentication_token"] == JSON.null) {
                    self.authfail()
                } else {
                    self.appDelegate.token = json["authentication_token"].rawString()!
                    self.appDelegate.email = json["user_email"].rawString()!
                    self.appDelegate.usern = json["user_name"].rawString()!
                    self.appDelegate.saveDefaults()
                    print(json["authentication_token"])
                    self.performSegue(withIdentifier: "LoginDoneSegue", sender: self)
                }
                self.activity.isHidden = true
                self.activity.stopAnimating()
            }
        }
    }
    
}

