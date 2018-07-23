//
//  Shopping+CoreDataProperties.m
//  Shopping
//
//  Created by Slava on 7/22/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Shopping+CoreDataProperties.h"

@implementation Shopping (CoreDataProperties)

+ (NSFetchRequest<Shopping *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shopping"];
}

@dynamic name;
@dynamic price;
@dynamic person;
@dynamic shop;

@end
