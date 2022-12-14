from flask import Blueprint, request, jsonify, make_response
import json
from src import db

artists = Blueprint('artists', __name__)


# Gets the NAME of the most played song of the artist
@artists.route('/topSong/<artistID>', methods=['GET'])
def getTopSong(artistID):
    cursor = db.get_db().cursor()

    query = '''select trackName from Songs where msPlayed=
                   (select MAX(msPlayed) from Songs where artistID = {0}))'''

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
