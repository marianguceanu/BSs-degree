# Quick rundown (small table of contents)
<!--toc:start-->
- [󱠡 Hello!](#󱠡-hello)
  - [Motivation: Why did I want to do this?](#motivation-why-did-i-want-to-do-this)
- [ Thesis breakdown](#-thesis-breakdown)
  - [Separation of concerns](#separation-of-concerns)
  - [Cross-platform development](#cross-platform-development)
- [ File tree comparisons](#-file-tree-comparisons)
  - [Example](#example)
- [Why is this important? Especially in the cross-platform context?](#why-is-this-important-especially-in-the-cross-platform-context)
- [Actual, real-world examples of big projects](#actual-real-world-examples-of-big-projects)
    - [ 11 graph arcs example](#-11-graph-arcs-example)
        - [Continuous communication between components](#continuous-communication-between-components)
        - [If you want a compositor to get rid of issues such as screen tearing](#if-you-want-a-compositor-to-get-rid-of-issues-such-as-screen-tearing)
    - [ ayland graph arcs example](#-ayland-graph-arcs-example)
        - [Continuous communication between components](#continuous-communication-between-components)
    - [Main focus of previous example](#main-focus-of-previous-example)
- [Is this a necessity? Yes!](#is-this-a-necessity-yes)
<!--toc:end-->
---
# 󱠡 Hello!
- _ whoami_: Guceanu George Marian
- _󰏢 pwd_: /thesis/**Separation-of-concerns-in-cross-platform-development**
- _ root_: Lector Dr. Cojocar Dan (coordinator)

## Motivation: Why did I want to do this?
- Personal frustration from previous projects I worked on 
- To provide a guideline for developers to follow when working on cross-platform projects
- Prove that separation of concerns can only have a positive impact
- For the first time in a while, it becomes a "trend"
---
#  Thesis breakdown and goals
## Separation of concerns
- What is it?
    - Modularity
    - Readability
    - Maintainability
    - Reusability
    - Scalability
- When? (earliest mention: _1968, "Go to statement considered harmful" by Edsger W. Djisktra_)
- Why is it important?
## Cross-platform development
- When? (earliest mention: _2006, "Cross-platform development: Software that lasts." by Bishop J. & Horspool_)
- How is it done now?
- Can it be improved?
---
#  File tree comparisons
- The file tree is often the first thing you see when you open a project 
- It's the first impression you get of the project
- Because of this, it is one of the most relevant and easy to understand examples
## Example
- Up next, we'll take a look at two different file trees 
- Both of them are for a Flutter (cross-platform framework) project
- Both projects implement the same app, only difference is in design and architecture 
- Let's analyze both and see which is easier to understand  
---
|Separation Of Concerns          |Component Design                 |
|--------------------------------| --------------------------------|
|.                               |.                                |
|├── custom_components           |├─ chat_page                     |
|│     └── chat_text.dart        |│     ├── chat_page.dart         |
|│  main.dart                    |│     ├── chat_provider.dart     |    
|├── models                      |│     ├─partner_provider.dart    |
|│     ├── chat.dart             |│     └── chat_service           |
|│     ├── signup.dart           |│         └─chat_service.dart    |
|│     └── user.dart             |├── model                        | 
|├── pages                       |│     └── chat.dart              |                                                         
|│     ├── chat_page.dart        |├── custom_components            |
|│     ├── main_page.dart        |│     └── chat_text.dart         |
|│     ├── start_chat_page.dart  |└─                               |
|│     └── user_page.dart        |                                 |
|├── icons                       |                                 |
|│     ├── desktop.dart          |                                 |
|│     ├── android.dart          |                                 |
|│     └── ios.dart              |                                 |
|├── providers                   |                                 |
|│     ├── chat_provider.dart    |                                 |
|│     └─partners_provider.dart  |                                 |
|├── services                    |                                 |
|│     ├── chat_service.dart     |                                 |
|│     └── storage_service.dart  |                                 |
|└─                              |                                 |
---
# Why is this important? Especially in the cross-platform context?
- **Cross-platform development** is a complex process
- Separating concerns can lead to a more uniform experience across platforms
- Codebase is maintainable!
- By maintainable we mean readable and easy to change.
---
# 󰂺 Easily readable code snippet from demo app:
```dart
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          SignUpTextField(
              icon: const Icon(Icons.business),
              hint: 'Enter your business name',
              controller: _businessNameController,
              isPassword: false),
          SignUpTextField(
              icon: const Icon(Icons.location_on),
              hint: 'Enter your address',
              controller: _addressController,
              isPassword: false),
          SignUpTextField(
              icon: Icon(Icons.phone),
              hint: 'Enter your phone number',
              controller: _phoneNumberController,
              isPassword: false),

```
---
# Focus: how easy can we change or test the parent component shown above?
- It's easy to locate the part that we want to change
- Due to suggestive naming, it's easy to have an idea of what the child component is, and how it functions
- The snippet has light nesting → easier to follow
# Focus: how easy can we change the child component?
- It's pretty repeated                 → should have a general behavior
- If we want to customize its behavior → insert flags (e.g. _isPassword_ parameter)
---
# 󰗙 Not so easy to read code, also from demo app
```dart
return Column(
  children: [
    Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
      return InitializeChatPane(
        partnerName:
            partnersProvider.partners[index].businessName,
        partnerReach:
            partnersProvider.partners[index].reach,
        partnerId: widget.partnerId,
        createChat: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EnterChatNamePopup(
                        controller: _chatNameController,
                        createChatCallback: () {
                          chatProvider.addChat(
                              widget.partnerId,
                              partnersProvider
                                  .partners[index].id,
                              _chatNameController
                                  .value.text);
                        },
                      )));
          // Start chat
          _chatNameController.clear();
        },
      );
    }),
```
---
# Focus: how easy can we understand what this component does?
- Due to extensive nesting → hard to follow its operational flow
- Inexpressive naming      → confusion (is _createChatCallback_ an actual callback or an API call?)
---
# Actual, real-world examples of big projects
---
#  11 operational flow example
### Continuous communication between components
- Kernel → X Server → X client → X server → Kernel
### If you want a compositor to get rid of issues such as screen tearing
- Kernel → X Server → X client → Compositor → X server → Kernel
<br>
**Above**: the communication between components in the X11 architecture 
[Reference for example](https://www.x.org/wiki/)
---
#  ayland operational flow example
### Continuous communication between components
- Kernel → Wayland Compositor* → Client → Wayland Compositor* → Kernel 
<br>
**Above**: the communication between components in the Wayland architecture.
Notice how there is no server component.
<br>
This is the successor of X, as it is better in every aspect.
It removes the compositor concern, because it is both the server and the compositor itself.
Thus, it more security and faster performance.
[Reference for example](https://wayland.freedesktop.org/architecture.html)
---
#  Demo time!
- Let's take a look at the project discussed in the tree and code comparison sections
## Tech stack used:
- Flutter                        → Cross-platform framework
- Golang with Gin as a framework → Rest API 
- MSSQL                          → Database
### Rundown:
- Chat app
- Will run on Linux and Android
- Is backed by an implemented backend

####  Important:
- The app is stateless
- It only listens to server changes and updates the UI accordingly
---
# Important references that were used in the thesis
- Dooley J., _Software development and professional practice._, 2011.
- Bishop J. & Horspool R., _Cross-platform development: Software that lasts._,  2006.
- Djisktra E. W. _Go to statement considered harmful._,  1968.
- Eric Windmill. _Flutter in action._ 2020.
---
# Thank you for your attention!
## Questions?
