import requests, json, re
from random import randint

#****************************
# By Marcin Sikorski
#****************************

# Feature: As a tester
#  I wish to demonstrate
#  How easy it is
#  to test API
#
# Background:
#   Given I'm using http://jsonplaceholder.typicode.com/users
#
#  Scenario:
#    Given I have a random userID
#    Then I want to print his address
#
#  Scenario:
#    Given I have a random userID
#    When I get his email
#    Then I want to verify email is correct
#
#  Scenario:
#    Given I'm using the same userID
#    When I get their associated posts
#    Then I want to verify they contain a valid id, title and body
#
#   Scenario:
#    Given I'm using the same userID
#    When post has invalid title or body
#    Then I want to POST correct title and body
# #****************************

id = randint(1,8)
userIDparameters = {"id": id}
postUserIDParametr = {"userId": id}

responseUser = requests.get("http://jsonplaceholder.typicode.com/users", params=userIDparameters)
clientAddress = json.loads(responseUser.text)

responsePost = requests.get("http://jsonplaceholder.typicode.com/posts", params=postUserIDParametr)
clientPosts = json.loads(responsePost.text)

clientStreet = clientAddress[0]['address']['street']
clientSuite = clientAddress[0]['address']['suite']
clientCity = clientAddress[0]['address']['city']
clientZipCode = clientAddress[0]['address']['zipcode']
clientEmail = clientAddress[0]['email']


print('Client\'s address: ' + '\n' + clientStreet + '\n' + clientSuite + '\n' + clientCity + '\n' + clientZipCode)
print(clientEmail)
print("Correct email" + "\n") if re.match(r"[^@]+@[^@]+\.[^@]+", clientEmail) else print('Incorrect email' + "\n")

for i in clientPosts:
    print('Post number: ' + str(i['id']) +'\n' + 'Title: '+ i['title']+ '\n' + 'Body: ' + i['body'] + '\n')
    if not str(i['id']).isdigit():
        print("This is not a valid ID! " + str(i['id']))
        break
    if not i['title']:
        print("We have an empty title! " + i['title'])
        titleMessage = requests.post("http://jsonplaceholder.typicode.com/posts", data={i['title']: 'THIS IS A PROPER TITLE'})
        print(titleMessage.status_code, titleMessage.reason)
        break
    if not i['body']:
        print("We have an empty post! " + i['body'])
        postMessage = requests.post("http://jsonplaceholder.typicode.com/posts",data={i['body']: 'THIS IS A PROPER POST'})
        print(postMessage.status_code, postMessage.reason)
        break
