import Foundation
import Localized

#if SWIFT_PACKAGE
let string = #Localized("Hello \(Date.now, format: .dateTime)")

print(string)
#endif
