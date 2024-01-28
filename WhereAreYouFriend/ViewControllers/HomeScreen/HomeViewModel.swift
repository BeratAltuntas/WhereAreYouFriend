//
//  HomeViewModel.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 29.01.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
}

protocol HomeViewModelDelegate: AnyObject {
    
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
}

extension HomeViewModel: HomeViewModelProtocol {
    
}
