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
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var editPostButton: UIButton!
    @IBOutlet weak var deletePostButton: UIButton!
    
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
            if location != nil && location != "" {
                locationImageView.image = UIImage(named: "icn_geolocate")
            }
        }
    }
    
    var entry: Entry!
    
    // MARK: Functions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case addImageButton: print("Pressed the add image button! Woah!")
        case editPostButton: print("Pressed the edit post button! Woah!")
        case deletePostButton: print("Pressed the delete post button! Woah!")
        default: print("How even did you get here? This shouldn't be possible")
        }
    }
    
    override func awakeFromNib() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.height / 2
        thumbnailImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.stateImageView.isHidden = true
            self.titleLabel.isHidden = true
            self.thumbnailImageView.isHidden = true
            self.contentLabel.isHidden = true
            self.locationImageView.isHidden = true
            self.locationlabel.isHidden = true
            self.addImageButton.isHidden = false
            self.editPostButton.isHidden = false
            self.deletePostButton.isHidden = false
            self.backgroundColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
        } else {
            self.stateImageView.isHidden = false
            self.titleLabel.isHidden = false
            self.thumbnailImageView.isHidden = false
            self.contentLabel.isHidden = false
            self.locationImageView.isHidden = false
            self.locationlabel.isHidden = false
            
            self.addImageButton.isHidden = true
            self.editPostButton.isHidden = true
            self.deletePostButton.isHidden = true

            
            self.stateImageView.image = self.stateImage
            self.titleLabel.text = title
            self.thumbnailImageView.image = thumbnailImage
            self.contentLabel.text = content
            self.locationlabel.text = location
            if location != nil && location != "" {
                locationImageView.image = UIImage(named: "icn_geolocate")
            }
            
            self.backgroundColor = UIColor.white
        }
    }
}

extension EntryTableViewCell: ImagePickerDelegate {
    func imagePicker(_ picker: ImagePicker, didFinishPickingImage image: UIImage) {
        picker.dismissImagePickerController(animated: true) {
            self.thumbnailImage = image
            self.entry.addImage(image)
        }
    }
}

