//
//  AddTripViewController.swift
//  traveljournalios
//
//  Created by Miah Sanchez on 11/22/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var rect: UILabel!
    let iconLength:CGFloat = 24
    var globeIcon: UIImageView!
    var pinIcon: UIImageView!
    var journalIcon: UIImageView!
    var startIcon: UIImageView!
    var endIcon: UIImageView!
    var cameraIcon: UIImageView!
    var selectedImage: UIImage!
    var selectedImageView: UIImageView!
    var imageData: Data?
    
    var tripName: UITextField!
    var tripLoc: UITextField!
    var tripDes: UITextField!
    var tripStart: UITextField!
    var tripEnd: UITextField!
    
    var addButton: UIButton!
    var photoButton: UIButton!
    var cancelButton: UIBarButtonItem!
    let buttonColor = UIColor(red: 0.165, green: 0.212, blue: 0.576, alpha: 1)
    let lineColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
    
    var delegate: AddTripDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "New Trip"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: buttonColor,
         NSAttributedString.Key.font: UIFont(name: "GillSans", size: 21)!]
        
    func initTextField(textInput: String) -> UITextField {
        var newTextField: UITextField!
        newTextField = UITextField()
        newTextField.text = textInput
        newTextField.font = UIFont(name: "GillSans", size: 17)
        newTextField.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        newTextField.clearsOnBeginEditing = true
        newTextField.layer.borderColor = UIColor.white.cgColor
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }
    
    func initImageView(name: String) -> UIImageView {
        var newImageView: UIImageView!
        newImageView = UIImageView()
        newImageView.image = UIImage(named: name)
        newImageView.clipsToBounds = true
        newImageView.contentMode = .scaleAspectFit
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        return newImageView
    }
    
    func initUIView(y: CGFloat, width: CGFloat) -> UIView {
        var newUIView: UIView!
        newUIView = UIView(frame: CGRect(x: 0, y: y, width: width, height: 1.0))
        newUIView.layer.borderWidth = 1.0
        newUIView.layer.borderColor = lineColor
        return newUIView
    }
    
    func initUIButton(title: String, backgroundColor: UIColor, cornerRadius: CGFloat) -> UIButton {
        var newUIButton: UIButton!
        newUIButton = UIButton()
        newUIButton.translatesAutoresizingMaskIntoConstraints = false
        newUIButton.backgroundColor = backgroundColor
        newUIButton.setTitle(title, for: .normal)
        newUIButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
        newUIButton.layer.borderWidth = 1
        newUIButton.layer.cornerRadius = cornerRadius
        newUIButton.layer.borderColor = buttonColor.cgColor
        return newUIButton
    }
            
        globeIcon = initImageView(name: "globe")
        pinIcon = initImageView(name: "pin")
        journalIcon = initImageView(name:"journal")
        startIcon = initImageView(name: "start")
        endIcon = initImageView(name:"end")
        cameraIcon = initImageView(name: "camera")
        
        view.addSubview(globeIcon)
        view.addSubview(pinIcon)
        view.addSubview(journalIcon)
        view.addSubview(startIcon)
        view.addSubview(endIcon)
        view.addSubview(cameraIcon)
        
        tripName = initTextField(textInput: "Trip Name")
        tripLoc = initTextField(textInput: "Trip Location")
        tripDes = initTextField(textInput: "Description of your trip")
        tripStart = initTextField(textInput: "Start date")
        tripEnd = initTextField(textInput: "End date")
        
        view.addSubview(tripName)
        view.addSubview(tripLoc)
        view.addSubview(tripDes)
        view.addSubview(tripStart)
        view.addSubview(tripEnd)
        
            
        photoButton = initUIButton(title: "Add a cover photo", backgroundColor: .white, cornerRadius: 17)
        photoButton.setTitleColor(buttonColor, for: .normal)
        photoButton.addTarget(self, action: #selector(importImage(_:)), for: .touchUpInside)
        view.addSubview(photoButton)
              
        addButton = initUIButton(title: "Begin Journey!", backgroundColor: buttonColor, cornerRadius: 25)
        addButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
        view.addSubview(addButton)

        selectedImageView = UIImageView()
        selectedImageView.clipsToBounds = true
        selectedImageView.contentMode = .scaleToFill
        selectedImageView.layer.cornerRadius = 7
        selectedImageView.layer.borderWidth = 1
        selectedImageView.layer.borderColor = UIColor.white.cgColor
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedImageView)
            
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelIt))
        cancelButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "GillSans", size: 17)!,
            NSAttributedString.Key.foregroundColor: buttonColor],
        for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
            
        rect = UILabel()
        rect.translatesAutoresizingMaskIntoConstraints = false
        rect.layer.cornerRadius = 7
        rect.layer.borderWidth = 1
        rect.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        view.addSubview(rect)
            
        let initial: CGFloat = 237
        let width: CGFloat = view.frame.width
        
        let lineView1: UIView! = initUIView(y: initial, width: width)
        let lineView2: UIView! = initUIView(y: initial + 69, width: width)
        let lineView3: UIView! = initUIView(y: initial + (69*2), width: width)
        let lineView4: UIView! = initUIView(y: initial + (69*3), width: width)
        let lineView5: UIView! = initUIView(y: initial + (69*4), width: width)
        let lineView6: UIView! = initUIView(y: initial + (69*5), width: width)
        
        view.addSubview(lineView1)
        view.addSubview(lineView2)
        view.addSubview(lineView3)
        view.addSubview(lineView4)
        view.addSubview(lineView5)
        view.addSubview(lineView6)
        
        setupConstraints()
        }
    
    @objc func saveItem(){
        if let tripName = tripName.text, let tripLoc = tripLoc.text, let tripDes = tripDes.text, let tripStart = tripStart.text, let tripEnd = tripEnd.text, let imageData = imageData{
            if tripName != "Trip Name" && tripName != "" && tripLoc != "Trip Location" && tripLoc != "" && tripDes != "Description of your trip" && tripDes != "" && tripStart != "Start date" && tripStart != "" && tripEnd != "End date" && tripEnd != ""{
                delegate?.AddNewTrip(tripName: tripName, tripLoc: tripLoc, tripDes: tripDes, tripStart: tripStart, tripEnd: tripEnd, imageData: imageData)
                }
            }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelIt(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func importImage(_ sender: AnyObject){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            selectedImage = image
            imageData = image.pngData()
            if let data = imageData{
                selectedImageView.image = UIImage(data: data)
            } //selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints(){
        let tfHeight: CGFloat = 40
        let tfWidth: CGFloat = 221
        
        NSLayoutConstraint.activate([
            globeIcon.widthAnchor.constraint(equalToConstant: iconLength),
            globeIcon.heightAnchor.constraint(equalToConstant: iconLength),
            globeIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 259),
            globeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            pinIcon.widthAnchor.constraint(equalToConstant: iconLength),
            pinIcon.heightAnchor.constraint(equalToConstant: iconLength),
            pinIcon.topAnchor.constraint(equalTo: globeIcon.topAnchor, constant: 69),
            pinIcon.leadingAnchor.constraint(equalTo: globeIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            journalIcon.widthAnchor.constraint(equalToConstant: iconLength),
            journalIcon.heightAnchor.constraint(equalToConstant: iconLength),
            journalIcon.topAnchor.constraint(equalTo: pinIcon.topAnchor, constant: 69),
            journalIcon.leadingAnchor.constraint(equalTo: globeIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startIcon.widthAnchor.constraint(equalToConstant: iconLength),
            startIcon.heightAnchor.constraint(equalToConstant: iconLength),
            startIcon.topAnchor.constraint(equalTo: journalIcon.topAnchor, constant: 69),
            startIcon.leadingAnchor.constraint(equalTo: globeIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            endIcon.widthAnchor.constraint(equalToConstant: iconLength),
            endIcon.heightAnchor.constraint(equalToConstant: iconLength),
            endIcon.topAnchor.constraint(equalTo: startIcon.topAnchor, constant: 69),
            endIcon.leadingAnchor.constraint(equalTo: globeIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cameraIcon.widthAnchor.constraint(equalToConstant: iconLength),
            cameraIcon.heightAnchor.constraint(equalToConstant: iconLength),
            cameraIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 151),
            cameraIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 67)
        ])
        
        NSLayoutConstraint.activate([
            tripName.topAnchor.constraint(equalTo: view.topAnchor, constant: 252),
            tripName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
            tripName.widthAnchor.constraint(equalToConstant: tfWidth),
            tripName.heightAnchor.constraint(equalToConstant: tfHeight)
        ])
        
        NSLayoutConstraint.activate([
            tripLoc.topAnchor.constraint(equalTo: tripName.topAnchor, constant: 69),
            tripLoc.leadingAnchor.constraint(equalTo: tripName.leadingAnchor),
            tripLoc.widthAnchor.constraint(equalToConstant: tfWidth),
            tripLoc.heightAnchor.constraint(equalToConstant: tfHeight),
        ])
        
        NSLayoutConstraint.activate([
            tripDes.topAnchor.constraint(equalTo: tripLoc.topAnchor, constant: 69),
            tripDes.leadingAnchor.constraint(equalTo: tripName.leadingAnchor),
            tripDes.widthAnchor.constraint(equalToConstant: tfWidth),
            tripDes.heightAnchor.constraint(equalToConstant: tfHeight),
        ])
        
        NSLayoutConstraint.activate([
            tripStart.topAnchor.constraint(equalTo: tripDes.topAnchor, constant: 69),
            tripStart.leadingAnchor.constraint(equalTo: tripName.leadingAnchor),
            tripStart.widthAnchor.constraint(equalToConstant: tfWidth),
            tripStart.heightAnchor.constraint(equalToConstant: tfHeight),
        ])
        
        NSLayoutConstraint.activate([
            tripEnd.topAnchor.constraint(equalTo: tripStart.topAnchor, constant: 69),
            tripEnd.leadingAnchor.constraint(equalTo: tripName.leadingAnchor),
            tripEnd.widthAnchor.constraint(equalToConstant: tfWidth),
            tripEnd.heightAnchor.constraint(equalToConstant: tfHeight),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 604),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 238),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            photoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 156),
            photoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 135),
            photoButton.widthAnchor.constraint(equalToConstant: 151),
            photoButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            rect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            rect.topAnchor.constraint(equalTo: view.topAnchor, constant: 119),
            rect.heightAnchor.constraint(equalToConstant: 88),
            rect.widthAnchor.constraint(equalToConstant: 88)
        ])
        
        NSLayoutConstraint.activate([
            selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            selectedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 119),
            selectedImageView.widthAnchor.constraint(equalToConstant: 88),
            selectedImageView.heightAnchor.constraint(equalToConstant: 88)
        ])
    }
    
    
    }



