//
//  CreateViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 21/09/2022.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    @Published var person = NewPerson()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    private let validator = CreateValidator()
    
    func create() {

        do {
            try validator.validate(person)
            DispatchQueue.main.async {
                self.state = .submitting
            }
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(person)
            
            NetworkingManager
                .shared
                .request(.create(submissionData: data)) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            self?.state = .successful
                        case .failure(let error):
                            self?.state = .unsuccessful
                            self?.hasError = true
                            if let networkingError = error as? NetworkingManager.NetworkingError {
                                self?.error = .networking(error: networkingError)
                                }
                        }
                    }
                }
        } catch {
            DispatchQueue.main.async {
                self.hasError = true
                if let validationError = error as? CreateValidator.CreateValidatorError {
                    self.error = .validation(error: validationError)
                }
            }
        }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case submitting
        case unsuccessful
        case successful
    }
}

extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
    }
}

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error),
                .validation(let error):
            return error.errorDescription
        }
    }
}
