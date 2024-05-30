from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

def user_existence_checker(username):
    try:
        url = f"https://www.instagram.com/{username}/"
        response = requests.get(url)
        length = len(response.text)
        print("The username:", username, "with a profile length:", length)
        if length <= 400000:
            return False
        else:
            return True
    except requests.RequestException as e:
        print(f"Error checking username {username}: {e}")
        return False

@app.route('/check', methods=['GET'])
def check_username():
    username = request.args.get('username')
    if not username:
        return jsonify({'error': 'No username provided'}), 400

    exists = user_existence_checker(username)
    return jsonify({'exists': exists})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
