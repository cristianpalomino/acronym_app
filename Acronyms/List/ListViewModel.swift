//
//  ListViewModel.swift
//  Acronyms
//
//  Created by Cristian Palomino on 3/31/21.
//

import Foundation

protocol ListViewModelProtocol {

    var items: [LongForm] { get set }

}

class ListViewModel: ListViewModelProtocol {

    var items: [LongForm]

    init(items: [LongForm]) {
        self.items = items
    }

}
