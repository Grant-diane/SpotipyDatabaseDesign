###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app

# create the app object
app = create_app()

# imports blueprints

from src import listeners

app.register_blueprint(listeners, url_prefix='/list')

@app.route("/")
def hello_world():
    return f'<h1>Hello welcome to SPOTIPY</h1>'

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug=True, host='0.0.0.0', port=4000)
