# Mocker

Mocker, a Mac OS app, is a tool that generates Mock implementations for protocols in the style of the Strobl Approach to Unit Testing.

![MockerScreenShot](/assets/MockerScreenShot.png)

To use Mocker, select an Xcode project to load it into the tool. The swift files in the Xcode project are listed in the left pane. Next, select one of the swift files. If the selected file contains protocols, you can select the protocol you want to generate a Mock for. By default the first protocol in the file will be selected. The code for the Mock if the selected protocol will be displayed in the right pane.

The code for the Mock can be put in your project in a couple of ways:

- Copy and paste the code from right pane (recommended method)
- Generate a file from the tool and add the file to your project via Xcode 
- Generate a file and have the tool insert the file into your project (**NOT recommended** because of the changes made to the project file by the XcodeEditor framework being utilized)

Use the code generated from Mocker as the starting point for your mock implementations. It is not meant to generate files perfectly ready to use within your unit testing.

## License
[Unlicense](https://unlicense.org)