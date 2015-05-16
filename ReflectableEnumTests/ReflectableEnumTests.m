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
}


#pragma mark - Min - generic function

- (void)testMinForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMinForMember((FirstEnum)FirstEnum1), 0);

  FirstEnum x = FirstEnum1;
  XCTAssertEqual(REFMinForMember(x), 0);
}

- (void)testMinForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMinForMember((SecondEnum)SecondEnum1), -1);

  SecondEnum x = SecondEnum1;
  XCTAssertEqual(REFMinForMember(x), -1);
}

- (void)testMinForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertEqual(REFMinForMember((ThirdEnum)ThirdEnum1), 0);

  ThirdEnum x = ThirdEnum1;
  XCTAssertEqual(REFMinForMember(x), 0);
}


#pragma mark - Max - generic function

- (void)testMaxForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMaxForMember((FirstEnum)FirstEnum1), 1);

  FirstEnum x = FirstEnum1;
  XCTAssertEqual(REFMaxForMember(x), 1);
}

- (void)testMaxForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqual(REFMaxForMember((SecondEnum)SecondEnum1), 2);

  SecondEnum x = SecondEnum1;
  XCTAssertEqual(REFMaxForMember(x), 2);
}

- (void)testMaxForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertEqual(REFMaxForMember((ThirdEnum)ThirdEnum1), 3);

  ThirdEnum x = ThirdEnum1;
  XCTAssertEqual(REFMaxForMember(x), 3);
}


#pragma mark - All values - generic function

- (void)testAllValuesForEnumWithConsecutiveValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFAllValuesForMember((FirstEnum)FirstEnum1), (@[@0, @1]));

  FirstEnum x = FirstEnum1;
  XCTAssertEqualObjects(REFAllValuesForMember(x), (@[@0, @1]));
}

- (void)testAllValuesForEnumWithInconsecutiveValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFAllValuesForMember((SecondEnum)SecondEnum1), (@[@(-1), @2]));

  SecondEnum x = SecondEnum1;
  XCTAssertEqualObjects(REFAllValuesForMember(x), (@[@(-1), @2]));
}

- (void)testAllValuesForEnumWithDuplicatedValuesUsingGenericFunction
{
  XCTAssertEqualObjects(REFAllValuesForMember((ThirdEnum)ThirdEnum1), (@[@0, @1, @3]));

  ThirdEnum x = ThirdEnum1;
  XCTAssertEqualObjects(REFAllValuesForMember(x), (@[@0, @1, @3]));
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

@end
