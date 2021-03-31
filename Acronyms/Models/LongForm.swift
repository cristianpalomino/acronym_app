//
//  LongForm.swift
//  Acronyms
//
//  Created by Cristian Palomino on 3/31/21.
//

import Foundation

struct LongForm: Decodable {

    let lf: String
    let vars: [LongForm]?

}
