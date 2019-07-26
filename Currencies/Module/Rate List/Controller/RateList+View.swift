//
//  RateList+View.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension RateListViewController: RateListViewDelegate {
    
    // MARK: - RateListViewDelegate methods
    func view(_ view: RateListView, refreshControlValueChanged refreshControl: UIRefreshControl) {
        getLatestRates()
    }
}
