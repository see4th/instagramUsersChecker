from existence_checker import UserExistenceChecker


usernames = [
    "EditReajfkslqjfsdjfqmsjdlm", "EditsByMagic", "PurelyEdits", "EditSpectra", "StellarEdits", "__anxs._"
    
]

available_usernames = [username for username in usernames if not UserExistenceChecker(username)]

print("Available usernames:")
for username in available_usernames:
    print(username)
