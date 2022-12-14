# Spotipy
### Database Design CS 3200 
### Thursday, Friday Section Fall 2022
### Professor Mark Fotenot
### Project Members
  - Amelia Yu
  - Diane Grant
  - Nina Paprocki 
  - Rachel Kahn 
### Completion Date: 12/13/2022

# Spotipy Database
This database was constructed in SQL to represent three different types of users of a music listening service loosely based on Spotify's product. We represent the listeners, artists, and producers. As well as songs, podcasts, album, playlists, genres, and various relationships among users. Our SQL file, spotipy.py contains sample data as well to represent examples of data that could exist in our constructed database. From our created dataset we created a webapp using tools including Flask, Docker, and AppSmith to create a representaion of various peice of data that may be of interest to listening service users. For example a listener can see their most listened to song, and a producer can see the number of artists they work with. Additonally users can log information as well. For instance the producer can add a genre to the dataset and every time a user logs in the email and username data is logged in a table so we know which users have used the program before.

## Instructions to View
Below are instructions provided by our professor on setting up the basis of the project. Please follow each step particularly of the 'How to setup and start the containers' section in order to view our project.
Once the Docker is up open ngrok after installation type in 'ngrok http 8001'.
After this the ngrok link is provided and we put it in AppSmith as our API Datasource.
Then when we write and insert our queries into AppSmith we use the just created API as our Datasource. 
Finally we can run what we have configured and developed over AppSmith and deploy our project to view how each of our queries are implemented and displayed in the final user interface.

## Video of Final Product
https://drive.google.com/file/d/1x6HvtM8nrqQmrgKMQx_pa34GXV0Go5c2/view?usp=sharing

## MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 2 docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## For setting up a Conda Web-Dev environment:

1. `conda create -n webdev python=3.9`
1. `conda activate webdev`
1. `pip install flask flask-mysql flask-restful cryptography flask-login`




