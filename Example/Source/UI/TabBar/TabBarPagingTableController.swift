//
//  TabBarPagingTableController.swift
//  ListControllerExample
//
//  Created by Vladislav Grokhotov on 22.12.2021.
//

import UIKit

class TabBarPagingTableController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(PagingTableController())
        addChild(PagingTableController())
    }
}
