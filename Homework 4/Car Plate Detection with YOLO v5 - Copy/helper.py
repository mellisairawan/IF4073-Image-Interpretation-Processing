import torch
import cv2
import numpy as np
import glob
import matplotlib.pyplot as plt
from matplotlib import image as mpimg
import pytesseract
import os
import pandas as pd


def load_model(yolo_path, weight_path):
    model = torch.hub.load(yolo_path, 'custom',
                           path=weight_path, source='local')
    model.conf = 0.5
    return model


def infer(model, filename):
    to_remove = glob.glob('result*')
    # print(f"removing {to_remove}")
    for item in to_remove:
        os.remove(item)
    if os.path.exists('show.jpg'):
        os.remove('show.jpg')
    im = cv2.imread(filename)
    w, h = np.shape(im)[1], np.shape(im)[0]
    im = cv2.resize(im, (416, 416))
    results = model(im, size=416)
    result_df = results.pandas().xyxy[0]
    result_df = result_df[result_df['name'] == 'license-plate']
    scalexs, scaleys = [], []
    for i in range(len(result_df)):
        x1 = np.round(result_df.iloc[i]['xmin']).astype(int)
        x2 = np.round(result_df.iloc[i]['xmax']).astype(int)
        y1 = np.round(result_df.iloc[i]['ymin']).astype(int)
        y2 = np.round(result_df.iloc[i]['ymax']).astype(int)
        cropped = im[y1:y2, x1:x2]
        scalex, scaley = w/416, h/416
        scalexs.append(scalex)
        scaleys.append(scaley)
        dim = (int(np.shape(cropped)[1]*scalex),
               int(np.shape(cropped)[0]*scaley))
        cropped = cv2.resize(cropped,
                             dim,
                             interpolation=cv2.INTER_AREA)
        cv2.imwrite(f"result_{i}.jpg", cropped)
    result_df['scalex'] = scalexs
    result_df['scaley'] = scaleys
    result_df['img_name'] = [filename for i in range(len(result_df))]
    result_df.to_csv('result.csv', index=False)
    # results.show()


def extract_plate_number():
    pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
    to_ocr = glob.glob('result*.jpg')
    plates = []
    for img in to_ocr:
        im = cv2.imread(img)

        gray = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
        blur = cv2.GaussianBlur(gray, (3, 3), 0)
        kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))
        opening = cv2.morphologyEx(blur, cv2.MORPH_OPEN, kernel, iterations=1)

        clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
        equalized = clahe.apply(opening)

        thresh = cv2.threshold(
            equalized, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]
        scale = np.round(640/np.shape(thresh)[1]).astype(int)
        thresh = cv2.resize(thresh, (np.shape(
            thresh)[1]*scale, np.shape(thresh)[0]*scale), interpolation=cv2.INTER_AREA)

        invert = 255 - thresh
        h, w = invert.shape[:2]
        mask = np.zeros((h+2, w+2), np.uint8)
        im_floodfill = invert.copy()
        cv2.floodFill(im_floodfill, mask, (0, 0), 255)

        data = pytesseract.image_to_string(
            im_floodfill, lang='eng', config='--psm 6')
        # print(data.strip('\n'))
        plates.append(data.strip("\n"))
    result_df = pd.read_csv('result.csv')
    result_df['plate_number'] = plates
    result_df.to_csv('result.csv', index=False)

    return plates


def create_show_img(filename):
    result_df = pd.read_csv('result.csv')
    image = cv2.imread(filename)

    for i in range(len(result_df)):
        row = result_df.iloc[i]
        start_point = (int(row.xmin*row.scalex), int(row.ymin*row.scaley))
        end_point = (int(row.xmax*row.scalex), int(row.ymax*row.scaley))
        color = (102, 51, 246)
        thickness = 4
        image = cv2.rectangle(image, start_point, end_point, color, thickness)
        (w, h), _ = cv2.getTextSize(
            row.plate_number, cv2.FONT_HERSHEY_SIMPLEX, 0.7, 1)
        image = cv2.rectangle(
            image, (start_point[0]-2, start_point[1] - 30), (start_point[0] + w + 6, start_point[1]), color, -1)
        image = cv2.putText(image, row.plate_number, (start_point[0]+2, start_point[1] - 7),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2)
    # cv2.imshow('image',image)
    # cv2.waitKey()
    # cv2.destroyAllWindows()
    cv2.imwrite('show.jpg', image)
