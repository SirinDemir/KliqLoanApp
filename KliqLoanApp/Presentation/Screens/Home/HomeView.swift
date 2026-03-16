//
//  HomeView.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

public struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Group {
            if let configError = viewModel.configurationError {
                configErrorView(message: configError)
            } else {
                mainContent
            }
        }
        .navigationTitle(Keys.Home.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(Keys.Home.logout) {
                    viewModel.logout()
                }
                .foregroundColor(ColorProvider.primary)
            }
        }
        .overlay {
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
            }
        }
        .allowsHitTesting(!viewModel.isLoading)
        .refreshable {
            if viewModel.configurationError == nil { viewModel.loadLoans() }
        }
        .onAppear {
            if viewModel.configurationError == nil { viewModel.loadLoans() }
        }
    }

    private func configErrorView(message: String) -> some View {
        VStack(spacing: Spacing.large.rawValue) {
            StyledText(message, provider: ErrorTextStyleProvider())
                .multilineTextAlignment(.center)
                .padding(Spacing.xLarge)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorProvider.background)
    }

    private var mainContent: some View {
        ZStack {
            ColorProvider.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                summaryCard
                filterSegment
                loanList
            }
        }
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            StyledText(viewModel.totalAmount, provider: HeadingOnPrimaryTextStyleProvider())
            StyledText(viewModel.loanCountText, provider: CaptionOnPrimaryTextStyleProvider())
            StyledText(viewModel.avgRateText, provider: CaptionOnPrimaryTextStyleProvider())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.xxLarge)
        .background(ColorProvider.primary)
        .cornerRadius(CornerRadius.large)
        .padding(.horizontal, Spacing.xLarge)
        .padding(.top, Spacing.large)
    }
    
    private var filterSegment: some View {
        Picker(Keys.Home.filter, selection: $viewModel.selectedFilter) {
            ForEach(LoanFilter.allCases, id: \.self) { filter in
                Text(filter.displayTitle).tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, Spacing.xLarge)
        .padding(.top, Spacing.large)
        .onChange(of: viewModel.selectedFilter) { _, newValue in
            viewModel.selectFilter(newValue)
        }
    }
    
    private var loanList: some View {
        List {
            ForEach(viewModel.filteredLoans) { loan in
                LoanCard(loan: loan)
                    .listRowInsets(EdgeInsets(
                        top: Spacing.medium.rawValue,
                        leading: Spacing.xLarge.rawValue,
                        bottom: Spacing.medium.rawValue,
                        trailing: Spacing.xLarge.rawValue
                    ))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
