from flask import Blueprint, request, jsonify, make_response
import json
from src import db

listeners = Blueprint('listeners', __name__)


# Gets the NAME of the top song of the listener
@listeners.route('/listeners/topSong/<username>', methods=['GET'])
def getTopSong(username):
    cursor = db.get_db().cursor()
    cursor.execute('select trackName from Listened_songs where timePlayed='
                   '(select MAX(timePlayed) from Listened_songs where ListenerID = {0}) '
                   'and ListenerID = {0}}'.format(username))
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
@listeners.route('/listeners/topPlaylist/<userID>', methods=['GET'])
def getTopPlaylist(username):
    cursor = db.get_db().cursor()
    cursor.execute('select playlistName from Playlist where playlistID = (select playlistID'
                   ' from playlist_Maker where minutesPlayed = (select MAX(minutesPlayed) '
                   'from Playlist_Maker where ListenerID = {0})'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
