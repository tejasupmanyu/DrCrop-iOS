//
//  DiagnosisResultsViewController.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 17/08/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit

class DiagnosisResultsViewController: UIViewController {

    var disease: Disease!
    @IBOutlet weak var TreatmentLabel: UILabel!
    @IBOutlet weak var DiseaseLabel: UILabel!
    @IBOutlet weak var submittedImageView: UIImageView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let dname = disease.diseaseName
        {
            if let ddesc = disease.diseaseDesc
            {
                if let dcure = disease.diseaseCure
                {
                    if let dimg = disease.img
                    {
                        DiseaseLabel.text = dname
                        DescriptionLabel.text = ddesc
                        submittedImageView.image = dimg
                        TreatmentLabel.text = dcure
                    }
                    
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
