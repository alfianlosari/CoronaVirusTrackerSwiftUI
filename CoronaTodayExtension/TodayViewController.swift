//
//  TodayViewController.swift
//  CoronaTodayExtension
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        containerStackView.isHidden = true
        errorLabel.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        CoronaArcGISService.shared.getAllTotalCount {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadingIndicator.isHidden = true
                switch result {
                case .success(let total):
                    self.containerStackView.isHidden = false
                    self.confirmedLabel.text = total.confirmedText
                    self.deathLabel.text = total.deathText
                    self.recoveredLabel.text = total.recoveredText
                    
                case .failure(let error):
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error.localizedDescription
                }
                completionHandler(NCUpdateResult.newData)
            }
        }
    }
    
}
