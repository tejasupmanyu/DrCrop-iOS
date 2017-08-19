//
//  Disease.swift
//  DrCrop
//
//  Created by Tejas Upmanyu on 18/08/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit

class Disease: NSObject {

    var diseaseName: String!
    var diseaseDesc: String!
    var diseaseCure: String!
    var img : UIImage!
    init(name: String, desc : String, cure: String, img : UIImage) {
        self.diseaseName = name
        self.diseaseDesc = desc
        self.diseaseCure = cure
        self.img = img
    }
}
