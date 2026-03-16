//
//  LoanCard.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

public struct LoanCard: View {
    let loan: Loan
    
    public init(loan: Loan) {
        self.loan = loan
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                StyledText(loan.name, provider: BodyBoldTextStyleProvider())
                
                Spacer()
                
                HStack(spacing: 8) {
                    BadgeView(text: loan.type.uppercased(), color: ColorProvider.loanType(loan.type))
                    BadgeView(text: loan.status.uppercased(), color: ColorProvider.status(loan.status))
                }
            }
            
            HStack(alignment: .center) {
                StyledText(formatAmount(loan.principal_amount), provider: AmountTextStyleProvider())

                StyledText(Keys.LoanCard.interestFormat(loan.interest_rate), provider: CaptionTextStyleProvider())
            }

            StyledText(dueText(loan.due_in), provider: SmallTextStyleProvider())
                .foregroundColor(ColorProvider.dueColor(dueIn: loan.due_in))
        }
        .padding(Spacing.xLarge)
        .background(ColorProvider.backgroundCard)
        .cornerRadius(CornerRadius.medium)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
    
    private func formatAmount(_ amount: Double) -> String {
        "$\(Int(amount))"
    }
    
    private func dueText(_ dueIn: Int) -> String {
        if dueIn > 0 { return Keys.LoanCard.daysRemaining(dueIn) }
        if dueIn == 0 { return Keys.LoanCard.dueToday }
        return Keys.LoanCard.daysOverdue(dueIn)
    }
}

public struct BadgeView: View {
    let text: String
    let color: Color
    
    public var body: some View {
        StyledText(" \(text) ", provider: BadgeTextStyleProvider())
            .background(color)
            .cornerRadius(Spacing.small.rawValue)
    }
}
