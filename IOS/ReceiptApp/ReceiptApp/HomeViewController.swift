//
//  HomeViewController.swift
//  ReceiptApp
//
//  Created by Ryan Johnson on 1/19/19.
//  Copyright © 2019 Ryan Johnson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var data:JSON?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func Logout(_ sender: Any) {
        appDelegate.clearDefaults();
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func displayActionSheet(_ sender: Any) {
        
        ImagePickerManager().pickImage(self) { image in
            print("\n\n\nIMG\n\n\n")
            
            let imgData = image.jpegData(compressionQuality: 0.2)
            
            let parameters = ["user_email": self.appDelegate.email!, "user_token": self.appDelegate.token!] //Optional for extra parameter
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData!, withName: "fileset",fileName: "pict.png", mimeType: "image/jpg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                } //Optional for extra parameters
            }, to: self.appDelegate.url + "/api/v1/receiptPhotoTranscribe")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseString { response in
                        self.data = JSON(parseJSON: response.result.value!)
                        print(self.data)
                        self.performSegue(withIdentifier: "receiptaddsegue", sender: self)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ReceiptAddViewController
        {
            let vc = segue.destination as? ReceiptAddViewController
            vc?.data = self.data
        }
    }


}

