//
//  ProfileViewController.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    // Information view
    @IBOutlet private weak var informationView: UIView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var loadingTitle: UILabel!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var messageView: UIView!
    @IBOutlet private weak var message: UILabel!
    @IBOutlet private weak var retryButton: UIButton!
    // Table view
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var username: UILabel!
    
    private lazy var viewModel = ProfileViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.loadUserInfo()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        avatar.layer.cornerRadius = avatar.frame.height / 2
        switch viewModel.state {
        case .loading:
            informationView.isHidden = false
            loadingView.isHidden = false
            loader.startAnimating()
            messageView.isHidden = true
            tableView.isHidden = true
        case let .message(text):
            informationView.isHidden = false
            loadingView.isHidden = true
            loader.stopAnimating()
            messageView.isHidden = false
            message.text = text
            tableView.isHidden = true
        case let .success(props):
            informationView.isHidden = true
            loader.stopAnimating()
            updateHeader(with: props)
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
}

// MARK: - Private actions
extension ProfileViewController {
    
    @objc private func refresh() {
        viewModel.loadUserInfo()
    }
    
    private func updateHeader(with properties: ProfileViewModel.ProfileViewProperties) {
        var firstName = properties.name.first
        if let title = properties.name.title {
            firstName = title.capitalized + ". " + firstName.capitalized
        }
        let text = NSMutableAttributedString(string: firstName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .medium)])
        text.append(NSAttributedString(string: " " + properties.name.last.capitalized, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        nameLabel.attributedText = text
        username.text = properties.username
        updateAvatar(properties.picture)
    }
    
    private func updateAvatar(_ picture: Picture) {
        guard let url = URL(string: picture.large) else {
            avatar.image = nil
            return
        }
        
        background {
            Alamofire.request(url).responseImage { response in
                main {
                    self.avatar.image = response.result.value
                }
            }
        }
    }
}

// MARK: - ProfileView
extension ProfileViewController: ProfileView {
    
    func update() {
        view.setNeedsLayout()
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let .success(props) = viewModel.state else {
            return 0
        }
        return props.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .success(props) = viewModel.state, let info = props.cells[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell", for: indexPath) as! UserDataCell
        cell.configure(title: info.title, value: info.value)
        return cell
    }
}

// MARK: - View setup
extension ProfileViewController {
    
    private func setupView() {
        titleLabel.text = "Profile"
        loadingTitle.text = "Loading…"
        setupRetryButton()
        setupTableView()
        avatar.clipsToBounds = true
    }
    
    private func setupRetryButton() {
        retryButton.setTitle("Tap to retry", for: .normal)
        retryButton.layer.cornerRadius = 4
        retryButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "UserDataCell", bundle: nil), forCellReuseIdentifier: "UserDataCell")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
