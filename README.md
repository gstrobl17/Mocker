# Mocker

Mocker, a Mac OS app, is a tool that generates mock implementations for protocols in the style of the [Strobl Approach to Unit Testing](https://gist.github.com/gstrobl17/1153977444aeac0c4f1722fecccb97e1).

![MockerScreenShot](/assets/MockerScreenShot.png)

To use Mocker, select an Xcode project to load it into the tool. The Swift files in the Xcode project are listed in the left pane. Next, choose one of the Swift files. If the chosen file contains protocols, you can select the protocol you want to generate a Mock for. By default, the first protocol in the file will be chosen. Finally, the code for the mock of the selected protocol will be displayed in the right pane.

The code for the Mock can be put into your project in a couple of ways:

- Copy and paste the code from the right pane (recommended method)
- Generate a file from the tool and add the file to your project via Xcode 
- Generate a file and have the tool insert the file into your project (**NOT recommended** because of the changes made to the project file by the XcodeEditor framework being utilized)

Use the code generated from Mocker as the starting point for your mock implementations. It is not meant to generate files ready for use within your unit testing.

## License
[Unlicense](https://unlicense.org)

## The Mock
The exact code generated for a mock depends, obviously, on the requirements of the protocol. But generically, most mocks have the following components:

- a `Method` option set. A value for each method in the protocol is defined using the method's name and the parameters. This naming approach handles methods with the same name but different signatures.
 
```swift
    struct Method: OptionSet {
        let rawValue: Int
        static let dataForRequestDelegateCalled = Method(rawValue: 1 << 0)
        static let dataFromUrlDelegateCalled = Method(rawValue: 1 << 1)
    }
```

- a `calledMethods` property of type `Method`. As the methods in the mock are called during a test. The mock will set the value for the method called. At the end of the test, you will know what methods were called in the mock (and what methods weren't called.)

```swift
    private(set) var calledMethods = Method()
```

- a `MethodParameter` option set. This defines a value for each parameter in all the methods in the protocol.

```swift
    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let request = MethodParameter(rawValue: 1 << 0)
        static let delegate = MethodParameter(rawValue: 1 << 1)
        static let url = MethodParameter(rawValue: 1 << 2)
    }
```

- an `assignedParameters` property of type `MethodParameter`. This works the same as `calledMethods` does, except for parameters.

```swift
    private(set) var assignedParameters = MethodParameter()
```

- variables to capture the values passed to methods. All the variables are defined as optional. If a non-optional value is passed to a method, it will be saved in the associated variable for inspection in the unit test.

```swift
    private(set) var request: URLRequest?
    private(set) var delegate: URLSessionTaskDelegate?
    private(set) var url: URL?
```

- variables to control and define the result of a method call in the mock. Those variables will include 
  - values to return from the method call
  - errors to throw
  - flags to control if the method should throw
  - flags to control if completion handlers should be called
 
```swift
    var dataForRequestDelegateReturnValue: (Data, URLResponse)!
    var dataFromUrlDelegateReturnValue: (Data, URLResponse)!

    var errorToThrow: Error!
    var dataForRequestDelegateShouldThrowError = false
    var dataFromUrlDelegateShouldThrowError = false
```

- a `reset()` method. This is used when you have unit tests that must clear the data captured in the mock to isolate upcoming interactions. I have made many mocks that ended up getting interacted with during the setup phase of a unit test class. I then call `reset()` at the end of the setup method to clear anything recorded before the actual unit test is executed. 

```swift
    func reset() {
        calledMethods = []
        assignedParameters = []
        request = nil
        delegate = nil
        url = nil
    }
```

- the method implementations for each method in the protocol. Each mock method records that it has been called, what parameters were provided, then executes the desired method exit path.

```swift
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        calledMethods.insert(.dataForRequestDelegateCalled)
        self.request = request
        assignedParameters.insert(.request)
        self.delegate = delegate
        assignedParameters.insert(.delegate)
        if dataForRequestDelegateShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return dataForRequestDelegateReturnValue
    }
```
 
- `CustomStringConvertible` extensions for the `Method` and `MethodParameter` option sets. With these in place, when tests fail, you get an understandable error message (with expected and unexpected values in a readable format) instead of some undecipherable numeric representation.

```swift
extension MockDataRetreiving.Method: CustomStringConvertible {
    var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }

        if self.contains(.dataForRequestDelegateCalled) {
            handleFirst()
            value += ".dataForRequestDelegateCalled"
        }
        if self.contains(.dataFromUrlDelegateCalled) {
            handleFirst()
            value += ".dataFromUrlDelegateCalled"
        }

        value += "]"
        return value
    }
}
```


The preceding example code is for the mock of the `DataRetreiving` protocol in the [Mocker Demonstration App](https://github.com/gstrobl17/MockerDemonstrationApp). [The entire file is found here.](https://github.com/gstrobl17/MockerDemonstrationApp/blob/main/Mocker%20Demonstration%20AppTests/Mocks/MockDataRetreiving.swift)

