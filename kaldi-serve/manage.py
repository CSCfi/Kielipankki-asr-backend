from server import app

if __name__ == '__main__':
    from flask.cli import FlaskGroup
    cli = FlaskGroup(app)
    cli()
