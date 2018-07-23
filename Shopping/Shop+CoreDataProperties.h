//
//  Shop+CoreDataProperties.h
//  Shopping
//
//  Created by Slava on 7/22/18.
//  Copyright © 2018 Slava. All rights reserved.
//
//

#import "Shop+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Shop (CoreDataProperties)

+ (NSFetchRequest<Shop *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Shopping *> *shopping;
@property (nullable, nonatomic, retain) NSSet<Person *> *person;

@end

@interface Shop (CoreDataGeneratedAccessors)

- (void)addShoppingObject:(Shopping *)value;
- (void)removeShoppingObject:(Shopping *)value;
- (void)addShopping:(NSSet<Shopping *> *)values;
- (void)removeShopping:(NSSet<Shopping *> *)values;

- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet<Person *> *)values;
- (void)removePerson:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
