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
    
    
    // MARK: - Outlets
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    
    // MARK: - DidSet Variables
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
