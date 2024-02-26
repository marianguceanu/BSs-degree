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
The application approaches the concept of separating concerns in cross-platform development.<br>
This is done by using the BLoC pattern (Business Logic Component).<br>
The BLoC pattern is a state management system that is used to manage the state of the application in a way that is easy to test and maintain.<br>
By this, the application is divided into three layers: the UI, the BLoC, and the Repository.<br>
The UI is built using the Material Design guidelines and the application is responsive to different screen sizes.<br>
The application is also built with a focus on performance and security.

## Goals
__In essence, this app follows the client-server architecture. The client is the (mobile-compiled for demonstration) application and the server is a REST API.__<br>
The goal of this application is to prove that good separation of concerns and a good state management system can lead to a faster, more maintainable and scalable application.<br>
Let's see how we can measure the success of this objective on both the client and the server side.

## Client-side
1. Adding features should be easy and not require a lot of changes to the existing code (if any).
2. Responsiveness and performance (online operations should not take longer than animation speeds).
3. Security (credentials should be stored securely, and the chat should be encrypted).
4. Minimum of API calls (the application should not make more calls than necessary).

## Server-side
1. Scalability (the server should be able to handle a large number of requests for a big customer base).
2. Security (handling of credentials and encryption of chat messages).
3. Performance (DTO's usage and caching, in order to minimize the data sent).
4. Middleware (logging, error handling, and authentication).
5. Database (the database should be normalized and indexed for fast read and write operations).
