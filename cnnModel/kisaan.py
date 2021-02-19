# -*- coding: utf-8 -*-
"""Kisaan.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1aOrS99Vqw8Wq9jSm9JOTqHw_rzSz4-3s

**Image Classification for Crop**
"""

from google.colab import drive
drive.mount('/content/drive')

import tensorflow as tf
import tensorflow.keras.layers as Layers
import tensorflow.keras.activations as Actications
import tensorflow.keras.models as Models
import tensorflow.keras.optimizers as Optimizer
import tensorflow.keras.metrics as Metrics
import tensorflow.keras.utils as Utils
from keras.utils.vis_utils import model_to_dot
import os
import matplotlib.pyplot as plot
import cv2
import numpy as np
from sklearn.utils import shuffle
from sklearn.metrics import confusion_matrix as CM
from random import randint
from IPython.display import SVG
from keras.models import model_from_json

"""Loading Image Dataset

"""

def loadImage(directory):
  Images = []
  Labels = [] #0=> Rice, 1=> Tomato, 2=> Potato, 3=> lady_finger, 4=> strawberry
  label = 0
  for nameDir in os.listdir(directory):
    if nameDir == 'rice':
      label = 0
    elif nameDir == 'tomato':
      label = 1
    elif nameDir == 'potato':
      label = 2
    elif nameDir == 'lady_finger':
      label = 3
    elif nameDir == 'strawberry':
      label = 4

    filePath = directory + nameDir

    for imageFile in os.listdir(filePath):
      image = cv2.imread(filePath + r'/' + imageFile)
      image = cv2.resize(image,(150,150))
      Images.append(image)
      Labels.append(label)

  return shuffle(Images,Labels,random_state = 8173)

directory = '/content/drive/MyDrive/dataset/'
Images,Labels = loadImage(directory)
Images = np.array(Images)
Labels = np.array(Labels)

"""Model Design and Save Model"""

totalClass = 5
model = Models.Sequential()

model.add(Layers.Conv2D(200,kernel_size=(3,3),activation='relu',input_shape=(150,150,3)))
model.add(Layers.Conv2D(180,kernel_size=(3,3),activation='relu'))
model.add(Layers.MaxPool2D(5,5))
model.add(Layers.Conv2D(180,kernel_size=(3,3),activation='relu'))
model.add(Layers.Conv2D(140,kernel_size=(3,3),activation='relu'))
model.add(Layers.Conv2D(100,kernel_size=(3,3),activation='relu'))
model.add(Layers.Conv2D(50,kernel_size=(3,3),activation='relu'))
model.add(Layers.MaxPool2D(5,5))
model.add(Layers.Flatten())
model.add(Layers.Dense(180,activation='relu'))
model.add(Layers.Dense(100,activation='relu'))
model.add(Layers.Dense(50,activation='relu'))
model.add(Layers.Dropout(rate=0.5))
model.add(Layers.Dense(totalClass,activation='softmax'))

model.compile(optimizer=Optimizer.Adam(lr=0.0001),loss='sparse_categorical_crossentropy',metrics=['accuracy'])
model.summary()

trained = model.fit(Images,Labels,epochs=25,validation_split=0.30)
model_json = model.to_json()
with open("/content/demo.json","w") as json_file:
	json_file.write(model_json)
model.save_weights("/content/model.h5")

"""Test Model

"""

img=cv2.imread("/content/drive/MyDrive/dataset/tomato/10.jpg")
img=cv2.resize(img,(150,150))
model.predict(np.array([img]))