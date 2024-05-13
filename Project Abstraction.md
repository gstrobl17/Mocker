# Project Abstraction

## Use of Current Project (and Relations)

- `AsyncFilteringHandler`, `ProjectFilteringHandler`, `FilteringOperation`
  - calls `Project.traverse(filteredBy:monitoredBy:)` which is defined in **XCProject+Extensions**
  - returns tree structure (`TreeNode`) with filter matches. Two parameters were returned from the operation. The exact same object is returned for both parameters. Only the first parameter is used.
<br>
- `ProjectFactory`, `XCProjectFactory`
<br>
- `MockGeneratorParameters`
  - **TODO** analyze how `Project` is used
<br>
- `TreeNodeView`
  - Directly used to figure out the type of icon to render for the node
  - Indirectly used via `TreeNode` parameter
<br>
- `GodfatherInteractor`
  - Holds a reference to the current project
<br>
- `SourceFileSelectorViewController`
  - held to supply as a parameter when creating `TreeNodeView` instances
<br>
- `MockFileParametersViewController`
  - used to define the targets available (currently of type `[XCTarget]`)
<br>
- **[REMOVED]** `DestinationGroupSelector*`
  It looks like this module can be removed. I think it is left over from the "generate" file code.
  
### `XCTarget`

> I think this can be "replaced" in the new abtraction with `String` where **targets** become `[String]`

- `Project`
  - `func targets() -> [XCTarget]!` called by `MockFileParametersViewController.setup(for:)`
  - `func target(withName name: String!) -> XCTarget!`called by `XcodeGroupMember.target(in:)`
<br>
- `extension XcodeGroupMember`
  - `func target(in project: Project) -> XCTarget!` called by `GodfatherInteractor.sourceFileSelector(_:fileSelected:)`
<br> 
- `extension XCTarget`
  - `var nameForCode: String?` called by  
     - `MockFileParametersViewController.comboBox(_:objectValueForItemAt:)`
     - `MockFileParametersViewController.setup(for:)`
<br> 
- `GodfatherInteractor`
  - `private(set) var targetOfCurrentSourceFile: XCTarget?` used/called by
     - `didSet` which calls `MockFileParametersViewController.setup(for:)`
     - `GodfatherInteractor.sourceFileSelector(_:fileSelected:)` where it is cleared/set
<br> 
- `MockFileParametersViewController`
  - `private var targets = [XCTarget]()` used/set by
     - Set in `MockFileParametersViewController.setup(for:)`
     - Used by `MockFileParametersViewController.setup(for:)`
<br> 
