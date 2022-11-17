//
//  ProfileViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 25/10/2022.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UITextField!
    @IBOutlet weak var profilePhoneNumberLabel: UITextField!
    
    var userData: UserModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isModalInPresentation = false
        
        userData = UserDefaults.standard.value(forKey: "User") as? UserModel
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTouchesRequired = 1
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)
        
        guard let name = profileNameLabel.text, name.isNotEmpty,
              let phone = profilePhoneNumberLabel.text, phone.isNotEmpty,
              let image = profileImageView.image, !image.isSymbolImage
              
        else {
            Vibration.heavy.vibrate()
            return
        }
        
        let user = UserModel(name: name, phone: phone, image: image)
        
        if user.setUserData(user: user) {
            dismiss(animated: true)
        } else {
            Messages().showMessage(title: "Error", body: "Failed to Save Object")
        }
    }
}

extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imgTapped() {
        showAlert()
    }
    
    //Show alert to selected the media source type.
    private func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK:- UIImagePickerViewDelegate.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) { [weak self] in
            
            guard let image = info[.originalImage] as? UIImage else  { return }
            self?.profileImageView.contentMode = .scaleAspectFill
            self?.profileImageView.image = image
            
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
