
@interface TableItem : NSObject

@property (nonatomic, copy) void (^action)(UITableView *, NSIndexPath *);
@property (nonatomic, copy) UITableViewCell *(^cell)(UITableView *, NSIndexPath *);
@property (nonatomic, copy) void (^deleted)();

@end

@interface TableSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) void(^removedItemAtIndex)(NSIndexPath *);
@property (nonatomic, copy) NSArray *items;

@end