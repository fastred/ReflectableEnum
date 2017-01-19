//
//  ReflectableEnumTests.m
//  ReflectableEnumTests
//
//  Created by Arkadiusz on 16-05-15.
//  Copyright (c) 2015 Arkadiusz Holko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

#import "ReflectableEnum.h"


REFLECTABLE_ENUM(NSInteger,
                 FirstEnum,
                 FirstEnum1,
                 FirstEnum2)

REFLECTABLE_ENUM(NSInteger,
                 SecondEnum,
                 SecondEnum1 = -1,
                 SecondEnum2 = 2)

REFLECTABLE_ENUM(NSInteger,
                 ThirdEnum,
                 ThirdEnum1,
                 ThirdEnum2 = ThirdEnum1,
                 ThirdEnum3,
                 ThirdEnum4 = 3)

REFLECTABLE_ENUM(NSInteger,
                 FourthEnum,
                 FourthEnum1,
                 FourthEnum2 = 0,
                 FourthEnum3,
                 FourthEnum4)


@interface ReflectableEnumTests : XCTestCase

@end

@implementation ReflectableEnumTests

#pragma mark - String - generic function

- (void)testStringForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFStringForMember((FirstEnum)FirstEnum1), @"FirstEnum1");
  XCTAssertEqualObjects(REFStringForMember((FirstEnum)FirstEnum2), @"FirstEnum2");
  XCTAssertEqualObjects(REFStringForMember((FirstEnum)2), nil);

  FirstEnum x = FirstEnum1;
  XCTAssertEqualObjects(REFStringForMember(x), @"FirstEnum1");
  FirstEnum y = FirstEnum2;
  XCTAssertEqualObjects(REFStringForMember(y), @"FirstEnum2");
}

- (void)testStringForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFStringForMember((SecondEnum)SecondEnum1), @"SecondEnum1");
  XCTAssertEqualObjects(REFStringForMember((SecondEnum)SecondEnum2), @"SecondEnum2");
  XCTAssertEqualObjects(REFStringForMember((SecondEnum)0), nil);

  SecondEnum x = SecondEnum1;
  XCTAssertEqualObjects(REFStringForMember(x), @"SecondEnum1");
  SecondEnum y = SecondEnum2;
  XCTAssertEqualObjects(REFStringForMember(y), @"SecondEnum2");
}

- (void)testStringForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertThrowsSpecific(REFStringForMember((ThirdEnum)ThirdEnum1), NSException);

  ThirdEnum x = ThirdEnum1;
  XCTAssertThrowsSpecific(REFStringForMember(x), NSException);
    
  XCTAssertThrowsSpecific(REFStringForMember((FourthEnum)FourthEnum1), NSException);
    
  FourthEnum y = FourthEnum1;
  XCTAssertThrowsSpecific(REFStringForMember(y), NSException);
}


#pragma mark - Min - generic function

- (void)testMinForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMinForEnumWithMember((FirstEnum)FirstEnum1), 0);

  FirstEnum x = FirstEnum1;
  XCTAssertEqual(REFMinForEnumWithMember(x), 0);
}

- (void)testMinForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMinForEnumWithMember((SecondEnum)SecondEnum1), -1);

  SecondEnum x = SecondEnum1;
  XCTAssertEqual(REFMinForEnumWithMember(x), -1);
}

- (void)testMinForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertEqual(REFMinForEnumWithMember((ThirdEnum)ThirdEnum1), 0);

  ThirdEnum x = ThirdEnum1;
  XCTAssertEqual(REFMinForEnumWithMember(x), 0);
}


#pragma mark - Max - generic function

- (void)testMaxForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMaxForEnumWithMember((FirstEnum)FirstEnum1), 1);

  FirstEnum x = FirstEnum1;
  XCTAssertEqual(REFMaxForEnumWithMember(x), 1);
}

- (void)testMaxForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMaxForEnumWithMember((SecondEnum)SecondEnum1), 2);

  SecondEnum x = SecondEnum1;
  XCTAssertEqual(REFMaxForEnumWithMember(x), 2);
}

- (void)testMaxForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertEqual(REFMaxForEnumWithMember((ThirdEnum)ThirdEnum1), 3);

  ThirdEnum x = ThirdEnum1;
  XCTAssertEqual(REFMaxForEnumWithMember(x), 3);
}


#pragma mark - All values - generic function

- (void)testAllValuesForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFAllValuesForEnumWithMember((FirstEnum)FirstEnum1), (@[@0, @1]));

  FirstEnum x = FirstEnum1;
  XCTAssertEqualObjects(REFAllValuesForEnumWithMember(x), (@[@0, @1]));
}

