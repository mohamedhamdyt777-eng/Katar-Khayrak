import urllib.request
import os

os.makedirs('assets/fonts', exist_ok=True)
os.makedirs('assets/icons', exist_ok=True)

try:
    print("Downloading Cairo-Regular...")
    urllib.request.urlretrieve("https://github.com/google/fonts/raw/main/ofl/cairo/static/Cairo-Regular.ttf", "assets/fonts/Cairo-Regular.ttf")
    print("Downloading Cairo-Bold...")
    urllib.request.urlretrieve("https://github.com/google/fonts/raw/main/ofl/cairo/static/Cairo-Bold.ttf", "assets/fonts/Cairo-Bold.ttf")
    print("Success")
except Exception as e:
    print("Error:", e)
