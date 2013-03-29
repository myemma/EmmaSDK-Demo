
@interface TableSection : NSObject

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, copy) NSString *title;

@end

@interface TableItem : NSObject

@property (nonatomic, copy) void (^action)(UITableView *, NSIndexPath *);
@property (nonatomic, copy) UITableViewCell *(^cell)(UITableView *, NSIndexPath *);

@end

@interface TableSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, copy) NSArray *sections;
@property (nonatomic, assign) BOOL displaysIndex;

+ (RACSequence *)tableSectionsFromItems:(RACSequence *)items titleForItem:(NSString *(^)(id))titleForItem tableItemForItem:(TableItem *(^)(id))tableItemForItem;

@end