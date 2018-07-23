//
//  Shopping+CoreDataProperties.h
//  Shopping
//
//  Created by Slava on 7/22/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Shopping+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Shopping (CoreDataProperties)

+ (NSFetchRequest<Shopping *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) float price;
@property (nullable, nonatomic, retain) Person *person;
@property (nullable, nonatomic, retain) Shop *shop;

@end

NS_ASSUME_NONNULL_END
