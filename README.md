# XCUITodo

This is a simple app used to introduce Xcode 7's UI testing support.

As of writing, Xcode 7.0 beta 4 (7A165t) was the current version.


## Blog Posts

It accompanies a series of blog posts on the BNR blog:

- [UI Testing in Xcode 7, Part 1: How To Do It]()


## Tags

You might want to check out these tags:

- `ui-tests-coming-soon`: The app is up and running, but it's utterly lacking
  in tests. Eek! Can you help?


## Functionality

The app supports these capabilities:

- Should be able to view a list of tasks and due dates.
- Should be able to mark an unfinished task as finished.
- Should be able to mark a finished task as unfinished.
- Should be able to view a list of finished tasks and due dates.
- Should show only unfinished tasks in the normal task list.
- Should be able to view a list of tasks due today.

Concretely, that means we have 3 main views:

- Today's Tasks
- Todos (unfinished tasks)
- Dones (finished tasks)

A final view enables navigating between these views.