- (void)testAllValuesForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFAllValuesForEnumWithMember((SecondEnum)SecondEnum1), (@[@(-1), @2]));

  SecondEnum x = SecondEnum1;
  XCTAssertEqualObjects(REFAllValuesForEnumWithMember(x), (@[@(-1), @2]));
}

- (void)testAllValuesForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFAllValuesForEnumWithMember((ThirdEnum)ThirdEnum1), (@[@0, @1, @3]));

  ThirdEnum x = ThirdEnum1;
  XCTAssertEqualObjects(REFAllValuesForEnumWithMember(x), (@[@0, @1, @3]));
}


#pragma mark - String - specific function

- (void)testStringForEnumWithConsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqualObjects(REFStringForMemberInFirstEnum(FirstEnum1), @"FirstEnum1");
  XCTAssertEqualObjects(REFStringForMemberInFirstEnum(FirstEnum2), @"FirstEnum2");
  XCTAssertEqualObjects(REFStringForMemberInFirstEnum(2), nil);

  FirstEnum x = FirstEnum1;
  XCTAssertEqualObjects(REFStringForMemberInFirstEnum(x), @"FirstEnum1");
  FirstEnum y = FirstEnum2;
  XCTAssertEqualObjects(REFStringForMemberInFirstEnum(y), @"FirstEnum2");
}

- (void)testStringForEnumWithInconsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqualObjects(REFStringForMemberInSecondEnum(SecondEnum1), @"SecondEnum1");
  XCTAssertEqualObjects(REFStringForMemberInSecondEnum(SecondEnum2), @"SecondEnum2");
  XCTAssertEqualObjects(REFStringForMemberInSecondEnum(0), nil);

  SecondEnum x = SecondEnum1;
  XCTAssertEqualObjects(REFStringForMemberInSecondEnum(x), @"SecondEnum1");
  SecondEnum y = SecondEnum2;
  XCTAssertEqualObjects(REFStringForMemberInSecondEnum(y), @"SecondEnum2");
}

- (void)testStringForEnumWithDuplicatedValuesUsingSpecificFuntion
{
  XCTAssertThrowsSpecific(REFStringForMemberInThirdEnum(ThirdEnum1), NSException);
}

#pragma mark - Enum - specific function
    
- (void)testEnumForStringWithConsecutiveValuesUsingSpecificFunction
{
    XCTAssertEqual(REFEnumForMemberInFirstEnum(@"FirstEnum1"), FirstEnum1);
    XCTAssertEqual(REFEnumForMemberInSecondEnum(@"SecondEnum2"), SecondEnum2);
    XCTAssertEqual(REFEnumForMemberInThirdEnum(@"ThirdEnum3"), ThirdEnum3);
    
    ThirdEnum x = ThirdEnum3;
    XCTAssertEqual(REFEnumForMember(x, @"ThirdEnum3"), ThirdEnum3);
    
}
    
#pragma mark - Min - specific function

- (void)testMinForEnumWithConsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqual(REFMinInFirstEnum(), 0);
}

- (void)testMinForEnumWithInconsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqual(REFMinInSecondEnum(), -1);
}

- (void)testMinForEnumWithDuplicatedValuesUsingSpecificFunction
{
  XCTAssertEqual(REFMinInThirdEnum(), 0);
}


#pragma mark - Max - specific function

- (void)testMaxForEnumWithConsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqual(REFMaxInFirstEnum(), 1);
}

- (void)testMaxForEnumWithInconsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqual(REFMaxInSecondEnum(), 2);
}

- (void)testMaxForEnumWithDuplicatedValuesUsingSpecificFunction
{
  XCTAssertEqual(REFMaxInThirdEnum(), 3);
}


#pragma mark - All values - specific function

- (void)testAllValuesForEnumWithConsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqualObjects(REFAllValuesInFirstEnum(), (@[@0, @1]));
}

- (void)testAllValuesForEnumWithInconsecutiveValuesUsingSpecificFunction
{
  XCTAssertEqualObjects(REFAllValuesInSecondEnum(), (@[@(-1), @2]));
}

- (void)testAllValuesForEnumWithDuplicatedValuesUsingSpecificFunction
{
  XCTAssertEqualObjects(REFAllValuesInThirdEnum(), (@[@0, @1, @3]));
}


#pragma mark - Min/Max caching

- (void)testMinShouldReturnTheSameValueEachTime
{
  XCTAssertEqual(REFMinInSecondEnum(), -1);
  XCTAssertEqual(REFMinInSecondEnum(), -1);
}

- (void)testMaxShouldReturnTheSameValueEachTime
{
  XCTAssertEqual(REFMaxInSecondEnum(), 2);
  XCTAssertEqual(REFMaxInSecondEnum(), 2);
}

@end
