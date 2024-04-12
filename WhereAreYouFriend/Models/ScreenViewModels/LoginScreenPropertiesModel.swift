//
//  File.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 11.04.2024.
//

import Foundation

class LoginScreenPropertiesModel {
    var firstTextFieldTitle: String = ""
    var firstTextFieldText: String = ""
    var firstTextFieldPlaceHolder: String = ""
    
    var secondtTextFieldTitle: String = ""
    var secondtTextFieldText: String = ""
    var secondTextFieldPlaceHolder: String = ""
    
    var pageNumber: Int = 1
    
    init() {
        
    }
    
    init (firstTextFieldTitle: String,
          firstTextFieldPlaceHolder: String ,
          secondtTextFieldTitle: String ,
          secondTextFieldPlaceHolder: String,
          pageNumber: Int) {
        
        self.firstTextFieldTitle = firstTextFieldTitle
        self.firstTextFieldPlaceHolder = firstTextFieldPlaceHolder
        self.secondtTextFieldTitle = secondtTextFieldTitle
        self.secondTextFieldPlaceHolder = secondTextFieldPlaceHolder
        self.pageNumber = pageNumber
        
    }
}
