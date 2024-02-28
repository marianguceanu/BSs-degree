# Partners management application
The application is meant to ease business partners management in a company.<br>
It is a mobile application written in a cross-platform framework called Flutter.<br>

## Features
1. Encrypted credentials storage (with JWT, 24h availability).
2. CRUD operations.
3. Filter partners by name, email, and company address.
4. Encrypted chat. 
5. Most active partners (by number of messages).
6. Meeting scheduling.
7. Email integration. Send an email to a partner (or multiple) directly from the app.

## Abstraction
*__The application approaches the concept of separating concerns in cross-platform development.__*<br>
- Classic development involves a lot of code duplication, especially when it comes to the UI. It is done using at most 2 degrees of separation: _data handling_ and _UI rendering_, and they are usually found in the same place in the codebase.<br>
- This application uses a multi-dimensional separation of concerns, with at least 3 degrees of separation: _UI rendering_, _business logic_, and _data handling_.<br>
- In the following sections, we will see how we can track the success of this approach and how it can be improved.

## Goals
__In essence, this app follows the client-server architecture. The client is the (mobile-compiled for demonstration) application and the server is a REST API.__<br>
The goal of this application is to prove that good separation of concerns and a good state management system can lead to a faster, more maintainable and scalable application.<br>
This is achievable by using *__N degrees of separation__* and *__multi-dimensional separation__*.<br>
- The N degrees of separation are the following:
    1. The UI layer.
    2. The BLoC layer.
    3. The Repository layer.
    4. The Service layer.
    5. The Model layer.
- The multi-dimensional separation is the following:
    1. The UI layer is separated into the UI rendering and the UI state.
    2. The BLoC layer is separated into the business logic and the state management.
    3. The Repository layer is separated into the data handling and the data source.
    4. The Service layer is separated into the service and the API.
    5. The Model layer is separated into the DTO's and the entities.
<!--     
The BLoC (Business Logic Component) pattern is a state management system that is used to manage the state of the application in a way that is easy to test and maintain.<br>
By this, the application is divided into three degrees: the UI, the BLoC, and the Repository.<br>
The UI is built using the Material Design guidelines and the application is responsive to different screen sizes.<br>
The application is also built with a focus on performance and security.<br>
-->
Let's see how we can measure the success of this objective on both the client and the server side.

## Client-side
1. Adding features should be easy and not require a lot of changes to the existing code (if any).
2. Changing features should not introduce bugs in other parts of the application.
3. Responsiveness and performance (online operations should not take longer than animation speeds).
4. Security (credentials should be stored securely, and the chat should be encrypted).
5. Minimum of API calls (the application should not make more calls than necessary).
6. Local state management should be minimum when online (the application should not rely on local state for its operations as long as it is connected to the internet).

## Server-side
1. Scalability (the server should be able to handle a large number of requests for a big customer base).
2. Security (handling of credentials and encryption of chat messages).
3. Performance (DTO's usage and caching, in order to minimize the data sent).
4. Middleware (logging, error handling, and authentication).
5. Database (the database should be normalized and indexed for fast read and write operations).