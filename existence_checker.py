import requests

def UserExistenceChecker(username):
    try:
        url = f"https://www.instagram.com/{username}/"
        response = requests.get(url)
        length= len(response.text)
        print("the user name :", username )

        
        if length<=400000:
            print("this user doesnt exist")
            return False
        else:
            print("this user exists")
            return True
        
    except requests.RequestException as e:
        print(f"Error checking username {username}: {e}")
        return False

    

