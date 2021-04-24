//
//  VideoCell+Ext.swift
//  GridAssignment
//
//  Created by Bhushan on 24/04/21.
//

import UIKit
import AVFoundation

extension VideoCell{

    func setupMoviePlayer(){
        self.avPlayer = AVPlayer.init(playerItem: self.videoPlayerItem)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        avPlayer?.volume = 3
        avPlayer?.actionAtItemEnd = .none
        
        avPlayerLayer?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 24, height: cellHeight.constant - 50)
        self.backgroundColor = .clear
        self.videoPlayerSuperView.layer.insertSublayer(avPlayerLayer!, at: 0)
        
        // This notification is fired when the video ends, you can handle it in the method.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer?.currentItem)
    }
    
    func stopPlayback(){
        self.playBTN.isHidden = false
        self.placeHolderView.isHidden = false
        self.avPlayer?.pause()
    }
    
    func startPlayback(){
        self.playBTN.isHidden = true
        self.placeHolderView.isHidden = true
        self.avPlayer?.play()
    }
    
    // A notification is fired and seeker is sent to the beginning to loop the video again
    @objc func playerItemDidReachEnd(notification: Notification) {
        //        let p: AVPlayerItem = notification.object as! AVPlayerItem
        //        p.seek(to: CMTime.zero)
        self.playBTN.isHidden = false
        self.placeHolderView.isHidden = false
        self.avPlayer?.pause()
    }
    
    func downloadImageWithURL(url: NSURL, completionBlock: @escaping  (_ succeeded: Bool, _ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            let url = url as URL
            let request = URLRequest(url: url)
            let cache = URLCache.shared
            if let cachedResponse = cache.cachedResponse(for: request),let image = UIImage(data: cachedResponse.data){
                DispatchQueue.main.async(execute: {
                    // assign your image to UIImageView
                    completionBlock(true, image)
                })
            }
            
            let asset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            imageGenerator.maximumSize = CGSize(width: UIScreen.main.bounds.size.width - 24, height: 200)
            
            var time = asset.duration
            time.value = 3000//min(time.value, 2000)
            
            var image: UIImage?
            
            do {
                let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                image = UIImage(cgImage: cgImage)
            } catch { }
            
            if
                let image = image,
                let data = image.pngData(),
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                
                cache.storeCachedResponse(cachedResponse, for: request)
            }
            
            let theFileName = (url.absoluteString as NSString).lastPathComponent
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            // choose a name for your image
            let fileName = theFileName.replacingOccurrences(of: "mp4", with: "png")
            // create the destination file url to save your image
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            // get your UIImage jpeg data representation and check if the destination file url already exists
            if let data = image?.jpegData(compressionQuality:  1.0),
               !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
            }
            DispatchQueue.main.async(execute: {
                completionBlock(true, image)
            })
        }
    }
}
