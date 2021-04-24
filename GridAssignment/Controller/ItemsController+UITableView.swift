//
//  ItemsController+UITableView.swift
//  GridAssignment
//
//  Created by Bhushan on 22/04/21.
//

import UIKit
import AVFoundation
import AVKit

extension ItemsController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataDic = viewModel.itemsArray[indexPath.row]
        
        if dataDic.type == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                ImageCell.identifier, for: indexPath) as? ImageCell else {
                    fatalError("UITableViewCell must be downcasted to ItemCell")
            }
            cell.setData(dataDic: dataDic)
            
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            VideoCell.identifier, for: indexPath) as? VideoCell else {
                    fatalError("UITableViewCell must be downcasted to VideoCell")
            }
            cell.delegate = self
            cell.setData(dataDic: dataDic, path: indexPath)
            if let strUrl = dataDic.url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
               let videoURL = URL(string: strUrl) {
                cell.videoPlayerItem = AVPlayerItem.init(url: videoURL)
            }
            
            return cell
        }
    }
    
  
}

extension ItemsController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let dataDic = viewModel.itemsArray[indexPath.row]
        if dataDic.type != 0{
            self.playpause_player(indexPath)
        }
    }
    
    func playpause_player(_ forPath : IndexPath){
        if let cell = listView.cellForRow(at: forPath) as? VideoCell{
            if cell.avPlayer?.isPlaying == true{
                self.selectedPath = nil
                cell.stopPlayback()
            }else{
                self.selectedPath = forPath
                cell.startPlayback()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.selectedPath != nil{
            if let cell = listView.cellForRow(at: self.selectedPath!) as? VideoCell{
                    self.selectedPath = nil
                    cell.stopPlayback()
            }
        }
    }
}

extension ItemsController : VideoCellProtocol{//Play pause button selected
    func selected(_ indexPath: IndexPath) {
        self.playpause_player(indexPath)
    }
}

