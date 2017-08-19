//
//  UploadViewController.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 17/08/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit
import Alamofire
class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var disease : Disease!
    var diseaseDesc : String!
    var diseaseCure : String!
    let picker = UIImagePickerController()
    var postImage : UIImage!
    var diseaseName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }

    @IBAction func uploadButtonPressed(_ sender: RoundButton) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ResultSuccess"
        {
            if let resultVC = segue.destination as? DiagnosisResultsViewController
            {
                if let diseaseInfo = sender as? Disease
                {
                    resultVC.disease = diseaseInfo
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.postImage = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(UIImageJPEGRepresentation(self.postImage!, 1)!, withName: "image", fileName: "Crops_Image.jpeg", mimeType: "image/jpeg")
        }, to:"http://192.168.43.100:8001/apiupload/")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                print(result)
                
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                
                upload.responseJSON { (response)  in
                    //print response.result
                    print(response)
                    if let dict = response.result.value as? [String:AnyObject]
                    {
                        print(dict)
                        if let dis = dict["disease"] as? [String:String]
                        {
                            if let diseaseName = dis["name"]
                            {
                                if let diseaseDesc = dis["desc"]
                                {
                                    if let diseaseCure = dis["cure"]
                                    {
                                        self.diseaseName = diseaseName
                                        self.diseaseDesc = diseaseDesc
                                        self.diseaseCure = diseaseCure
                                        let dis = Disease(name: diseaseName, desc: diseaseDesc, cure: diseaseCure,img: self.postImage)
                                        self.performSegue(withIdentifier: "ResultSuccess", sender: dis)
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError);
            }
        }
        
    }
    
    
}
