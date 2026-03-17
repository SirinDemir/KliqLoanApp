//
//  Keys.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//
//  String Catalog (Localizable.xcstrings) ile lokalizasyon. Key yoksa default kullanılır.
//  Best practice: .xcstrings tek dosyada tüm diller, Xcode ile yönetim, plural/device varyantları.
//

import Foundation

public enum Keys {

    private static var cache: [String: String] = [:]
    private static let cacheLock = NSLock()

    public static func localized(key: String, default defaultValue: String, table: String = "Localizable", bundle: Bundle = .main) -> String {
        let cacheKey = "\(table).\(key)"
        cacheLock.lock()
        defer { cacheLock.unlock() }
        if let cached = cache[cacheKey] {
            return cached
        }
        let value = bundle.localizedString(forKey: key, value: defaultValue, table: table)
        cache[cacheKey] = value
        return value
    }

    // MARK: - Common
    public enum Common {
        public static var error: String { Keys.localized(key: "common.error", default: "Error") }
        public static var ok: String { Keys.localized(key: "common.ok", default: "OK") }
        public static var configurationError: String { Keys.localized(key: "common.configuration_error", default: "Configuration error. Please restart the app.") }
    }

    // MARK: - Login
    public enum Login {
        public static var title: String { Keys.localized(key: "login.title", default: "Kliq Loan") }
        public static var placeholderEmail: String { Keys.localized(key: "login.placeholder_email", default: "E-mail address") }
        public static var placeholderPassword: String { Keys.localized(key: "login.placeholder_password", default: "Password") }
        public static var signIn: String { Keys.localized(key: "login.sign_in", default: "Sign In") }
    }

    // MARK: - Home
    public enum Home {
        public static var title: String { Keys.localized(key: "home.title", default: "Loan Portfolio") }
        public static var logout: String { Keys.localized(key: "home.logout", default: "Logout") }
        public static var filter: String { Keys.localized(key: "home.filter", default: "Filter") }
        public static var filterAll: String { Keys.localized(key: "home.filter_all", default: "All") }
        public static var filterActive: String { Keys.localized(key: "home.filter_active", default: "Active") }
        public static var filterOverdue: String { Keys.localized(key: "home.filter_overdue", default: "Overdue") }
        public static var filterDefault: String { Keys.localized(key: "home.filter_default", default: "Default") }
        public static var filterPaid: String { Keys.localized(key: "home.filter_paid", default: "Paid") }
        private static let loansInPortfolioFormat = Keys.localized(key: "home.loans_in_portfolio_format", default: "%d loans in portfolio")
        public static func loansInPortfolio(_ count: Int) -> String {
            String(format: loansInPortfolioFormat, count)
        }
        public static var avgInterestRateDefault: String { Keys.localized(key: "home.avg_interest_rate_default", default: "Avg. interest rate: 0.00%") }
        private static let avgInterestRateFormat = Keys.localized(key: "home.avg_interest_rate_format", default: "Avg. interest rate: %.2f%%")
        public static func avgInterestRate(_ value: Double) -> String {
            String(format: avgInterestRateFormat, value)
        }
    }

    // MARK: - LoanCard
    public enum LoanCard {
        public static var dueToday: String { Keys.localized(key: "loan_card.due_today", default: "Due today") }
        private static let daysRemainingFormat = Keys.localized(key: "loan_card.days_remaining_format", default: "%d days remaining")
        public static func daysRemaining(_ count: Int) -> String {
            String(format: daysRemainingFormat, count)
        }
        private static let daysOverdueFormat = Keys.localized(key: "loan_card.days_overdue_format", default: "%d days overdue")
        public static func daysOverdue(_ count: Int) -> String {
            String(format: daysOverdueFormat, abs(count))
        }
        private static let interestFormatFormat = Keys.localized(key: "loan_card.interest_format", default: "%.1f%% interest")
        public static func interestFormat(_ rate: Double) -> String {
            String(format: interestFormatFormat, rate)
        }
    }

    // MARK: - Validation
    public enum Validation {
        public static var email: String { Keys.localized(key: "validation.email", default: "Email") }
        public static var password: String { Keys.localized(key: "validation.password", default: "Password") }
        public static var invalidEmailFormat: String { Keys.localized(key: "validation.invalid_email_format", default: "Invalid email format") }
    }
}
