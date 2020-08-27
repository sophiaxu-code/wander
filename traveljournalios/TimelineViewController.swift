//
//  TimelineViewController.swift
//  traveljournalios
//
//  Created by Sophia Xu on 12/5/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit
import SnapKit
class TimelineViewController: UIViewController {
   
    let mainFontColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 1)
    var timelineLabel: UILabel!
    var categoryLabel: UILabel!
    var dateLabel: UILabel!
    var dateTextField: UITextField!
    var tripLocationLabel: UILabel!
    var tripLocationTextField: UITextField!
    var activityName: UILabel!
    var activityTextField: UITextField!
    var descriptionTextField: UITextField!
    var saveButton: UIButton!
    var cancelButton: UIButton!
    var delegate: addEventtoTimeLineDelegate?
    var categoryCollectionView: UICollectionView!
    var selectedCategoryCell: TimelineCategoryCollectionViewCell!
    var deselectedCategoryCell: TimelineCategoryCollectionViewCell!
    let categoryCellReuseIdentifier = "categoryCellReuseIdentifier"
    var categories : [String]!
    
    func initUILabel(text: String) -> UILabel {
        let newUILabel: UILabel! = UILabel()
        newUILabel.text = text
        newUILabel.textColor = mainFontColor
        return newUILabel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        cancelButton = UIButton()
        let cancelButtonImage = UIImage(named: "cancel") as UIImage?
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setBackgroundImage(cancelButtonImage, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        timelineLabel = initUILabel(text: "Timeline")
        timelineLabel.font = UIFont(name: "GillSans", size: 28)
        view.addSubview(timelineLabel)
        
        categoryLabel = initUILabel(text: "Choose a category:")
        categoryLabel.font = UIFont(name: "GillSans", size: 22)
        view.addSubview(categoryLabel)
        
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        categoryLayout.minimumLineSpacing = 10
        categoryLayout.minimumInteritemSpacing = 10
        categories = ["Accomodation", "Attraction", "Activity", "Dining", "Shopping", "Other"]
        
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.backgroundColor = .white
        categoryCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(categoryCollectionView)
        categoryCollectionView.register(TimelineCategoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryCellReuseIdentifier)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        dateLabel = initUILabel(text: "Date:")
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.addSubview(dateLabel)
        
        dateTextField = UITextField()
        dateTextField.placeholder = "MM/DD/YY"
        dateTextField.borderStyle = .roundedRect
        view.addSubview(dateTextField)
        
        tripLocationLabel = initUILabel(text: "Trip Location: ")
        tripLocationLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.addSubview(tripLocationLabel)
        
        tripLocationTextField = UITextField()
        tripLocationTextField.placeholder = "Enter Location: "
        tripLocationTextField.borderStyle = .roundedRect
        view.addSubview(tripLocationTextField)
        
        activityName = initUILabel(text: "Activity Name:")
        activityName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.addSubview(activityName)
        
        activityTextField = UITextField()
        activityTextField.placeholder = "Enter Activity Name: "
        activityTextField.borderStyle = .roundedRect
        view.addSubview((activityTextField))
        
        descriptionTextField = UITextField()
        descriptionTextField.placeholder = "Write about this moment..."
        descriptionTextField.textAlignment = .left
        descriptionTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.layer.borderColor = mainFontColor.cgColor
        view.addSubview(descriptionTextField)
        
        saveButton = UIButton()
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.backgroundColor = mainFontColor
        saveButton.setTitle("Add Event", for: .normal)
        saveButton.setTitleColor(.white, for:.normal)
        saveButton.layer.cornerRadius = 5
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 5, bottom: 14, right: 5)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        setupConstraints()
    }
    @objc func saveButtonPressed(){
        if let activityName = activityTextField.text, activityName != "" {
            if let tripLocation = tripLocationTextField.text, tripLocation != "" {
                if let tripDescription = descriptionTextField.text, tripDescription != "" {
                    if let tripDate = dateTextField.text, tripDate != "" {
                        if let categoryName = selectedCategoryCell.categoryLabel.text, categoryName != ""{
                            let timelineEventCreated = TimelineEvent(category: categoryName, activityName: activityName, tripLocation: tripLocation, date: tripDate, tripDescription: tripDescription)
                             delegate?.addEvent(to: timelineEventCreated)
                        }
                    }
                }
               }
    }
        dismiss(animated: true, completion: nil )
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil )
    }
    
    func setupConstraints() {
       
        timelineLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self.view)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(timelineLabel)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(23)
            make.width.equalTo(62)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(timelineLabel).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 150),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        activityName.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
              
        activityTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
            make.left.equalTo(activityName.snp.right).offset(20)
            make.centerY.equalTo(activityName)
        }
        
        tripLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(activityName.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        tripLocationTextField.snp.makeConstraints { make in
            make.top.equalTo(activityName.snp.bottom).offset(20)
            make.centerY.equalTo(tripLocationLabel)
            make.left.equalTo(tripLocationLabel.snp.right).offset(20)
        }
       
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tripLocationLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(tripLocationLabel.snp.bottom).offset(20)
            make.left.equalTo(dateLabel.snp.right).offset(20)
            make.centerY.equalTo(dateLabel)
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(300)
        }
        
        saveButton.snp.makeConstraints{ make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.view)
        }
    }
}
extension TimelineViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellReuseIdentifier, for: indexPath) as! TimelineCategoryCollectionViewCell
        cell.configure(for: categories[indexPath.row])
        return cell
    }
}

extension TimelineViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (3*20)) / 4.0
        return CGSize(width: size, height: size)
    }
}

extension TimelineViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryCell = collectionView.cellForItem(at: indexPath) as! TimelineCategoryCollectionViewCell
        selectedCategoryCell.layer.borderWidth = 2
        selectedCategoryCell.layer.borderColor = mainFontColor.cgColor
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
           deselectedCategoryCell = collectionView.cellForItem(at: indexPath) as! TimelineCategoryCollectionViewCell
           deselectedCategoryCell.layer.borderWidth = 0
           deselectedCategoryCell.layer.borderColor = mainFontColor.cgColor
           
       }
}

   
    


   

