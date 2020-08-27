//
//  AddTripViewController.swift
//  traveljournalios
//
//  Created by Miah Sanchez on 11/22/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        
    var locationName: UITextField!
    var dateName: UITextField!
    var saveButton: UIButton!
    
    var rect: UILabel!
    var iconLength:CGFloat = 24
    var globeIcon: UIImageView!
    var pinIcon: UIImageView!
    var journalIcon: UIImageView!
    var startIcon: UIImageView!
    var endIcon: UIImageView!
    var cameraIcon: UIImageView!
    var selectedImage: UIImage!
    var selectedImageView: UIImageView!
    var imageData: Data?
    
    var tfHeight: CGFloat = 40
    var tfWidth: CGFloat = 221
    var tripName: UITextField!
    var tripLoc: UITextField!
    var tripDes: UITextField!
    var tripStart: UITextField!
    var tripEnd: UITextField!
    
    var addButton: UIButton!
    var photoButton: UIButton!
    var cancelButton: UIBarButtonItem!
    var buttonColor = UIColor(red: 0.165, green: 0.212, blue: 0.576, alpha: 1)
    
    
    var lineView1: UIView!
    var lineView2: UIView!
    var lineView3: UIView!
    var lineView4: UIView!
    var lineView5: UIView!
    var lineView6: UIView!
    var lineColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
    
    var delegate: AddTripDelegate?

        
        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = .white
            title = "New Trip"
            self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: buttonColor,
             NSAttributedString.Key.font: UIFont(name: "GillSans", size: 21)!]
            

            
            locationName = UITextField()
            locationName.translatesAutoresizingMaskIntoConstraints = false
            locationName.text = "Add the location"
            locationName.backgroundColor = .white
            locationName.textColor = .systemGray
            locationName.borderStyle = .roundedRect
            locationName.textAlignment = .center
            locationName.clearsOnBeginEditing = true
            view.addSubview(locationName)

            dateName = UITextField()
            dateName.translatesAutoresizingMaskIntoConstraints = false
            dateName.text = "Add the dates"
            dateName.borderStyle = .roundedRect
            dateName.backgroundColor = .white
            dateName.textColor = .systemGray
            dateName.textAlignment = .center
            dateName.clearsOnBeginEditing = true
            view.addSubview(dateName)
            
            saveButton = UIButton()
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            saveButton.setTitle("Save", for: .normal)
            saveButton.setTitleColor(.systemBlue, for: .normal)
            saveButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            saveButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
            view.addSubview(saveButton)
            
            globeIcon = UIImageView()
            globeIcon.image = UIImage(named: "globe")
            globeIcon.clipsToBounds = true
            globeIcon.contentMode = .scaleAspectFit
            globeIcon.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(globeIcon)
            
            pinIcon = UIImageView()
            pinIcon.image = UIImage(named: "pin")
            pinIcon.clipsToBounds = true
            pinIcon.contentMode = .scaleAspectFit
            pinIcon.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(pinIcon)
            
            journalIcon = UIImageView()
            journalIcon.image = UIImage(named: "journal")
            journalIcon.clipsToBounds = true
            journalIcon.contentMode = .scaleAspectFit
            journalIcon.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(journalIcon)
            
            startIcon = UIImageView()
            startIcon.image = UIImage(named: "start")
            startIcon.clipsToBounds = true
            startIcon.contentMode = .scaleAspectFit
            startIcon.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(startIcon)
            
            endIcon = UIImageView()
            endIcon.image = UIImage(named: "end")
            endIcon.clipsToBounds = true
            endIcon.contentMode = .scaleAspectFit
            endIcon.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(endIcon)
            
            cameraIcon = UIImageView()
            cameraIcon.image = UIImage(named: "camera")
            cameraIcon.clipsToBounds = true
            cameraIcon.contentMode = .scaleAspectFit
            cameraIcon.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(cameraIcon)
            
            tripName = UITextField()
            tripName.text = "Trip Name"
            tripName.font = UIFont(name: "GillSans", size: 17)
            tripName.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            tripName.clearsOnBeginEditing = true
            tripName.layer.borderColor = UIColor.white.cgColor
            tripName.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tripName)
            
            tripLoc = UITextField()
            tripLoc.text = "Trip Location"
            tripLoc.font = UIFont(name: "GillSans", size: 17)
            tripLoc.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            tripLoc.clearsOnBeginEditing = true
            tripLoc.layer.borderColor = UIColor.white.cgColor
            tripLoc.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tripLoc)

            tripDes = UITextField()
            tripDes.text = "Description of your trip"
            tripDes.font = UIFont(name: "GillSans", size: 17)
            tripDes.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            tripDes.clearsOnBeginEditing = true
            tripDes.layer.borderColor = UIColor.white.cgColor
            tripDes.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tripDes)

            tripStart = UITextField()
            tripStart.text = "Start date"
            tripStart.font = UIFont(name: "GillSans", size: 17)
            tripStart.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            tripStart.clearsOnBeginEditing = true
            tripStart.layer.borderColor = UIColor.white.cgColor
            tripStart.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tripStart)

            tripEnd = UITextField()
            tripEnd.text = "End date"
            tripEnd.font = UIFont(name: "GillSans", size: 17)
            tripEnd.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            tripEnd.clearsOnBeginEditing = true
            tripEnd.layer.borderColor = UIColor.white.cgColor
            tripEnd.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tripEnd)

            addButton = UIButton()
            addButton.backgroundColor = buttonColor
            addButton.setTitle("Begin Journey!", for: .normal)
            addButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
            addButton.layer.borderWidth = 1
            addButton.layer.borderColor = buttonColor.cgColor
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.layer.cornerRadius = 25
            addButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
            view.addSubview(addButton)
            
            photoButton = UIButton()
            photoButton.backgroundColor = .white
            photoButton.setTitle("Add a cover photo", for: .normal)
            photoButton.setTitleColor(buttonColor, for: .normal)
            photoButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
            photoButton.layer.borderWidth = 1
            photoButton.layer.borderColor = buttonColor.cgColor
            photoButton.layer.cornerRadius = 17
            photoButton.addTarget(self, action: #selector(importImage(_:)), for: .touchUpInside)
            photoButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(photoButton)
            
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
            
            lineView1 = UIView(frame: CGRect(x: 0, y: 237, width: view.frame.width, height: 1.0))
            lineView1.layer.borderWidth = 1.0
            lineView1.layer.borderColor = lineColor
            view.addSubview(lineView1)
            
            lineView2 = UIView(frame: CGRect(x: 0, y: 306, width: view.frame.width, height: 1.0))
            lineView2.layer.borderWidth = 1.0
            lineView2.layer.borderColor = lineColor
            view.addSubview(lineView2)
            
            lineView3 = UIView(frame: CGRect(x: 0, y: 375, width: view.frame.width, height: 1.0))
            lineView3.layer.borderWidth = 1.0
            lineView3.layer.borderColor = lineColor
            view.addSubview(lineView3)
            
            lineView4 = UIView(frame: CGRect(x: 0, y: 444, width: view.frame.width, height: 1.0))
            lineView4.layer.borderWidth = 1.0
            lineView4.layer.borderColor = lineColor
            view.addSubview(lineView4)
            
            lineView5 = UIView(frame: CGRect(x: 0, y: 513, width: view.frame.width, height: 1.0))
            lineView5.layer.borderWidth = 1.0
            lineView5.layer.borderColor = lineColor
            view.addSubview(lineView5)
            
            lineView6 = UIView(frame: CGRect(x: 0, y: 582, width: view.frame.width, height: 1.0))
            lineView6.layer.borderWidth = 1.0
            lineView6.layer.borderColor = lineColor
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



