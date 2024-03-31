# Quokka Quick Seats

Quokka Quick Seats is a web application designed to manage seat reservations. It uses the Phoenix framework to manage a backend API and a small vanilla js frontend page with real time updating using sockets and [Phoenix channels](https://hexdocs.pm/phoenix/channels.html).

<img src="quokka_quick_seats_icon.png" alt="Icon" height="200px">

---

# User Documentation

## Preconditions
- Erlang (24 or later) and Elixir (1.14 or later) ([Docs](https://elixir-lang.org/install.html))
- Phoenix Framework ([Docs](https://hexdocs.pm/phoenix/installation.html))
- 4GB RAM recommended
- SQLite3 ([Docs](https://www.sqlite.org/index.html))

## Run
1. mix esbuild default  # Will build the .js files
2. mix phx.server       # Start the Phoenix server

## Database

Typical steps to set up database are:

1. **Run `mix deps.get`**: To fetch all dependencies.
2. **Set Up the Database**: `mix ecto.create` to create the database.
3. **Run Migrations**: `mix ecto.migrate` to apply your migrations and get their database schema in sync with the project.


### Save a copy


The `save_seats_to_json` task allows you to save the current state of seats in the database to a JSON file.


### Specifying a File Path

To run the task and specify the file path where you want the JSON data to be saved. It will save a snapshot of the database in JSON format to `priv\data\seats_backup\seats-yyyy-mm-dd-hh-mm-ssZ.json`
```
mix save_seats_to_json
```
Alternatively you can point out your own file path:
```
mix save_seats_to_json path/to/your/file.json
```

### Populate Seats

Seats in database can be populated with a simple text file and a mix task. First create a file with your desired seats: `priv/populate_seats/seats.txt`. Note, a backup will be created with the `save_seats_to_json`.
```
A1
A2
A3
B1
B2
B3
```

Then run mix task to insert new seats in the database:
```shell
mix populate_seats priv/populate_seats/seats.txt
```

It is also possible to load a database from a json file. This is an example of the previous `seats.txt` backed up as `priv/data/seats_backup/backup.json`:

```json
[
  {"seat_id": "A1", "is_booked": false, "full_name": null, "phone_number": null},
  {"seat_id": "A2", "is_booked": false, "full_name": null, "phone_number": null},
  {"seat_id": "A3", "is_booked": false, "full_name": null, "phone_number": null},
  {"seat_id": "B1", "is_booked": false, "full_name": null, "phone_number": null},
  {"seat_id": "B2", "is_booked": false, "full_name": null, "phone_number": null},
  {"seat_id": "B3", "is_booked": false, "full_name": null, "phone_number":null}
]
```

### Unbook all seats

To unbook all seats, run mix task `unbook_seats`. Note, a backup will be created with the `save_seats_to_json`.

```shell
mix unbook_seats
```

### Database Documentation and Best Practices

For more detailed information and best practices, you can refer to the official Elixir and Phoenix documentation. Here are some relevant sections:

- [Elixir Ecto Getting Started Guide](https://hexdocs.pm/ecto/getting-started.html): For understanding Ecto basics.
- [Phoenix Ecto Migrations Guide](https://hexdocs.pm/phoenix/ecto.html#ecto-migrations): Covers how migrations work in Phoenix.
- [Phoenix Testing Guide](https://hexdocs.pm/phoenix/testing.html): For writing and running tests in Phoenix applications.

These documents provide a wealth of information on using Ecto and Phoenix effectively and are great resources! 🚀👨‍💻📚


### Some problems with SQLite3 on Windows

On Windows, there can be some problems when first starting up application and SQLite3.
```shell
PS quokka_quick_seats> mix.bat ecto.create
==> exqlite
process_begin: CreateProcess(NULL, uname -s, ...) failed.
Makefile:46: pipe: No error
The syntax of the command is incorrect.
make: *** [Makefile:145: learning_elixir/phoenix_with_sqlite3/_build/dev/lib/exqlite/priv] Error 1
could not compile dependency :exqlite, "mix compile" failed. Errors may have been logged above. You can recompile this dependency with "mix deps.compile exqlite --force", update it with "mix deps.update exqlite" or clean it with "mix deps.clean exqlite"
...
```

There are fixes for this: [Cannot compile exqlite on Windows](https://stackoverflow.com/questions/69881330/cannot-compile-exqlite-on-windows).
```shell
PS quokka_quick_seats> cmd /k "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
**********************************************************************
** Visual Studio 2019 Developer Command Prompt v16.11.19
** Copyright (c) 2021 Microsoft Corporation
**********************************************************************
[vcvarsall.bat] Environment initialized for: 'x64'
```

It's also mentioned in the [Exqlite documentation for Windows users](https://github.com/elixir-sqlite/exqlite/blob/main/guides/windows.md).

## Frontend

First time starting up, frontend assets should be built automatically. To rebuild frontend is quite easy:
```shell
quokka_quick_seats> mix esbuild default

  ..\priv\static\assets\app.js  44.9kb

⚡ Done in 7ms

quokka_quick_seats> mix phx.digest
Check your digested files at "priv/static"
```

To remove all static assets run:
```shell
mix phx.digest.clean --all
```

