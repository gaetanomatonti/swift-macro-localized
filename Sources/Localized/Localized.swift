import Foundation

/// A macro that produces a localized string from a `LocalizedStringResource`
@freestanding(expression)
public macro Localized(_ stringResource: LocalizedStringResource) -> String = #externalMacro(module: "LocalizedMacros", type: "LocalizeMacro")
