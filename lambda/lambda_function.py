# Define module-level variables at the top level
HTML_HOME = """<!DOCTYPE html>
<html>
<head><title>Home</title></head>
<body>
<h1>Welcome to the Marathon</h1>
<p>This is the home page.</p>
</body>
</html>
"""

HTML_ABOUT = """<!DOCTYPE html>
<html>
<head><title>About</title></head>
<body>
<h1>About the Marathon</h1>
<p>Details about the marathon event.</p>
</body>
</html>
"""

def lambda_handler(event, context):
    path = event.get("rawPath", "/")

    if path == "/about":
        body = HTML_ABOUT
    else:
        body = HTML_HOME

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "text/html"},
        "body": body
    }

def home(event):
    return html_response(200, HTML_HOME)

def about(event):
    return html_response(200, HTML_ABOUT)

def html_response(status_code, body):
    return {
        "statusCode": status_code,
        "headers": {"Content-Type": "text/html; charset=utf-8"},
        "body": body,
    }