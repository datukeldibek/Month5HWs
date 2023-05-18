//
//  ViewController.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var amountLabel: UILabel!
    
    private let images: [UIImage?] = [
        UIImage(named: "pic1"),
        UIImage(named: "pic2"),
        UIImage(named: "pic3"),
        UIImage(named: "pic4"),
        UIImage(named: "pic1"),
        UIImage(named: "pic2")
    ]
    private let cvBText: [String] = [
        "Grociery",
        "Pharmacy",
        "Takeaway",
        "Convince",
        "Takeaway",
        "Grociery"
    ]
    
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    private var isFiltered: Bool = false
    
    private let viewModel: ProductsViewModel
    
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
        setUp()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
    }

    func setUp() {
        configureTableView()
        configureSearchBar()
        configureCollectionView()
    }
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: TableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: TableViewCell.reuseId
        )
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionViewA.dataSource = self
        collectionViewB.dataSource = self
        
        collectionViewA.delegate = self
        collectionViewB.delegate = self
        
        collectionViewA.register(
            UINib(
                nibName: CollectionViewACell.nibName,
                bundle: nil),
            forCellWithReuseIdentifier: CollectionViewACell.reuseId)
        collectionViewB.register(
            UINib(
                nibName: CollectionViewBCell.nibName,
                bundle: nil),
            forCellWithReuseIdentifier: CollectionViewBCell.reuseId)
    }
    
    private func fetchProducts() {
        Task {
            do {
                products = try await viewModel.fetchProducts()
                tableView.reloadData()
            } catch {
                
            }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        amountLabel.text = "\(isFiltered ? filteredProducts.count : products.count) products aviable"
        let model = isFiltered ? filteredProducts[indexPath.row] : products[indexPath.row]
        cell.display(item: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        330
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if collectionView == collectionViewA {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewACell.reuseId,
                for: indexPath) as? CollectionViewACell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewBCell.reuseId,
                for: indexPath) as? CollectionViewBCell else {
                return UICollectionViewCell()
            }
            cell.display(
                image: images[indexPath.row],
                text: cvBText[indexPath.row]
            )
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        if collectionView == collectionViewA {
            return CGSize(width: 110, height: 40)
        } else {
            return CGSize(width: 80, height: 150)
        }
    }
}

//MARK: - UISearchBarDelegates
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isFiltered = false
        } else {
            isFiltered = true
            filteredProducts = products.filter{ $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}
