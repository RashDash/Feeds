//
//  ItemCell.swift
//  GridAssignment
//
//  Created by Bhushan on 22/04/21.
//

import UIKit
import AVFoundation

class ImageCell: UITableViewCell {

    //Cell reusable - identifier
    public static let identifier = "ImageCell"
    
    //Cell Outlets Declared
    @IBOutlet var nameLBL : UILabel!
    @IBOutlet var imgView : CustomImageView!
    @IBOutlet var nameHolder : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLBL.textColor = .white
        nameLBL.font = FontBook.Heavy.of(size: 20)
        contentView.backgroundColor = .clear
        imgView.backgroundColor = .clear
        nameHolder.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        selectionStyle = .none

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(dataDic : Item){
        self.nameLBL.text = dataDic.title
        if let strUrl = dataDic.url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
                imgView.loadImageWithUrl(imgUrl)
        }
    }
}
