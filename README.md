![Swift](https://github.com/NSMutableString/be.chronux.typedTranslations/workflows/Swift/badge.svg)
## TypedTranslations

this swift package will make it easy to enable typed access to your literal specified in the `.strings` file.

### What to expect?

When you have a `Localized.strings` file containing following data:

```
"welcomeText" = "Hello %@, welcome in our app.";
"close" = "Close";
```

This will generate following swift code:

``` swift
//
//  Localizations.swift
//
//  Generated code that contains the available keys from en.lproj/Localizable.strings
//  Copyright © 2020. All rights reserved.
//

import Foundation

extension String {
	func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
		NSLocalizedString(self, tableName: tableName, bundle: bundle, value: self, comment: "")
	}

	func localizedWithParameters(bundle: Bundle = .main, tableName: String = "Localizable", args: CVarArg...) -> String {
		String.localizedStringWithFormat(self.localized(bundle: bundle, tableName: tableName), args)
	}
}

struct Localizations {

	private init() {}

	/// Base translation: Hello %@, welcome in our app.
	static func welcomeText(args: CVarArg...) -> String {
		"welcomeText".localizedWithParameters(args: args)
	}
	/// Base translation: Close
	static let close = "close".localized()
}

```

Now, you can use the following approach for easy access of your translations. In case no parameters provided, just use `Localizations.close` or in case you need to pass parameters. Just type `Localizations.welcomeText("John Doe")`.

### Quick run

```
swift run -c release TypedTranslations Localizable.strings
```

### Where is my XCode project?
- Run `open Package.swift` to open this swift package.

### Tests

For running tests, just run `swift test`. 
