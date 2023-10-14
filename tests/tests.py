import os
import pandas as pd
import connection.execute as exec
import numpy as np
#
# def directors_inserting(n):
#     conn = exec.psycopg2_conn()
#     for i in range(n):
#         sql_ins = f"INSERT INTO directors (id, firstname, middlename, lastname, began_career) \
#                         VALUES ({1000 + i}, 'Ivan', 'Ivanovich', 'Ivanov', '1990-01-01')"
#         exec.exec_sql(sql_ins, False)
#     conn.commit()
#
# def theatres_inserting(n):
#     conn = exec.psycopg2_conn()
#     for i in range(n):
#         sql_ins = f"INSERT INTO theatres (id, name, country, city, address) \
#                         VALUES ({2000 + i}, 'Theatre', 'Russia', 'Moscow', 'Theatre Square, {i + 2}')"
#         exec.exec_sql(sql_ins, False)
#     conn.commit()

def insert_performances(n=100000):
    conn = exec.psycopg2_conn()
    data = exec.exec_sql_file("tests/test_scripts/script1.sql", False, True)
    for i in range(n):
        sql_ins = f"INSERT INTO performances (id, play_id, theatre_id, date) \
                        VALUES (361, 212, 142, '2023-05-01')"
        exec.exec_sql(sql_ins, False)
    conn.commit()
#
# def test1():
#     data = exec.exec_sql_file("tests/test_scripts/script1.sql", False, True)
#     assert(len(data.index) == 3)
#
# def test2():
#     data = exec.exec_sql_file("tests/test_scripts/script2.sql", False, True)
#     hamlets_col = ['firstname', 'lastname']
#     assert (data.columns == hamlets_col).all
#
# def test3():
#     data = exec.exec_sql_file("tests/test_scripts/script3.sql", False, True)
#     assert (data.iloc[0][0] == 'Katie')
#
# def test4():
#     data = exec.exec_sql_file("tests/test_scripts/script4.sql", False, True)
#     check = pd.DataFrame(
#         {
#             "count": [3, 7],
#             "rank": ["supporting", "lead"],
#         }
#     )
#     assert (data.compare(check)).empty
def test():
    plays = exec.exec_sql_file("tests/test_scripts/plays.sql", False, True)
    plays = np.array(plays.iloc[:, 0])
    print(plays)

if __name__ == '__main__':
    test()
    # test1()
    # test2()
    # test3()
    # test4()
    # print("All tests passed!")
    # directors_inserting(10)
    # theatres_inserting(10)
    print("All data inserted!")

