//
//  UserViewModel.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 29.01.2024.
//

import Foundation

// MARK: - UserViewModelProtocol
protocol UserViewModelProtocol {
    var delegate: UserViewModelDelegate? { get set }
}

// MARK: - UserViewModelDelegate
protocol UserViewModelDelegate: AnyObject {
    
}

// MARK: - UserViewModel
final class UserViewModel {
    internal weak var delegate: UserViewModelDelegate?
}

// MARK: - UserViewModelExtension
extension UserViewModel: UserViewModelProtocol {
   
}
