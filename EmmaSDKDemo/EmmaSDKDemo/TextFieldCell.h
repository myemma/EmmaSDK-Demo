
@interface TextFieldCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

+ (TextFieldCell *)cellWithLabel:(NSString *)label;

@end
