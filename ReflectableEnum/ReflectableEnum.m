//
//  ReflectableEnum.m
//  ReflectableEnum
//
//  Created by Arkadiusz on 16-05-15.
//  Copyright (c) 2015 Arkadiusz Holko. All rights reserved.
//

#import "ReflectableEnum.h"

@implementation NSArray (IEMap)

- (NSArray *)ine_map: (id (^)(id obj))block
{
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
  for(id obj in self) {
    [array addObject:block(obj)];
  }

  return array;
}

@end


@interface REFEnumRepresentation : NSObject

@property (nonatomic, assign, readonly) long long maximumValue; // long long should cover most common cases of enum types: NSInteger and NSUInteger
@property (nonatomic, assign, readonly) long long mininimumValue;
@property (nonatomic, assign, readonly) BOOL containsDuplicates;
@property (nonatomic, copy, readonly) NSArray *allValues;
- (NSString *)stringForNumber:(NSNumber *)number;

@end

@interface REFEnumRepresentation ()

@property (nonatomic, copy, readonly) NSDictionary *mapFromValueToString;
@property (nonatomic, assign, readwrite) long long maximumValue;
@property (nonatomic, assign, readwrite) long long minimumValue;
@property (nonatomic, copy, readwrite) NSArray *allValues;

@end

@implementation REFEnumRepresentation

- (instancetype)initWithEnumDefinition:(NSString *)enumDefinition
{
  self = [super init];
  if (self) {
    [self setupWithEnumDefinition:enumDefinition];
  }

  return self;
}

- (long long)maximumValue
{
  if (!_maximumValue) {
    NSArray *keys = [self.mapFromValueToString allKeys];
    _maximumValue = [[keys valueForKeyPath:@"@max.self"] longLongValue];
  }

  return _maximumValue;
}

- (long long)minimumValue
{
  if (!_minimumValue) {
    NSArray *keys = [self.mapFromValueToString allKeys];
    _minimumValue = [[keys valueForKeyPath:@"@min.self"] longLongValue];
  }

  return _minimumValue;
}

- (NSString *)stringForNumber:(NSNumber *)number
{
  NSAssert(!self.containsDuplicates, @"It's not possible to get string for the enum with duplicated values.");
  return self.mapFromValueToString[number];
}

- (NSArray *)allValues
{
  if (!_allValues) {
    _allValues = [[self.mapFromValueToString allKeys] sortedArrayUsingSelector:@selector(compare:)];
  }

  return _allValues;
}

#pragma mark - Private

- (void)setupWithEnumDefinition:(NSString *)enumDefinition
{
  NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
  numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

  long long currentIndex = -1;
  NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];

  for (NSString *member in [enumDefinition componentsSeparatedByString:@","]) {
    NSArray *parts = [[member componentsSeparatedByString:@"="] ine_map:^NSString *(NSString *element) {
      return [element stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }];
    NSCAssert(parts.count == 1 || parts.count == 2, @"Illegal member definition");

    NSString *name = [parts firstObject];
    if (parts.count == 2) {
      NSString *valueString = [parts lastObject];
      NSNumber *number = [numberFormatter numberFromString:valueString];

      if (!number) {
        NSArray *matchingKeys = [mutableDictionary allKeysForObject:valueString];
        _containsDuplicates = YES;
        number = matchingKeys.firstObject;
        NSCAssert(number, @"Parsing should lead to a number");
      }

      currentIndex = [number longLongValue];
    } else {
      currentIndex++;
    }

    mutableDictionary[@(currentIndex)] = name;
  }

  _mapFromValueToString = [mutableDictionary copy];
}

@end


REFEnumRepresentation *private_REFRepresentationFromDefinition(NSString *enumDefinition)
{
  static NSDictionary *cacheMappingFromEnumDefinitionToRepresentation;

  if (!cacheMappingFromEnumDefinitionToRepresentation[enumDefinition]) {
    NSMutableDictionary *mutableCache = [cacheMappingFromEnumDefinitionToRepresentation mutableCopy] ?: [NSMutableDictionary new];
    mutableCache[enumDefinition] = [[REFEnumRepresentation alloc] initWithEnumDefinition:enumDefinition];
    cacheMappingFromEnumDefinitionToRepresentation = [mutableCache copy];
  }

  return cacheMappingFromEnumDefinitionToRepresentation[enumDefinition];
}

NSString *private_REFString(NSString *enumDefinition, NSNumber *number)
{
  return [private_REFRepresentationFromDefinition(enumDefinition) stringForNumber:number];
}

long long private_REFMax(NSString *enumDefinition)
{
  return private_REFRepresentationFromDefinition(enumDefinition).maximumValue;
}

long long private_REFMin(NSString *enumDefinition)
{
  return private_REFRepresentationFromDefinition(enumDefinition).minimumValue;
}

NSArray *private_REFAllValues(NSString *enumDefinition)
{
  return private_REFRepresentationFromDefinition(enumDefinition).allValues;
}
