import sqlite3
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

conn = sqlite3.connect("university.db")
cur = conn.cursor()

with open("models.sql", "r", encoding="utf-8") as f:
    cur.executescript(f.read())

# Groups
group_ids = []
for name in ["IK-01", "IK-02", "IK-03"]:
    cur.execute("INSERT INTO groups (name) VALUES (?)", (name,))
    group_ids.append(cur.lastrowid)

# Teachers (3-5)
teacher_ids = []
for _ in range(4):
    cur.execute("INSERT INTO teachers (fullname) VALUES (?)", (fake.name(),))
    teacher_ids.append(cur.lastrowid)

# Subjects (5–8)
subject_ids = []
subject_names = [
    "Math", "Physics", "Programming", "English",
    "Philosophy", "Biology", "Databases", "Algorithms"
]
random.shuffle(subject_names)

for name in subject_names[:7]:
    cur.execute(
        "INSERT INTO subjects (name, teacher_id) VALUES (?, ?)",
        (name, random.choice(teacher_ids))
    )
    subject_ids.append(cur.lastrowid)

# Students (30–50)
student_ids = []
for _ in range(random.randint(30, 50)):
    cur.execute(
        "INSERT INTO students (fullname, group_id) VALUES (?, ?)",
        (fake.name(), random.choice(group_ids))
    )
    student_ids.append(cur.lastrowid)

# Grades (до 20 оценок на студента)
for student in student_ids:
    for subject in subject_ids:
        for _ in range(random.randint(5, 20)):
            date = datetime.now() - timedelta(days=random.randint(1, 300))
            cur.execute("""
                INSERT INTO grades (student_id, subject_id, grade, date_received)
                VALUES (?, ?, ?, ?)
            """, (student, subject, random.randint(60, 100), date.date()))

conn.commit()
conn.close()

print("Database filled successfully!")
