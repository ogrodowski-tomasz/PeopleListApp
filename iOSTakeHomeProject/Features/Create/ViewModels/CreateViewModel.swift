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
    
    private let networkingManager: NetworkingManagerImpl!
    private let validator: CreateValidationImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared,
         validator: CreateValidationImpl = CreateValidator()) {
        self.networkingManager = networkingManager
        self.validator = validator
    }
    
    /*
     @MainActor annotation is a way to mark a function that handles UI updates on the main thread, so the request is made on a background thread but the UI updates are published on the main thread
     */
    @MainActor
    func create() async {
        do {
            try validator.validate(person)
            self.state = .submitting
            
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(person)
            
            try await networkingManager.request(session: .shared, .create(submissionData: data))
            self.state = .successful
            
        } catch {
            self.hasError = true
            self.state = .unsuccessful
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
            default:
                self.error = .system(error: error)
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
        case system(error: Error)
    }
}

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error),
                .validation(let error):
            return error.errorDescription
        case .system(let error):
            return error.localizedDescription
        }
    }
}

extension CreateViewModel.FormError: Equatable {
    static func == (lhs: CreateViewModel.FormError, rhs: CreateViewModel.FormError) -> Bool {
        switch (lhs, rhs) {
        case (.networking(let lhsType), .networking(let rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        case (.validation(let lhsType), .validation(let rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        case (.system(let lhsType), .system(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}
