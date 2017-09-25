//
//  EditEntryTableViewCell.swift
//  Today
//
//  Created by Jari Koopman on 25/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreLocation

class EditEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var setAverageButton: UIButton!
    @IBOutlet weak var setBadButton: UIButton!
    @IBOutlet weak var setGoodButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var numberOfCharsLabel: UILabel!
    @IBOutlet weak var addThumbnailButton: UIButton!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var state: Entry.EntryState = .none {
        didSet {
            switch self.state {
            case .happy: stateImageView.image = UIImage(named: "icn_happy")
            case .bad: stateImageView.image = UIImage(named: "icn_bad")
            case .average: stateImageView.image = UIImage(named: "icn_average")
            case .none: stateImageView.image = nil
            }
        }
    }
    
    var location: CLLocation?
    var content: String!
    var thumnailImage: UIImage?
    var entry: Entry!
    fileprivate var locationManager: LocationManager!
    var tableViewController: UITableViewController!
    
    lazy var imagePicker: ImagePicker = {
        let picker = ImagePicker(presentingViewController: self.tableViewController)
//        picker.delegate = self
        return picker
    }()
    
    func updateContent(completion: (String) -> ()) {
        if let image = self.thumnailImage {
            entry.addImage(image)
        }
        if let loc = self.location {
            entry.addLocation(loc)
        }
        if content != nil && content != "" {
            entry.content = content
        } else {
            completion("Entry content can't be empty!")
        }
        entry.date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        entry.title = dateFormatter.string(from: Date())
        entry.setState(self.state)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
