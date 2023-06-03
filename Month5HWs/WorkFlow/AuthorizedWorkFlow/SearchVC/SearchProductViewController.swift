//
//  SearchProductViewController.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import UIKit

class SearchProductViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsTableView: UITableView!
    
    private let viewModel: ProductsViewModel
    
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    private var isFiltered: Bool = false
    
    init() {
        viewModel = ProductsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = ProductsViewModel()
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        configureTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
    }

    func configureTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.register(
            UINib(
                nibName: ProductsTableViewCell.nibName,
                bundle: nil
            ),
            forCellReuseIdentifier: ProductsTableViewCell.reuseId
        )
    }
    
    private func fetchProducts() {
        Task {
            do {
                products = try await viewModel.fetchProducts()
                productsTableView.reloadData()
            } catch {
                showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func filterProducts(with text: String) {
        filteredProducts = products.filter {
            $0.title.lowercased()
            .contains(
                text.lowercased()
            )
        }
        productsTableView.reloadData()
    }
}

//MARK: - TableView DataSource / Delegate
extension SearchProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        isFiltered ? filteredProducts.count : products.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductsTableViewCell.reuseId,
            for: indexPath
        ) as! ProductsTableViewCell
        
        let model = isFiltered
        ? filteredProducts[indexPath.row]
        : products[indexPath.row]
        cell.display(item: model)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        330
    }
}
//MARK: - UISearchBarDelegates
extension SearchProductViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        isFiltered = !searchText.isEmpty
        filterProducts(with: searchText)
    }
}
