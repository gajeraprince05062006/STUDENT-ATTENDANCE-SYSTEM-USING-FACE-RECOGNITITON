import cv2
import os
import numpy as np
from datetime import date, datetime
from sklearn.neighbors import KNeighborsClassifier
import pandas as pd
import joblib
import pymysql

face_detector = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

# Connect to MySQL database
def create_connection(name):
    connection = pymysql.connect(host="localhost", port=3307, user="root", passwd="", database="prince")
    if connection:
        datetoday = date.today().strftime("%Y-%m-%d")  # Change the date format to match MySQL format
        current_time = datetime.now().strftime("%H:%M:%S")
        try:
            cursor = connection.cursor()
            cursor.execute("INSERT INTO attendance(name_enrollment_no, date, time) VALUES (%s, %s, %s)",(name, datetoday, current_time))  # Pass parameters as tuple
            connection.commit()
            print("Attendance added successfully")
        except pymysql.Error as e:
            print(e)
        finally:
            cursor.close()
            connection.close()

# Function to extract attendance
def extract_attendance():
    connection = pymysql.connect(host="localhost", port=3307, user="root", passwd="", database="prince")
    if connection:
        datetoday = date.today().strftime("%m_%d_%y")
        try:
            cursor = connection.cursor()
            cursor.execute(f"SELECT * FROM Attendance WHERE DATE(time) = '{datetoday}'")
            rows = cursor.fetchall()
            for row in rows:
                print(row)
        except pymysql.Error as e:
            print(e)
        finally:
            cursor.close()
            connection.close()

# Other functions remain the same
def extract_faces(img):
    try:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        face_points = face_detector.detectMultiScale(gray, 1.2, 5, minSize=(20, 20))
        return face_points
    except Exception as e:
        print(e)
        return []

def identify_face(facearray):
    model = joblib.load('static/face_recognition_model.pkl')
    return model.predict(facearray)

def train_model():
    faces = []
    labels = []
    userlist = os.listdir('static/faces')
    for user in userlist:
        for imgname in os.listdir(f'static/faces/{user}'):
            img = cv2.imread(f'static/faces/{user}/{imgname}')
            resized_face = cv2.resize(img, (50, 50))
            faces.append(resized_face.ravel())
            labels.append(user)
    faces = np.array(faces)
    knn = KNeighborsClassifier(n_neighbors=5)
    knn.fit(faces, labels)
    joblib.dump(knn, 'static/face_recognition_model.pkl')

def main_logic():
    cap = cv2.VideoCapture(0)
    
    # Set full screen property
    cv2.namedWindow('Attendance', cv2.WND_PROP_FULLSCREEN)
    cv2.setWindowProperty('Attendance', cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)
    
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Failed to capture image")
            break
        
        faces = extract_faces(frame)
        if len(faces) > 0:
            (x, y, w, h) = faces[0]
            face = cv2.resize(frame[y:y+h, x:x+w], (50, 50))
            identified_person = identify_face(face.reshape(1, -1))[0]
            cv2.rectangle(frame, (x,y), (x+w, y+h), (0,0,255), 2)
            # Decrease font size for identified person label
            cv2.putText(frame, f'Identified: {identified_person}', (x, y-15), cv2.FONT_HERSHEY_COMPLEX_SMALL, 1, (0, 0, 255), 1)
        
        cv2.imshow('Attendance', frame)
        
        key = cv2.waitKey(1)
        if key == 27:  # If ESC key is pressed
            create_connection(identified_person)
            break
        elif key == ord('q'):  # If 'q' key is pressed
            break
    
    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main_logic()