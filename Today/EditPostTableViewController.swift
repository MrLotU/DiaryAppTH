//
//  EditPostTableViewController.swift
//  Today
//
//  Created by Jari Koopman on 24/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreLocation

class EditPostTableViewController: UITableViewController {
    
    var entry: Entry!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneButtonPressed() {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditEntryTableViewCell
        cell.updateContent() { message in
            let alert = UIAlertController(title: "Something went wrong!", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editEntryCell", for: indexPath) as! EditEntryTableViewCell
        
        cell.tableViewController = self
        cell.entry = self.entry
        
        cell.setThumbnailButton.setImage(UIImage(data: entry.image!), for: .normal)
        cell.thumnailImage = UIImage(data: entry.image!)
        cell.content = entry.content
        cell.contentTextView.text = entry.content
        cell.state = entry.stateValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        cell.titleLabel.text = dateFormatter.string(from: Date())
        if let loc = entry.location {
            let location = loc.location
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                guard let placemarks = placemarks else { return }
                let placemark = placemarks[0]
                guard let name = placemark.name, let city = placemark.locality, let area = placemark.administrativeArea else { return }
                
                cell.addLocationButton.isHidden = true
                cell.locationLabel.isHidden = false
                cell.activityIndicator.isHidden = true
                cell.locationImageView.isHidden = false
                cell.locationLabel.text = "\(name), \(city), \(area)"
            }
        }
        return cell
    }
}
