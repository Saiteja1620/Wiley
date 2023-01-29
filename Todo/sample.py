with open('c:/Users/nomul/OneDrive/Desktop/registrationDetails.txt','r') as myfile:
        user_data=myfile.readlines()
        for i in user_data:
            user=i.split(',')
            fullName=user[0]
            userName=user[1]
            password=user[2]
            print(type(fullName),userName,password)