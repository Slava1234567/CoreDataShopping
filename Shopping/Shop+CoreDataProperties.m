//
//  Shop+CoreDataProperties.m
//  Shopping
//
//  Created by Slava on 7/22/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Shop+CoreDataProperties.h"

@implementation Shop (CoreDataProperties)

+ (NSFetchRequest<Shop *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shop"];
}

@dynamic name;
@dynamic shopping;
@dynamic person;

@end
