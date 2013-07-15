//
//  ONDKVOHelper.h
//  Created by Oliver Denman on 07/04/2013.

#import <Foundation/Foundation.h>

@interface ONDKVOHelper : NSObject

@property (weak) id callingObject;
@property (retain) NSDictionary *receivedDictionary;
@property (strong) NSMutableDictionary *keysDictionary;

- (id)initWithNSDictionaryOfKeysAndMethods:(NSDictionary *)dictionary AndReferenceToSelf:(id)caller;

@end
