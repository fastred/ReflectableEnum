# ReflectableEnum

A macro and a set of functions introducing reflection for enumerations in Objective-C.

Features:

- get a string value for an enumeration's member (which is a [common][1] [problem][2])
- get a minimum value of an enumeration
- get a maximum value of an enumeration
- get all values used in an enumeration

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
REFLECTABLE_ENUM(NSInteger,
                 AccountType,
                 AccountTypeStandard,
                 AccountTypeAdmin);
```

Now you can get a string representing an enumerator and minimum/maximum/all values of an enumeration the enumerator belongs to with:

```obj-c
AccountType accountType = AccountTypeStandard;
NSString *typeString = REFStringForMember(accountType);  // @"AccountTypeStandard"
NSInteger mininimum = REFMinForMember(accountType);      // 0
NSInteger maximum = REFMaxForMember(accountType);        // 1
NSArray *allValues = REFAllValuesForMember(accountType); // @[@0, @1]
```

In case you pass the enumerator directly to one of these functions, you have to cast it to `AccountType`, because the compiler doesn't know the type of the enumerator:

```obj-c
NSString *typeString = REFStringForMember((AccountType)AccountTypeStandard);
NSInteger mininimum = REFMinForMember((AccountType)AccountTypeStandard);
NSInteger maximum = REFMaxForMember((AccountType)AccountTypeStandard);
NSArray *allValues = REFAllValuesForMember((AccountType)AccountTypeStandard);
```

The need to cast is such a bummer (rdar://20990819), so `ReflectableEnum` will create enum-specific functions for you too:

```obj-c
NSString *typeString = REFStringForMemberInAccountType(AccountTypeStandard);
NSInteger mininimum = REFMinInAccountType();
NSInteger maximum = REFMaxInAccountType();
NSArray *allValues = REFAllValuesInAccountType();
```

As you can see names of these functions depend on the name of the enumeration and follow these patterns: `REFStringForMemberIn\(enumName)`, `REFMinIn\(enumName)`, `REFMaxIn\(enumName)` and `REFAllValuesIn\(enumName)`.

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
