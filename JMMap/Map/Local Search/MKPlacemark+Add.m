//
//  MKPlacemark+Add.m
//  JMMap
//
//  Created by tigerfly on 2020/9/12.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MKPlacemark+Add.h"
#import <Contacts/Contacts.h>

@implementation MKPlacemark (Add)

- (NSString *)formatString {
    
    CNPostalAddress *postalAddress = self.postalAddress;
   return [CNPostalAddressFormatter stringFromPostalAddress:postalAddress style:CNPostalAddressFormatterStyleMailingAddress];
}

@end
