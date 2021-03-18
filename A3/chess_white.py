import mysql.connector

#for white

# find_flag_N = []
# find_flag_B = []
# find_flag_R = []
#
# num_moves_N = [] # for knights
# num_moves_B = [] # for bishops
# num_moves_R = [] # for rooks
#
# list_total = []

dic_N = {}
dic_B = {}
dic_R = {}
# from A2 we have known that the max num of moves is 349

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="ww3952052",
    database="q2",
    auth_plugin='mysql_native_password'

)
mycursor = mydb.cursor()

for i in range(349):

    if (((i + 1) % 2) == 0):
        continue
    else:
        print(i)
        mycursor.execute("SELECT Game_ID, Start_time, moves FROM moves_" + str(i + 1) + ";")
        res = mycursor.fetchall()
        num_games = len(res)

        for j in range(num_games):
            game_ID = res[j][0]
            start_time = res[j][1]
            piece = res[j][2][0]
            #flag = [game_ID, start_time]
            #print(flag)
            # if (flag not in list_total):
            #     list_total.append(flag)

            if (piece == 'N' and ((str(game_ID) + str(start_time)) not in dic_N.keys())):
                dic_N[str(game_ID) + str(start_time)] = ((i + 1 + 1) / 2) - 1
                # find_flag_N.append(flag)
                # num_moves_N.append(((i + 1 + 1) / 2) - 1)

            if (piece == 'B' and ((str(game_ID) + str(start_time)) not in dic_B.keys())):
                dic_B[str(game_ID) + str(start_time)] = ((i + 1 + 1) / 2) - 1
                # find_flag_B.append(flag)
                # num_moves_B.append(((i + 1 + 1) / 2) - 1)

            if (piece == 'R' and ((str(game_ID) + str(start_time)) not in dic_R.keys())):
                dic_R[str(game_ID) + str(start_time)] = ((i + 1 + 1) / 2) - 1
                # find_flag_R.append(flag)
                # num_moves_R.append(((i + 1 + 1) / 2) - 1)
            # if (piece == 'N' and (game_ID not in dic_N.keys())):
            #     dic_N[game_ID] = ((i + 1 + 1) / 2) - 1
            #     # find_flag_N.append(flag)
            #     # num_moves_N.append(((i + 1 + 1) / 2) - 1)
            #
            # if (piece == 'B' and (game_ID not in dic_B.keys())):
            #     dic_B[game_ID] = ((i + 1 + 1) / 2) - 1
            #     # find_flag_B.append(flag)
            #     # num_moves_B.append(((i + 1 + 1) / 2) - 1)
            #
            # if (piece == 'R' and (game_ID) not in dic_R.keys()):
            #     dic_R[game_ID] = ((i + 1 + 1) / 2) - 1
            #     # find_flag_R.append(flag)
            #     # num_moves_R.append(((i + 1 + 1) / 2) - 1)


print("white moves before moving knights: ")
# print(sum(num_moves_N) / len(num_moves_N))
print(sum(dic_N.values()) / len(dic_N))
# print(sum(dic_N.values()) )
# print(len(dic_N))
print("\n")
print("white moves before moving bishops: ")
# print(sum(num_moves_B) / len(num_moves_B))
print(sum(dic_B.values()) / len(dic_B))
# print(sum(dic_B.values()) )
# print(len(dic_B))
print("\n")
print("white moves before moving rooks: ")
# print(sum(num_moves_R) / len(num_moves_R))
print(sum(dic_R.values()) / len(dic_R))
# print(sum(dic_R.values()) )
# print(len(dic_R))
print("\n")
#print(len(list_total))
# mycursor.execute("SELECT Game_ID, Start_time, moves FROM moves_200;")
# res = mycursor.fetchall()
# print(res[0][2][0])
