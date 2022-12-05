//
//  CustomCell.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/04.
//

import UIKit

class CustomCell : UITableViewCell {
    
    static let identifier = "CustomCell"
    
    lazy var leftImageView : UIImageView  = {
       let imageView = UIImageView()
        return imageView
    }()
    
    let label : UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomCell {
    func bind(model : NationWeatherM) {
        
        label.text = model.korean_name
        
        guard let imageAsset : UIImage = UIImage(systemName: "(\(model.asset_name))") else {return}
        leftImageView.image = imageAsset
    }
}
