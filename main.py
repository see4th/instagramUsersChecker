from existence_checker import UserExistenceChecker


usernames = [
    "hamiddd","hsfqlsdhfqo"
    
]

available_usernames = [username for username in usernames if not UserExistenceChecker(username)]


print("________________________________________________")
if len(available_usernames) > 0:

    print("PS : not all the usernames are valid ! ")
    print("in instagram when the user deletes his account , no one can use his username")
    print("if you can't use a username that means that the username belongs to a deleted account")
    print(" ")
    print("Available usernames:")
    
    for username in available_usernames:

        print("--------------------")
        print("▶ ",username)
        
else:
    print("⨻ there is no available usernames ⨻")
    
