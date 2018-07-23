//
//  ProductsShop.m
//  Shopping
//
//  Created by Slava on 7/21/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "ProductsShop.h"

static NSString* name[] = {
    @"Авст", @"Августин", @"Аврор", @"Агап", @"Адам", @"Аксён", @"Алевтин", @"Александр", @"Алексей", @"Алексий", @"Альберт", @"Анастасий", @"Анатолий", @"Анвар", @"Андрей", @"Андрон", @"Анисим", @"Антип", @"Антон", @"Антонин", @"Аркадий", @"Арсений", @"Артамон", @"Артём", @"Артемий", @"Артур", @"Архип", @"Аскольд", @"Афанасий", @"Афиноген", @"Борис Богдан", @"Борислав", @"Вадим", @"Валентин", @"Валерий", @"Валерьян", @"Василий", @"Вацлав", @"Велимир", @"Велор", @"Вениамин"
};



@implementation ProductsShop
@synthesize priceProducts = _priceProducts;
@synthesize nameProducts = _nameProducts;

- (NSString*)getName {
    return name[arc4random_uniform(40)];
}

- (NSNumber*) getPrice {
    float price = (float)(arc4random_uniform(11) + 5);
    return [NSNumber numberWithFloat:price];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray* names = [NSMutableArray array];
        NSMutableArray* prices = [NSMutableArray array];
        for (int i = 0; i < 15; i++) {
            NSString* name = [self getName];
            [names addObject:name];
            NSNumber* price = [self getPrice];
            [prices addObject:price];
        }
        _nameProducts = [NSArray arrayWithArray:names];
        _priceProducts = [NSArray arrayWithArray:prices];
    }
    return self;
}

@end
