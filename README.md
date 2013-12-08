#Sudoku City - an online Sudoku solver
##Makers Academy Week 5 Project


###Aim

The aim of this project is to build a simple website, using Sinatra, that will enable the user to play Sudoku in the browser.

This project also enabled the practice of front-end skills, such as HTML and CSS. 

###Other details

The task was set by Enrique Comba Riepenhausen, [@ecomba](http://www.github.com/ecomba)

For the Sudoku solving engine, I used [this code](https://github.com/makersacademy/sudoku) provided by Evgeny Shadchnev, [@shadchnev](http://www.github.com/shadchnev)

You can visit my Sudoku Solver [here](http://sudoku-solver-production.herokuapp.com/)

The *Week 5 test* was incorporated into this project. This involved:

* deploying the app to Heroku, complete with both staging and production deployment targets
* install the NewRelic add-on and find the average page loading time
* explore other analytical tools available with NewRelic
* enable app to run using a unicorn webserver


###Features

* Can generate *easy* and *hard* difficultly puzzles to play in the browser
* Can restart current game
* Can visit a *help* page for instructions
* Can *check progress* of current entries. Incorrect entries will be highlighted
* Can reveal final solution
* Can save game progress and return at a later date

###To do

* Ensure the solver can allow for multiple solutions in cases where they do exist


