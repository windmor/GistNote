//
//  Gist+CoreDataProperties.h
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Gist.h"

NS_ASSUME_NONNULL_BEGIN

@interface Gist (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *gist_id;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) User *owner;

@end

NS_ASSUME_NONNULL_END
