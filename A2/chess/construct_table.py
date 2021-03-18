
import mysql.connector
from pymysql import *
import pandas as pd

data = pd.read_csv('games_without_dupes.csv')

max_len = 0
games_moves = []
id = []
start_time = []
for row in data['moves']:
    games_moves.append(row.split())
    current_len = len(row.split())
    if (current_len) > max_len:
        max_len = current_len

for row in data['id']:
    id.append(row)

for row in data['created_at']:
    start_time.append(row)


mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="ww3952052",
    database="q2",
    auth_plugin='mysql_native_password'

)

mycursor = mydb.cursor()
mycursor.execute("SET FOREIGN_KEY_CHECKS=0;")
for i in range (max_len):
    #print("CREATE TABLE `moves_" + str(i+1) + "` (Game_ID VARCHAR(100), Start_time VARCHAR(100), moves VARCHAR(10)) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;")
    mycursor.execute("DROP TABLE IF EXISTS `moves_" + str(i+1) + "`;")
    mycursor.execute("CREATE TABLE `moves_" + str(i+1) + "` (Game_ID VARCHAR(100), Start_time VARCHAR(100), moves VARCHAR(10), "
                                                         "primary key(`Game_ID`,`Start_time`),"
                                                         "foreign key(`Game_ID`,`Start_time`) references Second_chess(`Game_ID`,`Start_time`)) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;")

mycursor.execute("SET FOREIGN_KEY_CHECKS=1;")

for i in range(len(id)):

    for j in range(max_len):

        if (j == len(games_moves[i])):
            break
        to_insert = [id[i], start_time[i], games_moves[i][j]]
        print("INSERT INTO `moves_" + str(j+1) + "` VALUES(`" + str(to_insert[0]) + "`,`" + str(to_insert[1]) +"`,`" + str(to_insert[2]) + "`)")
        mycursor.execute("INSERT INTO moves_" + str(j+1) + " VALUES('" + str(to_insert[0]) + "','" + str(to_insert[1]) +"','" + str(to_insert[2]) + "')")


mydb.commit()
mycursor.close()
mydb.close()

print(max_len)
print(len(games_moves))
print(len(games_moves[0]))
print(len(id))
print(start_time)

#print(data['moves'])
