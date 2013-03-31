#import "GroupController.h"
#import "TableSource.h"
#import "TextFieldCell.h"

@interface GroupController ()

@property (nonatomic, strong) UITableView *view;
@property (nonatomic, strong) TableSource *source;
@property (nonatomic, strong) EMGroup *group;

@end

@implementation GroupController

@dynamic view;

- (id)initWithGroup:(EMGroup *)group {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.title = @"Group";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped)];
        
        _group = group;
        _source = [[TableSource alloc] init];
        
        TableItem *item = [[TableItem alloc] init];
        item.cell = ^ UITableViewCell *(UITableView *table, NSIndexPath *indexPath) {
            
            TextFieldCell *cell = [table dequeueReusableCellWithIdentifier:@"GroupTextCell"];
            
            if (!cell) {
                cell = [TextFieldCell cellWithLabel:@"Name"];
            }
            
            cell.textField.text = group.name;
            
            RAC(group.name) = cell.textField.rac_textSignal;
            
            return cell;
        };
        
        _source.items = @[ item ];
    }
    return self;
}

- (void)loadView {
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.view.delegate = _source;
    self.view.dataSource = _source;
    self.view.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view reloadData];
}

- (void)cancelTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneTapped {
    NSUInteger indexes[] = { 0, 0 };
    
    TextFieldCell *cell = (TextFieldCell *)[self.view cellForRowAtIndexPath:[[NSIndexPath alloc] initWithIndexes:indexes length:2]];
    
    RACSignal *signal;
    
    if (_group.ID)
        signal = [EMClient.shared updateGroup:_group];
    else
        signal = [EMClient.shared createGroupsWithNames:@[ cell.textField.text ]];
    
    [signal subscribeCompleted:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
