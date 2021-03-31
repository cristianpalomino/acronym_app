//
//  ListViewController.swift
//  Acronyms
//
//  Created by Cristian Palomino on 3/31/21.
//

import Foundation
import UIKit

class ListViewController: UIViewController {

    var viewModel: ListViewModelProtocol?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    private func prepare() {
        title = "Results"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = viewModel?.items[indexPath.row]
        cell.textLabel?.text = item?.lf.capitalized
        return cell
    }

}
