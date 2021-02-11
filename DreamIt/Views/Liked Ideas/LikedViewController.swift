//
//  LikedViewController.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-12.
//

import Foundation
import UIKit

class LikedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    private var likedIdeasList: [IdeaItemModelView] = []
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        loadData()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background") ?? UIImage()).withAlphaComponent(0.85)
        self.tableView.isScrollEnabled = true
        self.lblTitle.text = "Liked Ideas"
        self.lblTitle.textColor = UIColor.white
        self.profileimg.image = UIImage(named: "profile")
        self.profileimg.layer.cornerRadius = self.profileimg.frame.height / 2
    }
    
    private func loadData() {
        api.getIdeas { ideaData in
            self.likedIdeasList = ideaData
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
        
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = CGColor.init(gray: 1, alpha: 1)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize.init(width: 20, height: 20)

        cell.setup(currentIdea)

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath)
    {
            let additionalSeparatorThickness = CGFloat(15)
        let additionalSeparator = UIView(frame: CGRect(x: 0,
                                                       y: cell.frame.size.height - additionalSeparatorThickness,
                                                       width: cell.frame.size.width,
                                                       height: additionalSeparatorThickness))
        additionalSeparator.backgroundColor = UIColor.red
            cell.addSubview(additionalSeparator)
    }
}
