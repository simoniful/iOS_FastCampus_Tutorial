//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import Foundation
import UIKit

protocol SearchBookProtocol {
    func setupView()
    func dismiss()
    func reloadTableView()
}

protocol SearchBookDelegate {
    func selectBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    private let bookSearchManager: BookSearchManagerProtocol
    private let delegate: SearchBookDelegate
    
    var books: [Book] = []
    
    init(viewController: SearchBookProtocol, delegate: SearchBookDelegate, bookSearchManager: BookSearchManagerProtocol = BookSearchManager()) {
        self.viewController = viewController
        self.delegate = delegate
        self.bookSearchManager = bookSearchManager
    }
    
    func viewDidLoad() {
        viewController.setupView()
    }
}

extension SearchBookPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if searchText == "" { return }

        bookSearchManager.request(from: searchText) { [weak self] newBooks in
            self?.books = newBooks
            self?.viewController.reloadTableView()
        }
    }
}

extension SearchBookPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBookViewCell.identifier, for: indexPath) as? SearchBookViewCell else { return UITableViewCell() }
        let book = books[indexPath.row]
        cell.configureCell(book)
        return cell
    }
}

extension SearchBookPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.selectBook(selectedBook)
        viewController.dismiss()
    }
}



