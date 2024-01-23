class Constants {
  static const CREATE_TODOS_TABLE = """CREATE TABLE IF NOT EXISTS todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT, 
            description TEXT, 
            status INTEGER,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
            updated_at DATETIME)""";
}
