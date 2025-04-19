# Xcode Instacrash

This is a minimum reproducer for an Xcode instacrash when a Package.swift file presents a target whose source are hard links to other files in the file system.

## To reproduce the crash
1. Create the hard links running this commands (git can't represents hard links, so they have to be created locally):
```
mkdir -p Sources/DependencyHL/Root
ln ./Sources/Dependency/Root/Subfolder/MyObject.h ./Sources/DependencyHL/Root/MyObject.h
ln ./Sources/Dependency/Root/Subfolder/MyObject.cpp ./Sources/DependencyHL/Root/MyObject.cpp
```
2. Double click on the `Package.swift` file to open the project in Xcode
3. press <kbd>⌘</kbd>+<kbd>B</kbd> and observe the project build successfully
4. Click on one of the linked files in the `DependencyHL` folder and observe Xcode crash.

## Motivation
We are migrating React Native from Cocoapods to Swift PM.

React Native has a complex structure and some custom import and include paths.

Specifically, the `React` folders contains all the Objective-C files of the project. The folder has several subfolders, such as `Base`, `Default`, and others. However, the `import` path for all the files in the `React` subtrees should be `#import <React/Header.h>` and not `#import <React/Subfolder/Header.h>`.

For example, if a client has to import the `RCTBridge.h`, which is located in the `React/Base` path, we want for it to be imported with `#import <React/RCTBridge.h>` and not with `#import <React/Base/RCTBridge.h>`.

Currently, Swift PM does not allow remapping of the headers. So, one possible solution would be to prepare the repository by creating hard links to the original files in a temporary location, and have the `Package.swift` file use that temporary location as source. This would have the benefit that, when a file is modified from the link, the original file get modified as well.

However, this can't be achieved because Xcode crashes as soon as we try to open one of the hard links.

https://github.com/user-attachments/assets/1604b020-3135-4866-a400-42e5e10e07df

