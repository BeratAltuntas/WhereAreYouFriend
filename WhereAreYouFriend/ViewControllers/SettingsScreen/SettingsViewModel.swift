//
//  SettingsViewModel.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 29.01.2024.
//

import Foundation

// MARK: - SettingsViewModelProtocol
protocol SettingsViewModelProtocol {
    var delegate: SettingsViewModelDelegate? { get set }
}

// MARK: - SettingsViewModelDelegate
protocol SettingsViewModelDelegate: AnyObject {
    
}

// MARK: - SettingsViewModel
final class SettingsViewModel {
    internal weak var delegate: SettingsViewModelDelegate?
}

// MARK: - SettingsViewModelExtension
extension SettingsViewModel: SettingsViewModelProtocol {
    
}
