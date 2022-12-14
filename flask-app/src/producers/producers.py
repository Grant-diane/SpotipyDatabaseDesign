from flask import Blueprint, request, jsonify, make_response
import json
from src import db

producers = Blueprint('producers', __name__)

# Gets the number of songs a particular producer has made
@producers.route('/producer/numOfSongs/<ProducerID>', methods=['GET'])
def getNumOfSongs(ProducerID):
    cursor = db.get_db().cursor()

    query = '''select numOfSongs from Producer 
    where producerID = {0} '''

    cursor.execute(query.format(ProducerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Returns the number of artists a producer has worked with
@producers.route('/producer/artistsWorkedWith/<ProducerID>', methods=['GET'])
def getNumOfArtistsWorkedWith(ProducerID):
    cursor = db.get_db().cursor()

    query = '''select count(*) from Works_with 
    where producerID = {0} '''

    cursor.execute(query.format(ProducerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response