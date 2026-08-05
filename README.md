# user_detail_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Folder Responsibility

models
      │
      ▼
What data looks like

--------------------------

services
      │
      ▼
Talk to server

--------------------------

repositories
      │
      ▼
Middle layer

--------------------------

providers
      │
      ▼
Store data

--------------------------

screens
      │
      ▼
Show UI


Complete API Flow

Dashboard Page

↓

UsersPage opens

↓

UserProvider.loadUsers()

↓

UserRepository.getUsers()

↓

ApiService.fetchUsers()

↓

GET API

↓

Server

↓

JSON

↓

User.fromJson()

↓

Repository

↓

Provider

↓

notifyListeners()

↓

Consumer

↓

ListView.builder()

↓

Users visible

Future → "I'll return something later."
async → "This function contains work that takes time."
await → "Pause here until that work finishes."