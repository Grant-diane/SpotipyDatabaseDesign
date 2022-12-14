from flask import Blueprint, request, jsonify, make_response
import json
from src import db

producers = Blueprint('producers', __name__)


# Gets the NAME of the top song by the given artist
@producers.route('/producers/topSong/<username>', methods=['GET'])
def getTopSongByArtist(username):
    cursor = db.get_db().cursor()

    q = ''' '''


    cursor.execute('select trackName from Listened_songs JOIN Works_with where timePlayed='
                   '(select MAX(timePlayed) from Listened_songs '
                   'where ArtistID = {0} and ListenerID = {0}) '
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


# Get the most played album for listener with particular ArtistID
@producers.route('/producers/topAlbum/<userID>', methods=['GET'])
def getTopPlaylist(username):
    cursor = db.get_db().cursor()
    cursor.execute('select nameAlbum from Album JOIN Listener '
                   'where albumonID = (select albumID'
                   ' from playlist_Maker where '
                   'AlbumID = {0] and minutesPlayed = (select MAX(minutesPlayed) '
                   'from Playlist_Maker where albumonID = {0})'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response