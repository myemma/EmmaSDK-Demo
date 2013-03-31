#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textAlignment = NSTextAlignmentRight;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        [self.contentView addSubview:textField];
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textFieldWidth = self.contentView.bounds.size.width / 2 - 10;
    [textField sizeToFit];
    textField.frame = CGRectMake(textFieldWidth + 10, (self.contentView.bounds.size.height - textField.frame.size.height) / 2, textFieldWidth, textField.frame.size.height);
    [textField.superview bringSubviewToFront:textField];
}

+ (TextFieldCell *)cellWithLabel:(NSString *)label {
    TextFieldCell *result = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    result.selectionStyle = UITableViewCellSelectionStyleNone;
    result.textLabel.text = label;
    result.textField.placeholder = label;
    
    return result;
}

- (BOOL)textFieldShouldReturn:(UITextField *)leTextField {
    [textField resignFirstResponder];
    return NO;
}

@end
