//
//  ColorProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.

import SwiftUI

public enum ColorProvider {
    public static let primary = Color(red: 0.13, green: 0.17, blue: 0.27)
    public static let background = Color(red: 0.95, green: 0.95, blue: 0.97)
    public static let backgroundCard = Color.white
    public static let textPrimary = Color(red: 0.15, green: 0.15, blue: 0.20)
    public static let textSecondary = Color.gray
    public static let textOnPrimary = Color.white
    public static let textOnPrimaryMuted = Color.white.opacity(0.85)
    
    public static let statusActive = Color(red: 0.18, green: 0.72, blue: 0.45)
    public static let statusOverdue = Color(red: 0.95, green: 0.62, blue: 0.15)
    public static let statusDefault = Color(red: 0.90, green: 0.22, blue: 0.21)
    public static let statusPaid = Color(red: 0.55, green: 0.55, blue: 0.58)
    
    public static let typePersonal = Color(red: 0.13, green: 0.17, blue: 0.27)
    public static let typeMortgage = Color(red: 0.16, green: 0.50, blue: 0.73)
    public static let typeAuto = Color(red: 0.20, green: 0.60, blue: 0.56)
    public static let typeBusiness = Color(red: 0.58, green: 0.34, blue: 0.14)
    
    public static let error = Color.red
    public static let borderDefault = Color.gray.opacity(0.5)
    public static let borderError = Color.red
    public static let borderSuccess = ColorProvider.statusActive
    
    public static func status(_ status: String) -> Color {
        switch status {
        case "active": return statusActive
        case "overdue": return statusOverdue
        case "default": return statusDefault
        case "paid": return statusPaid
        default: return Color.gray
        }
    }
    
    public static func loanType(_ type: String) -> Color {
        switch type {
        case "personal": return typePersonal
        case "mortgage": return typeMortgage
        case "auto": return typeAuto
        case "business": return typeBusiness
        default: return Color.gray
        }
    }
    
    public static func dueColor(dueIn: Int) -> Color {
        if dueIn > 0 { return statusActive }
        if dueIn == 0 { return statusOverdue }
        return statusDefault
    }
}
