import requests
from base64 import b64decode, b64encode
admin_encoded='CCTzEQMg80HMvFT8ngaLBg=='
#admin_encoded='yGa+AciUAoosKB3muluB2Q=='
prevLen=None
already_cookie=[]
url="https://cookiecutter.chal.cyberjousting.com"
#url="http://127.0.0.1:1337"
def loginAndGetCookie(i):
    global already_cookie
    form={'email':'a'*i}
    response=requests.post(url+'/login',data=form)
    cookie=response.cookies.get('cookie')
    suffix=b64encode(b64decode(cookie)[-16:]).decode('ascii')
    print(i)
    print(suffix)
    if suffix in already_cookie:
        print("Found")
    else:
        already_cookie.append(suffix)
    return cookie
def modifyCookie(cookie):
    bytes=b64decode(cookie)
    arr=bytearray(bytes)
    arr[-16:]=bytearray(b64decode(admin_encoded))
    return b64encode(arr).decode('ascii')
def modifyAndVerify(cookie):
    cookies={'cookie':modifyCookie(cookie)}
    print("modified:"+modifyCookie(cookie))
    response=requests.get(url+'/authenticate',cookies=cookies)
    if "You can only get the flag if you're an admin" in response.text:
        print("nope")
        return False
    else:
        print(response.text)
        return True

isDone=False
i=0
while not isDone:
    print(i)
    cookie = loginAndGetCookie(i)
    isDone = modifyAndVerify(cookie)
    i+=1



        