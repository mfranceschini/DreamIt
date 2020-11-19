//
//  LikedIdeasViewController.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-02.
//

import SwiftUI
import UIKit

class LikedIdeasViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    @Environment(\.colorScheme) var colorScheme
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.separatorColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = Component(frame: .zero)
        headerView.configure(text: "Liked Ideas")
        tv.tableHeaderView = headerView
        tv.tableHeaderView?.backgroundColor = .clear
        
        return tv
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: self.tableview.tableHeaderView)
    }

    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableview.register(DreamIdeaCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        tableview.delegate = self
        tableview.dataSource = self
        self.title = "Liked Ideas"
        tableview.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.screenSize.width, height: Constants.screenSize.height))
        tableview.backgroundColor = colorWithGradient()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, height section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "title"
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DreamIdeaCell
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func colorWithGradient() -> UIColor {
        
        let background: [UIColor] = [
            UIColor(red: 0.96, green: 0.44, blue: 0.24, alpha: 0.8),
            UIColor(red: 1.00, green: 0.42, blue: 0.44, alpha: 0.8),
            UIColor(red: 0.95, green: 0.49, blue: 0.71, alpha: 0.8),
            UIColor(red: 0.61, green: 0.31, blue: 0.62, alpha: 0.8),
            UIColor(red: 0.37, green: 0.22, blue: 0.56, alpha: 0.8),
        ]
        
        // create the background layer that will hold the gradient
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = CGRect(x: 0, y: 0, width: Constants.screenSize.width, height: Constants.screenSize.height)
         
        // we create an array of CG colors from out UIColor array
        let cgColors = background.map({$0.cgColor})
        
        backgroundGradientLayer.colors = cgColors
        
        UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
        backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: backgroundColorImage)
    }
}

class DreamIdeaCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = CGColor.init(gray: 1, alpha: 1)
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize.init(width: 20, height: 20)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ideaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App ideia title"
        label.textColor = UIColor.black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "App ideia author"
        label.textColor = UIColor.gray
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let daysAfterPostLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-11-09"
        label.textColor = UIColor.lightGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let impressionsLabel: UILabel = {
        let label = UILabel()
        label.text = "1707"
        label.textColor = UIColor.lightGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let impressionsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye.fill")
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        //        cellView.addSubview(ideaImage)
        cellView.addSubview(titleLabel)
        cellView.addSubview(authorLabel)
        cellView.addSubview(daysAfterPostLabel)
        cellView.addSubview(impressionsLabel)
        cellView.addSubview(impressionsIcon)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        //titleLabel
        titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 100).isActive = true
        
        //authorLabel
        authorLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: 10).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 100).isActive = true
        
        //daysAfterPostLabel
        daysAfterPostLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -15).isActive = true
        daysAfterPostLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15).isActive = true
        
        //impressionsLabel
        impressionsLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -15).isActive = true
        impressionsLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15).isActive = true
        
        //impressionsIcon
        impressionsIcon.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -5).isActive = true
        impressionsIcon.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15).isActive = true
    }
    
}

class Component: UIView {

    let label = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }

    func configure(text: String) {
        label.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
