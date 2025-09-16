from flask import Flask, jsonify
import json
import random
import os

app = Flask(__name__)

# --- Load Data ---
# In a real app, you might load from a database or external API.
# For simplicity, we'll load from local JSON files or use defaults.

# Try to load memes from a local file, otherwise use a default list
try:
    with open('memes.json') as f:
        memes_data = json.load(f)
except FileNotFoundError:
    # Default memes data if memes.json is not found
    memes_data = [
        {"id": 1, "url": "https://example.com/meme1.jpg", "caption": "DevOps Meme 1"},
        {"id": 2, "url": "https://example.com/meme2.jpg", "caption": "DevOps Meme 2"},
        # Add more default memes here...
    ]

# Try to load quotes from a local file, otherwise use a default list
try:
    with open('quotes.json') as f:
        quotes_data = json.load(f)
except FileNotFoundError:
     # Default quotes data if quotes.json is not found
    quotes_data = [
        {"id": 1, "text": "Any sufficiently advanced technology is indistinguishable from magic.", "author": "Arthur C. Clarke"},
        {"id": 2, "text": "Simplicity is prerequisite for reliability.", "author": "Edsger W. Dijkstra"},
         # Add more default quotes here...
    ]


@app.route('/')
def index():
    return jsonify({"message": "Welcome to the DevOps Meme & Quote Generator!", "endpoints": ["/meme", "/quote"]})

@app.route('/meme')
def get_meme():
    meme = random.choice(memes_data)
    return jsonify(meme)

@app.route('/quote')
def get_quote():
    quote = random.choice(quotes_data)
    return jsonify(quote)

if __name__ == '__main__':
    # Use the PORT environment variable if provided (useful for cloud deployment)
    # Default to 5000 for local development
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True) # debug=True is okay for local dev