//
//  CreateValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

#if DEBUG

import Foundation

struct CreateValidatorSuccessMock: CreateValidationImpl {
    
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws { }
    
}

#endif
