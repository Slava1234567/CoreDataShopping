//
//  Person+CoreDataProperties.h
//  Shopping
//
//  Created by Slava on 7/22/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) float cash;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Shopping *> *shopping;
@property (nullable, nonatomic, retain) NSSet<Shop *> *shop;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addShoppingObject:(Shopping *)value;
- (void)removeShoppingObject:(Shopping *)value;
- (void)addShopping:(NSSet<Shopping *> *)values;
- (void)removeShopping:(NSSet<Shopping *> *)values;

- (void)addShopObject:(Shop *)value;
- (void)removeShopObject:(Shop *)value;
- (void)addShop:(NSSet<Shop *> *)values;
- (void)removeShop:(NSSet<Shop *> *)values;

@end

NS_ASSUME_NONNULL_END
