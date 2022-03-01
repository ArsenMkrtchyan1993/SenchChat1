//
//  ListViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 25.02.22.
//

import UIKit

struct MChat:Hashable {
    
    var userName:String
    var UserImage:UIImage
    var lastMessage:String
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.id == rhs.id
    }
}


class ListViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section,MChat>?
    let activeChat:[MChat] = [
            MChat(userName: "harut", UserImage: UIImage(named: "human1")!, lastMessage: "hello "),
            MChat(userName: "Popxos", UserImage: UIImage(named: "human2")!, lastMessage: "hello "),
            MChat(userName: "armine", UserImage: UIImage(named: "human3")!, lastMessage: "hello "),
            MChat(userName: "arpine", UserImage: UIImage(named: "human5")!, lastMessage: "hello ")
    ]
    
    enum Section: Int, CaseIterable {
        case activeChats
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        createDataSource()
        reloadData()
        
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.tintColor = .mainWhite()
       // navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("section noe found")
            }
                switch section {
                case .activeChats:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
                    cell.backgroundColor = .black
                    return cell
                }
        })
        
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,MChat>()
        snapshot.appendSections([.activeChats])
        snapshot.appendItems(activeChat, toSection: .activeChats)
        dataSource?.apply(snapshot,animatingDifferences: true)
        
        
    }
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(84))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
            return section
        }
        return layout
    }
}

// MARK: - UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


// MARK: - SwiftUI


import SwiftUI

struct ListVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: ListVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) {
            
        }
    }
}

