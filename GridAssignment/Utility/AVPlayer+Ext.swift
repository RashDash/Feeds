//
//  AV.swift
//  GridAssignment
//
//  Created by Bhushan on 24/04/21.
//

import UIKit
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
