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
      String(localized: "Hello World", bundle: .module)
      """,
      macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
