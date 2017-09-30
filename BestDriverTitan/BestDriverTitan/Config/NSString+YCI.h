//
//  NSString+YCI.h
//  YCIVADemo
//
//  Created by yanchen on 16/6/21.
//  Copyright © 2016年 yanchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

#define ConcatStrings(firstStr,...) [NSString joinedWithSubStrings:firstStr,__VA_ARGS__,nil]
/**
 *  HtmlToText 是比较耗时的工作 必须在子线程中转换完毕后由主线程刷新
 *  @return NSAttributedString
 */
#define HtmlToText(htmlString) [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

#define SimpleHtmlText(color,size,context) HtmlToText(ConcatStrings(@"<font size='",size,@"' color='",[color hexFromUIColor],@"' >",context,@"</font>"))
#define SimpleHtmlTextFace(face,color,size,context) HtmlToText(ConcatStrings(@"<font size='",size,@"' color='",[color hexFromUIColor],@"' face='",face,@"'>",context,@"</font>"));


#define SimpleAttrubuteText(color,size,context) [NSString simpleAttributedString:color size:size context:context];
#define SimpleAttrubuteTextFace(face,color,size,context) [NSString simpleAttributedString:face color:color size:size context:context];

@interface NSString (YCI)

+ (NSAttributedString *)simpleAttributedString:(UIColor*)color size:(CGFloat)size content:(NSString*)content;
+ (NSAttributedString *)simpleAttributedString:(NSString*)face color:(UIColor*)color size:(CGFloat)size content:(NSString*)content;
+ (NSString *)joinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION;

//- (NSString *)formartScientificNotationWithString;


@end
