#import "GroupsController.h"
#import "TableSource.h"

@interface GroupsController ()

@property (nonatomic, strong) UITableView *view;
@property (nonatomic, strong) TableSource *source;

@end

@implementation GroupsController

@dynamic view;

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _source = [[TableSource alloc] init];
    }
    return self;
}

- (void)loadView {
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.view.delegate = _source;
    self.view.dataSource = _source;
}

- (void)viewWillAppear:(BOOL)animated {
    [[EMClient.shared getGroupsWithType:EMGroupTypeAll inRange:EMResultRangeAll] subscribeNext:^(NSArray *groups) {
        _source.items = [groups.rac_sequence map:^id(EMGroup *g) {
            TableItem *item = [[TableItem alloc] init];
            item.cell = ^ UITableViewCell * (UITableView *table, NSIndexPath *indexPath) {
                UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"GroupCell"];
                
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupCell"];
                }
                
                cell.textLabel.text = g.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d member%@", g.activeCount, g.activeCount == 1 ? @"" : @"s"];
                
                return cell;
            };
            return item;
        }].array;
    }];
}

@end
