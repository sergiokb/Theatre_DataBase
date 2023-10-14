import os
import pandas as pd
import connection.execute as exec
import numpy as np
from datetime import datetime

def insert_performances(n=100000):
    conn = exec.psycopg2_conn()
    plays = exec.exec_sql_file("tests/test_scripts/plays.sql", False, True)
    plays = np.array(plays.iloc[:, 0])
    psize = len(plays)
    theatres = exec.exec_sql_file("tests/test_scripts/theatres.sql", False, True)
    theatres = np.array(theatres.iloc[:, 0])
    tsize = len(theatres)
    ym = datetime.today().strftime('%Y-%m')
    dates = [ym + '-' + str(i % 20 + 10) for i in range(n)]
    dsize = len(dates)
    for i in range(n):
        sql_ins = "INSERT INTO performances (id, play_id, theatre_id, date) \
                        VALUES ({x}, {y}, {z}, '{s}')"\
            .format(x=3000 + i, y=plays[i % psize], z=theatres[i % tsize], s=dates[i % dsize])
        exec.exec_sql(sql_ins, False)
    conn.commit()

if __name__ == '__main__':
    insert_performances()
    print("All data inserted!")

