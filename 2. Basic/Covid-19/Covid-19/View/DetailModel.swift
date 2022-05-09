//
//  DetailModel.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/08.
//

import Foundation
import UIKit

struct DetailSection {
    var title: String // The title of the section
    var cells: [DetailItem] // The cells that this section contains
}

struct DetailItem {
    var createdCell: () -> UITableViewCell // The cell that this item creates
    var action: ((DetailItem) -> Swift.Void)? // The action that this item might have when tapped
}
