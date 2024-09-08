#!/bin/bash
# PSQL command to connect to the database
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\n~~~~~ GUESS NUMBER ~~~~~\n"

echo -e "\nEnter your username:"
read USERNAME

# Query user data
GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")

# Handle potential null values
GAMES_PLAYED=${GAMES_PLAYED:-0}
BEST_GAME=${BEST_GAME:-0}

# Generate a random secret number between 1 and 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

if [[ $GAMES_PLAYED -eq 0 ]]
then
  # New user
  INSERT_USERNAME=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."

else
  # Returning user
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo -e "\nGuess the secret number between 1 and 1000:"

GAMES_PLAYED_COUNT=0

while true 
do
  read INPUT_NUMBER

  # Check if the input is a number
  if [[ $INPUT_NUMBER =~ ^[0-9]+$ ]]
  then
    let GAMES_PLAYED_COUNT+=1

    # Correct guess
    if [[ $INPUT_NUMBER -eq $SECRET_NUMBER ]]
    then
      echo -e "\nYou guessed it in $GAMES_PLAYED_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
      
      # Update games played and best game
      TOTAL_GAMES_PLAYED=$(( GAMES_PLAYED + 1 ))
      if [[ $GAMES_PLAYED_COUNT -lt $BEST_GAME || $BEST_GAME -eq 0 ]]
      then
        UPDATE_SCORE=$($PSQL "UPDATE users SET games_played=$TOTAL_GAMES_PLAYED, best_game=$GAMES_PLAYED_COUNT WHERE username='$USERNAME'")
      else
        UPDATE_SCORE=$($PSQL "UPDATE users SET games_played=$TOTAL_GAMES_PLAYED WHERE username='$USERNAME'")
      fi
      break
    elif [[ $INPUT_NUMBER -gt $SECRET_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    else
      echo -e "\nIt's higher than that, guess again:"
    fi
  else
    echo -e "\nThat is not an integer, guess again:"
  fi
done
