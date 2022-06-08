import pyautogui as pag
import clipboard as c

def send_keys(keys):
    pag.press(keys)

def copy(code):
    c.copy(code)