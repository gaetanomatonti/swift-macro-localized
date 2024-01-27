import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(LocalizedMacros)
import LocalizedMacros

let testMacros: [String: Macro.Type] = [
  "Localized": LocalizeMacro.self,
]
#endif

final class LocalizedTests: XCTestCase {
  func testMacro() throws {
    #if canImport(LocalizedMacros)
    assertMacroExpansion(
      """
      #Localized("Hello World")
      """,
      expandedSource: """
          {
            #if SWIFT_PACKAGE
            return String(localized: "Hello World", bundle: .module)
            #else
            final class BundleToken {}
            return String(localized: "Hello World", bundle: Bundle(for: BundleToken.self))
            #endif
          }()
      """,
      macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
