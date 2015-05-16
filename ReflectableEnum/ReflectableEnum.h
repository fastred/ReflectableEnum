//
//  ReflectableEnum.h
//  ReflectableEnum
//
//  Created by Arkadiusz on 16-05-15.
//  Copyright (c) 2015 Arkadiusz Holko. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for ReflectableEnum.
FOUNDATION_EXPORT double ReflectableEnumVersionNumber;

//! Project version string for ReflectableEnum.
FOUNDATION_EXPORT const unsigned char ReflectableEnumVersionString[];

// Private
NSString *private_REFString(NSString *enumDefinition, NSNumber *number);
long long private_REFMax(NSString *enumDefinition);
long long private_REFMin(NSString *enumDefinition);
NSArray *private_REFAllValues(NSString *enumDefinition);
typedef int ExampleEnum;


// PUBLIC API

// Functions like these below are created by REFLECTABLE_ENUM macro for each enum during preprocessing.
// Functions created for your enum will look like them, except names and parameters' types will be replaced: s/ExampleEnum/YourEnumName/g.
// WARNING: Functions below serve only as an  example of the API, they're not implemented.

// Generic (overloaded) functions

__attribute__((overloadable)) NSString *REFStringForMember(ExampleEnum value); // Returns nil if the value doesn't exist.
__attribute__((overloadable)) long long REFMaxForMember(ExampleEnum value);
__attribute__((overloadable)) long long REFMinForMember(ExampleEnum value);
__attribute__((overloadable)) NSArray *REFAllValuesForMember(ExampleEnum value);

// Specific functions

NSString *REFStringForMemberInExampleEnum(ExampleEnum value); // Returns nil if the value doesn't exist.
NSInteger REFMinInExampleEnum();
NSInteger REFMaxInExampleEnum();
NSArray *REFAllValuesInExampleEnum();


#define REFLECTABLE_ENUM(type, name, ...) \
typedef NS_ENUM(type, name) { \
__VA_ARGS__ \
}; \
\
__attribute__((overloadable)) NSString *REFStringForMember(name value) \
{ \
  return private_REFString(@(#__VA_ARGS__), @(value)); \
} \
\
__attribute__((overloadable)) type REFMinForMember(name value) \
{ \
  return (type)private_REFMin(@(#__VA_ARGS__)); \
} \
\
__attribute__((overloadable)) type REFMaxForMember(name value) \
{ \
  return (type)private_REFMax(@(#__VA_ARGS__)); \
} \
\
__attribute__((overloadable)) NSArray *REFAllValuesForMember(name value) \
{ \
  return private_REFAllValues(@(#__VA_ARGS__)); \
} \
\
__attribute__((overloadable)) NSString *REFStringForMemberIn##name(name value) \
{ \
  return private_REFString(@(#__VA_ARGS__), @((name)value)); \
} \
\
type REFMinIn##name(void) \
{ \
  return (type)private_REFMin(@(#__VA_ARGS__)); \
} \
\
type REFMaxIn##name(void) \
{ \
  return (type)private_REFMax(@(#__VA_ARGS__)); \
} \
\
NSArray *REFAllValuesIn##name(void) \
{ \
  return private_REFAllValues(@(#__VA_ARGS__)); \
} \
