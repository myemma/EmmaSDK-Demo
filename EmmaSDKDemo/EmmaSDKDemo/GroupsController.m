#import "GroupsController.h"
#import "TableSource.h"
#import "GroupController.h"

@interface GroupsController ()

@property (nonatomic, strong) UITableView *view;
@property (nonatomic, strong) TableSource *source;

@end

@implementation GroupsController

@dynamic view;

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _source = [[TableSource alloc] init];
        self.title = @"Groups";
        [self showDefaultNavigationBarItems];
    }
    return self;
}

- (void)showEditingNavigationBarItems {
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editDoneTapped)];
}

- (void)showDefaultNavigationBarItems {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTapped)];
}

- (void)loadView {
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.view.delegate = _source;
    self.view.dataSource = _source;
    self.view.allowsSelectionDuringEditing = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [[EMClient.shared getGroupsWithType:EMGroupTypeAll inRange:EMResultRangeAll] subscribeNext:^(NSArray *groups) {
        _source.items = [groups.rac_sequence map:^id(EMGroup *g) {
            TableItem *item = [[TableItem alloc] init];
            item.cell = ^ UITableViewCell * (UITableView *table, NSIndexPath *indexPath) {
                UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"GroupCell"];
                
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"GroupCell"];
                }
                
                cell.textLabel.text = g.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d member%@", g.activeCount, g.activeCount == 1 ? @"" : @"s"];
                
                return cell;
            };
            item.deleted = ^ {
                [[EMClient.shared deleteGroupID:g.ID] subscribeCompleted:^{}];
            };
            item.action = ^ (UITableView *table, NSIndexPath *indexPath) {
                if (self.view.editing) {
                    [self presentGroupControllerWithGroup:g];
                }
            };
            return item;
        }].array;
        [self.view reloadData];
    }];
}

- (void)presentGroupControllerWithGroup:(EMGroup *)group {
    UIViewController *c = [[GroupController alloc] initWithGroup:group];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:c];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)addGroup {
    [self presentGroupControllerWithGroup:nil];
}

- (void)editTapped {
    [self.view setEditing:YES animated:YES];
    [self showEditingNavigationBarItems];
}

- (void)editDoneTapped {
    [self.view setEditing:NO animated:YES];
    [self showDefaultNavigationBarItems];
}

@end
