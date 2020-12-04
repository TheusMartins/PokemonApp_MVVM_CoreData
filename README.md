# Pokemon App

Pokemon app is an app that consumes https://pokeapi.co/ API.

App basicaly has 3 screens: 
- Pokemon list: Is a screen where app list every pokemon by generation for you, you can choose generation tapping on green arrow down, by doing so 
a list with generations will be open and you can choose

- Pokemon Details: You go to Pokemon Details by selecting a pokemon in Pokemon list, in this screen you can see more details about the pokemon you choose and you
can add it on your team by tapping on "Add in your team" button

- Pokemon team: Is a screen that list your team, you can not have more than 6 pokemons in your team, you can remove pokemon from your team by tapping on red trash,
you access this screen by tapping on Team tabBar

# Tech comments

## App was build on MVVM Pattern, where: 

- Model: layer that has properties that will feed screens
- View: Layer that build screens that user will see
- ViewModel: Layer that feed View with infos and where logic should be

## Unit tests: 

- Only tests viewModel layer because its where logic is

## API

There was some situations that https://pokeapi.co/ did not provide all informations i needed to build the app the way I wanted to, so to get pokemon image in List view, 
my approach was make a call to feed a list and another to download pokemon image based on pokemons name

## Core data

Simple layer of core data to storage user's pokemon team

## View code

The decision of making views in viewCode was based on following reasons: 
- My pc is not so powerfull, open a .swift file is easier than open a .xib or .storyBoard
- Its possible to analyse on a code review

## Pokemon team screen

I could use a tableView on this screen but i created it the way I did to have freedom that UITableViewCell does not provide. 
