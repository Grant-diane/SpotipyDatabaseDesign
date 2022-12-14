from flask import Blueprint, request, jsonify, make_response
import json
from src import db

listeners = Blueprint('listeners', __name__)

# Gets the NAME of the top song of the listener
@listeners.route('/topSong/<username>', methods=['GET'])
def getTopSong(username):
    cursor = db.get_db().cursor()

    query = '''select trackName from Songs where songID = (select songID from Listened_songs 
    where ListenerID = {0} AND timePlayed=
                   (select MAX(timePlayed) from Listened_songs where ListenerID = {0}))'''

    cursor.execute(query.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get the most played playlist for listener with particular ListenerID
@listeners.route('/topPlaylist/<username>', methods=['GET'])
def getTopPlaylist(username):
    cursor = db.get_db().cursor()

    q = '''select playlistName from Playlist where playlistID = (select playlistId
    from Playlist_Maker where listenerID = {0} AND minutesPlayed = (select max(minutesPlayed) from Playlist_Maker))'''
    cursor.execute(q.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Adds a new genre via a post route
@listeners.route('/listeners/newGenre',methods=['POST'])
def insertGenre():
    cursor = db.get_db().cursor()
    genre_ID = request.form['genreID']
    genreName = request.form['genreName']
    cursor.execute(f'INSERT INTO Genre (genreID, genreName) VALUES ({genre_ID, genreName})')
    return cursor.connection.commit()

# Adds a new user via a post route
@listeners.route('/listeners/addUser', methods=['POST'])
def addUsername():
    cursor = db.get_db().cursor()
    username_ID = request.form['username']
    email_ID = request.form['email']
    cursor.execute(f'INSERT INTO VisitedUsers (username, email, visits) VALUES ({username_ID, email_ID, 1})')
    return cursor.connection.commit()


# Displays the genre table to see the updated data
@listeners.route('/displayUpdatedGenre', methods=['GET'])
def displayGenres():
    cursor = db.get_db().cursor()

    cursor.execute('select genreID, genreName from Genre')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Displays the listeners table to show the updated data
@listeners.route('/displayUpdatedUser', methods=['GET'])
def displayUsers():
    cursor = db.get_db().cursor()

    cursor.execute('select email, username from Listener')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response