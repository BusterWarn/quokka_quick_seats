# Quokka Quick Seats

<img src="quokka_quick_seats_icon.png" alt="Icon" height="200px">

## Introduction
Welcome to the Quokka Quick Seats, a web application designed to manage seat reservations. Whether you're hosting a theatre event, a conference, or any venue with seat allocation, this app streamlines the booking process, making it smooth and efficient for both administrators and end-users.


## How it Works
Users can browse available seats, reserve or cancel a reservation, and get real-time updates on seat availability. Admins can set up seating arrangements, track reservations, and manage users.

---

# User Documentation

### Database

Typical steps to set up database are:

1. **Run `mix deps.get`**: To fetch all dependencies.
2. **Set Up the Database**: `mix ecto.create` to create the database.
3. **Run Migrations**: `mix ecto.migrate` to apply your migrations and get their database schema in sync with the project.

### Database Documentation and Best Practices

For more detailed information and best practices, you can refer to the official Elixir and Phoenix documentation. Here are some relevant sections:

- [Elixir Ecto Getting Started Guide](https://hexdocs.pm/ecto/getting-started.html): For understanding Ecto basics.
- [Phoenix Ecto Migrations Guide](https://hexdocs.pm/phoenix/ecto.html#ecto-migrations): Covers how migrations work in Phoenix.
- [Phoenix Testing Guide](https://hexdocs.pm/phoenix/testing.html): For writing and running tests in Phoenix applications.

These documents provide a wealth of information on using Ecto and Phoenix effectively and are great resources! 🚀👨‍💻📚

# Tech Stack

### Backend: Elixir + Phoenix

#### What it Does
Handles logic, data, and real-time updates.

#### Why We Picked It
Elixir and Phoenix excel in real-time, scalability, and reliability.

#### Preconditions
- Erlang (24 or later) and Elixir (1.14 or later) ([Docs](https://elixir-lang.org/install.html))
- Phoenix Framework ([Docs](https://hexdocs.pm/phoenix/installation.html))
- 4GB RAM recommended

#### Logging
- Built-in Logger utility for Elixir and Phoenix
- No need for separate logging tools

---

### Frontend option 1: Svelte

#### What it Does
User interface.

#### Why We Picked It
Svelte is lightweight and offers reactive programming. 

#### Preconditions
- Node.js v14+ installed ([Docs](https://svelte.dev/tutorial/basics))
- 2GB RAM minimum

### Frontend option 2: Alpine.js

#### What it Does
User interface.

#### Why We Picked It
Alpine.js is small, and focuses on sprinkling in behavior.

#### Preconditions
- Node.js v14+ ([Docs](https://alpinejs.dev/start-here))
- 2GB RAM minimum

### Other Frontend Options

#### VanillaJS

- **What it Does**: Pure JavaScript interface.
- **Why We Picked It**: Zero dependencies, extremely lightweight.
- **Preconditions**: None

#### jQuery

- **What it Does**: DOM manipulation and event handling.
- **Why We Picked It**: Simple, just include via CDN.
- **Preconditions**: None

#### Mithril.js

- **What it Does**: Small, fast JavaScript framework.
- **Why We Picked It**: Lightweight, can include via CDN.
- **Preconditions**: None
- **Docs**: https://mithril.js.org/

#### Vue.js

- **What it Does**: Reactive UI library.
- **Why We Picked It**: Can be included via CDN, but optimized for Node.js.
- **Preconditions**: None if CDN is used

---

### Database: SQLite

#### What it Does
Stores data related to seats, reservations, and users.

#### Why We Picked It
SQLite is lightweight and easy to set up.

#### Preconditions
- SQLite installed ([Docs](https://sqlite.org/docs.html))
- 100MB Disk Space

---

### Additional Features

#### GraphQL

- **What it Does**: Allows flexible and efficient data queries.
- **Why We Picked It**: Reduces over-fetching and under-fetching. ([Docs](https://graphql.org/))
- **Absinthe** is an Elixir framework for working with GraphQL: https://hexdocs.pm/absinthe/overview.html

#### Testing and Mocking

- **What it Does**: Verifies code functionality; simulates real systems.
- **Why We Picked It**: ExUnit for Elixir ([ExUnit Docs](https://hexdocs.pm/ex_unit/ExUnit.html)); Jest/Mocha for frontend ([Jest Docs](https://jestjs.io/docs/getting-started)); Mox for mocking ([Mox Docs](https://hexdocs.pm/mox/Mox.html))
  
---

### Git and CI

- **What it Does**: Automates testing and deployment.
- **Why We Picked It**: GitHub Actions ([Docs](https://docs.github.com/en/actions)); Git hooks for linting through Credo

---

### Deploy Strategy

- **Method**: Simple Git pull on the server.
- **Why We Picked It**: Easy to set up, no need for heavy-duty tools like Kubernetes.
- **Preconditions**: Git installed on the server; exclude test code and Node.js if not needed.

---
