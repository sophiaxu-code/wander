//
//  TimelineCategoryCollectionViewCell.swift
//  traveljournalios
//
//  Created by Sophia Xu on 12/5/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit
import SnapKit

class TimelineCategoryCollectionViewCell: UICollectionViewCell {
    var categoryImage: UIImageView!
    var categoryLabel: UILabel!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryImage = UIImageView()
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryImage)
        
        categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        contentView.addSubview(categoryLabel)
        setupConstraints()
    }
    
    
    func setupConstraints(){
        categoryImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.width.equalTo(83.5)
            make.height.equalTo(83.5)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImage.snp.bottom).offset(5)
            make.centerX.equalTo(categoryImage)
        }
        
    }
    func configure(for category: String){
        categoryImage.image = UIImage(named: category)
        categoryLabel.text = category
        
    }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
   
}
