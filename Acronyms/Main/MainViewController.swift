//
//  ViewController.swift
//  Acronyms
//
//  Created by Cristian Palomino on 3/30/21.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel: MainViewModelProtocol? = MainViewModel()
    @IBOutlet weak var inputSearch: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        bind()
    }

    private func prepare() {
        title = "Acronyms"
        navigationController?.navigationBar.prefersLargeTitles = true
        inputSearch.autocapitalizationType = .none
        inputSearch.autocorrectionType = .no
        inputSearch.keyboardType = .alphabet
    }

    private func bind() {
        viewModel?.presentError = { [weak self] error in
            guard let self = self else { return }
            self.indicator.isHidden = true
            let alert = UIAlertController(title: "Alert", message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        viewModel?.pushResults = { [weak self] items in
            guard let self = self else { return }
            self.indicator.isHidden = true
            self.pushToList(items: items)
        }
    }

    @IBAction func didTapSearch() {
        guard let text = inputSearch.text else { return }
        indicator.isHidden = false
        viewModel?.didTapSearch(acronym: text)
    }

    private func pushToList(items: [LongForm]) {
        let sb = UIStoryboard(name: "List", bundle: Bundle.main)
        let controller = sb.instantiateInitialViewController() as! ListViewController
        controller.viewModel = ListViewModel(items: items)
        navigationController?.pushViewController(controller, animated: true)
    }

}
