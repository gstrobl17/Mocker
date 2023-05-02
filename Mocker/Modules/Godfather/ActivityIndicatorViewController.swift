//
//  ActivityIndicatorViewController.swift
//  Mocker
//
//  Created by Greg on 2/25/18.
//

import Cocoa

class ActivityIndicatorViewController: NSViewController {

    @IBOutlet weak private var activityIndicator: NSProgressIndicator! {
        didSet {
            if let activityIndicator = activityIndicator {
                activityIndicator.startAnimation(nil)
            }
        }
    }

    @IBOutlet weak private var label: NSTextField! {
        didSet {
            if let label = label {
                label.stringValue = message
            }
        }
    }

    var message: String = "" {
        didSet {
            if let label = label {
                label.stringValue = message
            }
        }
    }
    
}
