//
//  CreateView.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 21/09/2022.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm: CreateViewModel
    private let successfulAction: () -> Void
    
    init(successfulAction: @escaping () -> Void) {
        self.successfulAction = successfulAction
        
        #if DEBUG
        if UITestingHelper.isUITesting {
            let mock: NetworkingManagerImpl = UITestingHelper.isCreateNetworkingSuccessful ? NetworkingManagerCreateSuccessMock() : NetworkingManagerCreateFailureMock()
            _vm = StateObject(wrappedValue: CreateViewModel(networkingManager: mock)) // We've done validation already, we want to test when networking is failed
        } else {
            _vm = StateObject(wrappedValue: CreateViewModel())
        }
        #else
            _vm = StateObject(wrappedValue: CreateViewModel())
        #endif
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    firstName
                    lastName
                    job
                } footer: {
                    if case .validation(let err) = vm.error,
                       let errorDesc = err.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }

                
                Section {
                    submit
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .onChange(of: vm.state) { formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { }
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView { }
    }
}

private extension CreateView {
    
    var done: some View {
        Button {
            dismiss()
        } label: {
            Text("Done")
        }
        .accessibilityIdentifier("doneBtn")
    }
    
    var firstName: some View {
        TextField("First Name", text: $vm.person.firstName)
            .focused($focusedField, equals: .firstName)
            .accessibilityIdentifier("firstNameTxtField")
    }
    
    var lastName: some View {
        TextField("Last Name", text: $vm.person.lastName)
            .focused($focusedField, equals: .lastName)
            .accessibilityIdentifier("lastNameTxtField")
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusedField, equals: .job)
            .accessibilityIdentifier("jobTxtField")
    }
    
    var submit: some View {
        Button {
            focusedField = nil
            Task {
                await vm.create()
            }
        } label: {
            Text("Submit")
        }
        .accessibilityIdentifier("submitBtn")
    }
}
