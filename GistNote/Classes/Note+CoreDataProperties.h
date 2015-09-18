//
//  Note+CoreDataProperties.h
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) Gist *initial_gist;

@end

NS_ASSUME_NONNULL_END
