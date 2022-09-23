//
//  CreateValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

struct CreateValidatorSuccessMock: CreateValidationImpl {
    
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws { }
    
}
