//
//  ImagePickerManager.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright (c) 2019 Veer Suthar. All rights reserved.

import Foundation
import UIKit
import Photos

enum ImagePickerType: Int {
    case camera = 0
    case gallery
    
    func getSourceType() -> UIImagePickerController.SourceType {
        switch self {
            
        case .camera:
            return .camera
        case .gallery:
            return .photoLibrary
        }
    }
}

protocol IImagePickerManager: class {
    // do someting...
    
    func openImagePicker(sourceType: ImagePickerType, delegate: ImagePickerDelegate)
}

protocol ImagePickerDelegate: class {
    // do someting...
    func didSelectImage(image: UIImage)
    func didCancel()
}

class ImagePickerManager: NSObject, IImagePickerManager {
    
    // do someting...
    static let shared = ImagePickerManager()
    weak var delegate: ImagePickerDelegate?
    
    private var pickerController: UIImagePickerController? = nil
    
    private override init() { }
    
    deinit { }
    
    func openImagePicker(sourceType: ImagePickerType, delegate: ImagePickerDelegate) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType.getSourceType()) {
            self.pickerController = UIImagePickerController()
            self.pickerController?.delegate = self
            self.pickerController?.allowsEditing = true
            self.pickerController?.mediaTypes = ["public.image"]
            self.pickerController?.sourceType = sourceType.getSourceType()
            
            if #available(iOS 13.0, *) {
                self.pickerController?.modalPresentationStyle = .fullScreen
            }
            
            self.delegate = delegate
            
            self.authorisationStatus(type: sourceType)
        } else {
            let alertController = UIAlertController(title: "", message: "Your device doesn't support this type of selection.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
                //Cancel Action is selected
            }
            alertController.addAction(okAction)
            DispatchQueue.main.async {
                UIViewController.top().present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func didSelectImage(image: UIImage) {
        self.delegate?.didSelectImage(image: image)
    }
    
}

extension ImagePickerManager: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true) {
            self.didSelectImage(image: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImagePickerManager: UINavigationControllerDelegate {
    
}

extension ImagePickerManager {
    func authorisationStatus(type: ImagePickerType) {
        
        if type == .camera {
            //Camera
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //access granted
                    if let pickerController = self.pickerController {
                        DispatchQueue.main.async {
                            UIViewController.top().present(pickerController, animated: true, completion: nil)
                        }
                    }
                } else {
                    
                    self.showCameraError()
                    
                }
            }
        }else if type == .gallery {
            //Photos
            let photos = PHPhotoLibrary.authorizationStatus()
            
            switch photos {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized {
                        if let pickerController = self.pickerController {
                            DispatchQueue.main.async {
                                UIViewController.top().present(pickerController, animated: true, completion: nil)
                            }
                        }
                    } else {
                        self.showGalleryError()
                    }
                })
            case .restricted:
                self.showGalleryError()
            case .denied:
                self.showGalleryError()
            case .authorized:
                if let pickerController = self.pickerController {
                    DispatchQueue.main.async {
                        UIViewController.top().present(pickerController, animated: true, completion: nil)
                    }
                }
            @unknown default:
                break
            }
            
        }
    }
    
    private func showCameraError() {
        let alertController = UIAlertController(title: "", message: "Camera permission is not granted", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction) in
            //Settings Action is selected
            if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(settingsAction)
        
        let okAction = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
            //Cancel Action is selected
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            UIViewController.top().present(alertController, animated: true, completion: nil)
        }
    }
    
    private func showGalleryError() {
        let alertController = UIAlertController(title: "", message: "Gallery permission is not granted.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction) in
            //Setting Action is selected
            if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(settingsAction)
        
        let okAction = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
            //Cancel Action is selected
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            UIViewController.top().present(alertController, animated: true, completion: nil)
        }
    }
}
