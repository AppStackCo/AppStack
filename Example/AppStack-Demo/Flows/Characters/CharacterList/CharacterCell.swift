//
//  CharacterCell.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import SDWebImage
import UIKit

final class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    var model: CharacterEntity! {
        didSet {
            characterImageView.sd_setImage(with: model.image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

