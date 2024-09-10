# Number Guess Game

This project is a shell script and PostgreSQL database schema designed to facilitate a number guessing game. It includes a shell script for interactive gameplay and a PostgreSQL database schema to track user performance.

## Project Overview

The project consists of two main components:

- **`number_guess.sh`**: A shell script that manages the game, tracks user performance, and interacts with the PostgreSQL database.
- **`number_guess.sql`**: A PostgreSQL SQL dump file that creates and populates the database schema for tracking user statistics.

## Schema Details

### Tables

- **`users`**
  - `username`: Unique identifier for each user.
  - `games_played`: Number of games played by the user.
  - `best_game`: Best number of guesses the user has taken to guess the correct number.

### Constraints

- **Primary Key constraint** ensures each `username` is unique.

## Getting Started

To get started with this project:

1. **Clone the Repository**
   - Clone this repository to your local machine using your preferred Git client.

2. **Set Up the Database**
   - Ensure you have PostgreSQL installed on your system.
   - Use the provided SQL dump file (`number_guess.sql`) to create and populate the database. This file contains the schema definitions for tracking user performance.

3. **Run the Shell Script**
   - Execute the `number_guess.sh` script to start the game. The script will prompt you to enter your username and guess a secret number between 1 and 1000.
   - The game will keep track of the number of guesses and update your performance in the database.

4. **Explore the Database**
   - Connect to the PostgreSQL database using a client like `psql` or a graphical tool like pgAdmin.
   - Explore the `users` table to see user statistics.

## Example Usage

To start the game, run:

```
./number_guess.sh
```
Follow the on-screen prompts to play the game.

## What I Learned

- Implementing interactive shell scripts to manage game logic and user input.
- Designing a simple database schema to track user performance.
- Using PostgreSQL commands to interact with and manage database records.

## Acknowledgements

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- FreeCodeCamp for providing the certification and project guidelines.
