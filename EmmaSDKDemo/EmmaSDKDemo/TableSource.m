#import "TableSource.h"

@implementation TableItem

@synthesize action, cell;

@end

@interface TableSource ()

@property (nonatomic, strong) NSDictionary *titleIndex;

@end

@implementation TableSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    void(^action)() = ((TableItem *)_items[indexPath.row]).action;
    
    if (action)
        action(tableView, indexPath);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((TableItem *)_items[indexPath.row]).cell(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableItem *removedItem = _items[indexPath.row];
    
    NSMutableArray *newItems = [_items mutableCopy];
    [newItems removeObject:removedItem];
    _items = [newItems copy];
    [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationRight];
    removedItem.deleted();
}

@end
