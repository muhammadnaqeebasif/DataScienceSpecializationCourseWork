import pymysql as mysql


class MySQL:

    def __init__(self, host='localhost', user='root', password='1607'):
        self._user = user
        self._password = password
        self._host = host
        self._db = []
        self._using = None

        self._update_dbs()

    def _update_dbs(self):
        self._db = [row for row in self._get_DBs_from_server()]

    def get_dbs(self):
        return self._db

    def get_db(self, db):
        return db in self.get_dbs()

    def set_db(self, db):
        if db in self.get_dbs():
            raise NameError('Please input an unexacting database name')
        self._create_DB(db)
        self._db.append(db)
        return True

    def delete_db(self, db):
        if db not in self.get_dbs():
            raise NameError('Please input an existing database name')
        self._drop_DB(db)
        self._db.remove(db)
        return True

    @property
    def using(self):
        return self._using

    @using.getter
    def using(self):
        return self._using

    @using.setter
    def using(self, db):
        if db not in self.get_dbs():
            self.set_db(db)
        self._using = db

    @using.deleter
    def using(self):
        self.delete_db(self._using)
        self._using = None

    def _connect(self):
        # connect by unpacking dictionary credentials
        conn = mysql.connect(host=self._host, user=self._user, passwd=self._password)
        # create cursor
        cursor = conn.cursor()
        return conn, cursor

    def _close(self, cursor, conn):
        # close cursor
        cursor.close()
        # close connection to MySQL
        conn.close()

    def _get_DBs_from_server(self):
        # connect to MySQL
        conn, cursor = self._connect()
        cursor.execute("SHOW DATABASES;")
        generator = (row[0] for row in cursor.fetchall())

        # close cursor and connection
        self._close(cursor, conn)
        return generator

    def _drop_DB(self, nameDB):
        conn, cursor = self._connect()
        try:
            cursor.execute(
                "DROP DATABASE {};".format(nameDB))
        # close cursor and connection
        except mysql.Error as err:
            print("Failed to drop DB: {}".format(err))
        finally:
            self._close(cursor, conn)

    def _create_DB(self, nameDB):
        conn, cursor = self._connect()
        try:
            cursor.execute("CREATE DATABASE {} DEFAULT CHARACTER SET 'utf8';".format(nameDB))
        except mysql.Error as err:
            print("Failed to create DB: {}".format(err))
        finally:
            self._close(cursor, conn)

    def _use_DB(self, cursor):
        '''
        Expects open connection.
        '''
        cursor.execute("USE {}".format(self._using))

    def get_Tables(self):
        # connect to MySQL
        conn, cursor = self._connect()
        try:
            cursor.execute("SHOW TABLES FROM {}".format(self._using))
            return (row[0] for row in cursor.fetchall())
        except Exception as e:
            print(e)
        finally:
            self._close(cursor, conn)

    def get_records(self, table):
        # connect to MySQL
        conn, cursor = self._connect()
        try:
            self._use_DB(cursor)
            cursor.execute("SELECT * FROM {}".format(table))
            return (row for row in cursor.fetchall())
        except Exception as e:
            print(e)
        finally:
            self._close(cursor, conn)

    def run_query(self, sqlwrite):
        # connect to MySQL
        conn, cursor = self._connect()
        try:
            self._use_DB(cursor)
            # create Table inside DB
            cursor.execute(sqlwrite)
            conn.commit()
        # close cursor and connection
        except mysql.Error as err:
            print("Failed to run query in DB: {}".format(err))
        finally:
            self._close(cursor, conn)

    def drop_table(self, tableName):
        # connect to MySQL
        conn, cursor = self._connect()
        try:
            self._use_DB(cursor)
            cursor.execute("DROP TABLE {}".format(tableName))
            return True
        except mysql.Error as err:
            print("Failed to drop DB: {}".format(err))
        finally:
            self._close(cursor, conn)

    def showColumns(self, tableName):
        # connect to MySQL
        conn, cursor = self._connect()
        try:
            self._use_DB(cursor)
            cursor.execute("SHOW COLUMNS FROM {}".format(tableName))
            return (row for row in cursor.fetchall())
        except mysql.Error as err:
            print("Failed to perform operation in DB: {}".format(err))
        finally:
            self._close(cursor, conn)