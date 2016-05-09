/# Git Definitions
Kit Robinson 5-9-16

**Instructions: ** Define each of the following Git concepts.

* What is version control?  Why is it useful?
	
	version control is useful for tracking changes to our code as they come in, and storing older versions.  This way we can roll back to earlier versions if needed, and also potentially identify which change caused a bug - even if it's been around for a while.

* What is a branch and why would you use one?

	a branch is like a copy of your code base, where you can make changes that won't affect the master code.  like saving a new copy of an importat document to edit.  We would use a branch in order to work on and test changes without actaully modifying the master code - this is important for version control, and also makes it easier for multiple people to work at once.  

* What is a commit? What makes a good commit message?
	a commit is a savepoint - where changes you have made to code are officiall saved, and the author, timestamp, and message is added.  the commit message should show what was changed in a detailed enough way that readers (possibly much later on) will be able to understand the alteration

* What is a merge conflict?
	a merge conflict occurs when git is not certain how to merge a branch into master (or into another branch or what have you).  this could happen if there have been commits in both branches since the branches diverged - for example, if one person is updating versioncontrol.md and another person has deleted versioncontrol.md  - the file will be marked as having a conflict, and we will have to choose which version is correct.  Happily, we are keeping all the version control savepoints (commits) so if we have a conflict we cannot easily resolve, we can backtrack and fix it!