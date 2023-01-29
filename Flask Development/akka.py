with open("C:/Users/nomul/OneDrive/Desktop/akka.txt.txt") as f:
    # data=f.readlines()
    # for i in range(len(data)):
    #     if 'Warning' in data[i] or 'Error' in data[i]:
    #         print('line',i,'=>',data[i][:-1])
    #         while ':' not in data[i]:
    #             print('line',i,'=>',data[i][:-1])
    #             i+=1
    data=f.read().split('\n')
    for line in range(len(data)):
        print(str(line)+data[line])