//
//  ONDKVOHelper.m
//  Created by Oliver Denman on 07/04/2013.

#import "ONDKVOHelper.h"

@implementation ONDKVOHelper

// Caller sends reference to self and dictionary of values to be observed and methods to call.
//
//     Example:
//     NSDictionary *keysAndMethods = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    @"methodname1",@"value1",
//                                    @"methodname2",@"value2", ...
//                                    nil];
//
- (id)initWithNSDictionaryOfKeysAndMethods:(NSDictionary *)dictionary AndReferenceToSelf:(id)caller
{

    if (self = [super init]) {

        self.keysDictionary = [[NSMutableDictionary alloc] init];
        self.receivedDictionary = [dictionary copy];
        self.callingObject = caller;

        for (NSString *key in dictionary) {
            if ([self.callingObject respondsToSelector:NSSelectorFromString(key)]) {
                [self registerKey:key];
            } else {
                NSLog(@"%@ does not have property for key:%@",self.callingObject,key);
            }
        }
    }

    return self;
}

// Register key for KVO. (NSKeyValueObservingOptionNew)
- (void) registerKey:(NSString *)key
{

    NSString *keyPathString = [NSString stringWithFormat:@"callingObject.%@",key];
    [self addObserver:self forKeyPath:keyPathString options:NSKeyValueObservingOptionNew context:nil];
    [self.keysDictionary setObject:key forKey:keyPathString];
}

// Calls method on callingObject
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    NSString *selectorKeyString = [self.keysDictionary objectForKey:keyPath];
    NSString *selectorString = [self.receivedDictionary objectForKey:selectorKeyString];

    if (NSSelectorFromString(selectorString)) {
        if ([self.callingObject respondsToSelector:NSSelectorFromString(selectorString)]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.callingObject performSelector:NSSelectorFromString(selectorString)];
            #pragma clang diagnostic pop
        } else {
            NSLog(@"%@ does not respond to selector: %@",self.callingObject,selectorString);
        }
    }
}

@end
