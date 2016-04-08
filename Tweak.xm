@interface CKConversation
- (id)name;
@end

@interface CKTranscriptController {
	UINavigationItem* _navItem;
}
-(void)chat:(id)arg1 progressDidChange:(float)arg2 sendingMessages:(id)arg3 sendCount:(unsigned long long)arg4 totalCount:(unsigned long long)arg5 finished:(BOOL)arg6;
- (CKConversation *)conversation;
@end

static NSString *title;

%hook CKTranscriptController

-(void)chat:(id)arg1 progressDidChange:(float)arg2 sendingMessages:(id)arg3 sendCount:(unsigned long long)arg4 totalCount:(unsigned long long)arg5 finished:(BOOL)arg6 {
	%orig;

	UINavigationItem* _navItem = MSHookIvar<UINavigationItem*>(self, "_navItem");
	//HBLogDebug(@"self.conversation.name: %@", [[self.conversation.name componentsSeparatedByString:@" "] objectAtIndex:0]);
	//HBLogDebug(@"_navItem.title: %@", _navItem.title);

	if(arg2 != 0.0f && ![_navItem.title isEqualToString:[[self.conversation.name componentsSeparatedByString:@" "] objectAtIndex:0]]) {

		static dispatch_once_t once;
		dispatch_once(&once, ^ {
	  		title = _navItem.title;
		});

		_navItem.title = [NSString stringWithFormat:@"%.0f%% %@", arg2*100.0f, title];
	}

}

%end