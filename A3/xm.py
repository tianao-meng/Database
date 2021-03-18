import mysql.connector

def connectDB():
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="ww3952052",
        database="q2",
        auth_plugin='mysql_native_password'

    )

    return mydb


def getData(color, condition):
    mydb = connectDB()
    cursor = mydb.cursor()
    id = {}
    meet_condition_id = {}
    move = None
    res = None
    if color == "white":
        move = 1
    elif color == "black":
        move = 2
    while True:
        # print(move)
        try:
            # read the table
            cursor.execute("SELECT * FROM moves_" + str(move))
        except:
            # if there is no more table, return the results
            return meet_condition_id
        res = cursor.fetchall()
        for r in res:
            if r[0] not in id:
                id[r[0]] = 0
            else:
                id[r[0]] += 1
            if r[2][0] == condition:
                # meet the condition
                if r[0] not in meet_condition_id:
                    meet_condition_id[r[0]] = id[r[0]]
        move += 2


if __name__ == "__main__":
    result = {"white": {}, "black": {}}
    cases = {"white" :
                {"knight": "N",
                 "bishop": "B",
                 "rook": "R"},
            "black":
            {"knight": "N",
             "bishop": "B",
             "rook": "R"}}
    for k, v in cases.items():
        for kk, vv in v.items():
            print(k, vv)
            res = getData(k, vv)

            result[k][kk] = sum(res.values())/len(res.keys())
            print(sum(res.values()))
            print(len(res.keys()))

    print(result)
    # res = getData("white", condition)
    # print(sum())