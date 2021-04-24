//
//  AppDelegate+Ext.swift
//  GridAssignment
//
//  Created by Bhushan on 24/04/21.
//

import UIKit

extension AppDelegate{
    func getFonts(){
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
}
