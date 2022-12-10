//
//  CustomCell.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/04.
//

import UIKit
import SnapKit
class CustomCell : UITableViewCell {
    
    static let identifier = "CustomCell"
    
    lazy var leftImageView : UIImageView  = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let stack : UIStackView = {
        let settings = UIStackView()
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.axis = .vertical
        settings.distribution = .fillEqually
        return settings
    }()
    
    let nationLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isHighlighted = true
        return label
    }()
    
    let weatherLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let rainyLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftImageView)
        contentView.addSubview(stack)
        stack.addArrangedSubview(nationLabel)
        stack.addArrangedSubview(weatherLabel)
        stack.addArrangedSubview(rainyLabel)
        leftImageView.snp.makeConstraints{make in
            make.leading.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.3)
        }
        stack.snp.makeConstraints{make in
            make.top.bottom.trailing.equalTo(contentView)
            make.leading.equalTo(leftImageView.snp.trailing)
            
        }
        
        self.accessoryType = .disclosureIndicator

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

