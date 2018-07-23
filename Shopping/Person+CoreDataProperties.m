//
//  Person+CoreDataProperties.m
//  Shopping
//
//  Created by Slava on 7/22/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic cash;
@dynamic name;
@dynamic shopping;
@dynamic shop;

@end
