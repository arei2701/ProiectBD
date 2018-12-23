//
//  FirstCustomCell.swift
//  ProiectBD
//
//  Created by Andrei Popa on 21/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class FirstCustomCell: UITableViewCell {

    @IBOutlet weak var thumbneilHeight: NSLayoutConstraint!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        backgroundColor = UIColor.clear
        
        self.backView.layer.borderWidth = 1
        self.backView.layer.cornerRadius = 10
        self.backView.layer.borderColor = UIColor.clear.cgColor
        self.backView.layer.masksToBounds = true
        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = Colors.black.cgColor
        self.layer.masksToBounds = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .blue // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style : style,reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
   
  
}
