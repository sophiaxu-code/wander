//
//  TripCollectionViewCell.swift
//  traveljournalios
//
//  Created by Sophia Xu on 11/20/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    var tripNameLabel: UILabel!
    var tripImageView: UIImageView!
    var tripDateLabel: UILabel!
    var blurLabel: UILabel!
    var blurLabelColor = UIColor(red: 0.608, green: 0.792, blue: 0.969, alpha: 0.86)
    var compassIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tripImageView = UIImageView()
        tripImageView.contentMode = .scaleToFill
        tripImageView.layer.cornerRadius = 20
        tripImageView.clipsToBounds = true
        tripImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tripImageView)
        
        blurLabel = UILabel()
        blurLabel.layer.backgroundColor = blurLabelColor.cgColor
        blurLabel.layer.borderColor = blurLabelColor.cgColor
        blurLabel.layer.cornerRadius = 20
        blurLabel.clipsToBounds = true
        blurLabel.layer.borderWidth = 1
        blurLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        blurLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurLabel)
        
        compassIcon = UIImageView()
        compassIcon.image = UIImage(named: "compass")
        compassIcon.clipsToBounds = true
        compassIcon.contentMode = .scaleAspectFit
        compassIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(compassIcon)
        
        tripNameLabel = UILabel()
        tripNameLabel.font = UIFont(name: "GillSans", size: 14)
        tripNameLabel.textColor = .black
        tripNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tripNameLabel)
        
        tripDateLabel = UILabel()
        tripDateLabel.font = UIFont(name: "GillSans", size:14)
        tripDateLabel.textColor = .black
        tripDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tripDateLabel)
        
        setUpConstraints()
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tripImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tripImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tripImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tripImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            blurLabel.leadingAnchor.constraint(equalTo: tripImageView.leadingAnchor),
            blurLabel.bottomAnchor.constraint(equalTo: tripImageView.bottomAnchor),
            blurLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            blurLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            compassIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            compassIcon.topAnchor.constraint(equalTo: blurLabel.topAnchor, constant: 6),
            compassIcon.heightAnchor.constraint(equalToConstant: 23),
            compassIcon.widthAnchor.constraint(equalToConstant: 23),
        ])
        
        NSLayoutConstraint.activate([
            tripNameLabel.leadingAnchor.constraint(equalTo: compassIcon.trailingAnchor, constant: 10),
            tripNameLabel.topAnchor.constraint(equalTo: blurLabel.topAnchor, constant: 11),

        ])
        
        NSLayoutConstraint.activate([
            tripDateLabel.topAnchor.constraint(equalTo: tripNameLabel.topAnchor),
            tripDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    func configure(for trip: Trip){
        let tripName = trip.tripName
        let tripDate = trip.tripStartDate
        let imageData = trip.imageData
        tripNameLabel.text = tripName
        tripDateLabel.text = tripDate
        if let data = imageData{
            tripImageView.image = UIImage(data: data)//UIImage(named: tripImageName)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

