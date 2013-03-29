#import "TableSource.h"

@implementation TableItem

@synthesize action, cell;

@end

@implementation TableSection

@synthesize items, title;

@end

@interface TableSource ()

@property (nonatomic, strong) NSDictionary *titleIndex;

@end

@implementation TableSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ((TableItem *)((TableSection *)_sections[indexPath.section]).items[indexPath.row]).action(tableView, indexPath);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (((TableSection *)_sections[section]).items).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((TableItem *)((TableSection *)_sections[indexPath.section]).items[indexPath.row]).cell(tableView, indexPath);
}

@end
