//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 21/09/2022.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var vm = PeopleViewModel()
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    @State private var hasAppeared = false

    var body: some View {
        NavigationView {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(vm.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                        .task {
                                            if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                                await vm.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                    }
                    .overlay(alignment: .leading) {
                        if vm.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    refresh
                }
            }
            .task {
                if !hasAppeared {
                    await vm.fetchUsers()
                    hasAppeared = true
                }
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess = true
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchUsers() 
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess = false
                                }
                            }
                        }
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}


private extension PeopleView {
    var background: some View {
        Theme.background
            .ignoresSafeArea()
    }
    var create: some View {
        Button {
            shouldShowCreate = true
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
        .disabled(vm.isLoading)
    }
    var refresh: some View {
        Button {
            Task {
                await vm.fetchUsers()
            }
        } label: {
            Symbols.refresh
        }
        .disabled(vm.isLoading)
    }
}
