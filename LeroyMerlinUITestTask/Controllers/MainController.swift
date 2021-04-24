//
//  ViewController.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 16.04.2021.
//

import UIKit

class MainController: UIViewController {
    
//    MARK: Outlets
    let sections = Bundle.main.decode([SectionModel].self, from: "model.json")
    var collectionView: UICollectionView!
    
//    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCells()
        setupNavigationBar()
        addSearchController()
        addQRCodeButton()
    }
    
//    MARK: Configuring NavBar
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemGreen
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Поиск товаров"
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.hidesSearchBarWhenScrolling = false
        extendedLayoutIncludesOpaqueBars = true
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .white
        standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .systemGreen
        scrollEdgeAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        scrollEdgeAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationController?.navigationBar.standardAppearance = standardAppearance
    }
    
    
    private func addSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.searchTextField.layer.cornerRadius = 4
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.borderStyle = .none
        searchController.searchBar.searchTextField.leftView = nil
        navigationItem.searchController = searchController
    }
    
    private func addQRCodeButton() {
        let button = ScanQRButton(frame: .init(x: 0, y: 0, width: 45, height: 45))
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
//    MARK: Configuring CollectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCollectionViewLayout() )
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment ) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            switch section.type {
            case "categories"  :
                return self.setupCategoriesLayout()
            default:
                return self.setupProductsLayout()
            }
            
        }
        return layout
    }
    
    private func setupCategoriesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
        return section
    }
    
    private func setupProductsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(210))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 20)
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: " ", alignment: .top)
        return sectionHeader
    }
    
    private func registerCells() {
        collectionView.register(CatalogCell.self, forCellWithReuseIdentifier: CatalogCell.reuseID)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        collectionView.register(AllCategoriesCell.self, forCellWithReuseIdentifier: AllCategoriesCell.reuseID)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: SectionHeader.reuseID)}
            
}
//MARK: UICollectionViewDataSource
extension MainController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sections[section].type == "categories" {
            return (sections[section].items?.count ?? 0) + 2
        }
            return sections[section].items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath == [0, 0] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCell.reuseID, for: indexPath) as! CatalogCell
            return cell
        } else if indexPath.section == 0 && indexPath.item > 0 && indexPath.item <= 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
            cell.title.text = sections[indexPath.section].items?[indexPath.item-1].name
            cell.imageView.image =  UIImage(named:sections[indexPath.section].items?[indexPath.item-1].name ?? "")
            return cell
        } else if indexPath.section == 0 && indexPath.item == 6 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCategoriesCell.reuseID, for: indexPath) as! AllCategoriesCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
            cell.productNameLabel.text = sections[indexPath.section].items?[indexPath.item].name
            cell.productPriceLabel.text = (sections[indexPath.section].items?[indexPath.item].price?.toString())
            cell.cacheImage(with: sections[indexPath.section])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
        headerView.title.text = sections[indexPath.section].title
        return headerView
    }
    
}

