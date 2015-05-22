# ReflectableEnum

[![Build Status](https://travis-ci.org/fastred/ReflectableEnum.svg?branch=master)](https://travis-ci.org/fastred/ReflectableEnum)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A macro and a set of functions introducing reflection for enumerations in Objective-C.

Features:

- get a string value for an enumeration's member (which is a [<u>common</u>][1] [<u>problem</u>][2])
- get all values used in an enumeration (also a [<u>prevalent</u>][3] [<u>issue</u>][4])
- get a minimum value in an enumeration
- get a maximum value in an enumeration

## Usage

Once you have ReflectableEnum added to your project, you just need to replace existing enum definitions, like:

```obj-c
typedef NS_ENUM(NSUInteger, AccountType) {
  AccountTypeStandard,
  AccountTypeAdmin
};
```

with:

```obj-c
REFLECTABLE_ENUM(NSInteger, AccountType,
  AccountTypeStandard,
  AccountTypeAdmin
);
```

Now you can get a string representing an enumerator and all/minimum/maximum values of an enumeration the enumerator belongs to with:

```obj-c
AccountType accountType = AccountTypeStandard;
NSString *typeString = REFStringForMember(accountType);          // @"AccountTypeStandard"
NSArray *allValues = REFAllValuesForEnumWithMember(accountType); // @[@0, @1]
NSInteger mininimum = REFMinForEnumWithMember(accountType);      // 0
NSInteger maximum = REFMaxForEnumWithMember(accountType);        // 1
```

In case you pass the enumerator directly to one of these functions, you have to cast it to `AccountType`, because the compiler doesn't know its type (it's treated as `NSInteger` in this case):

```obj-c
NSString *typeString = REFStringForMember((AccountType)AccountTypeStandard);
NSArray *allValues = REFAllValuesForEnumWithMember((AccountType)AccountTypeStandard);
NSInteger mininimum = REFMinForEnumWithMember((AccountType)AccountTypeStandard);
NSInteger maximum = REFMaxForEnumWithMember((AccountType)AccountTypeStandard);
```

The need to cast is a hassle, so `ReflectableEnum` will create enum-specific functions for you too:

```obj-c
NSString *typeString = REFStringForMemberInAccountType(AccountTypeStandard);
NSArray *allValues = REFAllValuesInAccountType();
NSInteger mininimum = REFMinInAccountType();
NSInteger maximum = REFMaxInAccountType();
```

As you can see names of these functions depend on the name of the enumeration and follow these patterns: `REFStringForMemberIn\(enumName)`, `REFAllValuesIn\(enumName)`, `REFMinIn\(enumName)` and `REFMaxIn\(enumName)` 

## Drawbacks

- `REFStringForMember` and `REFStringForMemberIn\(enumName)` don't work with enumerations containing duplicated values, e.g. with self-referencing members `AccountTypeModerator = AccountTypeAdmin`
- can't be used for enumerations already defined in frameworks and libraries

## Requirements

 * iOS 7 and above
 * OS X 10.9 and above

## Installation

Install with Carthage:

    github "fastred/ReflectableEnum"

or with CocoaPods:

    pod "ReflectableEnum"

And then import with: `#import <ReflectableEnum/ReflectableEnum.h>`

## Author

Arkadiusz Holko:

* [Blog](http://holko.pl/)
* [@arekholko on Twitter](https://twitter.com/arekholko)

  [1]:http://stackoverflow.com/questions/6331762/enum-values-to-nsstring-ios
  [2]:http://stackoverflow.com/questions/1094984/convert-objective-c-typedef-to-its-string-equivalent
  [3]:http://stackoverflow.com/questions/6910127/iteration-over-enum-in-objective-c
  [4]:http://stackoverflow.com/questions/1662719/looping-through-enum-values
  [5]:http://www.openradar.me/radar?id=6679230377099264
