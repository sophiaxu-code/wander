//
//  EditTripViewController.swift
//  traveljournalios
//
//  Created by Sophia Xu on 12/7/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit
import SnapKit

class EditTripViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var editTripLabel: UILabel!
    var doneButton: UIButton!
    var photoButton: UIButton!
    var pinIcon: UIImageView!
    var startIcon: UIImageView!
    var endIcon: UIImageView!
    var globeIcon: UIImageView!
    var cameraIcon: UIImageView!
    var imageData: Data?
    var selectedImageView: UIImageView!
    var iconLength: CGFloat = 28
    var tripStart: UITextField!
    var tripEnd: UITextField!
    var tripLoc: UITextField!
    var tripName: UITextField!
    
    var changeTripLabel: UILabel!
    var changeTitleLabel: UILabel!
    
    var tfHeight: CGFloat = 40
    var tfWidth: CGFloat = 221
    
    var titleRect: UILabel!
    var imageRect: UILabel!
    var lineView1: UIView!
    var lineView2: UIView!
    var lineView3: UIView!
    var lineView4: UIView!
    var lineView5: UIView!
    
    var delegate: editTheTripDelegate?
    
    let fontColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 1)
    let lineColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        editTripLabel = UILabel()
        editTripLabel.text = "Edit Trip"
        editTripLabel.font = UIFont(name: "GillSans", size: 34)
        editTripLabel.textColor = fontColor
        view.addSubview(editTripLabel)
        
        doneButton = UIButton()
        let doneButtonImage = UIImage(named: "doneButton") as UIImage?
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setBackgroundImage(doneButtonImage, for: .normal)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        view.addSubview(doneButton)
        
        pinIcon = UIImageView()
        pinIcon.image = UIImage(named: "pin")
        pinIcon.clipsToBounds = true
        pinIcon.contentMode = .scaleAspectFit
        pinIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinIcon)
        
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
        
        globeIcon = UIImageView()
        globeIcon.image = UIImage(named: "globe")
        globeIcon.clipsToBounds = true
        globeIcon.contentMode = .scaleAspectFit
        globeIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(globeIcon)
        
        cameraIcon = UIImageView()
        cameraIcon.image = UIImage(named: "camera")
        cameraIcon.clipsToBounds = true
        cameraIcon.contentMode = .scaleAspectFit
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraIcon)
        
        selectedImageView = UIImageView()
        selectedImageView.clipsToBounds = true
        selectedImageView.contentMode = .scaleToFill
        selectedImageView.layer.cornerRadius = 7
        selectedImageView.layer.borderWidth = 1
        selectedImageView.layer.borderColor = UIColor.white.cgColor
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedImageView)
        
        tripStart = UITextField()
        tripStart.text = "Start date"
        tripStart.font = UIFont(name: "GillSans", size: 22)
        tripStart.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        tripStart.clearsOnBeginEditing = true
        tripStart.layer.borderColor = UIColor.white.cgColor
        tripStart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripStart)
        
        tripEnd = UITextField()
        tripEnd.text = "End date"
        tripEnd.font = UIFont(name: "GillSans", size: 22)
        tripEnd.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        tripEnd.clearsOnBeginEditing = true
        tripEnd.layer.borderColor = UIColor.white.cgColor
        tripEnd.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripEnd)
        
        tripLoc = UITextField()
        tripLoc.text = "Trip Location"
        tripLoc.font = UIFont(name: "GillSans", size: 22)
        tripLoc.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        tripLoc.clearsOnBeginEditing = true
        tripLoc.layer.borderColor = UIColor.white.cgColor
        tripLoc.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripLoc)
        
        tripName = UITextField()
        tripName.clearsOnBeginEditing = true
        tripName.text = "Trip Name"
        tripName.font = UIFont(name: "GillSans", size: 22)
        tripName.textColor = .black
        tripName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripName)
        
        changeTitleLabel = UILabel()
        changeTitleLabel.text = "Change Title:"
        changeTitleLabel.font = UIFont(name: "GillSans", size: 19)
        changeTitleLabel.textColor = fontColor
        changeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeTitleLabel)
        
        changeTripLabel = UILabel()
        changeTripLabel.text = "Change Trip Details:"
        changeTripLabel.font = UIFont(name: "GillSans", size: 19)
        changeTripLabel.textColor = fontColor
        changeTripLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeTripLabel)
        
        titleRect = UILabel()
        titleRect.translatesAutoresizingMaskIntoConstraints = false
        titleRect.layer.cornerRadius = 24
        titleRect.layer.borderWidth = 1
        titleRect.layer.borderColor = UIColor.black.cgColor
        view.addSubview(titleRect)
        
        imageRect = UILabel()
        imageRect.translatesAutoresizingMaskIntoConstraints = false
        imageRect.layer.cornerRadius = 7
        imageRect.layer.borderWidth = 1
        imageRect.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        view.addSubview(imageRect)
        
        photoButton = UIButton()
        photoButton.backgroundColor = .white
        photoButton.setTitle("Change cover photo", for: .normal)
        photoButton.setTitleColor(fontColor, for: .normal)
        photoButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
        photoButton.layer.borderWidth = 1
        photoButton.layer.borderColor = fontColor.cgColor
        photoButton.layer.cornerRadius = 17
        photoButton.addTarget(self, action: #selector(importImage(_:)), for: .touchUpInside)
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoButton)
        
        lineView1 = UIView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 1.0))
        lineView1.layer.borderWidth = 1.0
        lineView1.layer.borderColor = lineColor
        view.addSubview(lineView1)
        
        lineView2 = UIView(frame: CGRect(x: 0, y: 197, width: view.frame.width, height: 1.0))
        lineView2.layer.borderWidth = 1.0
        lineView2.layer.borderColor = lineColor
        view.addSubview(lineView2)

        // Do any additional setup after loading the view.
        editTripLabel = UILabel()
        editTripLabel.text = "Edit Trip"
        editTripLabel.textColor = fontColor
        editTripLabel.font = UIFont(name: "GillSans", size: 28)
        view.addSubview(editTripLabel)
    

        lineView3 = UIView(frame: CGRect(x: 0, y: 384.5, width: view.frame.width, height: 1.0))
        lineView3.layer.borderWidth = 1.0
        lineView3.layer.borderColor = lineColor
        view.addSubview(lineView3)
        
        lineView4 = UIView(frame: CGRect(x: 0, y: 456, width: view.frame.width, height: 1.0))
        lineView4.layer.borderWidth = 1.0
        lineView4.layer.borderColor = lineColor
        view.addSubview(lineView4)
        
        lineView5 = UIView(frame: CGRect(x: 0, y: 526, width: view.frame.width, height: 1.0))
        lineView5.layer.borderWidth = 1.0
        lineView5.layer.borderColor = lineColor
        view.addSubview(lineView5)

        
        setUpConstraints()
    }
    
    @objc func doneAction(){
        if let tripName = tripName.text, let tripStart = tripStart.text, let tripEnd = tripEnd.text, let tripLoc = tripLoc.text, let imageData = imageData{
            if tripName != "Trip Name" && tripName != "" && tripLoc != "Trip Location" && tripLoc != "" && tripStart != "Start date" && tripStart != "" && tripEnd != "End date" && tripEnd != ""{
                delegate?.editTheTrip(tripName: tripName, tripStart: tripStart, tripEnd: tripEnd, tripLoc: tripLoc, imageData: imageData)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func importImage(_ sender: AnyObject){
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true)
    }
        
        internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imageData = image.pngData()
                if let data = imageData{
                    selectedImageView.image = UIImage(data: data)
                }
            }
            dismiss(animated: true, completion: nil)
        }
    
    func setUpConstraints(){
        editTripLabel.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        })
        
        doneButton.snp.makeConstraints{ make in
            make.centerY.equalTo(editTripLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(30)
        
        }
        
        NSLayoutConstraint.activate([
            photoButton.leadingAnchor.constraint(equalTo: imageRect.trailingAnchor, constant: 35),
            photoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            photoButton.heightAnchor.constraint(equalToConstant: 34),
            photoButton.widthAnchor.constraint(equalToConstant: 151)
        ])
            
        NSLayoutConstraint.activate([
            startIcon.widthAnchor.constraint(equalToConstant: iconLength),
            startIcon.heightAnchor.constraint(equalToConstant: iconLength),
            startIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 339),
            startIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            endIcon.widthAnchor.constraint(equalToConstant: iconLength),
            endIcon.heightAnchor.constraint(equalToConstant: iconLength),
            endIcon.topAnchor.constraint(equalTo: startIcon.topAnchor, constant: 70),
            endIcon.leadingAnchor.constraint(equalTo: pinIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pinIcon.widthAnchor.constraint(equalToConstant: iconLength),
            pinIcon.heightAnchor.constraint(equalToConstant: iconLength),
            pinIcon.topAnchor.constraint(equalTo: endIcon.topAnchor, constant: 70),
            pinIcon.leadingAnchor.constraint(equalTo: startIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tripStart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
            tripStart.topAnchor.constraint(equalTo: view.topAnchor, constant: 334),
            tripStart.widthAnchor.constraint(equalToConstant: tfWidth),
            tripStart.heightAnchor.constraint(equalToConstant: tfHeight)
        ])
        
        NSLayoutConstraint.activate([
            tripEnd.leadingAnchor.constraint(equalTo: tripStart.leadingAnchor),
            tripEnd.topAnchor.constraint(equalTo: tripStart.topAnchor, constant: 70),
            tripEnd.widthAnchor.constraint(equalToConstant: tfWidth),
            tripEnd.heightAnchor.constraint(equalToConstant: tfHeight)
        ])
        
        NSLayoutConstraint.activate([
            tripLoc.leadingAnchor.constraint(equalTo: tripStart.leadingAnchor),
            tripLoc.topAnchor.constraint(equalTo: tripEnd.topAnchor, constant: 70),
            tripLoc.widthAnchor.constraint(equalToConstant: tfWidth),
            tripLoc.heightAnchor.constraint(equalToConstant: tfHeight)
        ])
        
        NSLayoutConstraint.activate([
            changeTripLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            changeTripLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 294),
        ])
        
        NSLayoutConstraint.activate([
            changeTitleLabel.leadingAnchor.constraint(equalTo: changeTripLabel.leadingAnchor),
            changeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 203)
        ])
        
        NSLayoutConstraint.activate([
            titleRect.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleRect.bottomAnchor.constraint(equalTo: changeTripLabel.topAnchor, constant: -13),
            titleRect.heightAnchor.constraint(equalToConstant: 48),
            titleRect.widthAnchor.constraint(equalToConstant: 331)
        ])
        
         NSLayoutConstraint.activate([
            imageRect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            imageRect.topAnchor.constraint(equalTo: view.topAnchor, constant: 68),
            imageRect.heightAnchor.constraint(equalToConstant: 122),
            imageRect.widthAnchor.constraint(equalToConstant: 122)
                ])
        
        NSLayoutConstraint.activate([
            globeIcon.leadingAnchor.constraint(equalTo: titleRect.leadingAnchor, constant: 11),
            globeIcon.topAnchor.constraint(equalTo: titleRect.topAnchor, constant: 10),
            globeIcon.widthAnchor.constraint(equalToConstant: iconLength),
            globeIcon.heightAnchor.constraint(equalToConstant: iconLength)
        ])
        
        NSLayoutConstraint.activate([
            tripName.leadingAnchor.constraint(equalTo: globeIcon.trailingAnchor, constant: 18),
            tripName.topAnchor.constraint(equalTo: globeIcon.topAnchor, constant: 2),
            tripName.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            cameraIcon.widthAnchor.constraint(equalToConstant: iconLength-4),
            cameraIcon.heightAnchor.constraint(equalToConstant: iconLength-4),
            cameraIcon.topAnchor.constraint(equalTo: imageRect.topAnchor, constant: 49),
            cameraIcon.leadingAnchor.constraint(equalTo: imageRect.leadingAnchor, constant: 49)
        ])
        
        NSLayoutConstraint.activate([
            selectedImageView.leadingAnchor.constraint(equalTo: imageRect.leadingAnchor),
            selectedImageView.topAnchor.constraint(equalTo: imageRect.topAnchor),
            selectedImageView.widthAnchor.constraint(equalToConstant: 122),
            selectedImageView.heightAnchor.constraint(equalToConstant: 122)
        ])
    }
}
    
    
