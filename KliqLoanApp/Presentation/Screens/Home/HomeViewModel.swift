//
//  HomeViewModel.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI
import Combine

public enum LoanFilter: String, CaseIterable {
    case all
    case active
    case overdue
    case `default`
    case paid

    public var displayTitle: String {
        switch self {
        case .all: return Keys.Home.filterAll
        case .active: return Keys.Home.filterActive
        case .overdue: return Keys.Home.filterOverdue
        case .default: return Keys.Home.filterDefault
        case .paid: return Keys.Home.filterPaid
        }
    }
}

@MainActor
public final class HomeViewModel: BaseViewModel, DataReturnable, CompletionHandling {
    @Published public var allLoans: [Loan] = []
    @Published public var filteredLoans: [Loan] = []
    @Published public var selectedFilter: LoanFilter = .all
    @Published public var totalAmount: String = "$0"
    @Published public var loanCountText: String = Keys.Home.loansInPortfolio(0)
    @Published public var avgRateText: String = Keys.Home.avgInterestRateDefault
    
    public private(set) var transferredUserEmail: String?
    
    public var completionDataHandler: CompletionDataHandler?

    private let loanReactive: LoanReactiveProtocol?
    private let router: Router?
    private var cancellables = Set<AnyCancellable>()

    private let loadTrigger = PassthroughSubject<Void, Never>()

    public init(loanReactive: LoanReactiveProtocol? = nil, router: Router? = nil) {
        let lr = loanReactive ?? ServiceLocator.shared.resolve(LoanReactiveProtocol.self)
        let r = router ?? ServiceLocator.shared.resolve(Router.self)
        self.loanReactive = lr
        self.router = r
        super.init()
        if lr == nil || r == nil {
            configurationError = Keys.Common.configurationError
        } else {
            bindLoansObserver()
        }
    }

    // MARK: - DataReturnable (makale)

    public func prepareInjectData(_ data: ModelTransferable?) {
        if let userData = data as? UserTransferData {
            transferredUserEmail = userData.email
        }
    }

    public func setCompletionDataHandler(_ handler: @escaping CompletionDataHandler) {
        completionDataHandler = handler
    }

    private func bindLoansObserver() {
        guard let loanReactive else { return }
        loadTrigger
            .flatMap { [weak self] _ -> AnyPublisher<[Loan], Error> in
                self?.setLoadingState(.loading) ?? ()
                self?.dismissError()
                return loanReactive.processAndUpdateLoans()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.setLoadingState(.idle)
                    if case .failure(let error) = completion {
                        self?.showError(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] loans in
                    self?.setLoadingState(.success)
                    self?.allLoans = loans
                    self?.applyFilter()
                    self?.setLoadingState(.idle)
                }
            )
            .store(in: &cancellables)
    }
    
    private func applyFilter() {
        switch selectedFilter {
        case .all: filteredLoans = allLoans
        case .active: filteredLoans = allLoans.filter { $0.status == "active" }
        case .overdue: filteredLoans = allLoans.filter { $0.status == "overdue" }
        case .default: filteredLoans = allLoans.filter { $0.status == "default" }
        case .paid: filteredLoans = allLoans.filter { $0.status == "paid" }
        }
        updateSummary()
    }
    
    private func updateSummary() {
        let total = filteredLoans.reduce(0.0) { $0 + $1.principal_amount }
        let avgRate = filteredLoans.isEmpty ? 0.0 : filteredLoans.reduce(0.0) { $0 + $1.interest_rate } / Double(filteredLoans.count)
        totalAmount = "$\(Int(total))"
        loanCountText = Keys.Home.loansInPortfolio(filteredLoans.count)
        avgRateText = Keys.Home.avgInterestRate(avgRate)
    }
    
    public func loadLoans() {
        guard loanReactive != nil else { return }
        loadTrigger.send(())
    }

    public func selectFilter(_ filter: LoanFilter) {
        selectedFilter = filter
        applyFilter()
    }

    public func logout() {
        guard let router else {
            showError(configurationError ?? Keys.Common.configurationError)
            return
        }
        if let email = transferredUserEmail {
            completionDataHandler?(UserTransferData(email: email))
        }
        router.logout()
    }
}
