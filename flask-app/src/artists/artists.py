from flask import Blueprint, request, jsonify, make_response
import json
from src import db

artists = Blueprint('artists', __name__)

# Returns the number of listeners a particular artists has
@artists.route('/numOfListeners/<artistID>', methods=['GET'])
def getNumOfListeners(artistID):
    cursor = db.get_db().cursor()

    query = '''select count(*) from Listens_to where ArtistID = {0} '''

    cursor.execute(query.format(artistID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Reutrns the top song of a particular artists
@artists.route('/topSong/<artistID>', methods=['GET'])
def getTopSong(artistID):
    cursor = db.get_db().cursor()

    query = '''select trackName from Songs where msPlayed=
                   (select MAX(msPlayed) from Songs where performerID = {0})'''

    cursor.execute(query.format(artistID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response





