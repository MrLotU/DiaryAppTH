//
//  NewEntryTableViewCell.swift
//  Today
//
//  Created by Jari Koopman on 22/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreLocation

class NewEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var setAverageButton: UIButton!
    @IBOutlet weak var setBadButton: UIButton!
    @IBOutlet weak var setGoodButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryTexView: UITextView!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var numberOfCharsLabel: UILabel!
    @IBOutlet weak var setThumbnailButton: UIButton!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var thumnailImageView: UIImageView!
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
    fileprivate var locationManager: LocationManager!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case setAverageButton:
            if self.state == .average {
                self.state = .none
            } else {
            self.state = .average
            }
        case setGoodButton:
            if self.state == .happy {
                self.state = .none
            } else {
                self.state = .happy
            }
        case setBadButton:
            if self.state == .bad {
                self.state = .none
            } else {
                self.state = .bad
            }
        case setThumbnailButton: break
        case addLocationButton:
            self.getLocation()
        default: break
        }
    }
    
    func saveContent() {
        Entry.entryWith(self.content, location: self.location, image: self.thumnailImage, state: self.state)
    }
    
    func getLocation() {
        activityIndicator.isHidden = false
        locationImageView.isHidden = true
        activityIndicator.startAnimating()
        
        locationManager = LocationManager()
        locationManager.onLocationFix = { placemark, error in
            if let placemark = placemark {
                self.location = placemark.location
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.locationImageView.isHidden = false
                self.addLocationButton.isHidden = true
                self.addLocationButton.isEnabled = false
                
                guard let name = placemark.name, let city = placemark.locality, let area = placemark.administrativeArea else { return }
                
                self.locationLabel.text = "\(name), \(city), \(area)"
            }
        }
    }
    
    override func awakeFromNib() {
        activityIndicator.isHidden = true
        locationImageView.isHidden = false
        
        self.entryTexView.delegate = self
        
        self.numberOfCharsLabel.text = "0 / 200"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        
        self.titleLabel.text = dateFormatter.string(from: Date())
    }
}

//MARK: - UITextViewDelegate

extension NewEntryTableViewCell: UITextViewDelegate {
    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        if textView.text.characters.count >= 200 {
//            return true
//        } else {
//            return false
//        }
//    }
//
//
    
    func textViewDidChange(_ textView: UITextView) {
        let characters = textView.text.characters
        let charCount = characters.count
        if charCount > 200 {
            textView.text = self.content
        } else {
            self.content = textView.text
            self.numberOfCharsLabel.text = "\(charCount) / 200"
        }
    }
}
