//
//  UITableView+iBurn.swift
//  iBurn
//
//  Created by Chris Ballinger on 7/30/18.
//  Copyright © 2018 Burning Man Earth. All rights reserved.
//

import Foundation


extension UITableView {
    public static func iBurnTableView(style: UITableView.Style = .plain) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.setDataObjectDefaults()
        return tableView
    }
    
    public func setDataObjectDefaults() {
        registerCustomCellClasses()
        estimatedRowHeight = 120
        rowHeight = UITableView.automaticDimension
    }
    
    /** Registers custom cell classes for BRC data objects */
    @objc public func registerCustomCellClasses() {
        let mapping = BRCDataObjectTableViewCell.cellIdentifiers
        mapping.forEach { cellIdentifier, cellClass in
            let nibName = NSStringFromClass(cellClass);
            let nib = UINib.init(nibName: nibName, bundle: nil)
            self.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
}
