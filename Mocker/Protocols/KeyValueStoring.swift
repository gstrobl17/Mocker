//
//  KeyValueStoring.swift
//  Mocker
//
//  Created by Greg on 2/25/18.
//

import Foundation

/// Protocol to define what UserDefaults should look like for the application.
/// This protocol exists so that a Mock/Fake implementation can be created for unit/integration testing.
public protocol KeyValueStoring {
    
    /*!
     -objectForKey: will search the receiver's search list for a default with the key 'defaultName' and return it. If another process has changed defaults in the search list, NSUserDefaults will automatically update to the latest values. If the key in question has been marked as ubiquitous via a Defaults Configuration File, the latest value may not be immediately available, and the registered value will be returned instead.
     */
    func object(forKey defaultName: String) -> Any?
    
    /*!
     -setObject:forKey: immediately stores a value (or removes the value if nil is passed as the value) for the provided key in the search list entry for the receiver's suite name in the current user and any host, then asynchronously stores the value persistently, where it is made available to other processes.
     */
    func set(_ value: Any?, forKey defaultName: String)
    
    /// -removeObjectForKey: is equivalent to -[... setObject:nil forKey:defaultName]
    func removeObject(forKey defaultName: String)
    
    /// -stringForKey: is equivalent to -objectForKey:, except that it will convert NSNumber values to their NSString representation. If a non-string non-number value is found, nil will be returned.
    func string(forKey defaultName: String) -> String?
    
    /// -arrayForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray.
    func array(forKey defaultName: String) -> [Any]?
    
    /// -dictionaryForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSDictionary.
    func dictionary(forKey defaultName: String) -> [String: Any]?
    
    /// -dataForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSData.
    func data(forKey defaultName: String) -> Data?
    
    /// -stringForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray<NSString *>. Note that unlike -stringForKey:, NSNumbers are not converted to NSStrings.
    func stringArray(forKey defaultName: String) -> [String]?
    
    /*!
     -integerForKey: is equivalent to -objectForKey:, except that it converts the returned value to an NSInteger. If the value is an NSNumber, the result of -integerValue will be returned. If the value is an NSString, it will be converted to NSInteger if possible. If the value is a boolean, it will be converted to either 1 for YES or 0 for NO. If the value is absent or can't be converted to an integer, 0 will be returned.
     */
    func integer(forKey defaultName: String) -> Int
    
    /// -floatForKey: is similar to -integerForKey:, except that it returns a float, and boolean values will not be converted.
    func float(forKey defaultName: String) -> Float
    
    /// -doubleForKey: is similar to -doubleForKey:, except that it returns a double, and boolean values will not be converted.
    func double(forKey defaultName: String) -> Double
    
    /*!
     -boolForKey: is equivalent to -objectForKey:, except that it converts the returned value to a BOOL. If the value is an NSNumber, NO will be returned if the value is 0, YES otherwise. If the value is an NSString, values of "YES" or "1" will return YES, and values of "NO", "0", or any other string will return NO. If the value is absent or can't be converted to a BOOL, NO will be returned.
     
     */
    func bool(forKey defaultName: String) -> Bool
    
    /*!
     -URLForKey: is equivalent to -objectForKey: except that it converts the returned value to an NSURL. If the value is an NSString path, then it will construct a file URL to that path. If the value is an archived URL from -setURL:forKey: it will be unarchived. If the value is absent or can't be converted to an NSURL, nil will be returned.
     */
    func url(forKey defaultName: String) -> URL?
    
    /// -setInteger:forKey: is equivalent to -setObject:forKey: except that the value is converted from an NSInteger to an NSNumber.
    func set(_ value: Int, forKey defaultName: String)
    
    /// -setFloat:forKey: is equivalent to -setObject:forKey: except that the value is converted from a float to an NSNumber.
    func set(_ value: Float, forKey defaultName: String)
    
    /// -setDouble:forKey: is equivalent to -setObject:forKey: except that the value is converted from a double to an NSNumber.
    func set(_ value: Double, forKey defaultName: String)
    
    /// -setBool:forKey: is equivalent to -setObject:forKey: except that the value is converted from a BOOL to an NSNumber.
    func set(_ value: Bool, forKey defaultName: String)
    
    /// -setURL:forKey is equivalent to -setObject:forKey: except that the value is archived to an NSData. Use -URLForKey: to retrieve values set this way.
    func set(_ url: URL?, forKey defaultName: String)
    
    /*!
     -registerDefaults: adds the registrationDictionary to the last item in every search list. This means that after NSUserDefaults has looked for a value in every other valid location, it will look in registered defaults, making them useful as a "fallback" value. Registered defaults are never stored between runs of an application, and are visible only to the application that registers them.
     
     Default values from Defaults Configuration Files will automatically be registered.
     */
    func register(defaults registrationDictionary: [String: Any])
    
    /*!
     -synchronize is deprecated and will be marked with the NS_DEPRECATED macro in a future release.
     
     -synchronize blocks the calling thread until all in-progress set operations have completed. This is no longer necessary. Replacements for previous uses of -synchronize depend on what the intent of calling synchronize was. If you synchronized...
     - ...before reading in order to fetch updated values: remove the synchronize call
     - ...after writing in order to notify another program to read: the other program can use KVO to observe the default without needing to notify
     - ...before exiting in a non-app (command line tool, agent, or daemon) process: call CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
     - ...for any other reason: remove the synchronize call
     */
    func synchronize() -> Bool
}
