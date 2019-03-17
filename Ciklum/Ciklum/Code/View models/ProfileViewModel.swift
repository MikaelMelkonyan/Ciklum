//
//  ProfileViewModel.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

final class ProfileViewModel {
    
    private unowned var view: ProfileView
    init(view: ProfileView) {
        self.view = view
    }
    
    private(set) var state: RequestStaste<ProfileViewProperties> = .loading {
        didSet {
            main {
                self.view.update()
            }
        }
    }
}

// MARK: - Public
extension ProfileViewModel {
    
    func loadUserInfo() {
        state = .loading
        background {
            let api = ProfileApi()
            api.getUser { [weak self] (resultState) in
                guard let strongSelf = self else {
                    return
                }

                switch resultState {
                case let .success(user):
                    strongSelf.state = .success(ProfileViewProperties(user: user))
                case let .error(text):
                    strongSelf.state = .message(text)
                }
            }
        }
    }
}

// MARK: - ProfileViewProperties
extension ProfileViewModel {
    
    struct ProfileViewProperties {
        
        let picture: Picture
        let name: Name
        let username: String
        let cells: [(title: String, value: String)]
        
        init(user: User) {
            picture = user.picture
            name = user.name
            username = user.username
            
            cells = [
                ("Postal Address", user.location.description),
                ("E-mail", user.email),
                ("Cell", user.cell),
                ("Registered", user.registeredAt.textFormat)
            ]
        }
    }
}
