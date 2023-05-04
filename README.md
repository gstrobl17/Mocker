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