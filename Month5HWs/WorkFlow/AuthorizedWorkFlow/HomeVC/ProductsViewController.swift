//
//  ViewController.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var deliveryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var amountLabel: UILabel!
    
    private let categories = [
        Category(title: "Grociery", image: "pic1"),
        Category(title: "Pharmacy", image: "pic2"),
        Category(title: "Takeaway", image: "pic3"),
        Category(title: "Convince", image: "pic4"),
        Category(title: "Takeaway", image: "pic1")
    ]
    
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
        setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        
        FirestoreManager.shared.readData(collection: .news) { dictionary in
            let str: Any = dictionary.values
            
            print("here")
            print(str)
            let product = Product(
                id: 0,
                title: "\(str)",
                description: "jkfoiajgfojflks;fks;fk",
                price: 0,
                rating: 5.0,
                brand: "",
                category: "",
                thumbnail: "https://img.freepik.com/free-photo/road-mountains-with-cloudy-sky_1340-23022.jpg"
            )
            self.products.append(product)
            self.productsTableView.reloadData()
        }
    }
    
    func setUp() {
        configureTableView()
        configureSearchBar()
        configureCollectionView()
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
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureCollectionView() {
        deliveryCollectionView.dataSource = self
        categoryCollectionView.dataSource = self
        
        deliveryCollectionView.delegate = self
        categoryCollectionView.delegate = self
        
        deliveryCollectionView.register(
            UINib(
                nibName: DeliveryCollectionViewCell.nibName,
                bundle: nil
            ),
            forCellWithReuseIdentifier: DeliveryCollectionViewCell.reuseId)
        categoryCollectionView.register(
            UINib(
                nibName: CategoryCollectionViewCell.nibName,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseId)
    }
    
    private func fetchProducts() {
        Task {
            do {
                let model = try await viewModel.fetchProducts()
                products.append(contentsOf: model)
                productsTableView.reloadData()
            } catch {
                showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func handleProductCount() {
        let count = isFiltered
        ? filteredProducts.count
        : products.count
        amountLabel.text = "\(count) products aviable"
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

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
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

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ProductsViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if collectionView == deliveryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DeliveryCollectionViewCell.reuseId,
                for: indexPath) as? DeliveryCollectionViewCell else {
                    return UICollectionViewCell()
                }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.reuseId,
                for: indexPath) as? CategoryCollectionViewCell else {
                    return UICollectionViewCell()
                }
            
            let category = categories[indexPath.row]
            cell.display(category: category)
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        if collectionView == deliveryCollectionView {
            return CGSize(width: 110, height: 40)
        } else {
            return CGSize(width: 80, height: 150)
        }
    }
}

//MARK: - UISearchBarDelegates
extension ProductsViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        handleProductCount()
        isFiltered = !searchText.isEmpty
        filterProducts(with: searchText)
    }
}
