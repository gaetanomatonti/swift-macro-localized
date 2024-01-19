# Localized
A Swift macro to access localized strings in Swift Packages.

## Why `#Localized`?
Swift Packages support resources, such as assets and localized strings. However, these are only accessible from a `.module` Bundle instance inside the package. This can prove to be tricky when using such resources in SwiftUI views.

Some SwiftUI views, like `Text`, provide initializers where it's possible to specify the Bundle that contains a specific resource. This parameter defaults to the main app Bundle, meaning you must specify it for every view in your package.
It may sound easy, but it's not.

Many views are attached to others as modifiers – alerts are among those. You can specify a title in the modifier function, but you cannot specify a bundle. Even worse, the APIs do not allow you to directly use a `LocalizedStringResource`, which does allow you to specify a bundle. So the correct way to approach this problem would be to use the `String(localized:)` initializer – which also provides a bundle parameter. This means defining your strings as follows:
```swift
.alert(String(localized: "Are you sure you want to delete this item?", bundle: .module), isPresented: $isPresented) {
  ...
}
```

This can be simplified using the `#Localized` macro, which expands your `LocalizedStringResource` into a `String(localized:)` expression.
```swift
.alert(#Localized("Are you sure you want to delete this item?"), isPresented: $isPresented) {
  ...
}
```

While it's not great that SwiftUI cannot automatically infer the bundle where a view is located, this is the best solution so far to:
- ensure developers access resources from the correct bundle
- support localized String interpolation
- extract used strings with the compiler

## Requirements
Please, be mindful that this macro only works in Swift Packages that embed resources, as it uses the `Bundle.module` accessor synthesized by the package.
