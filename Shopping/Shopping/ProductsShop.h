//
//  ProductsShop.h
//  Shopping
//
//  Created by Slava on 7/21/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductsShop : NSObject

@property(copy, nonatomic) NSArray* nameProducts;
@property(copy, nonatomic) NSArray* priceProducts;

- (NSString*)getName;
@end
