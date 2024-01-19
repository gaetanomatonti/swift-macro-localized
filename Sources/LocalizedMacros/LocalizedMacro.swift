import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct LocalizeMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    guard let argument = node.argumentList.first?.expression else {
      fatalError("compiler bug: the macro does not have any arguments")
    }

    return """
    {
      #if SWIFT_PACKAGE
      return String(localized: \(argument), bundle: .module)
      #else
      final class BundleToken {}
      return String(localized: \(argument), bundle: Bundle(for: BundleToken.self))
      #endif
    }()
    """
  }
}

@main
struct LocalizedPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    LocalizeMacro.self,
  ]
}
