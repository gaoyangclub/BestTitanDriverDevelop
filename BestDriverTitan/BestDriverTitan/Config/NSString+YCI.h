//
//  NSString+YCI.h
//  YCIVADemo
//
//  Created by yanchen on 16/6/21.
//  Copyright © 2016年 yanchen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ConcatStrings(firstStr,...) [NSString joinedWithSubStrings:firstStr,__VA_ARGS__,nil]
#define HtmlToText(htmlString) [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

#define SimpleHtmlText(color,size,context) HtmlToText(ConcatStrings(@"<font size='",size,@"' color='",[color hexFromUIColor],@"' >",context,@"</font>"))
#define SimpleHtmlTextFace(face,color,size,context) HtmlToText(ConcatStrings(@"<font size='",size,@"' color='",[color hexFromUIColor],@"' face='",face,@"'>",context,@"</font>"));

@interface NSString (YCI)

+ (NSString *)joinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION;

@end
