import streamlit as st
import os
import tempfile
import shutil
from helper import *
import PIL.Image as im

st.title('Plate Recognition')

f = st.file_uploader(
    'Upload an image here', type=['png', 'jpeg', 'jpg'])

if f is not None:
    # st.text(image_file.name)

    tfile = tempfile.NamedTemporaryFile(delete=False)
    tfile.write(f.read())
    dest_name = os.path.join(f.name)
    if not os.path.exists(dest_name):
        shutil.copy(tfile.name, dest_name)
        st.success(f"cached in {dest_name}")

    model = load_model('yolov5', 'best.pt')
    filename = f.name
    infer(model, filename)
    try:
        plates = extract_plate_number()
        create_show_img(filename)
        img = im.open('show.jpg')
        st.image(img)

    except:
        st.error('Tesseract is not installed. Click the link to download and install the binary https://digi.bib.uni-mannheim.de/tesseract/tesseract-ocr-w64-setup-v5.2.0.20220712.exe')
