//
//  ImagePicker.swift
//  Today
//
//  Created by Jari Koopman on 24/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol ImagePickerDelegate: class {
    func imagePicker(_ picker: ImagePicker, didFinishPickingImage image: UIImage)
}

class ImagePicker: NSObject {
    
    fileprivate let imagePickerController = UIImagePickerController()
    fileprivate let presentingViewController: UIViewController
    
    weak var delegate: ImagePickerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        super.init()
        
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .rear
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
    }
    
    func presentImagePickerController() {
        presentingViewController.present(imagePickerController, animated: true, completion: nil)
    }
    
    func dismissImagePickerController(animated: Bool, completion: @escaping (() -> Void)) {
        imagePickerController.dismiss(animated: animated, completion: completion)
    }
    
}

extension ImagePicker: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagePicker(self, didFinishPickingImage: image)
    }
}
