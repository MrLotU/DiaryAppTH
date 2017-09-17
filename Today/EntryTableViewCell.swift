//
//  EntryTableViewCell.swift
//  Today
//
//  Created by Jari Koopman on 01/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreLocation

class EntryTableViewCell: UITableViewCell {
    
    
    // MARK: Outlets and variables
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    
    var editingMode: Bool = false
    
    // MARK: DidSet Variables
    var stateImage: UIImage? {
        didSet{
            stateImageView.image = stateImage
        }
    }
    
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }
    
    var thumbnailImage: UIImage? {
        didSet{
            thumbnailImageView.image = thumbnailImage
        }
    }
    
    var content: String? {
        didSet{
            contentLabel.text = content
        }
    }
    
    var location: String? {
        didSet{
            locationlabel.text = location
            locationImageView.image = UIImage(named: "icn_geolocate")
        }
    }
    
    func setViewEditingMode(_ editingMode: Bool) {
        self.editingMode = editingMode
        if editingMode == true {
            self.stateImageView.isHidden = true
            self.titleLabel.isHidden = true
            self.thumbnailImageView.isHidden = true
            self.contentLabel.isHidden = true
            self.locationImageView.isHidden = true
            self.locationlabel.isHidden = true
            self.backgroundColor = UIColor(colorLiteralRed: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
        } else {
            self.stateImageView.isHidden = false
            self.titleLabel.isHidden = false
            self.thumbnailImageView.isHidden = false
            self.contentLabel.isHidden = false
            self.locationImageView.isHidden = false
            self.locationlabel.isHidden = false
            self.backgroundColor = UIColor.white
        }
    }
}
