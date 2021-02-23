//
//  LikedViewController.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-12.
//

import Foundation
import UIKit

class LikedViewController: UIViewController {
    
    let api = API()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var searchText: String = ""
    
    private var likedIdeasList: [IdeaItemModelView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        loadData()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background") ?? UIImage()).withAlphaComponent(0.85)
        self.tableView.isScrollEnabled = true
        self.tableView.backgroundColor = .clear
        self.searchBar.barTintColor = .white
        self.searchBar.tintColor = .white
        self.lblTitle.text = "Liked Ideas"
        self.lblTitle.textColor = UIColor.white
        self.profileimg.image = UIImage(systemName: "person.crop.circle")
        self.profileimg.image?.withTintColor(.white)
        self.profileimg.layer.cornerRadius = self.profileimg.frame.height / 2
    }
    
    private func loadData() {
        api.getIdeas { ideaData in
            self.likedIdeasList = ideaData
            self.tableView.reloadData()
        }
    }
    
}

extension LikedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likedIdeasList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let currentIdea = self.likedIdeasList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "likedIdeaCell", for: indexPath) as! LikedIdeaCell
        
        cell.layer.shadowColor = CGColor.init(gray: 1, alpha: 1)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize.init(width: 20, height: 20)
        cell.layer.backgroundColor = UIColor.clear.cgColor

        cell.setup(currentIdea)

        return cell
    }
}

extension LikedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("clicked search -> ", self.searchText)
        self.likedIdeasList = self.likedIdeasList.filter { idea in
            (self.searchText.isEmpty ? true :
                idea.title.lowercased().contains(self.searchText.lowercased()) ||
                idea.author.lowercased().contains(self.searchText.lowercased()))
        }
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print("search button click")
        }
}
