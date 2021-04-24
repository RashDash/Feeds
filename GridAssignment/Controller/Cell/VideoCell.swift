//
//  VideoCell.swift
//  GridAssignment
//
//  Created by Bhushan on 22/04/21.
//

import UIKit
import AVFoundation

protocol VideoCellProtocol {
    func selected(_ indexPath : IndexPath)
}

class VideoCell: UITableViewCell {
    var delegate:VideoCellProtocol?
    var cellPath : IndexPath?
    //Cell reusable - identifier
    public static let identifier = "VideoCell"
    
    // I have put the avplayer layer on this view
    @IBOutlet weak var videoPlayerSuperView: UIView!
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var paused: Bool = false
    
    //Outlets for the cell
    @IBOutlet var nameLBL : UILabel!
    @IBOutlet var nameHolder : UIView!
    @IBOutlet var playBTN : UIView!
    @IBOutlet var placeHolderView : UIImageView!
    @IBOutlet var cellHeight : NSLayoutConstraint!
    
    //This will be called everytime a new value is set on the videoplayer item
    var videoPlayerItem: AVPlayerItem? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            avPlayer?.replaceCurrentItem(with: self.videoPlayerItem)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Configure UI
        nameLBL.textColor = .white
        nameLBL.font = FontBook.Heavy.of(size: 20)
        selectionStyle = .none
        nameHolder.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        contentView.backgroundColor = .clear
        ////////////////////////////////////
        
        //Setup you avplayer while the cell is created
        self.setupMoviePlayer()
    }
    func setData(dataDic : Item,path : IndexPath){
        self.cellPath = path
        self.nameLBL.text = dataDic.title
        self.placeHolderView.image = UIImage()
        if let strUrl = dataDic.url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
            self.downloadImageWithURL(url: imgUrl as NSURL) { (success, image) in
                self.placeHolderView.image = image
            }
        }
        if dataDic.type == 1{
            cellHeight.constant = 100
        }else{
            cellHeight.constant = 200
        }
        layoutSubviews()
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func playAction(_ sender : UIButton){
        self.delegate?.selected(cellPath!)
    }
}

