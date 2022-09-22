//
//  DetailViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 21/09/2022.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchDetails(for id: Int) {
        self.isLoading = true
        NetworkingManager.shared.request(.detail(id: id), ofType: UserDetailResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                defer { self?.isLoading = false }
                switch result {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
    
}

