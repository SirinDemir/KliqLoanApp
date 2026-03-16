//
//  FormField.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

public enum FormFieldType: Hashable {
    case email
    case password
}

public struct FormField<FocusValue: Hashable>: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    let validationResult: ValidationResult?
    let fieldType: FocusValue
    var isSecure: Bool = false
    var focusBinding: FocusState<FocusValue?>.Binding?
    var onNext: (() -> Void)?
    var onSubmit: (() -> Void)?

    public init(
        label: String,
        placeholder: String,
        text: Binding<String>,
        validationResult: ValidationResult? = nil,
        fieldType: FocusValue,
        isSecure: Bool = false,
        focusBinding: FocusState<FocusValue?>.Binding? = nil,
        onNext: (() -> Void)? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self.validationResult = validationResult
        self.fieldType = fieldType
        self.isSecure = isSecure
        self.focusBinding = focusBinding
        self.onNext = onNext
        self.onSubmit = onSubmit
    }

    private var inputField: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
        }
    }
    
    private var borderColor: Color {
        guard let result = validationResult else { return ColorProvider.borderDefault }
        return result.isValid ? ColorProvider.borderSuccess : ColorProvider.borderError
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if !label.isConsideredEmpty {
                StyledText(label, provider: FormLabelTextStyleProvider())
            }

            inputField
            .modifier(OptionalFocusModifier(binding: focusBinding, value: fieldType))
            .submitLabel(onNext != nil ? .next : .done)
            .onSubmit {
                if let onNext = onNext {
                    onNext()
                } else {
                    onSubmit?()
                }
            }
            .padding(Spacing.large)
            .background(ColorProvider.backgroundCard)
            .cornerRadius(CornerRadius.small)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(borderColor, lineWidth: 1)
            )
            
            if let result = validationResult, !result.isValid, let message = result.errorMessage {
                StyledText(message, provider: ErrorTextStyleProvider())
            }
        }
    }
}

private struct OptionalFocusModifier<Value: Hashable>: ViewModifier {
    let binding: FocusState<Value?>.Binding?
    let value: Value
    
    func body(content: Content) -> some View {
        if let binding = binding {
            content.focused(binding, equals: value)
        } else {
            content
        }
    }
}
