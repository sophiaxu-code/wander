//
//  TimelineTableViewCell.swift
//  traveljournalios
//
//  Created by Sophia Xu on 12/6/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    var activityNameLabel: UILabel!
    var tripLocationLabel: UILabel!
    var dateLabel: UILabel!
    var categoryImageView: UIImageView!
    var locationPinImageView: UIImageView!
    var tripDescriptionTextView: UITextView!
    
    let fillColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 0.15)
    let fillColorGrey = UIColor (red: 42/255, green: 54/255, blue: 157/255, alpha: 0.04)
    
    func initUILabel(fontName: String, fontSize: CGFloat) -> UILabel {
        let newUILabel: UILabel! = UILabel()
        newUILabel.textColor = .black
        newUILabel.font = UIFont(name: fontName, size: fontSize)
        return newUILabel
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        categoryImageView = UIImageView()
        contentView.addSubview(categoryImageView)
        
        activityNameLabel = initUILabel(fontName: "GillSans-Bold", fontSize: 13)
        tripLocationLabel = initUILabel(fontName: "GillSans-Italic", fontSize: 11)
        dateLabel = initUILabel(fontName: "GillSans", fontSize: 14)
        
        contentView.addSubview(activityNameLabel)
        contentView.addSubview(tripLocationLabel)
        contentView.addSubview(dateLabel)
      
        locationPinImageView = UIImageView()
        contentView.addSubview(locationPinImageView)
             
        tripDescriptionTextView = UITextView()
        tripDescriptionTextView.font = UIFont(name: "GillSans", size:11)
        tripDescriptionTextView.textColor = .black
        tripDescriptionTextView.backgroundColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 0)
        tripDescriptionTextView.isEditable = false
        tripDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tripDescriptionTextView)
        
        setUpConstraints()
        
}
    
    func setUpConstraints(){
        let logolabelspacing = 8
        categoryImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(self.safeAreaLayoutGuide).offset(7)
            make.height.equalTo(25.5)
            make.width.equalTo(30)
        }
        
        activityNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(categoryImageView.snp.right).offset(logolabelspacing)
            make.centerY.equalTo(categoryImageView.snp.centerY)
            
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(activityNameLabel.snp.top)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-7)
        }
        
        locationPinImageView.snp.makeConstraints{ make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(5)
            make.centerX.equalTo(categoryImageView)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        tripLocationLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(locationPinImageView)
            make.left.equalTo(activityNameLabel)
        }
        
        tripDescriptionTextView.snp.makeConstraints{ make in
            
            make.top.equalTo(tripLocationLabel.snp.bottom).offset(1)
            make.left.equalTo(tripLocationLabel).offset(-4)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-7)
            make.height.equalTo(60)
        }
    }
    
    func configure(for event: TimelineEvent) {
        contentView.backgroundColor = fillColor
        activityNameLabel.text = event.activityName
        tripLocationLabel.text = "Location: " + event.tripLocation
        dateLabel.text = event.date
        categoryImageView.image = UIImage(named: event.category + "logo")
        locationPinImageView.image = UIImage(named: "locationpin")
        tripDescriptionTextView.text = event.tripDescription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
