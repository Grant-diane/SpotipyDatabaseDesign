from flask import Blueprint, request, jsonify, make_response
import json
from src import db

artists = Blueprint('artists', __name__)


# Gets the NAME of the most played song of the artist
@artists.route('/artists/topSong/<username>', methods=['GET'])
def getTopSong(username):
    cursor = db.get_db().cursor()
    cursor.execute('select trackName from Listened_songs where timePlayed='
                   '(select MAX(timePlayed) from Listened_songs where ArtistID = {0}) '
                   'and ArtistID = {0}}'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Get the most played album for artist with particular ArtistID
@artists.route('/artists/topAlbum/<userID>', methods=['GET'])
def getTopPlaylist(username):
    cursor = db.get_db().cursor()
    cursor.execute('select playlistName from Playlist where playlistID = (select playlistID'
                   ' from playlist_Maker where minutesPlayed = (select MAX(minutesPlayed) '
                   'from Playlist_Maker where ArtistID = {0})'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

def getTopAlbum(username):
    cursor = db.get_db().cursor()
    cursor.execute('select albumName from Album JOIN Listener where albumID = (select albumID'
                   ' from album_Maker where minutesPlayed = (select MAX(minutesPlayed) '
                   'from Album_Maker where ArtistID = {0})'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response